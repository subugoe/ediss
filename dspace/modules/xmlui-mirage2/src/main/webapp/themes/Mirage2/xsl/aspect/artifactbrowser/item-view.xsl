<?xml version="1.0"?>
<!--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

-->
<!--
    Rendering specific to the item display page.

    Author: art.lowel at atmire.com
    Author: lieven.droogmans at atmire.com
    Author: ben at atmire.com
    Author: Alexey Maslov

-->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1" xmlns:dri="http://di.tamu.edu/DRI/1.0/" xmlns:mets="http://www.loc.gov/METS/" xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" xmlns:xlink="http://www.w3.org/TR/xlink/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:ore="http://www.openarchives.org/ore/terms/" xmlns:oreatom="http://www.openarchives.org/ore/atom/" xmlns="http://www.w3.org/1999/xhtml" xmlns:xalan="http://xml.apache.org/xalan" xmlns:encoder="xalan://java.net.URLEncoder" xmlns:util="org.dspace.app.xmlui.utils.XSLUtils" xmlns:jstring="java.lang.String" xmlns:rights="http://cosimo.stanford.edu/sdr/metsrights/" xmlns:confman="org.dspace.core.ConfigurationManager" version="1.0" exclude-result-prefixes="xalan encoder i18n dri mets dim xlink xsl util jstring rights confman">
  <xsl:output indent="yes"/>
  <xsl:template name="itemSummaryView-DIM">
    <!-- Generate the info about the item from the metadata section -->
    <xsl:apply-templates select="./mets:dmdSec/mets:mdWrap[@OTHERMDTYPE='DIM']/mets:xmlData/dim:dim" mode="itemSummaryView-DIM"/>
    <xsl:copy-of select="$SFXLink"/>
    <!-- Generate the Creative Commons license information from the file section (DSpace deposit license hidden by default)-->
    <xsl:if test="./mets:fileSec/mets:fileGrp[@USE='CC-LICENSE' or @USE='LICENSE']">
      <div class="license-info table">
        <p>
          <i18n:text>xmlui.dri2xhtml.METS-1.0.license-text</i18n:text>
        </p>
        <ul class="list-unstyled">
          <xsl:apply-templates select="./mets:fileSec/mets:fileGrp[@USE='CC-LICENSE' or @USE='LICENSE']" mode="simple"/>
        </ul>
      </div>
    </xsl:if>
  </xsl:template>
  <!-- An item rendered in the detailView pattern, the "full item record" view of a DSpace item in Manakin. -->
  <xsl:template name="itemDetailView-DIM">
    <!-- Output all of the metadata about the item from the metadata section -->
    <xsl:apply-templates select="mets:dmdSec/mets:mdWrap[@OTHERMDTYPE='DIM']/mets:xmlData/dim:dim" mode="itemDetailView-DIM"/>
    <!-- Generate the bitstream information from the file section -->
    <xsl:choose>
      <xsl:when test="./mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL' or @USE='LICENSE']/mets:file">
        <h3>
          <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-head</i18n:text>
        </h3>
        <div class="file-list">
          <xsl:apply-templates select="./mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL' or @USE='LICENSE' or @USE='CC-LICENSE']">
            <xsl:with-param name="context" select="."/>
            <xsl:with-param name="primaryBitstream" select="./mets:structMap[@TYPE='LOGICAL']/mets:div[@TYPE='DSpace Item']/mets:fptr/@FILEID"/>
          </xsl:apply-templates>
        </div>
      </xsl:when>
      <!-- Special case for handling ORE resource maps stored as DSpace bitstreams -->
      <xsl:when test="./mets:fileSec/mets:fileGrp[@USE='ORE']">
        <xsl:apply-templates select="./mets:fileSec/mets:fileGrp[@USE='ORE']" mode="itemDetailView-DIM"/>
      </xsl:when>
      <xsl:otherwise>
        <h2>
          <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-head</i18n:text>
        </h2>
        <table class="ds-table file-list">
          <tr class="ds-table-header-row">
            <th>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-file</i18n:text>
            </th>
            <th>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-size</i18n:text>
            </th>
            <th>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-format</i18n:text>
            </th>
            <th>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-view</i18n:text>
            </th>
          </tr>
          <tr>
            <td colspan="4">
              <p>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-no-files</i18n:text>
              </p>
            </td>
          </tr>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="dim:dim" mode="itemSummaryView-DIM">
    <div class="item-summary-view-metadata">
      <xsl:call-template name="itemTitle"/>
      <!-- <xsl:call-template name="itemSummaryView-DIM-file-section"/>


                    <xsl:call-template name="itemSummaryView-DIM-date"/>
                    <xsl:call-template name="itemSummaryView-DIM-authors"/>
                    <xsl:if test="$ds_item_view_toggle_url != ''">
                        <xsl:call-template name="itemSummaryView-show-full"/>
                    </xsl:if>

                    <xsl:call-template name="itemSummaryView-DIM-abstract"/>
                    <xsl:call-template name="itemSummaryView-DIM-URI"/>
                    <xsl:call-template name="itemSummaryView-collections"/> -->
      <xsl:call-template name="itemTitleTranslated"/>
      <xsl:call-template name="itemAuthors"/>
      <xsl:call-template name="itemType"/>
      <!-- <xsl:apply-templates select="$dim" mode="itemAuthorBirthname"/> -->
      <xsl:call-template name="itemExamination"/>
      <!--<xsl:apply-templates select="$dim" mode="itemCitation"/>-->
      <xsl:call-template name="itemDate"/>
      <!--<xsl:apply-templates select="$dim" mode="itemPublisher"/>-->
      <!-- <xsl:apply-templates select="$dim" mode="itemPURL"/> -->
      <!--<xsl:apply-templates select="$dim" mode="itemEmail"/>-->
      <!--<xsl:apply-templates select="$dim" mode="itemBirth"/>-->
      <!-- <xsl:apply-templates select="$dim" mode="itemInstitute"/> -->
      <!-- <xsl:apply-templates select="$dim" mode="itemURN"/> -->
      <xsl:call-template name="itemAdvisor"/>
      <xsl:call-template name="itemReferee"/>
      <xsl:call-template name="itemCoreferee"/>
      <xsl:call-template name="itemThirdreferee"/>
      <xsl:call-template name="itemSeries"/>
      <xsl:call-template name="itemURI"/>
      <!--<xsl:apply-templates select="$dim" mode="itemType-DIM"/>-->
      <!--<xsl:apply-templates select="$dim" mode="itemLanguage-DIM"/>-->
      <!--<xsl:apply-templates select="$dim" mode="itemSeries-DIM"/>-->
      <xsl:if test="$ds_item_view_toggle_url != ''">
        <p class="ds-paragraph item-view-toggle item-view-toggle-bottom">
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$ds_item_view_toggle_url"/>
            </xsl:attribute>
            <!-- <i18n:text>xmlui.ArtifactBrowser.ItemViewer.show_full</i18n:text> -->
            <xsl:text>&#xA0;</xsl:text>
          </a>
        </p>
      </xsl:if>
      <span class="spacer">&#xA0;</span>
      <xsl:call-template name="itemSummaryView-DIM-file-section"/>
      <xsl:choose>
      <xsl:when test="//dim:field[@element='notes'][@qualifier='embargohistory']">
        <p class="small">
          <i18n:text>xmlui.item.oldembargo</i18n:text>
          <xsl:text>: </xsl:text>
          <xsl:value-of select="//dim:field[@element='date'][@qualifier='embargoed']"/>
        </p>
	</xsl:when>
	<xsl:when test="//dim:field[@element='date'][@qualifier='embargoed']">
        <div class="embargo-info">
          <p>
            <xsl:choose>
              <xsl:when test="contains(//dim:field[@element='date'][@qualifier='embargoed'], '3000')">
                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed-examen</i18n:text>
              </xsl:when>
              <xsl:when test="contains(//dim:field[@element='date'][@qualifier='embargoed'], '5000')">
                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed-unknown</i18n:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="year">
                  <xsl:value-of select="substring-before(//dim:field[@element='date'][@qualifier='embargoed'], '-')"/>
                </xsl:variable>
                <xsl:variable name="monthday">
                  <xsl:value-of select="substring-after(//dim:field[@element='date'][@qualifier='embargoed'], '-')"/>
                </xsl:variable>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed1</i18n:text>
                <xsl:value-of select="substring-after($monthday, '-')"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="substring-before($monthday, '-')"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$year"/>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed2</i18n:text>
              </xsl:otherwise>
            </xsl:choose>
          </p>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="lc">
          <xsl:choose>
            <xsl:when test="contains(dim:field[@element='rights'][@qualifier='uri'], 'creativecommons')">
		    <xsl:value-of select="concat('/themes/Mirage2/images/creativecommons/cc-', substring-before(substring-after(dim:field[@element='rights'][@qualifier='uri'], 'licenses/'), '/'), '.png')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>cc-by-nc-nd</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="lc-img">
          <xsl:choose>
            <xsl:when test="contains(dim:field[@element='rights'][@qualifier='uri'], 'creativecommons')">
              <xsl:value-of select="concat('/themes/Mirage2/images/creativecommons/cc-', substring-before(substring-after(dim:field[@element='rights'][@qualifier='uri'], 'licenses/'), '/'), '.png')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>/themes/Mirage2//images/creativecommons/cc-by-nc-nd.png</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <div class="license-info">
          <p>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.license-text</i18n:text>
          </p>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="concat('http://creativecommons.org/licenses/', substring-after($lc, 'cc-'), '/4.0/')"/>
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:value-of select="$lc"/>
            </xsl:attribute>
            <img>
              <xsl:attribute name="id">cc-license</xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="$lc-img"/>
              </xsl:attribute>
            </img>
            <!-- <xsl:text> creativecommons: </xsl:text>
			<xsl:value-of select="$lc"/> -->
          </a>
        </div>
        <xsl:apply-templates select="mets:fileGrp[@USE='CC-LICENSE']" mode="simple"/>
        <!-- <xsl:call-template name="itemLicense" /> -->
