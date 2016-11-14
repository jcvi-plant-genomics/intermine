package org.intermine.api.mines;

/*
 * Copyright (C) 2002-2016 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * A generic container for a request for information about an object.
 * @author Vivek Krishnakumar
 *
 */
public class SyntenyObjectRequest
{

    private final String domain, chromosomeLocation;

    /**
     * Define a new object request.
     * @param domain The domain over which these chromosomeLocations have validity.
     * @param chromosomeLocation The chromosomeLocation.
     */
    public SyntenyObjectRequest(String domain, String chromosomeLocation) {
        this.domain = domain;
        this.chromosomeLocation = chromosomeLocation;
    }

    /**
     * @return the chromosomeLocation
     */
    public String getChromosomeLocation() {
        return chromosomeLocation;
    }

    /**
     * @return the domain
     */
    public String getDomain() {
        return domain;
    }

    // -- object contract.

    @Override
    public int hashCode() {
        HashCodeBuilder hcb = new HashCodeBuilder();
        hcb.append(domain).append(chromosomeLocation);
        return hcb.toHashCode();
    }

    @Override
    public String toString() {
        return String.format("SyntenyObjectRequest(domain = %s, chromosomeLocation = %s)", domain, chromosomeLocation);
    }

    @Override
    public boolean equals(Object other) {
        if (other == null || !(other instanceof SyntenyObjectRequest)) {
            return false;
        }
        SyntenyObjectRequest oor = (SyntenyObjectRequest) other;
        if (chromosomeLocation == null && oor.chromosomeLocation != null) {
            return false;
        }
        if (chromosomeLocation != null && !chromosomeLocation.equals(oor.chromosomeLocation)) {
            return false;
        }
        if (domain == null && oor.domain != null) {
            return false;
        }
        if (domain != null && !domain.equals(oor.domain)) {
            return false;
        }
        return true;
    }
}
