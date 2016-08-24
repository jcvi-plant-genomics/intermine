<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- tdnaseqInsertionsDisplayer.jsp -->
<div id="TdnaseqInsertionsDisplayer" class="collection-table">
<div class="header">
<h3>TDNA-Seq Insertions</h3>
<p>Data Source: <a target="_blank" href="/${WEB_PROPERTIES['webapp.path']}/portal.do?class=DataSet&externalids=SIGnAL">SIGnAL</a></p>
</div>

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${((!empty object.chromosomeLocation && !empty object.chromosome)
                || className == 'Chromosome') && className != 'ChromosomeBand'}">
  <c:set var="name" value="${object.primaryIdentifier}"/>

<div id="salk-tdnaseq-table-container" class="collection-table imtables-dashboard container-fluid imtables">
 <div id="salk-tdnaseq-container"></div>

</div>

 <script type="text/javascript">
    var featureId = "${name}";
    var selector = '#salk-tdnaseq-container';
    var service  = {root: "${WEB_PROPERTIES['webapp.baseurl']}/${WEB_PROPERTIES['webapp.path']}/service"};
    var query    = {
        "from": "SequenceFeature",
        "select": [
            "overlappingFeatures.symbol",
            "overlappingFeatures.polymorphismSite",
            "overlappingFeatures.chromosome.primaryIdentifier",
            "overlappingFeatures.chromosomeLocation.start",
            "overlappingFeatures.chromosomeLocation.end"
        ],
        "orderBy": [ { "path": "overlappingFeatures.symbol", "direction": "ASC" } ],
        "where": [ { "path": "primaryIdentifier", "op": "=", "value": featureId, "code": "A" },
            { "path": "overlappingFeatures", "type": "TransposableElementInsertionSite" } ]
    };

    imtables.loadDash(
        selector, // Can also be an element, or a jQuery object.
        {"start":0,"size":5}, // May be null
        {service: service, query: query} // May be an imjs.Query
    ).then(
        function (table) { console.log('Table loaded', table); },
        function (error) { console.error('Could not load table', error); }
    );
 </script>
</c:when>
<c:otherwise>
  <p style="font-style:italic;">No TDNA-Seq Insertions data available</p>
</c:otherwise>
</c:choose>
</div>
<!-- /tdnaseqInsertionsDisplayer.jsp -->
