<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- barEfpBrowserDisplayer.jsp -->
<div id="efp_browser_displayer" class="collection-table">
<div class="header">
<h3>eFP Visualization</h3>
    <p>Data Source: <a target="_blank" href="/${WEB_PROPERTIES['webapp.path']}/portal.do?class=DataSet&externalids=BAR+Interactions+data+set">BAR</a></p>
</div>

<c:set var="object" value="${reportObject.object}"/>

<c:choose>
<c:when test="${!empty object.probesetIdentifier}">

<div id="eFPBrowser" class="feature basic-table">
  <c:set var="name" value="${object.probesetIdentifier}"/>
  <c:set var="datasource" value="medicago mas"/>

  <c:choose>
  <c:when test="${WEB_PROPERTIES['bar.eFPBrowser.prefix'] != null}">
  <style type="text/css">
      #powerby { padding: 5px; text-align: center; }
      #powerby a { color: rgb(136, 136, 136); text-decoration: none; background-color: white; }
      #powerby img { vertical-align: middle; }
  </style>
  <div>
      <br /><br />
      <iframe style="border: 1px solid black"
          src="${WEB_PROPERTIES['bar.eFPBrowser.prefix']}?dataSource=medicago_rma&modeInput=Absolute&primaryGene=${name}&primaryProbeset=${name}"
          width="820" height="820">
      </iframe>
  </div>
  </c:when>
  <c:otherwise>
   	<p>There are no probeset data available for this gene.</code>.</p>
	<script type="text/javascript">
		jQuery('#eFPBrowser').addClass('warning');
	</script>
  </c:otherwise>
  </c:choose>
</div>
</c:when>
<c:otherwise>
<div id="eFPBrowser" class="feature basic-table warning">
  <h3><fmt:message key="sequenceFeature.eFPBrowser.message"/></h3>
  <p>There was a problem rendering the BAR eFP Browser.</p>
</div>
</c:otherwise>
</c:choose>
<!-- /barEfpBrowserDisplayer.jsp -->
