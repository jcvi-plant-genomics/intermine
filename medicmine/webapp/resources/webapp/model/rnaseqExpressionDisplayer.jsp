<!-- RNASEQ EXPRESSION -->
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>

<div id="rnaseqExpressionDisplayerWidget" class="collection-table">

<div class="header">
<p>Data Source: <a target="_blank" href="/${WEB_PROPERTIES['webapp.path']}/portal.do?class=DataSet&externalids=RNA-seq+expression">MTGD</a></p>
</div>

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${!empty object.primaryIdentifier}">

<c:set var="TYPE" value="" />
<c:if test="${fn:contains(object.type, 'RNA') || fn:contains(object.type, 'Transcript')}">
    <c:set var="TYPE" value="Transcript" />
</c:if>
<c:if test="${object.type == 'Gene' || object.type == 'Pseudogene' || object.type == 'TransposableElementGene'}">
    <c:set var="TYPE" value="Gene" />
</c:if>

<c:if test="${(TYPE eq 'Gene' || TYPE eq 'Transcript')}">
<div id="domainregion" class="collection-table column-border" style="margin-bottom: 0px"></div>
  <c:set var="QUERYID" value="${object.primaryIdentifier}" />
  <c:set var="MINEURL" value="${WEB_PROPERTIES['webapp.baseurl']}/${WEB_PROPERTIES['webapp.path']}" />

<svg id="eChart" class="eChart" style="width: 100%;"></svg>

<script type="text/javascript" charset="utf-8">
var queryId="${QUERYID}";
var mineUrl="${MINEURL}/";
var svgId="eChart";
var token="${token}"; // not needed for report, but for temporary lists
var type="${TYPE}";   // the root for the ws query
</script>

<script type="text/javascript" charset="utf-8" src="${WEB_PROPERTIES['head.cdn.location']}/js/d3/3.5.5/d3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${WEB_PROPERTIES['head.cdn.location']}/js/d3-legend/1.8.0/d3-legend.min.js"></script>
<link rel="stylesheet" type="text/css" href="${WEB_PROPERTIES['head.cdn.location']}/js/intermine/expression/1.0.2/expression.css">
<script type="text/javascript" charset="utf-8" src="${WEB_PROPERTIES['head.cdn.location']}/js/intermine/expression/1.0.2/expression.min.js"></script>
<br>
</c:if>
</c:when>
<c:otherwise>
No expression data available for this gene.
</c:otherwise>
</c:choose>

</div>

<br>
<!--  /RNASEQ EXPRESSION -->
