<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- lisLinksDisplayer.jsp -->
<tiles:importAttribute />
<style>
	div#lisLinks li { margin-top:10px; margin-bottom:10px; }
</style>

<c:set var="primaryId" value="${object.primaryIdentifier}" />

<h3 class="goog">${WEB_PROPERTIES['lislinks.name']}</h3>
<div id="lisLinks"></div>
<script type="text/javascript">
        var primaryId = "${primaryId}";
        var lisJsonUrl = "${WEB_PROPERTIES['lislinks.url']}" + "/"
                        + "${WEB_PROPERTIES['lislinks.key_prefix']}" + primaryId
                        + "/json";
        fetch(lisJsonUrl).then(function(response) {
            return response.json();
        }).then(function(json) {
            var innerHtml = '<ul>';
            for(var i = 0; i < json.length; i++) {
                innerHtml += '<li><a rel="external" target="_blank" href="' + json[i].href + '">' + json[i].text + '</a></li>';
            }
            innerHtml += '</ul>';
            document.getElementById("lisLinks").innerHTML = innerHtml;
        });
</script>
<!-- /lisLinksDisplayer.jsp -->

