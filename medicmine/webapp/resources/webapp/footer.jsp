<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- footer.jsp -->
<br/>
<br/>
<br/>

<div class="body" align="center" style="clear:both">
    <!-- contact -->
    <c:if test="${pageName != 'contact'}">
        <div id="contactFormDivButton">
            <im:vspacer height="11" />
            <div class="contactButton">
                <a href="#" onclick="showContactForm();return false">
                    <b><fmt:message key="feedback.title"/></b>
                </a>
            </div>
        </div>
        <div id="contactFormDiv" style="display:none;">
            <im:vspacer height="11" />
            <tiles:get name="contactForm" />
        </div>
    </c:if>
    <br/>

<div id="promo-footer">
  <!-- powered -->
  <div class="powered-footer footer">
    <p>Powered by</p>
    <a target="new" href="http://intermine.org" title="InterMine">
      <img src="images/icons/intermine-footer-logo.png" alt="InterMine logo" />
    </a>
  </div>
    <div class="android">
        <p>Have you tried our InterMine Android app?</p>
        <a href='https://play.google.com/store/apps/details?id=org.intermine.app&utm_source=global_co&utm_medium=prtnr&utm_content=Mar2515&utm_campaign=PartBadge&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1' target="_blank"><img class="googleplay" alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' /></a>
    </div>
    <div class="cite-footer footer">
      <strong>Cite us:</strong>
          <cite>${WEB_PROPERTIES['project.citation']}</cite>
    </div>
</div>
<div class="funding-footer footer">
  <!-- funding -->
  <p><fmt:message key="funding" /></p>
</div>

</div>

<!-- logo and links -->
<div class="body bottom-footer">
    <ul class="footer-links">
        <!-- contact us form link -->
        <li><a href="#" onclick="showContactForm();return false;">Contact Us</a></li>
        <c:set value="${WEB_PROPERTIES['header.links']}" var="headerLinks"/>
        <!-- web properties -->
        <c:forEach var="entry" items="${headerLinks}" varStatus="status">
            <c:set value="header.links.${entry}" var="linkProp"/>
            <c:choose>
                <c:when test="${!empty WEB_PROPERTIES[linkProp]}">
                    <li><a href="${WEB_PROPERTIES[linkProp]}">${entry}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${WEB_PROPERTIES['project.sitePrefix']}/${entry}.shtml">${entry}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

    </ul>

    <!-- mines -->
    <ul class="footer-links">
        <li><a href="http://medicmine.jcvi.org/medicmine/begin.do" target="_blank">JCVI MedicMine (Medicago)</a></li>
        <li><a href="http://intermine.legumefederation.org/legumemine/begin.do" target="_blank">LegFed LegumeMine (various legumes)</a></li>
        <li><a href="http://mines.legumeinfo.org/beanmine/begin.do" target="_blank">LIS BeanMine (string bean)</a></li>
        <li><a href="http://mines.legumeinfo.org/soymine/begin.do" target="_blank">LIS Soymine (soybean)</a></li>
        <li><a href="http://mines.legumeinfo.org/peanutmine/begin.do" target="_blank">LIS PeanutMine (several peanut species)</a></li>
        <li><a href="https://apps.araport.org/thalemine/begin.do" target="_blank">ThaleMine (Arabidopsis thaliana)</a></li>
        <li><a href="https://phytozome.jgi.doe.gov/phytomine/begin.do" target="_blank">PhytoMine (Plant Comparative Genomics)</a></li>
    </ul>

    <p class="footer-copy">&copy; 2014 - 2016 Plant Genomics, J. Craig Venter Institute, 9714 Medical Center Dr,<br />
        Rockville, MD 20850, United States of America</p>

    <div style="clear:both"></div>
</div>
<!-- /footer.jsp -->