</xsl:otherwise>
</xsl:choose>
      <xsl:if test="//dim:field[@element='notes'][@qualifier='extern']">
        <xsl:call-template name="itemNotesExtern"/>
      </xsl:if>
      <hr/>
      <h2>
        <i18n:text>xmlui.dri2xhtml.METS-1.0.item-abstract</i18n:text>
      </h2>
      <div class="metadata">
        <xsl:call-template name="itemAbstractEng"/>
        <xsl:call-template name="itemKeywords">
          <xsl:with-param name="lang">eng</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="itemAbstractGer"/>
        <xsl:call-template name="itemAbstractOther"/>
        <xsl:call-template name="itemKeywords">
          <xsl:with-param name="lang">ger</xsl:with-param>
        </xsl:call-template>
        <div class="spacer">&#xA0;</div>
      </div>
      <hr/>
      <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
          <xsl:variable name="hdl">
            <xsl:value-of select="//dim:field[@element='identifier'][@qualifier='uri']"/>
          </xsl:variable>
          <xsl:variable name="title">
            <xsl:value-of select="//dim:field[@element='title' and not(@qualifier)]"/>
          </xsl:variable>
          <ul class="share-buttons">
            <li>
              <a target="_blank">
                <xsl:attribute name="title"><!-- <i18n:text>xmlui.item.socialmedia.email</i18n:text> -->
						E-Mail
					</xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:text>mailto:?subject=</xsl:text>
                  <xsl:value-of select="$title"/>
                  <xsl:text>&amp;body=Publikation:</xsl:text>
                  <xsl:value-of select="$hdl"/>
                </xsl:attribute>
                <span class="icon-mail-1"/>
              </a>
            </li>
            <li>
              <a target="_blank">
                <xsl:attribute name="title"><!-- <i18n:text>xmlui.item.socialmedia.tweet</i18n:text> -->
						Tweet
					</xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:text>https://twitter.com/intent/tweet?text=</xsl:text>
                  <xsl:value-of select="$title"/>
                  <xsl:text>&amp;url=</xsl:text>
                  <xsl:value-of select="$hdl"/>
                </xsl:attribute>
                <span class="icon-twitter-1"/>
              </a>
            </li>
            <li>
              <a target="_blank">
                <xsl:attribute name="title"><!-- <i18n:text>xmlui.item.socialmedia.facebook</i18n:text> -->
						Share on Facebook
					</xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:text>https://www.facebook.com/sharer/sharer.php?u=</xsl:text>
                  <xsl:value-of select="$hdl"/>
                  <xsl:text>&amp;t=</xsl:text>
                  <xsl:value-of select="$title"/>
                </xsl:attribute>
                <span class="icon-facebook"/>
              </a>
            </li>
            <li>
              <a target="_blank">
                <xsl:attribute name="title"><!-- <i18n:text>xmlui.item.socialmedia.googleplus</i18n:text> -->
						Share on Google+
					</xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:text>https://plus.google.com/share?url=</xsl:text>
                  <xsl:value-of select="$hdl"/>
                </xsl:attribute>
                <span class="icon-gplus-1"/>
              </a>
            </li>
            <li>
              <a target="_blank">
                <xsl:attribute name="title"><!--     <i18n:text>xmlui.item.socialmedia.linkedin</i18n:text> -->
							Share on LinkedIn
						</xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:text>http://www.linkedin.com/shareArticle?mini=true&amp;url=</xsl:text>
                  <xsl:value-of select="$hdl"/>
                  <xsl:text>&amp;title=</xsl:text>
                  <xsl:value-of select="$title"/>
                </xsl:attribute>
                <span class="icon-linkedin-1"/>
              </a>
            </li>
          </ul>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
          <xsl:if test="not(//dim:field[@element='date'][@qualifier='embargoed'])">
            <div class="statistics pull-right">
              <xsl:variable name="statlink">
                <xsl:value-of select="concat('http://ediss.uni-goettingen.de/handle', substring-after(//dim:field[@element='identifier'][@qualifier='uri'], 'http://hdl.handle.net'), '/statistics')"/>
              </xsl:variable>
              <a href="{$statlink}">
                <span class="icon-chart-bar"/>
                <i18n:text>xmlui.statistic.link</i18n:text>
              </a>
            </div>
          </xsl:if>
        </div>
      </div>
    </div>
    <hr/>
  </xsl:template>
  <xsl:template name="itemTitle">
    <xsl:choose>
      <xsl:when test="count(dim:field[@element='title'][not(@qualifier)]) &gt; 1">
        <h1 class="page-header first-page-header">
          <xsl:value-of select="dim:field[@element='title'][not(@qualifier)][1]/node()" disable-output-escaping="yes"/>
        </h1>
        <div class="simple-item-view-other">
          <p class="lead">
            <xsl:for-each select="dim:field[@element='title'][not(@qualifier)]">
              <xsl:if test="not(position() = 1)">
                <xsl:value-of select="./node()"/>
                <xsl:if test="count(following-sibling::dim:field[@element='title'][not(@qualifier)]) != 0">
                  <xsl:text>; </xsl:text>
                  <br/>
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
          </p>
          <xsl:if test="dim:field[@element='title'][@qualifier='alternative']">
            <p class="subtitle">
              <xsl:value-of select="dim:field[@element='title'][@qualifier='alternative']" disable-output-escaping="yes"/>
            </p>
          </xsl:if>
        </div>
      </xsl:when>
      <xsl:when test="count(dim:field[@element='title'][not(@qualifier)]) = 1">
        <h1 class="page-header first-page-header">
          <xsl:value-of select="dim:field[@element='title'][not(@qualifier)][1]/node()" disable-output-escaping="yes"/>
        </h1>
        <xsl:if test="dim:field[@element='title'][@qualifier='alternative']">
          <p class="subtitle">
            <xsl:value-of select="dim:field[@element='title'][@qualifier='alternative']" disable-output-escaping="yes"/>
          </p>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <h1 class="page-header first-page-header">
          <i18n:text>xmlui.dri2xhtml.METS-1.0.no-title</i18n:text>
        </h1>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="itemSummaryView-DIM-thumbnail">
    <div class="thumbnail">
      <xsl:choose>
        <xsl:when test="//mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']">
          <xsl:variable name="src">
            <xsl:choose>
              <xsl:when test="/mets:METS/mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/mets:file[@GROUPID=../../mets:fileGrp[@USE='CONTENT']/mets:file[@GROUPID=../../mets:fileGrp[@USE='THUMBNAIL']/mets:file/@GROUPID][1]/@GROUPID]">
                <xsl:value-of select="/mets:METS/mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/mets:file[@GROUPID=../../mets:fileGrp[@USE='CONTENT']/mets:file[@GROUPID=../../mets:fileGrp[@USE='THUMBNAIL']/mets:file/@GROUPID][1]/@GROUPID]/mets:FLocat[@LOCTYPE='URL']/@xlink:href"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="//mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/mets:file/mets:FLocat[@LOCTYPE='URL']/@xlink:href"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <!-- Checking if Thumbnail is restricted and if so, show a restricted image -->
          <xsl:choose>
            <xsl:when test="contains($src,'isAllowed=n')"/>
            <xsl:otherwise>
              <img class="img-thumbnail" alt="Thumbnail">
                <xsl:attribute name="src">
                  <xsl:value-of select="$src"/>
                </xsl:attribute>
              </img>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <img class="img-thumbnail" alt="Thumbnail">
            <xsl:attribute name="data-src">
              <xsl:text>holder.js/100%x</xsl:text>
              <xsl:value-of select="$thumbnail.maxheight"/>
              <xsl:text>/text:No Thumbnail</xsl:text>
            </xsl:attribute>
          </img>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  <xsl:template name="itemAbstract">
    <xsl:if test="dim:field[@element='description' and @qualifier='abstract']">
      <div class="simple-item-view-description item-page-field-wrapper table">
        <h5 class="visible-xs">
          <i18n:text>xmlui.dri2xhtml.METS-1.0.item-abstract</i18n:text>
        </h5>
        <div>
          <xsl:for-each select="dim:field[@element='description' and @qualifier='abstract']">
            <xsl:choose>
              <xsl:when test="node()">
                <xsl:copy-of select="node()"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>&#xA0;</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="count(following-sibling::dim:field[@element='description' and @qualifier='abstract']) != 0">
              <div class="spacer">&#xA0;</div>
            </xsl:if>
          </xsl:for-each>
          <xsl:if test="count(dim:field[@element='description' and @qualifier='abstract']) &gt; 1">
            <div class="spacer">&#xA0;</div>
          </xsl:if>
        </div>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemAbstractGer">
    <!-- Abstract german row -->
    <xsl:if test="dim:field[@element='description' and @qualifier='abstractger']">
      <div class="simple-item-view-abstract">
        <!--<span class="bold"><i18n:text>xmlui.dri2xhtml.METS-1.0.item-description</i18n:text>:</span>-->
        <h3>
          <i18n:text>xmlui.general.language.de</i18n:text>
        </h3>
        <span>
          <xsl:value-of select="dim:field[@element='description' and @qualifier='abstractger']" disable-output-escaping="yes"/>
        </span>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemAbstractEng">
    <!-- Abstract english row -->
    <xsl:if test="dim:field[@element='description' and @qualifier='abstracteng']">
      <div class="simple-item-view-abstract">
        <!--<span class="bold"><i18n:text>xmlui.dri2xhtml.METS-1.0.item-description</i18n:text>:</span>-->
        <h3>
          <i18n:text>xmlui.general.language.en</i18n:text>
        </h3>
        <span>
          <xsl:value-of select="dim:field[@element='description' and @qualifier='abstracteng']" disable-output-escaping="yes"/>
        </span>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemAbstractOther">
    <xsl:if test="(dim:field[@element='description' and @qualifier='abstract'] and string-length(dim:field[@element='description' and @qualifier='abstract']) &gt; 1)">
      <div class="simple-item-view-abstract">
        <h3>
          <i18n:text>xmlui.general.language.other</i18n:text>
        </h3>
        <xsl:for-each select="//dim:field[@element='description' and @qualifier='abstract']">
          <div>
            <xsl:value-of select="." disable-output-escaping="yes"/>
          </div>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemNotesExtern">
    <xsl:if test="dim:field[@element='notes' and @qualifier='extern']">
      <p class="simple-item-view-other">
        <xsl:value-of select="dim:field[@element='notes' and @qualifier='extern']"/>
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemKeywords">
    <xsl:param name="lang"/>
    <!--
		<xsl:if test="dim:field[@element='subject' and @qualifier='gokverbal']">
			<div class="ds-item-categories"> 
				<strong><i18n:text>xmlui.dri2xhtml.METS-1.0.item-gok</i18n:text>:</strong>
				<xsl:for-each select="dim:field[@element='subject' and @qualifier='gokverbal']">
					<xsl:copy-of select="."/>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="concat('/browse?type=subject&amp;value=', .)"/></xsl:attribute><xsl:value-of select="."/>
					</a>
					<xsl:if test="count(following-sibling::dim:field[@element='subject' and @qualifier='gokverbal']) != 0">
						<xsl:text>; </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</div>
		</xsl:if>
		-->
    <xsl:if test="dim:field[@element='subject'][@qualifier=$lang] ">
      <div class="ds-item-keywords">
        <strong>
          <xsl:choose>
            <xsl:when test="$lang = 'ger'">
              <xsl:text>Schlagw&#xF6;rter: </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Keywords: </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </strong>
        <xsl:for-each select="dim:field[@element='subject' and @qualifier=$lang]">
          <xsl:value-of select="lang"/>
          <!-- <xsl:call-template name="split-list">
						<xsl:with-param name="list">
							<xsl:value-of select="."/> 
						</xsl:with-param>
					</xsl:call-template> -->
          <xsl:value-of select="."/>
          <xsl:if test="count(following-sibling::dim:field[@element='subject'and @qualifier=$lang]) != 0">
            <xsl:text>; </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemLicense">
    <xsl:if test="contains(dim:field[@element='rights'][@qualifier='uri'], 'creativecommons')">
      <xsl:variable name="lc">
        <xsl:value-of select="substring-before(substring-after(dim:field[@element='rights'][@qualifier='uri'], 'licenses/'), '/')"/>
      </xsl:variable>
      <xsl:variable name="lc-img">
        <xsl:value-of select="concat('/themes/Mirage2/images/creativecommons/', $lc, '.png')"/>
      </xsl:variable>
      <div class="license-info">
        <p>
          <i18n:text>xmlui.dri2xhtml.METS-1.0.license-text</i18n:text>
        </p>
        <ul>
          <li>
            <a href="{dim:field[@element='rights'][@qualifier='uri']}">
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="$lc-img"/>
                </xsl:attribute>
              </img>
              <xsl:value-of select="$lc"/>
            </a>
          </li>
        </ul>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemAuthors">
    <div class="simple-item-view-authors item-page-field-wrapper table">
      <xsl:for-each select="dim:field[@element='contributor'][@qualifier='author']">
        <xsl:call-template name="itemSummaryView-DIM-authors-entry"/>
      </xsl:for-each>
      <xsl:if test="dim:field[@element='creator' and @qualifier='birthname']">
        <br/>
        <i18n:text>xmlui.item-view.birthname</i18n:text>
        <xsl:value-of select="dim:field[@element='creator' and @qualifier='birthname']"/>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template name="itemSummaryView-DIM-authors-entry">
    <div>
      <xsl:if test="@authority">
        <xsl:attribute name="class">
          <xsl:text>ds-dc_contributor_author-authority</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="node()"/>
    </div>
  </xsl:template>
  <xsl:template name="itemURI">
    <!-- identifier.uri row -->
    <xsl:if test="dim:field[@element='identifier' and @qualifier='uri']">
      <div class="simple-item-view-bookmark"><span class="icon-link"/><i18n:text>xmlui.dri2xhtml.METS-1.0.item-uri</i18n:text>:
					<xsl:for-each select="dim:field[@element='identifier' and @qualifier='uri']"><span class="bookmark"><xsl:copy-of select="./node()"/></span><xsl:if test="count(following-sibling::dim:field[@element='identifier' and @qualifier='uri']) != 0"><br/></xsl:if></xsl:for-each></div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemDate">
    <!-- date.issued row -->
    <xsl:if test="dim:field[@element='date' and @qualifier='issued']">
      <div class="simple-item-view-other">
        <span class="bold"><i18n:text>xmlui.dri2xhtml.METS-1.0.item-date</i18n:text>:</span>
        <span>
          <xsl:for-each select="dim:field[@element='date' and @qualifier='issued']">
            <xsl:copy-of select="substring(./node(),1,10)"/>
            <xsl:if test="count(following-sibling::dim:field[@element='date' and @qualifier='issued']) != 0">
              <br/>
            </xsl:if>
          </xsl:for-each>
        </span>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemType">
    <xsl:if test="dim:field[@element='type']">
      <span class="bold">
        <xsl:for-each select="dim:field[@element='type']">
          <i18n:text>
            <xsl:copy-of select="."/>
          </i18n:text>
          <xsl:if test="count(following-sibling::dim:field[@element='type']) != 0">
            <br/>
          </xsl:if>
        </xsl:for-each>
      </span>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemExamination">
    <xsl:if test="dim:field[@element='date' and @qualifier='examination']">
      <div class="simple-item-view-other">
        <span class="bold"><i18n:text>xmlui.item-view.examination</i18n:text>:</span>
        <span>
          <xsl:value-of select="dim:field[@element='date' and @qualifier='examination']"/>
          <xsl:for-each select="//dim:field[@element='date' and @qualifier='ppexamination']">
            <i18n:text>xmlui.item-view.examination.postponed</i18n:text>
            <xsl:value-of select="."/>
          </xsl:for-each>
        </span>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemAdvisor">
    <xsl:if test="dim:field[@element='contributor' and @qualifier='advisor']">
      <xsl:for-each select="dim:field[@element='contributor' and @qualifier='advisor']">
        <div class="simple-item-view-other">
          <span class="bold"><i18n:text>xmlui.item-view.advisor</i18n:text>:</span>
          <span>
            <xsl:value-of select="."/>
          </span>
        </div>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemReferee">
    <xsl:if test="dim:field[@element='contributor' and @qualifier='referee']">
      <div class="simple-item-view-other">
        <span class="bold"><i18n:text>xmlui.item-view.referee</i18n:text>:</span>
        <span>
          <xsl:value-of select="dim:field[@element='contributor' and @qualifier='referee']"/>
        </span>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemCoreferee">
    <xsl:if test="dim:field[@element='contributor' and @qualifier='coReferee']">
      <div class="simple-item-view-other">
        <span class="bold"><i18n:text>xmlui.item-view.referee</i18n:text>:</span>
        <span>
          <xsl:value-of select="dim:field[@element='contributor' and @qualifier='coReferee']"/>
        </span>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemThirdreferee">
    <xsl:if test="dim:field[@element='contributor' and @qualifier='thirdReferee']">
      <xsl:for-each select="dim:field[@element='contributor' and @qualifier='thirdReferee']">
        <div class="simple-item-view-other">
          <span class="bold"><i18n:text>xmlui.item-view.referee</i18n:text>:</span>
          <span>
            <xsl:value-of select="."/>
          </span>
        </div>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemSeries">
    <xsl:if test="dim:field[@element='relation' and @qualifier='ispartofseries']">
      <xsl:for-each select="dim:field[@element='relation' and @qualifier='ispartofseries']">
        <div class="simple-item-view-other">
          <span class="bold"><i18n:text>xmlui.item-view.series</i18n:text>:</span>
          <span>
            <xsl:value-of select="."/>
          </span>
        </div>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemTitleTranslated">
    <xsl:if test="dim:field[@element='title' and @qualifier='translated']">
      <p class="title translated">
        <xsl:value-of select="dim:field[@element='title' and @qualifier='translated']" disable-output-escaping="yes"/>
      </p>
      <xsl:if test="dim:field[@element='title'][@qualifier='alternativeTranslated']">
        <p class="subtitle translated">
          <xsl:value-of select="dim:field[@element='title'][@qualifier='alternativeTranslated']" disable-output-escaping="yes"/>
        </p>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemSummaryView-DIM-notesExtern">
    <xsl:if test="dim:field[@element='notes' and @qualifier='extern']">
      <p class="simple-item-view-other">
        <xsl:value-of select="dim:field[@element='notes' and @qualifier='extern']"/>
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemSummaryView-show-full">
    <div class="simple-item-view-show-full item-page-field-wrapper table">
      <h5>
        <i18n:text>xmlui.mirage2.itemSummaryView.MetaData</i18n:text>
      </h5>
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="$ds_item_view_toggle_url"/>
        </xsl:attribute>
        <i18n:text>xmlui.ArtifactBrowser.ItemViewer.show_full</i18n:text>
      </a>
    </div>
  </xsl:template>
  <xsl:template name="itemSummaryView-collections">
    <xsl:if test="$document//dri:referenceSet[@id='aspect.artifactbrowser.ItemViewer.referenceSet.collection-viewer']">
      <div class="simple-item-view-collections item-page-field-wrapper table">
        <h5>
          <i18n:text>xmlui.mirage2.itemSummaryView.Collections</i18n:text>
        </h5>
        <xsl:apply-templates select="$document//dri:referenceSet[@id='aspect.artifactbrowser.ItemViewer.referenceSet.collection-viewer']/dri:reference"/>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="itemSummaryView-DIM-file-section">
    <xsl:variable name="primaryBitstream" select="//mets:fileSec/mets:structMap[@TYPE='LOGICAL']/mets:div[@TYPE='DSpace Item']/mets:fptr/@FILEID"/>
    <xsl:choose>
      <xsl:when test="//mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL' or @USE='LICENSE']/mets:file">
        <!-- <div class="item-page-field-wrapper table word-break">
			 <h5>
                        <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-viewOpen</i18n:text>
		    </h5> -->
        <div class="files-metadata">
          <h2>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-head</i18n:text>
          </h2>
          <xsl:variable name="label-1">
            <xsl:choose>
              <xsl:when test="confman:getProperty('mirage2.item-view.bitstream.href.label.1')">
                <xsl:value-of select="confman:getProperty('mirage2.item-view.bitstream.href.label.1')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>label</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="label-2">
            <xsl:choose>
              <xsl:when test="confman:getProperty('mirage2.item-view.bitstream.href.label.2')">
                <xsl:value-of select="confman:getProperty('mirage2.item-view.bitstream.href.label.2')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>title</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <!-- Primary bitstream is always first fptr child of mets:div[@TYPE='DSpace Item'] -->
          <xsl:variable name="primaryBitstream" select="//mets:structMap[@TYPE='LOGICAL']/mets:div[@TYPE='DSpace Item']/mets:fptr/@FILEID"/>

          <!-- If primary bitstream has text/html MIME type ONLY list that bitstream -->
          <xsl:choose>
            <xsl:when test="//mets:file[@ID=$primaryBitstream]/@MIMETYPE='text/html'">
              <xsl:for-each select="//mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL' or @USE='LICENSE']/mets:file[@ID=$primaryBitstream]">
                <xsl:call-template name="itemSummaryView-DIM-file-section-entry">
                  <xsl:with-param name="href" select="mets:FLocat[@LOCTYPE='URL']/@xlink:href" />
                  <xsl:with-param name="mimetype" select="@MIMETYPE" />
                  <xsl:with-param name="label-1" select="$label-1" />
                  <xsl:with-param name="label-2" select="$label-2" />
                  <xsl:with-param name="title" select="mets:FLocat[@LOCTYPE='URL']/@xlink:title" />
                  <xsl:with-param name="label" select="mets:FLocat[@LOCTYPE='URL']/@xlink:label" />
                  <xsl:with-param name="size" select="@SIZE" />
                </xsl:call-template>
              </xsl:for-each>
            </xsl:when>
            <!-- Otherwise, iterate over and display all of them -->
            <xsl:otherwise>
              <xsl:for-each select="//mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL' or @USE='LICENSE']/mets:file">
                <xsl:call-template name="itemSummaryView-DIM-file-section-entry">
                  <xsl:with-param name="href" select="mets:FLocat[@LOCTYPE='URL']/@xlink:href" />
                  <xsl:with-param name="mimetype" select="@MIMETYPE" />
                  <xsl:with-param name="label-1" select="$label-1" />
                  <xsl:with-param name="label-2" select="$label-2" />
                  <xsl:with-param name="title" select="mets:FLocat[@LOCTYPE='URL']/@xlink:title" />
                  <xsl:with-param name="label" select="mets:FLocat[@LOCTYPE='URL']/@xlink:label" />
                  <xsl:with-param name="size" select="@SIZE" />
                </xsl:call-template>
              </xsl:for-each>
            </xsl:otherwise>
    </xsl:choose>
        </div>
      </xsl:when>
      <!-- Special case for handling ORE resource maps stored as DSpace bitstreams -->
      <xsl:when test="//mets:fileSec/mets:fileGrp[@USE='ORE']">
        <xsl:apply-templates select="//mets:fileSec/mets:fileGrp[@USE='ORE']" mode="itemSummaryView-DIM"/>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="count(//mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL']/mets:file) &gt; 1">
	    <xsl:if test="count(//mets:file/mets:FLocat[contains(@xlink:href, 'isAllowed=n')]) = 0">
                <xsl:variable name="hdl"><xsl:value-of select="substring-after(//mets:METS/@ID, 'hdl:')"/></xsl:variable>
                <div>
                        <a href="{concat('/downloads/', $hdl, '.zip')}"><i18n:text>xmlui.dri2xhtml.METS-1.0.item.zipdownload</i18n:text></a>
		</div>
	    </xsl:if>
        </xsl:if>
        <!-- show embargo date if existent -->
	<!-- <xsl:if test="//dim:field[@element='date'][@qualifier='embargoed']">
                        <div class="embargo-info">
                                <p>
                                <xsl:choose>
                                        <xsl:when test="contains(//dim:field[@element='date'][@qualifier='embargoed'], '3000')">
                                                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed-examen</i18n:text>
                                        </xsl:when>
                                        <xsl:when test="contains(//dim:field[@element='date'][@qualifier='embargoed'], '5000')">
                                                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed-unknown</i18n:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:variable name="year"><xsl:value-of select="substring-before(//dim:field[@element='date'][@qualifier='embargoed'], '-')" /></xsl:variable>
                                                <xsl:variable name="monthday"><xsl:value-of select="substring-after(//dim:field[@element='date'][@qualifier='embargoed'], '-')" /></xsl:variable>


                                                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed1</i18n:text>
                                                <xsl:value-of select="substring-after($monthday, '-')" /><xsl:text>.</xsl:text><xsl:value-of select="substring-before($monthday, '-')" /><xsl:text>.</xsl:text><xsl:value-of select="$year" />
                                                <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-embargoed2</i18n:text>
                                        </xsl:otherwise>
                                </xsl:choose>
                                </p>
                        </div>
		</xsl:if> -->
		<xsl:if test="dim:field[@element='notes' and @qualifier='extern']">
                        <p class="simple-item-view-other">
                                <xsl:value-of select="dim:field[@element='notes' and @qualifier='extern']"/>
                        </p>

                </xsl:if>
  </xsl:template>
  <xsl:template name="itemSummaryView-DIM-file-section-entry">
    <xsl:param name="href"/>
    <xsl:param name="mimetype"/>
    <xsl:param name="label-1"/>
    <xsl:param name="label-2"/>
    <xsl:param name="title"/>
    <xsl:param name="label"/>
    <xsl:param name="size"/>
    <div class="file-list"> 
	    <div class="file-wrapper clearfix">    
		    <div class="file-metadata">
			    <div>
				    <span class="bold">Name:</span>
				    <span>
					    <xsl:choose>
						    <xsl:when test="string-length(mets:FLocat[@LOCTYPE='URL']/@xlink:title) &gt; 54">
							    
							    <xsl:value-of select="concat(substring(mets:FLocat[@LOCTYPE='URL']/@xlink:title,1,44), '...', substring-after($mimetype, '/'))"/>
						    </xsl:when>
						    <xsl:otherwise>
							    <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/>
						    </xsl:otherwise>
					    </xsl:choose>
				    </span>
	    </div>
	    <div>
		    <span class="bold">Size:</span>
		    <span>
			    <xsl:choose>
          <xsl:when test="$size &lt; 1024">
            <xsl:value-of select="$size"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-bytes</i18n:text>
          </xsl:when>
          <xsl:when test="$size &lt; 1024 * 1024">
            <xsl:value-of select="substring(string($size div 1024),1,4)"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-kilobytes</i18n:text>
          </xsl:when>
          <xsl:when test="$size &lt; 1024 * 1024 * 1024">
            <xsl:value-of select="substring(string($size div (1024 * 1024)),1,4)"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-megabytes</i18n:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring(string($size div (1024 * 1024 * 1024)),1,4)"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-gigabytes</i18n:text>
          </xsl:otherwise>
        </xsl:choose>
		</span>
	</div>
	<div>
		<span class="bold">Format:</span>
		<span><xsl:value-of select="translate(substring-after($mimetype, '/'), 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		</span>
	</div>
	<xsl:if test="string-length($label)!=0">
		<span class="bold">Description:</span>
		<span><xsl:value-of select="$label"/></span>
	</xsl:if>
