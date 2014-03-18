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
    <th>Note</th>
  </tr>
<tr>
   <td  class="leftcol"> <h2><p>Genes</p></h2></td>
    <td> Genome annotation for M. truncatula</td>
    <td><a href="http://www.jcvi.org/cgi-bin/medicago/overview.cgi" target="_new" class="extlink">Project Overview</a> - Version 4.0 </td>
    <td>31661 High Confidence and 19233 Low Confidence Genes</td>
</tr>
<tr>
 <td   class="leftcol"> <p><h2>Expression</h2></p></td>
    <td> Expression patterns of mRNAs for 6 different tissue types: nodule, seedpod, blade, bud, open flower and root </td>
    <td> &nbsp; </td>
    <td> &nbsp; </td>
</tr>

</table>
<!-- /dataCategories -->
