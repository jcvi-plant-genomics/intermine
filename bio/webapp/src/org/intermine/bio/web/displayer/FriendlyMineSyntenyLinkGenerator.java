package org.intermine.bio.web.displayer;

/*
 * Copyright (C) 2002-2016 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Arrays;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.intermine.api.beans.SyntenyObjectDetails;
import org.intermine.api.beans.SyntenyPartnerLink;
import org.intermine.api.mines.Mine;
import org.intermine.api.mines.ObjectRequest;
import org.intermine.metadata.ConstraintOp;
import org.intermine.pathquery.Constraints;
import org.intermine.pathquery.OrderDirection;
import org.intermine.pathquery.PathQuery;
import org.intermine.pathquery.PathConstraintRange;
import org.intermine.metadata.Util;
import org.intermine.web.displayer.InterMineSyntenyLinkGenerator;
import org.intermine.webservice.server.core.Predicate;

/**
 * Helper class for synteny-based intermine links generated on report and lists pages
 *
 * @author Vivek Krishnakumar
 */
public final class FriendlyMineSyntenyLinkGenerator implements InterMineSyntenyLinkGenerator
{

    private class MustBeIn implements Predicate<List<Object>>
    {

        private final Set<String> collection;

        MustBeIn(Set<String> coll) {
            this.collection = coll;
        }

        @Override
        public Boolean call(List<Object> row) {
            return (row != null) && collection.contains(row.get(2));
        }

    }

    private static final Logger LOG = Logger.getLogger(FriendlyMineSyntenyLinkGenerator.class);
    private static final Map<String, String> ORGANISM_PREFIX = new HashMap<String, String>();

    static {
        ORGANISM_PREFIX.put("M. truncatula", "medtr");
        ORGANISM_PREFIX.put("A. duranensis", "aradu");
        ORGANISM_PREFIX.put("A. ipaensis", "araip");
        ORGANISM_PREFIX.put("P. vulgaris", "phavu");
        ORGANISM_PREFIX.put("G. max", "glyma");
    }

    /**
     * Constructor
     */
    public FriendlyMineSyntenyLinkGenerator() {
        super();
    }

    public Collection<SyntenyPartnerLink> getLinks(Mine thisMine, Mine mine, ObjectRequest req) {

        String organismShortName = req.getDomain();
        String chromosomeLocation = req.getIdentifier();

        if (StringUtils.isEmpty(organismShortName) || StringUtils.isEmpty(chromosomeLocation)) {
            return Collections.emptySet();
        }

        // FIXME temporarily ignoring lists with more than one organism
        if (organismShortName.contains(",")) {
            return Collections.emptySet();
        }

        // Wrapping up in a sub object means we don't need a messy web of static calls.
        LinkFetcher fetcher = new LinkFetcher(thisMine, mine);
        return fetcher.fetch(req);
    }

    private class LinkFetcher
    {

        private final Mine thisMine, thatMine;
        private MustBeIn predicate;

        LinkFetcher(Mine thisMine, Mine mine) {
            this.thisMine = thisMine; // The local mine, where the idents come from
            this.thatMine = mine; // The remote mine, where we want to find things.
            this.predicate = new MustBeIn(thatMine.getDefaultValues());
        }

        Collection<SyntenyPartnerLink> fetch(ObjectRequest req) {

            // Phase one -- query the remote mine for syntenyBlocks.
            Map<String, Set<SyntenyObjectDetails>> syntenyBlocks = remoteSyntenyStrategy(req);
            // Phase two -- query this mine for syntenyBlocks.
            if (syntenyBlocks == null || syntenyBlocks.isEmpty()) {
                syntenyBlocks = localSyntenyStrategy(req);
            }

            return toLinks(syntenyBlocks);
        }

        /**
         * Look for syntenyBlocks to the requested objects in the remote mine, but only accept
         * syntenyBlocks for organisms that mine specialises in.
         * @param req The definition of the thing we are looking for.
         * @return A mapping from organisms to groups of syntenyBlocks.
         */
        private Map<String, Set<SyntenyObjectDetails>> remoteSyntenyStrategy(ObjectRequest req) {
            PathQuery q = getSyntenyQuery(thatMine, req);
            return runQuery(thatMine, q);
        }

