<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- lisGeneFamilyDisplayer.jsp -->
<div id="lisGeneFamily_displayer" class="collection-table">
<div class="header">
<h3>LIS Gene Families</h3>
<p>Data Source: <a target="_blank" href="${WEB_PROPERTIES['legumemine.url']}">LegumeMine</a></p>
</div>

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${!empty object.primaryIdentifier}">
<br />

<div id="PhytozomeHomologDisplayer" class="collection-table imtables-dashboard container-fluid imtables">
  <c:set var="name" value="${object.primaryIdentifier}"/>
  <c:set var="orgName" value="${object.organism.shortName}"/>

  <c:choose>
  <c:when test="${WEB_PROPERTIES['legumemine.url'] != null}">
<link rel="stylesheet" type="text/css" href="${WEB_PROPERTIES['head.cdn.location']}/js/intermine/im-tables/latest/imtables.css">
 <div id="legumemine-homolog-container">
 <!-- temporarily removed
   <p class="apology">
     Please be patient while the results of your query are retrieved.
   </p>
   -->
 </div>

 <script type="text/javascript">

   var geneId = "${name}";
   var orgName = "${orgName}";
   // for local test only
   var webapp_root_url = "${WEB_PROPERTIES['legumemine.url']}";

   var legumemine = new imjs.Service({root: webapp_root_url});
   var imjsquery  = {"from": "Gene", "select": [ "geneFamily.primaryIdentifier", "geneFamily.description", "geneFamily.genes.primaryIdentifier" ],
       "orderBy": [ { "path": "geneFamily.primaryIdentifier", "direction": "ASC" } ],
       "joins": [ "geneFamily.genes" ],
       "where": [
           { "path": "primaryIdentifier", "op": "=", "value": geneId, "code": "A" },
           { "path": "organism.shortName", "op": "=", "value": orgName, "code": "B" }
       ],
       "constraintLogic": "A and B"
   };

   var options = {
     type: 'table',
     service: legumemine,
     query: imjsquery,
     properties: { pageSize: 10 }
    };

    // note: imtables.loadTable delivers a table without controls (only pagination)

    imtables.configure('DefaultPageSize', 10);
    imtables.configure('TableCell.IndicateOffHostLinks', false);

    imtables.loadDash('#legumemine-homolog-container',
        {start : 0, size : 10},
        {service : options.service,
            query : options.query}
        ).then(
            withTable,
            FailureNotification.notify
        );

        function withTable(table) {
            table.bus.on('list-action:failure', LIST_EVENTS['list-creation:failure']);
            table.bus.on('list-action:success', LIST_EVENTS['list-creation:success']);
        }
    </script>

  </c:when>
  <c:otherwise>
     <p>There was a problem rendering the LIS Gene Family data</code>.</p>
  <script type="text/javascript">
    jQuery('#PhytozomeHomologDisplayer').addClass('warning');
  </script>
  </c:otherwise>
  </c:choose>
</c:when>
<c:otherwise>
  <p style="font-style:italic;">No LIS Gene Family data available</p>
</c:otherwise>
</c:choose>
</div>
<!-- /lisGeneFamilyDisplayer.jsp -->