</div>
<div class="file-link">
	<a>
        <xsl:attribute name="href">
          <xsl:value-of select="$href"/>
        </xsl:attribute>
	<!-- <xsl:call-template name="getFileIcon">
          <xsl:with-param name="mimetype">
            <xsl:value-of select="substring-before($mimetype,'/')"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="substring-after($mimetype,'/')"/>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="contains($label-1, 'label') and string-length($label)!=0">
            <xsl:value-of select="$label"/>
          </xsl:when>
          <xsl:when test="contains($label-1, 'title') and string-length($title)!=0">
            <xsl:value-of select="$title"/>
          </xsl:when>
          <xsl:when test="contains($label-2, 'label') and string-length($label)!=0">
            <xsl:value-of select="$label"/>
          </xsl:when>
          <xsl:when test="contains($label-2, 'title') and string-length($title)!=0">
            <xsl:value-of select="$title"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="getFileTypeDesc">
              <xsl:with-param name="mimetype">
                <xsl:value-of select="substring-before($mimetype,'/')"/>
                <xsl:text>/</xsl:text>
                <xsl:choose>
                  <xsl:when test="contains($mimetype,';')">
                    <xsl:value-of select="substring-before(substring-after($mimetype,'/'),';')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="substring-after($mimetype,'/')"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="translate(substring-after($mimetype, '/'), 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        <xsl:text>, </xsl:text>
        <xsl:choose>
          <xsl:when test="$size &lt; 1024">
            <xsl:value-of select="$size"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-bytes</i18n:text>
          </xsl:when>
          <xsl:when test="$size &lt; 1024 * 1024">
            <xsl:value-of select="substring(string($size div 1024),1,5)"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-kilobytes</i18n:text>
          </xsl:when>
          <xsl:when test="$size &lt; 1024 * 1024 * 1024">
            <xsl:value-of select="substring(string($size div (1024 * 1024)),1,5)"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-megabytes</i18n:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring(string($size div (1024 * 1024 * 1024)),1,5)"/>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.size-gigabytes</i18n:text>
          </xsl:otherwise>
        </xsl:choose>
	<xsl:text>)</xsl:text> -->
	<span class="hidden-xs visible-sm visible-md visible-lg">View<wbr/>Open</span>
