<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- jBrowseDisplayer.jsp -->

<c:if test="${((!empty reportObject.object.chromosomeLocation && !empty reportObject.object.chromosome)
                || cld.unqualifiedName == 'Chromosome') && cld.unqualifiedName != 'ChromosomeBand'}">

  <div class="geneInformation">

    <h3 class="overlapping">Genome Browser</h3>

    <c:set var="jbrowseURL" value="${WEB_PROPERTIES['jbrowse.install.url']}"/>
    <c:set var="chr" value="${reportObject.object.chromosomeLocation.locatedOn.primaryIdentifier}"/>

    <c:set var="offset" value="${fn:substringBefore((reportObject.object.length * 0.1), '.')}"/>

    <c:set var="start" value="${reportObject.object.chromosomeLocation.start - offset}"/>
    <c:set var="end" value="${reportObject.object.chromosomeLocation.end + offset}"/>

    <c:set var="genus" value="${reportObject.object.organism.genus}"/>
    <c:set var="species" value="${reportObject.object.organism.species}"/>
    <c:set var="taxon" value="${reportObject.object.organism.taxonId}"/>

    <c:set var="tracks" value="${WEB_PROPERTIES['project.title']}-${taxon}-${reportObject.type}"/>
    <c:set var="dataURL" value="${WEB_PROPERTIES['webapp.baseurl']}/${WEB_PROPERTIES['webapp.path']}/service/jbrowse/config/${taxon}"/>
    <c:set var="dataSource" value="${WEB_PROPERTIES['jbrowse.database.source']}"/>

    <c:set var="jbLink" value="${jbrowseURL}?data=${dataURL}&loc=${chr}:${start}..${end}&tracks=${tracks}&tracklist=0&nav=0&overview=0"/>
    <c:set var="jbLinkFullScreen" value="${jbrowseURL}?data=${dataSource}&loc=${chr}:${start}..${end}"/>

    <a href="${jbLink}" target="jbrowse">Center on ${reportObject.object.symbol}</a>&nbsp;|&nbsp;<a href="${jbLinkFullScreen}" target="_blank">Full-screen view</a></p>
    <iframe name="jbrowse" height="300px" width="98%" style="border: 1px solid #dfdfdf; padding: 1%" src="${jbLink}"></iframe>
    <p><a href="javascript:;" onclick="jQuery('iframe').css({height: '600px'});">Expand viewer</a>&nbsp;(more about <a href="http://jbrowse.org">JBrowse</a>)</p>
</div>

</c:if>
<!-- /jBrowseDisplayer.jsp -->
