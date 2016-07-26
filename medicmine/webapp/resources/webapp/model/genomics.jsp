<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td valign="top">
      <div class="heading2">
        Data sets
      </div>
    </td>
    <td valign="top">
      <div class="heading2">
        Bulk download
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <div class="body">
        <p>
          <a href="/medicmine">MedicMine</a> contains <i>Medicago truncatula</i> genome
          data from:
        </p>
        <ul>
          <li>
            <a href="http://www.genedb.org/">
              Fasta sequences for <i>M. truncatula</i></a>
          </li>
          <li>
            <a href="http://www.genedb.org/">
              GFF3 for <i>M. truncatula</i> genome features</a>
          </li>
        </ul>
        <!-- The Element we will target -->
        <div id="ref-genome-datasets-elem"></div>
        <!-- The imtables source -->
        <script type="text/javascript">
            var selector = '#ref-genome-datasets-elem';
            var service  = new imjs.Service({ root: "${WEB_PROPERTIES['webapp.baseurl']}/${WEB_PROPERTIES['webapp.path']}" });

            var query    = {
              "from": "DataSource",
              "select": [ "name", "dataSets.name", "dataSets.description", "dataSets.version" ],
              "orderBy": [ { "path": "dataSets.version", "direction": "ASC" } ],
              "where": [ { "path": "name", "op": "=", "value": "MTGD", "code": "A" } ]
            };

            imtables.configure('DefaultPageSize', 10);
            imtables.configure('TableCell.IndicateOffHostLinks', false);
            imtables.loadTable(
              selector, // Can also be an element, or a jQuery object.
              {"start":0,"size":25}, // May be null
              {service: service, query: query} // May be an imjs.Query
            ).then(
              function (table) { console.log('Table loaded', table); },
              function (error) { console.error('Could not load table', error); }
            );
        </script>
      </div>
    </td>
    <td width="40%" valign="top">
      <div class="body">
        <ul>
          <li>
            <im:querylink text="All <i>M. truncatula</i> genes identifiers, chromosome positions and chromosome identifiers" skipBuilder="true">
<query name="" model="genomic" view="Gene.primaryIdentifier Gene.secondaryIdentifier Gene.organism.shortName Gene.chromosome.primaryIdentifier Gene.chromosomeLocation.start Gene.chromosomeLocation.end" sortOrder="Gene.primaryIdentifier asc">
</query>
            </im:querylink>
          </li>
        </ul>
      </div>
    </td>
  </tr>
</table>
