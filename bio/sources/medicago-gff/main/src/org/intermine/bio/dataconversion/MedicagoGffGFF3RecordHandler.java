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

import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.lang.StringUtils;

import org.intermine.bio.io.gff3.GFF3Record;
import org.intermine.metadata.Model;
import org.intermine.xml.full.Item;
import org.intermine.util.StringUtil;

/**
 * A converter/retriever for the AipGff dataset via GFF files.
 */

public class MedicagoGffGFF3RecordHandler extends GFF3RecordHandler
{

    /**
     * Create a new MedicagoGffGFF3RecordHandler for the given data model.
     * @param model the model for which items will be created
     */
    public MedicagoGffGFF3RecordHandler (Model model) {
        super(model);
        refsAndCollections.put("Exon", "transcripts");
        refsAndCollections.put("MRNA", "gene");
        refsAndCollections.put("TransposonFragment", "transposableelements");
        refsAndCollections.put("PseudogenicExon","pseudogenictranscripts");
        refsAndCollections.put("PseudogenicTranscript","pseudogene");
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
            String clsName = feature.getClassName();

            if("Gene".equals(clsName)) {
		if(record.getAttributes().get("Note") != null){
		    String note = record.getAttributes().get("Note").iterator().next();
		    if(note != null){
			feature.setAttribute("briefDescription", note);
		    }
		} 
                if(record.getAttributes().get("conf_class") != null){
                    String conf_class = record.getAttributes().get("conf_class").iterator().next();
                    if(conf_class != null){
                        feature.setAttribute("confidenceClass", conf_class);
                    }
                }
                if(record.getAttributes().get("affy_id") != null){
                    String affy_id = record.getAttributes().get("affy_id").iterator().next();
                    if(affy_id != null){
                        feature.setAttribute("affymetricsIdentifier", affy_id);
                    }
                }
                if(record.getAttributes().get("Dbxref") != null){
                    String secondaryIdentifier = record.getAttributes().get("Dbxref").iterator().next();
                    if(secondaryIdentifier != null){
                        feature.setAttribute("secondaryIdentifier", secondaryIdentifier);
                    }
                }
            }
        

            if("MRNA".equals(clsName)) {
		if(record.getAttributes().get("Note") != null){
		    String note = record.getAttributes().get("Note").iterator().next();
		    if(note != null){
			feature.setAttribute("briefDescription", note);
		    }
		} 
                if(record.getAttributes().get("conf_class") != null){
                    String conf_class = record.getAttributes().get("conf_class").iterator().next();
                    if(conf_class != null){
                        feature.setAttribute("confidenceClass", conf_class);
                    }
                }
                if(record.getAttributes().get("affy_id") != null){
                    String affy_id = record.getAttributes().get("affy_id").iterator().next();
                    if(affy_id != null){
                        feature.setAttribute("affymetricsIdentifier", affy_id);
                    }
                }
                if(record.getAttributes().get("Dbxref") != null){
                    String secondaryIdentifier = record.getAttributes().get("Dbxref").iterator().next();
                    if(secondaryIdentifier != null){
                        feature.setAttribute("secondaryIdentifier", secondaryIdentifier);
                    }
                }
            }
        }
}
