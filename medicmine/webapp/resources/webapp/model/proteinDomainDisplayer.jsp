<!-- proteinDomainDisplayer.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${!empty object.primaryIdentifier}">

<div id="domainregion" class="collection-table column-border" style="margin-bottom: 0px"></div>
<c:set var="QUERYID" value="${object.primaryIdentifier}" />
<c:set var="MINEURL" value="${WEB_PROPERTIES['webapp.baseurl']}/${WEB_PROPERTIES['webapp.path']}" />

<svg id="mychart" class="pdchart" style="width: 100%;"></svg>

<script type="text/javascript" charset="utf-8" src="${WEB_PROPERTIES['head.cdn.location']}/js/d3/3.5.5/d3.min.js"></script>
<script type="text/javascript" charset="utf-8">
    var queryId="${QUERYID}";
    var mineUrl="${MINEURL}/";
</script>
<link rel="stylesheet" type="text/css" href="${WEB_PROPERTIES['head.cdn.location']}/js/intermine/protein-domain/1.2.0/protein-domain.css">
<script type="text/javascript" charset="utf-8" src="${WEB_PROPERTIES['head.cdn.location']}/js/intermine/protein-domain/1.2.0/protein-domain.js"></script>

</c:when>
<c:otherwise>
<p style="font-style:italic;">No protein domain data available</p>
</c:otherwise>
</c:choose>
<!-- /proteinDomainDisplayer.jsp -->
