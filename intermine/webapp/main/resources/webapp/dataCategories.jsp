<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>

<!-- dataCategories -->
<html:xhtml/>

<div class="body">
<im:boxarea title="Data" stylename="plainbox"><p><fmt:message key="dataCategories.intro"/></p></im:boxarea>
<table cellpadding="0" cellspacing="0" border="0" class="dbsources">
  <tr>
    <th>Data Category</th>
    <th>Data</th>
    <th>Source</th>
    <th>PubMed</th>
  </tr>
<tr>
   <td  class="leftcol"> <h2><p>Genes</p></h2></td>
    <td>Genome annotation for <em>M. truncatula</em></td>
    <td><a href="http://www.jcvi.org/cgi-bin/medicago/overview.cgi" target="_new" class="extlink">Project Overview</a> - Version 4.0 </td>
    <td>Young ND, Debellé F, et al. - <a href="http://www.ncbi.nlm.nih.gov/pubmed/22089132">PubMed: 22089132</a></td>
</tr>

  <tr>
    <td rowspan="2" class="leftcol"><h2><p>Proteins</p></h2></td>
    <td>Proteins from UniProt (trEMBL and SwissProt)</td>
    <td><a href="http://www.ebi.uniprot.org/index.shtml" target="_blank" class="extlink">UniProt</a>- Release 2013_12</td>
    <td>UniProt Consortium - <a href="http://www.ncbi.nlm.nih.gov/pubmed/17142230" target="_blank" class="extlink">PMID:17142230</a></td>
  </tr>
  <tr>
    <td>Protein family and domain assignments to proteins</td>
    <td><a href="http://www.ebi.ac.uk/interpro" target="_blank" class="extlink">InterPro</a>(from UniProt Release 2013_12)</td>
    <td>Mulder et al - <a href="http://www.ncbi.nlm.nih.gov/pubmed/17202162" target="_blank" class="extlink">PMID:17202162</a></td>
  </tr>
<tr>
    <td class="leftcol"> <h2><p>Homology</p></h2></td>
    <td>Orthologs calculated by reciprocal BLASTP analysis</td>
    <td><a href="http://www.jcvi.org/cgi-bin/medicago/overview.cgi" target="_new" class="extlink">Project Overview</a> - Version 4.0  </td>
    <td>&nbsp</td>
</tr>

<tr>
    <td rowspan="2" class="leftcol"><h2><p>Gene Ontology</p></h2></td>
    <td>Several electronic and manual GO annotation methods utilized by UniProt</td>
    <td><a href="http://www.ebi.ac.uk/GOA/" target="_blank" class="extlink">UniProt GOA</a></td>
    <td>Camon et al - <a href="http://www.ncbi.nlm.nih.gov/pubmed/14681408" target="_blank" class="extlink">PMID:14681408</a></td>
</tr>

  <tr>
    <td>InterPro domains to GO terms</td>
    <td><a href="http://www.ebi.ac.uk/interpro" target="_blank" class="extlink">InterPro</a>(from <a href="http://www.geneontology.org" target="_blank" class="extlink">Gene Ontology Site</a>)</td>
    <td>Mulder et al - <a href="http://www.ncbi.nlm.nih.gov/pubmed/17202162" target="_blank" class="extlink">PMID:17202162</a></td>
  </tr>

<tr>
    <td rowspan="2" class="leftcol"> <p><h2>Expression</h2></p></td>
    <td> Expression patterns of mRNAs for 6 different tissue types: nodule, seedpod, blade, bud, open flower and root </td>
    <td> &nbsp; </td>
    <td> &nbsp; </td>
</tr>

<tr>
    <td>Electronic Fluorescent Pictograph (eFP) Visualization paints gene expression information from one of the AtGenExpress data sets or other compendia for a desired gene onto a diagrammatic representation of <em>Arabidopsis thaliana</em> plants.</td>
    <td><a href="http://bar.utoronto.ca/efpmedicago/cgi-bin/efpWeb.cgi" target="_blank" class="extlink">Medicago eFP Browser</a></td>
    <td>Winter et al., 2007 - <a href="http://www.ncbi.nlm.nih.gov/pubmed/17684564" target="_blank" class="extlink">PMID:17684564</a>
</tr>

<tr>
    <td class="leftcol"><h2><p>Publications</p></h2></td>
    <td>Relevant publications are identified by searching databases such as PubMed (full-text is read, relevant information extracted and added to the entry)</td>
    <td><a href="http://www.uniprot.org/help/publications" target="_blank" class="extlink">Publications</a>(from UniProt Release 2013_12)</td>
    <td>Magrane et al., 2011 - <a href="http://www.ncbi.nlm.nih.gov/pubmed/21447597" target="_blank" class="extlink">PMID:21447597</a></td>
</tr>
</table>
<!-- /dataCategories -->
