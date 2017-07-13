package org.intermine.bio.util;

/*
 * Copyright (C) 2002-2017 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */


/**
 * A class to hold data about one organism.
 * SH: Added variety.
 *
 * @author Kim Rutherford
 * @author Sam Hokin
 */
public class OrganismData {

    public static final String DEFAULT_VARIETY = "reference";

    private String species;
    private String genus;
    private String abbreviation;
    private int taxonId;
    private String ensemblPrefix;
    private String uniprot;
    private String variety = DEFAULT_VARIETY;


    /**
     * Create a new OrganismData object.  Not public because these are created only by
     * OrganismRepository.
     */
    OrganismData() {
        // empty
    }

    /**
     * Get the short of this organism, eg. D. melanogaster.  may be null for some organisms from
     * uniprot
     * @return the genus
     */
    public String getShortName() {
        if (genus == null || species == null) {
            return null;
        }
        return genus.substring(0, 1) + ". " + species;
    }

    /**
     * Get the genus of this organism.
     * @return the genus
     */
    public String getGenus() {
        return genus;
    }

    /**
     * Get the species of this organism.
     * @return the species
     */
    public String getSpecies() {
        return species;
    }

    /**
     * Get the variety of this organism.
     * @return the variety
     */
    public String getVariety() {
        return variety;
    }

    /**
     * Get the abbreviation of this organism.  eg. "Dmel"
     * @return the abbreviation
     */
    public String getAbbreviation() {
        return abbreviation;
    }

    /**
     * Get the taxonId of this organism.
     * @return the taxonId
     */
    public int getTaxonId() {
        return taxonId;
    }

    /**
     * Set the species of this organism.
     * @param species the species to set
     */
    public void setSpecies(String species) {
        this.species = species;
    }

    /**
     * Set the genus of this organism.
     * @param genus the genus to set
     */
    public void setGenus(String genus) {
        this.genus = genus;
    }

    /**
     * Set the variety of this organism.
     * @param variety the variety to set
     */
    public void setVariety(String variety) {
        if (variety==null) {
            this.variety = DEFAULT_VARIETY;
        } else {
            this.variety = variety;
        }
    }

    /**
     * Set the abbreviation of this organism.  eg. "Dmel"
     * @param abbreviation the abbreviation to set
     */
    void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    /**
     * Set the taxonId of this organism.
     * @param taxonId the taxonId to set
     */
    void setTaxonId(int taxonId) {
        this.taxonId = taxonId;
    }

    /**
     * @param ensemblPrefix prefix for Ensembl genes, eg. ENSMUSG for this organism
     */
    public void setEnsemblPrefix(String ensemblPrefix) {
        this.ensemblPrefix = ensemblPrefix;
    }

    /**
     * @return prefix for Ensembl genes, eg. ENSMUSG for this organism
     */
    public String getEnsemblPrefix() {
        return ensemblPrefix;
    }

    /**
     * @return the uniprot prefix, eg. HUMAN or DROME
     */
    public String getUniprot() {
        return uniprot;
    }

    /**
     * @param uniprot the uniprot prefix, eg. HUMAN or DROME
     */
    public void setUniprot(String uniprot) {
        this.uniprot = uniprot;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return genus + " " + species + " ("+variety+"), " + abbreviation + ", " + taxonId + ", " + ensemblPrefix + ", " + uniprot;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(Object obj) {
        return obj instanceof OrganismData && ((OrganismData) obj).toString().equals(toString());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return toString().hashCode();
    }
}
