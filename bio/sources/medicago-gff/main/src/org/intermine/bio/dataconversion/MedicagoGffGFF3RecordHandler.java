package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2002-2011 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */
    
import org.intermine.bio.io.gff3.GFF3Record;
import org.intermine.metadata.Model;
import org.intermine.xml.full.Item;

/**
 * A converter/retriever for the MedicagoGff dataset via GFF files.
 */

public class MedicagoGffGFF3RecordHandler extends GFF3RecordHandler
{

    /**
     * Create a new MedicagoGffGFF3RecordHandler for the given data model.
     * @param model the model for which items will be created
     */
    public MedicagoGffGFF3RecordHandler (Model model) {
        super(model);
        // refsAndCollections controls references and collections that are set from the
        // Parent= attributes in the GFF3 file.
         refsAndCollections.put("Exon", "transcripts");
         //refsAndCollections.put("CDS","transcript");
         refsAndCollections.put("MRNA", "gene");
    }


    /**
     * {@inheritDoc}
     */
    @Override
     

    public void process(GFF3Record record) {
        // This method is called for every line of GFF3 file(s) being read.  Features and their
        // locations are already created but not stored so you can make changes here.  Attributes
        // are from the last column of the file are available in a map with the attribute name as
        // the key.   For example:
        //
        Item feature = getFeature();
        //     String symbol = record.getAttributes().get("symbol");
        //     feature.setAttrinte("symbol", symbol);
        //     Item feature = getFeature();
        //    String id = record.getAttributes().get("ID");
        //    feature.setAttribute("id", id);
        String clsName = feature.getClassName();
        if("Gene".equals(clsName)){
            if(record.getAttributes().get("Note") != null){
                String note = record.getAttributes().get("Note").iterator().next();
                if(note != null){
                    feature.setAttribute("Note", note);
                }   
            }    
        }
        if("MRNA".equals(clsName)){
            if(record.getAttributes().get("conf_class") !=null){
                String  confClass = record.getAttributes().get("conf_class").iterator().next();
                if(confClass != null){
                    feature.setAttribute("confClass",confClass);
                }   
            }
        } 
        //
        // Any new Items created can be stored by calling addItem().  For example:
        // 
        //     String geneIdentifier = record.getAttributes().get("gene");
        //     gene = createItem("Gene");
        //     gene.setAttribute("primaryIdentifier", geneIdentifier);
        //     addItem(gene);
        //
        // You should make sure that new Items you create are unique, i.e. by storing in a map by
        // some identifier. 

    }

}
