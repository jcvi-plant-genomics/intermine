<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>


<!-- dataCategories -->

<html:xhtml/>

<div class="body">
    <div>
        <p><h1>Data</h1></p>
        <p>MedicMine integrates biological data from a wide array of public sources into a data warehouse.
        This page lists the data source/sets that are included in the current release.</p>
        <p>Please <a href="mailto:support@medicagogenome.org?Subject=MedicMine Data request"> contact us
        </a> if there are any particular data you would like to suggest.</p>
    </div>
    <br />
    <hr />
    <br />

    <h2><i>Medicago truncatula</i> (barrel medic) Mt4.0 genome Data Source/Sets</h2><br />
    <div id="reference-genome-data-elem"></div>

    <h2>Public Data Sources/Sets</h2><br />
    <div id="public-data-elem"></div>

    <script type="text/javascript">
        var refdata_selector = '#reference-genome-data-elem';
        var pubdata_selector = '#public-data-elem';
        var service  = new imjs.Service({root: "${WEB_PROPERTIES['webapp.baseurl']}/${WEB_PROPERTIES['webapp.path']}"});

        var refdata_query    = {
          "from": "DataSource",
          "select": [ "name", "description", "dataSets.name", "dataSets.description", "dataSets.version", "publications.firstAuthor", "publications.year" ],
          "orderBy": [ { "path": "name", "direction": "ASC" } ],
          "joins": [ "dataSets" ],
          "where": [ { "path": "name", "op": "=", "value": "MTGD", "code": "A" } ]
        };

        var pubdata_query    = {
          "from": "DataSource",
          "select": [ "name", "description", "dataSets.name", "dataSets.description", "dataSets.version", "publications.firstAuthor", "publications.year" ],
          "orderBy": [ { "path": "name", "direction": "ASC" } ],
          "joins": [ "dataSets" ],
          "where": [ { "path": "name", "op": "!=", "value": "MTGD", "code": "A" } ]
        };

        imtables.configure('TableCell.IndicateOffHostLinks', false);
        imtables.configure('Subtables.Initially.expanded', true);

        imtables.loadTable(
          refdata_selector, // Can also be an element, or a jQuery object.
          {"start":0,"size":25}, // May be null
          {service: service, query: refdata_query} // May be an imjs.Query
        ).then(
          function (table) { console.log('Table loaded', table); },
          function (error) { console.error('Could not load table', error); }
        );

        imtables.loadTable(
          pubdata_selector, // Can also be an element, or a jQuery object.
          {"start":0,"size":25}, // May be null
          {service: service, query: pubdata_query} // May be an imjs.Query
        ).then(
          function (table) { console.log('Table loaded', table); },
          function (error) { console.error('Could not load table', error); }
        );
    </script>

</div>
<!-- /dataCategories -->