        /**
         * Look for syntenyBlocks to the requested objects in the local mine, and accept
         * all answers.
         * @param req The definition of the thing we are looking for.
         * @return A mapping from organisms to groups of syntenyBlocks.
         */
        private Map<String, Set<SyntenyObjectDetails>> localSyntenyStrategy(ObjectRequest req) {
            PathQuery q = getSyntenyQuery(thisMine, req);
            return runQuery(thisMine, q);
        }

        private PathQuery getSyntenyQuery(Mine mine, ObjectRequest req) {
            String chromosomeLocation = req.getIdentifier();
            final String regexp = "^(\\S+):([0-9]+)-([0-9]+)$";
            Pattern p = Pattern.compile(regexp);
            Matcher m = p.matcher(chromosomeLocation);
            String chrId, chromosomeId, start, end;
            chrId = chromosomeId = start = end = "";
            if (m.matches()) {
                chrId = m.group(1);
                chromosomeId = ORGANISM_PREFIX.get(req.getDomain()) + "." + chrId.replace("chr", "Chr0");
                start = m.group(2);
                end = m.group(3);
            }
            String[] regions = { chromosomeId + ":" + start + "-" + end };

            PathQuery q = new PathQuery(mine.getModel());
            q.addViews(
                 "SyntenyBlock.sourceRegion.primaryIdentifier",
                 "SyntenyBlock.targetRegion.primaryIdentifier",
                 "SyntenyBlock.targetRegion.organism.shortName"
            );
            q.addOrderBy("SyntenyBlock.sourceRegion.primaryIdentifier", OrderDirection.ASC);
            q.addConstraint(Constraints.eq("SyntenyBlock.sourceRegion.organism.shortName", req.getDomain()), "A");
            q.addConstraint(new PathConstraintRange("SyntenyBlock.sourceRegion.chromosomeLocation", ConstraintOp.OVERLAPS, Arrays.asList(regions)), "B");
            q.setConstraintLogic("A and B");

            return q;
        }

        /**
         * Processes the results of queries produced by getSyntenyQuery - ie. they
         * have three views: SyntenyBlock.sourceRegion.primaryIdentifier, SyntenyBlock.targetRegion.primaryIdentfier,
         *                      SyntenyBlock.targetRegion.organism.shortName
         * @param mine The data source
         * @param q The query
         * @return
         */
        private Map<String, Set<SyntenyObjectDetails>> runQuery(
                Mine mine,
                PathQuery q) {
            Map<String, Set<SyntenyObjectDetails>> retval = new HashMap<String, Set<SyntenyObjectDetails>>();

            List<List<Object>> results = mine.getRows(q);

            for (List<Object> row: results) {
                if (!predicate.call(row)) {
                    continue;
                }
                SyntenyObjectDetails details = new SyntenyObjectDetails();
                details.setType("SyntenicRegion");
                if (row.get(0) != null) {
                    details.setSourceRegion((String) row.get(0));
                }
                if (row.get(1) != null) {
                    details.setTargetRegion((String) row.get(1));
                }

                Util.addToSetMap(retval, String.valueOf(row.get(2)), details);
            }
            return retval;
        }

        /*
         * Turn the syntenyBlocks into a collection of SyntenyPartnerLinks
         */
        private Collection<SyntenyPartnerLink> toLinks(Map<String, Set<SyntenyObjectDetails>> syntenyBlocks) {
            Set<SyntenyPartnerLink> retVal = new HashSet<SyntenyPartnerLink>();
            for (Entry<String, Set<SyntenyObjectDetails>> entry : syntenyBlocks.entrySet()) {
                String organismName = entry.getKey();
                Set<SyntenyObjectDetails> objects = entry.getValue();
                SyntenyPartnerLink link = new SyntenyPartnerLink();
                link.setDomain(organismName);
                link.setObjects(objects);
                retVal.add(link);
            }
            return retVal;
        }

    }


}