</a>
</div>
	</div>
	 </div>
  </xsl:template>
  <xsl:template match="dim:dim" mode="itemDetailView-DIM">
    <xsl:call-template name="itemTitle"/>
    <div class="ds-table-responsive">
      <table class="ds-includeSet-table detailtable table table-striped table-hover">
        <xsl:apply-templates mode="itemDetailView-DIM"/>
      </table>
    </div>
    <span class="Z3988"><xsl:attribute name="title"><xsl:call-template name="renderCOinS"/></xsl:attribute>
            &#xFEFF; <!-- non-breaking space to force separating the end tag -->
        </span>
    <xsl:copy-of select="$SFXLink"/>
  </xsl:template>
  <xsl:template match="dim:field" mode="itemDetailView-DIM">
    <tr>
      <xsl:attribute name="class">
        <xsl:text>ds-table-row </xsl:text>
        <xsl:if test="(position() div 2 mod 2 = 0)">even </xsl:if>
        <xsl:if test="(position() div 2 mod 2 = 1)">odd </xsl:if>
      </xsl:attribute>
      <td class="label-cell">
        <xsl:value-of select="./@mdschema"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="./@element"/>
        <xsl:if test="./@qualifier">
          <xsl:text>.</xsl:text>
          <xsl:value-of select="./@qualifier"/>
        </xsl:if>
      </td>
      <td class="word-break">
        <xsl:copy-of select="./node()"/>
      </td>
      <td>
        <xsl:value-of select="./@language"/>
      </td>
    </tr>
  </xsl:template>
  <!-- don't render the item-view-toggle automatically in the summary view, only when it gets called -->
  <xsl:template match="dri:p[contains(@rend , 'item-view-toggle') and         (preceding-sibling::dri:referenceSet[@type = 'summaryView'] or following-sibling::dri:referenceSet[@type = 'summaryView'])]">
    </xsl:template>
  <!-- don't render the head on the item view page -->
  <xsl:template match="dri:div[@n='item-view']/dri:head" priority="5">
    </xsl:template>
  <xsl:template match="mets:fileGrp[@USE='CONTENT']">
    <xsl:param name="context"/>
    <xsl:param name="primaryBitstream" select="-1"/>
    <xsl:choose>
      <!-- If one exists and it's of text/html MIME type, only display the primary bitstream -->
      <xsl:when test="mets:file[@ID=$primaryBitstream]/@MIMETYPE='text/html'">
        <xsl:apply-templates select="mets:file[@ID=$primaryBitstream]">
          <xsl:with-param name="context" select="$context"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- Otherwise, iterate over and display all of them -->
      <xsl:otherwise>
        <xsl:apply-templates select="mets:file">
          <!--Do not sort any more bitstream order can be changed-->
          <xsl:with-param name="context" select="$context"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="mets:fileGrp[@USE='LICENSE']">
    <xsl:param name="context"/>
    <xsl:param name="primaryBitstream" select="-1"/>
    <xsl:apply-templates select="mets:file">
      <xsl:with-param name="context" select="$context"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="mets:file">
    <xsl:param name="context" select="."/>
    <div class="file-metadata">
      <!--style="height: {$thumbnail.maxheight}px;"-->
      <div>
        <span class="bold">
          <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-name</i18n:text>
          <xsl:text>:</xsl:text>
        </span>
        <span>
          <xsl:attribute name="title">
            <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/>
          </xsl:attribute>
          <!-- TS: Why is the string shortened? Long strings don't break the layout -->
          <!--<xsl:value-of select="util:shortenString(mets:FLocat[@LOCTYPE='URL']/@xlink:title, 17, 5)"/>-->
          <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/>
        </span>
      </div>
      <!-- File size always comes in bytes and thus needs conversion -->
      <div>
        <span class="bold">
          <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-size</i18n:text>
          <xsl:text>:</xsl:text>
        </span>
        <span>
          <xsl:choose>
            <xsl:when test="@SIZE &lt; 1024">
              <xsl:value-of select="@SIZE"/>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.size-bytes</i18n:text>
            </xsl:when>
            <xsl:when test="@SIZE &lt; 1024 * 1024">
              <xsl:value-of select="substring(string(@SIZE div 1024),1,5)"/>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.size-kilobytes</i18n:text>
            </xsl:when>
            <xsl:when test="@SIZE &lt; 1024 * 1024 * 1024">
              <xsl:value-of select="substring(string(@SIZE div (1024 * 1024)),1,5)"/>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.size-megabytes</i18n:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring(string(@SIZE div (1024 * 1024 * 1024)),1,5)"/>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.size-gigabytes</i18n:text>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </div>
      <!-- Lookup File Type description in local messages.xml based on MIME Type.
		 In the original DSpace, this would get resolved to an application via
		 the Bitstream Registry, but we are constrained by the capabilities of METS
		 and can't really pass that info through. -->
      <div>
        <span class="bold">
          <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-format</i18n:text>
          <xsl:text>:</xsl:text>
        </span>
        <span>
          <xsl:call-template name="getFileTypeDesc">
            <xsl:with-param name="mimetype">
              <xsl:value-of select="substring-before(@MIMETYPE,'/')"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="substring-after(@MIMETYPE,'/')"/>
            </xsl:with-param>
          </xsl:call-template>
        </span>
      </div>
      <!---->
      <!-- Display the contents of 'Description' only if bitstream contains a description -->
      <xsl:if test="mets:FLocat[@LOCTYPE='URL']/@xlink:label != ''">
        <div>
          <span class="bold">
            <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-description</i18n:text>
            <xsl:text>:</xsl:text>
          </span>
          <span>
            <xsl:attribute name="title">
              <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:label"/>
            </xsl:attribute>
            <!--<xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:label"/>-->
            <xsl:value-of select="util:shortenString(mets:FLocat[@LOCTYPE='URL']/@xlink:label, 17, 5)"/>
          </span>
        </div>
      </xsl:if>
    </div>
    <div class="file-link">
      <!-- style="max-height: {$thumbnail.maxheight}px;" -->
      <xsl:if test="//dim:field[@element='date'][@qualifier='embargoed']">
        <xsl:attribute name="class">
          <xsl:text>file-link disabled</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:href"/>
        </xsl:attribute>
        <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-viewOpen</i18n:text>
      </a>
    </div>
    <div class="file-wrapper row">
      <div class="col-xs-6 col-sm-3">
        <div class="thumbnail">
          <a class="image-link">
            <xsl:attribute name="href">
              <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:href"/>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="$context/mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/                         mets:file[@GROUPID=current()/@GROUPID]">
                <img class="img-thumbnail" alt="Thumbnail">
                  <xsl:attribute name="src">
                    <xsl:value-of select="$context/mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/                                     mets:file[@GROUPID=current()/@GROUPID]/mets:FLocat[@LOCTYPE='URL']/@xlink:href"/>
                  </xsl:attribute>
                </img>
              </xsl:when>
              <xsl:otherwise>
                <img class="img-thumbnail" alt="Thumbnail">
                  <xsl:attribute name="data-src">
                    <xsl:text>holder.js/100%x</xsl:text>
                    <xsl:value-of select="$thumbnail.maxheight"/>
                    <xsl:text>/text:No Thumbnail</xsl:text>
                  </xsl:attribute>
                </img>
              </xsl:otherwise>
            </xsl:choose>
          </a>
        </div>
      </div>
      <div class="col-xs-6 col-sm-7">
        <dl class="file-metadata dl-horizontal">
          <dt>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-name</i18n:text>
            <xsl:text>:</xsl:text>
          </dt>
          <dd class="word-break">
            <xsl:attribute name="title">
              <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/>
            </xsl:attribute>
            <xsl:value-of select="util:shortenString(mets:FLocat[@LOCTYPE='URL']/@xlink:title, 30, 5)"/>
          </dd>
          <!-- File size always comes in bytes and thus needs conversion -->
          <dt>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-size</i18n:text>
            <xsl:text>:</xsl:text>
          </dt>
          <dd class="word-break">
            <xsl:choose>
              <xsl:when test="@SIZE &lt; 1024">
                <xsl:value-of select="@SIZE"/>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.size-bytes</i18n:text>
              </xsl:when>
              <xsl:when test="@SIZE &lt; 1024 * 1024">
                <xsl:value-of select="substring(string(@SIZE div 1024),1,5)"/>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.size-kilobytes</i18n:text>
              </xsl:when>
              <xsl:when test="@SIZE &lt; 1024 * 1024 * 1024">
                <xsl:value-of select="substring(string(@SIZE div (1024 * 1024)),1,5)"/>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.size-megabytes</i18n:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="substring(string(@SIZE div (1024 * 1024 * 1024)),1,5)"/>
                <i18n:text>xmlui.dri2xhtml.METS-1.0.size-gigabytes</i18n:text>
              </xsl:otherwise>
            </xsl:choose>
          </dd>
          <!-- Lookup File Type description in local messages.xml based on MIME Type.
         In the original DSpace, this would get resolved to an application via
         the Bitstream Registry, but we are constrained by the capabilities of METS
         and can't really pass that info through. -->
          <dt>
            <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-format</i18n:text>
            <xsl:text>:</xsl:text>
          </dt>
          <dd class="word-break">
            <xsl:call-template name="getFileTypeDesc">
              <xsl:with-param name="mimetype">
                <xsl:value-of select="substring-before(@MIMETYPE,'/')"/>
                <xsl:text>/</xsl:text>
                <xsl:choose>
                  <xsl:when test="contains(@MIMETYPE,';')">
                    <xsl:value-of select="substring-before(substring-after(@MIMETYPE,'/'),';')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="substring-after(@MIMETYPE,'/')"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:call-template>
          </dd>
          <!-- Display the contents of 'Description' only if bitstream contains a description -->
          <xsl:if test="mets:FLocat[@LOCTYPE='URL']/@xlink:label != ''">
            <dt>
              <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-description</i18n:text>
              <xsl:text>:</xsl:text>
            </dt>
            <dd class="word-break">
              <xsl:attribute name="title">
                <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:label"/>
              </xsl:attribute>
              <xsl:value-of select="util:shortenString(mets:FLocat[@LOCTYPE='URL']/@xlink:label, 30, 5)"/>
            </dd>
          </xsl:if>
        </dl>
      </div>
      <div class="file-link col-xs-6 col-xs-offset-6 col-sm-2 col-sm-offset-0">
        <xsl:choose>
          <xsl:when test="@ADMID">
            <xsl:call-template name="display-rights"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="view-open"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>
  <xsl:template name="view-open">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:href"/>
      </xsl:attribute>
      <i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-viewOpen</i18n:text>
    </a>
  </xsl:template>
  <xsl:template name="display-rights">
    <xsl:variable name="file_id" select="jstring:replaceAll(jstring:replaceAll(string(@ADMID), '_METSRIGHTS', ''), 'rightsMD_', '')"/>
    <xsl:variable name="rights_declaration" select="../../../mets:amdSec/mets:rightsMD[@ID = concat('rightsMD_', $file_id, '_METSRIGHTS')]/mets:mdWrap/mets:xmlData/rights:RightsDeclarationMD"/>
    <xsl:variable name="rights_context" select="$rights_declaration/rights:Context"/>
    <xsl:variable name="users">
      <xsl:for-each select="$rights_declaration/*">
        <xsl:value-of select="rights:UserName"/>
        <xsl:choose>
          <xsl:when test="rights:UserName/@USERTYPE = 'GROUP'">
            <xsl:text> (group)</xsl:text>
          </xsl:when>
          <xsl:when test="rights:UserName/@USERTYPE = 'INDIVIDUAL'">
            <xsl:text> (individual)</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="position() != last()">, </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="not ($rights_context/@CONTEXTCLASS = 'GENERAL PUBLIC') and ($rights_context/rights:Permissions/@DISPLAY = 'true')">
        <a href="{mets:FLocat[@LOCTYPE='URL']/@xlink:href}">
          <img width="64" height="64" src="{concat($theme-path,'/images/Crystal_Clear_action_lock3_64px.png')}" title="Read access available for {$users}"/>
          <!-- icon source: http://commons.wikimedia.org/wiki/File:Crystal_Clear_action_lock3.png -->
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="view-open"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="getFileIcon">
    <xsl:param name="mimetype"/>
    <i aria-hidden="true">
      <xsl:attribute name="class">
        <xsl:text>glyphicon </xsl:text>
        <xsl:choose>
          <xsl:when test="contains(mets:FLocat[@LOCTYPE='URL']/@xlink:href,'isAllowed=n')">
            <xsl:text> glyphicon-lock</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> glyphicon-file</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </i>
    <xsl:text> </xsl:text>
  </xsl:template>
  <!-- Generate the license information from the file section -->
  <xsl:template match="mets:fileGrp[@USE='CC-iLICENSE']" mode="simple">
    <li>
      <a href="{mets:file/mets:FLocat[@xlink:title='license_text']/@xlink:href}">
        <i18n:text>xmlui.dri2xhtml.structural.link_cc</i18n:text>
      </a>
    </li>
  </xsl:template>
  <!-- Generate the license information from the file section -->
  <xsl:template match="mets:fileGrp[@USE='LICENSE']" mode="simple">
    <li>
      <a href="{mets:file/mets:FLocat[@xlink:title='license.txt']/@xlink:href}">
        <i18n:text>xmlui.dri2xhtml.structural.link_original_license</i18n:text>
      </a>
    </li>
  </xsl:template>
  <!--
    File Type Mapping template

    This maps format MIME Types to human friendly File Type descriptions.
    Essentially, it looks for a corresponding 'key' in your messages.xml of this
    format: xmlui.dri2xhtml.mimetype.{MIME Type}

    (e.g.) <message key="xmlui.dri2xhtml.mimetype.application/pdf">PDF</message>

    If a key is found, the translated value is displayed as the File Type (e.g. PDF)
    If a key is NOT found, the MIME Type is displayed by default (e.g. application/pdf)
    -->
  <xsl:template name="getFileTypeDesc">
    <xsl:param name="mimetype"/>
    <!--Build full key name for MIME type (format: xmlui.dri2xhtml.mimetype.{MIME type})-->
    <xsl:variable name="mimetype-key">xmlui.dri2xhtml.mimetype.<xsl:value-of select="$mimetype"/></xsl:variable>
    <!--Lookup the MIME Type's key in messages.xml language file.  If not found, just display MIME Type-->
    <i18n:text i18n:key="{$mimetype-key}">
      <xsl:value-of select="$mimetype"/>
    </i18n:text>
  </xsl:template>
</xsl:stylesheet>
