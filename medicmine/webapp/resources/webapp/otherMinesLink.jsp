<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/functions.tld" prefix="imf" %>

<!-- This section is rendered with Ajax to improve responsiveness -->
<c:if test="${!empty mines && imf:hasValidPath(object, 'organism.shortName', INTERMINE_API)}">
<script type="text/javascript" charset="utf-8" src="js/other-mines-links.js"></script>
<script type="text/javascript" charset="utf-8" src="js/other-mines-synteny-links.js"></script>

<c:set var="chromosomeLocation" value="${object.chromosomeLocation.locatedOn.primaryIdentifier}:${object.chromosomeLocation.start}-${object.chromosomeLocation.end}"/>
<h3 class="goog"><fmt:message key="othermines.title"/></h3>
<div id="friendlyMines">
  <c:forEach items="${mines}" var="mine">
    <div class="mine" id="partner_mine_${mine.name}">

      <span style="background:${mine.bgcolor};color:${mine.frontcolor};">
          <c:out value="${mine.name}"/>
      </span>

      <div class="loading-indicator"></div>

      <span class="apology" style="display:none">
          <fmt:message key="noResults.title"/>
      </span>

      <ul class="results"></ul>

      <script type="text/javascript" charset="utf-8">
        var mine = {name: '${mine.name}', url: '${mine.url}'};
        var req = {
          origin: '${localMine.name}',
          domain: '${object.organism.shortName}'
        };
<c:forEach items="${mine.linkClasses}" var="linkClass">
    <c:if test="${linkClass == 'homologue' || linkClass == 'phytomineHomolog'}">
        req.identifiers = '${object.primaryIdentifier}';
        OtherMines.getLinks('#partner_mine_${mine.name}', mine, req);
    </c:if>
    <c:if test="${linkClass == 'syntenyBlock'}">
        req.chromosomeLocation = '${chromosomeLocation}';
        OtherMinesSynteny.getLinks('#partner_mine_${mine.name}', mine, req);
    </c:if>
</c:forEach>
      </script>

    </div>
  </c:forEach>
</div>
</c:if>
