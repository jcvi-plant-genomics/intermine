<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- lisSyntenicRegionsDisplayer.jsp -->
<div id="lisSyntenicRegions_displayer" class="collection-table">
<div class="header">
<h3>LIS Syntenic Regions</h3>
<p>Data Source: <a target="_blank" href="${WEB_PROPERTIES['legumemine.url']}">LegumeMine</a></p>
</div>

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${!empty object.primaryIdentifier}">
<br />

<div id="LisSyntenicRegionsDisplayer" class="collection-table imtables-dashboard container-fluid imtables">
  <c:set var="chrId" value="${object.chromosome.primaryIdentifier}"/>
  <c:set var="orgnShortName" value="${object.organism.shortName}"/>
  <c:set var="start" value="${object.chromosomeLocation.start}"/>
  <c:set var="end" value="${object.chromosomeLocation.end}"/>

  <c:choose>
  <c:when test="${WEB_PROPERTIES['legumemine.url'] != null}">
<link rel="stylesheet" type="text/css" href="${WEB_PROPERTIES['head.cdn.location']}/js/intermine/im-tables/latest/imtables.css">
 <div id="legumemine-syntenic-regions-container">
 <!-- temporarily removed
   <p class="apology">
     Please be patient while the results of your query are retrieved.
   </p>
   -->
 </div>

 <script type="text/javascript">

    var chrId = "${chrId}";
    var objClass = imSummaryFields.type;
    var orgnShortName = "${orgnShortName}";
    var featStart = "${start}";
    var featEnd = "${end}";
    // for local test only
    var webapp_root_url = "${WEB_PROPERTIES['legumemine.url']}";

    var legumemine = new imjs.Service({root: webapp_root_url});
    var imjsquery  = {
        "from": "SyntenyBlock",
        "select": [
            "sourceRegion.primaryIdentifier", "targetRegion.primaryIdentifier",
            "medianKs", "targetRegion.organism.shortName"
        ],
        "where": [
            { "path": "sourceRegion.organism.shortName", "op": "=", "value": orgnShortName, "code": "A" },
            { "path": "sourceRegion.chromosome", "op": "LOOKUP", "value": chrId, "extraValue": orgnShortName, "code": "B" },
            { "path": "sourceRegion.chromosomeLocation.start", "op": "<", "value": featStart, "code": "C" },
            { "path": "sourceRegion.chromosomeLocation.start", "op": "<", "value": featEnd, "code": "D" },
            { "path": "sourceRegion.chromosomeLocation.end", "op": ">", "value": featStart, "code": "E" },
            { "path": "sourceRegion.chromosomeLocation.end", "op": ">", "value": featEnd, "code": "F" }
        ],
        "constraintLogic": "A and B and ((C and E) or (D and F))"
    };

    var options = {
        type: 'table',
        service: legumemine,
        query: imjsquery,
        properties: { pageSize: 10 }
    };

    // set up InterMine LinkFormatters to reformat sourceRegion column in data table
    var formatLink = function(url, text, target, cls){
        target = target || "_self";
        text = text || url;

        if (cls == 'extlink') {
            return '<a class="'+cls+'" href="'+url+'" target="'+target+'">' + text + '</a>';
        } else {
            return '<a href="'+url+'" target="'+target+'">' + text + '</a>';
        }
    };

    var formatSourceRegionLink = function(id) {
        var prefixToReplace = "medtr.Chr0";
        if (id.indexOf(prefixToReplace) == -1) {
            var extLink = '${WEB_PROPERTIES['legumemine.url']}' + '/portal.do?class=SyntenicRegion' + '&externaids=' + id;
            return formatLink(extLink, id, "_blank", "extlink");
        }
        var chromLocation = id.replace(prefixToReplace, "chr");

        var baseClass = "SequenceFeature";
        var imqxml = [
            '<query model="genomic" view="SequenceFeature.primaryIdentifier SequenceFeature.briefDescription" sortOrder="SequenceFeature.primaryIdentifier asc">',
            '<constraint path="SequenceFeature.chromosomeLocation" op="WITHIN">',
            '<value>' + chromLocation + '</value>',
            '</constraint>',
            '</query>'
        ].join("\n");

        var sourceRegionLinkElems = [id];

        var re = new RegExp(baseClass, 'g');
        var qxml = imqxml.replace(re, objClass);
        var qlink = '/${WEB_PROPERTIES['webapp.path']}' + '/loadQuery.do?query=' +
        encodeURIComponent(qxml) + '&method=xml';
        var qlinkText = objClass + 's within SyntenicRegion';

        sourceRegionLinkElems.push(formatLink(qlink, qlinkText, "_blank", undefined));
        var sourceRegionLink = sourceRegionLinkElems.join(" | ");

        return sourceRegionLink;
    };

    var sourceRegionLinkFormatter = function(o) {
        return formatSourceRegionLink(o.get('primaryIdentifier'));
    }

    imtables.formatting
                .registerFormatter(sourceRegionLinkFormatter, 'genomic', 'SyntenicRegion', ['primaryIdentifier']);

    // note: imtables.loadTable delivers a table without controls (only pagination)

    imtables.configure('DefaultPageSize', 10);
    imtables.configure('TableCell.IndicateOffHostLinks', false);

    imtables.loadDash('#legumemine-syntenic-regions-container',
        {start : 0, size : 10},
        {service : options.service, query : options.query}
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
     <p>There was a problem rendering the LIS Syntenic Region data</code>.</p>
  <script type="text/javascript">
    jQuery('#LisSyntenicRegionsDisplayer').addClass('warning');
  </script>
  </c:otherwise>
  </c:choose>
</c:when>
<c:otherwise>
  <p style="font-style:italic;">No LIS Syntenic Region data available</p>
</c:otherwise>
</c:choose>
</div>
<!-- /lisSyntenicRegionsDisplayer.jsp -->
