package org.intermine.api.beans;

/*
 * Copyright (C) 2002-2016 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */
import java.io.Serializable;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * An object that describes an object.
 * @author alex
 *
 */
public class SyntenyObjectDetails implements Serializable
{

    private String sourceRegion, targetRegion, type;

    /**
     * @return the targetRegion
     */
    public String getTargetRegion() {
        return targetRegion;
    }

    /**
     * @param targetRegion the targetRegion to set
     */
    public void setTargetRegion(String targetRegion) {
        this.targetRegion = targetRegion;
    }

    /**
     * @return the sourceRegion
     */
    public String getSourceRegion() {
        return sourceRegion;
    }

    /**
     * @param sourceRegion the sourceRegion to set
     */
    public void setSourceRegion(String sourceRegion) {
        this.sourceRegion = sourceRegion;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    // -- Object contract

    @Override
    public String toString() {
        return String.format(
                "SyntenyObjectDetails(type = %s, targetRegion = %s, sourceRegion = %s)",
                    type, targetRegion, sourceRegion);
    }

    @Override
    public int hashCode() {
        HashCodeBuilder hcb = new HashCodeBuilder();
        hcb.append(type).append(targetRegion).append(sourceRegion);
        return hcb.toHashCode();
    }

    @Override
    public boolean equals(Object other) {
        if (other == null) {
            return false;
        }
        if (other == this) {
            return true;
        }
        if (other.getClass() != getClass()) {
            return false;
        }
        SyntenyObjectDetails rhs = (SyntenyObjectDetails) other;
        return new EqualsBuilder().append(type, rhs.type)
                                  .append(targetRegion, rhs.targetRegion)
                                  .append(sourceRegion, rhs.sourceRegion)
                                  .isEquals();
    }

}
