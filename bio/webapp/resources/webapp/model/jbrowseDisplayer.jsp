<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- jbrowseDisplayer.jsp -->
<div class="basic-table">
<h3>JBrowse</h3>
<br />

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${((!empty object.chromosomeLocation && !empty object.chromosome)
                || className == 'Chromosome') && className != 'ChromosomeBand'}">

<div id="jbrowse" class="feature basic-table">
  <c:set var="name" value="${object.primaryIdentifier}"/>

  <c:if test="${className == 'CDS' || fn:containsIgnoreCase(className, 'exon') || fn:containsIgnoreCase(className, 'UTR')}">
    <c:set var="name" value="${object.gene.primaryIdentifier}"/>
  </c:if>

  <c:choose>
  <c:when test="${WEB_PROPERTIES['jbrowse.database.source'] != null}">
  <div>
      <iframe style="border: 1px solid black"
          src="${WEB_PROPERTIES['jbrowse.prefix']}/?data=${WEB_PROPERTIES['jbrowse.database.source']}&loc=${name}&nav=0&overview=0&tracks=Root20(Control)%20RNAseq%20Coverage%2Cgene_models%2CTE_gene_models"
          width="820" height="250">
      </iframe>
  </div>
  </c:when>
  <c:otherwise>
  <p>There was a problem rendering the displayer, check: <code>${WEB_PROPERTIES['jbrowse.database.source']}</code>.</p>
	<script type="text/javascript">
		jQuery('#jbrowse').addClass('warning');
	</script>
  </c:otherwise>
  </c:choose>
</div>
</c:when>
<c:otherwise>
<div id="jbrowse" class="feature basic-table warning">
  <h3><fmt:message key="sequenceFeature.jbrowse.message"/></h3>
  <p>There was a problem rendering the displayer.</p>
</div>
</c:otherwise>
</c:choose>
<!-- /jbrowseDisplayer.jsp -->
