package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2002-2017 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.io.Reader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.intermine.dataconversion.ItemWriter;
import org.intermine.metadata.Model;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.util.FormattedTextParser;
import org.intermine.xml.full.Item;


/**
 * A data parser for  illumina body map.
 * @author Julie Sullivan
 */
public class AtlasExpressConverter extends BioFileConverter
{
    private static final String DATASET_TITLE = "E-MTAB-513 illumina body map";
    private static final String DATA_SOURCE_NAME = "ArrayExpress";
    private Map<String, String> genes = new HashMap<String, String>();
    protected IdResolver rslv;
    private static final String TAXON_ID = "9606";
    private static final Logger LOG = Logger.getLogger(AtlasExpressConverter.class);

    private static final String EXPRESSION_TYPE = "FPKM value";

    /**
     * Constructor
     * @param writer the ItemWriter used to handle the resultant items
     * @param model the Model
     */
    public AtlasExpressConverter(ItemWriter writer, Model model) {
        super(writer, model, DATA_SOURCE_NAME, DATASET_TITLE);
        if (rslv == null) {
            rslv = IdResolverService.getIdResolverByOrganism(TAXON_ID);
        }
    }

    /**
     * Read Atlas Express TSV file.
     *
     * {@inheritDoc}
     */
    @Override
    public void process(Reader reader) throws Exception {

        /* data has format
        Gene ID Gene Name       adipose adrenal brain   breast  colon   heart   kidney  leukocyte
             liver   lung    lymph node      ovary   prostate        skeletal muscle testis  thyroid
        ENSG00000000003 TSPAN6  21      5       5       16      12      2       13      0.1     31
         */
        Iterator<?> lineIter = FormattedTextParser.parseTabDelimitedReader(reader);

        // parse header
        String[] header = (String[]) lineIter.next();

        // each gene is on a new line
        while (lineIter.hasNext()) {
            String[] line = (String[]) lineIter.next();

            String geneId = getGeneId(line[0]);

            if (StringUtils.isEmpty(geneId)) {
                continue;
            }

            // each column represents a tissue
            // skip first two columns, gene name
            for (int i = 2; i < header.length; i++) {

                String tissue = header[i];
                String expression = line[i];

                Item item = createItem("AtlasExpression");
                item.setAttribute("type", EXPRESSION_TYPE);
                item.setAttribute("condition", tissue);
                item.setAttribute("expression", expression);
                item.setReference("gene", geneId);
                store(item);
            }
        }
    }


    private String getGeneId(String primaryIdentifier) throws ObjectStoreException {
        String resolvedIdentifier = resolveGene(primaryIdentifier);
        if (StringUtils.isEmpty(resolvedIdentifier)) {
            return null;
        }
        String geneId = genes.get(resolvedIdentifier);
        if (geneId == null) {
            Item gene = createItem("Gene");
            gene.setAttribute("primaryIdentifier", resolvedIdentifier);
            gene.setReference("organism", getOrganism(TAXON_ID));
            store(gene);
            geneId = gene.getIdentifier();
            genes.put(resolvedIdentifier, geneId);
        }
        return geneId;
    }

    private String resolveGene(String identifier) {
        String id = identifier;

        if (rslv != null && rslv.hasTaxon(TAXON_ID)) {
            int resCount = rslv.countResolutions(TAXON_ID, identifier);
            if (resCount != 1) {
                LOG.info("RESOLVER: failed to resolve gene to one identifier, ignoring gene: "
                         + identifier + " count: " + resCount + " Human identifier: "
                         + rslv.resolveId(TAXON_ID, identifier));
                return null;
            }
            id = rslv.resolveId(TAXON_ID, identifier).iterator().next();
        }
        return id;
    }

}
