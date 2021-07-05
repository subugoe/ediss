<!--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

-->

<!--
    Rendering specific to the navigation (options)

    Author: art.lowel at atmire.com
    Author: lieven.droogmans at atmire.com
    Author: ben at atmire.com
    Author: Alexey Maslov

-->

<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
	xmlns:dri="http://di.tamu.edu/DRI/1.0/"
	xmlns:mets="http://www.loc.gov/METS/"
	xmlns:xlink="http://www.w3.org/TR/xlink/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:mods="http://www.loc.gov/mods/v3"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="i18n dri mets xlink xsl dim xhtml mods dc">

    <xsl:output indent="yes"/>

    <!--
        The template to handle dri:options. Since it contains only dri:list tags (which carry the actual
        information), the only things than need to be done is creating the ds-options div and applying
        the templates inside it.

        In fact, the only bit of real work this template does is add the search box, which has to be
        handled specially in that it is not actually included in the options div, and is instead built
        from metadata available under pageMeta.
    -->
    <!-- TODO: figure out why i18n tags break the go button -->
    <xsl:template match="dri:options">
        <div id="ds-options" class="word-break hidden-print">
		<!-- <xsl:if test="not(contains(/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='request'][@qualifier='URI'], 'discover'))">
                <div id="ds-search-option" class="ds-option-set">
		     <form id="ds-search-form" class="hidden-xs hidden-xm hidden-md hidden-lg" method="post">
                        <xsl:attribute name="action">
                            <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath']"/>
                            <xsl:value-of
                                    select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='search'][@qualifier='simpleURL']"/>
                        </xsl:attribute>
                        <fieldset>
                            <div class="input-group">
                                <input class="ds-text-field form-control" type="text" placeholder="xmlui.general.search"
                                       i18n:attr="placeholder">
                                    <xsl:attribute name="name">
                                        <xsl:value-of
                                                select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='search'][@qualifier='queryField']"/>
                                    </xsl:attribute>
                                </input>
                                <span class="input-group-btn">
                                    <button class="ds-button-field btn btn-primary" title="xmlui.general.go" i18n:attr="title">
                                        <span class="glyphicon glyphicon-search" aria-hidden="true"/>
                                        <xsl:attribute name="onclick">
                                                    <xsl:text>
                                                        var radio = document.getElementById(&quot;ds-search-form-scope-container&quot;);
                                                        if (radio != undefined &amp;&amp; radio.checked)
                                                        {
                                                        var form = document.getElementById(&quot;ds-search-form&quot;);
                                                        form.action=
                                                    </xsl:text>
                                            <xsl:text>&quot;</xsl:text>
                                            <xsl:value-of
                                                    select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath']"/>
                                            <xsl:text>/handle/&quot; + radio.value + &quot;</xsl:text>
                                            <xsl:value-of
                                                    select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='search'][@qualifier='simpleURL']"/>
                                            <xsl:text>&quot; ; </xsl:text>
                                                    <xsl:text>
                                                        }
                                                    </xsl:text>
                                        </xsl:attribute>
                                    </button>
                                </span>
                            </div>

                            <xsl:if test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='focus'][@qualifier='container']">
                                <div class="radio">
                                    <label>
                                        <input id="ds-search-form-scope-all" type="radio" name="scope" value=""
                                               checked="checked"/>
                                        <i18n:text>xmlui.dri2xhtml.structural.search</i18n:text>
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input id="ds-search-form-scope-container" type="radio" name="scope">
                                            <xsl:attribute name="value">
                                                <xsl:value-of
                                                        select="substring-after(/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='focus'][@qualifier='container'],':')"/>
                                            </xsl:attribute>
                                        </input>
                                        <xsl:choose>
                                            <xsl:when
                                                    test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='focus'][@qualifier='containerType']/text() = 'type:community'">
                                                <i18n:text>xmlui.dri2xhtml.structural.search-in-community</i18n:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <i18n:text>xmlui.dri2xhtml.structural.search-in-collection</i18n:text>
                                            </xsl:otherwise>

                                        </xsl:choose>
                                    </label>
                                </div>
                            </xsl:if>
                        </fieldset>
		    </form> 
                </div>
	  </xsl:if> -->
          <div class="publish">
                                <a>
                                <xsl:choose>
                                        <xsl:when test="contains(//dri:metadata[@element='request'][@qualifier='URI'], 'submit')">
                                                <xsl:attribute name="href"><xsl:text>#</xsl:text></xsl:attribute>

                                                        <i18n:text>xmlui.general.publish_now</i18n:text>

                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:choose>
							<xsl:when test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='focus'][@qualifier='container']">	
                                                                <xsl:variable name="container">
                                                                        <xsl:value-of select="concat('handle/', substring-after(//dri:metadata[@element='focus'][@qualifier='container'], 'hdl:'))"/>

                                                                </xsl:variable>
                                                                <xsl:attribute name="href"><xsl:value-of select="concat($context-path, '/', $container, '/submit')"/></xsl:attribute>

                                                                        <i18n:text>xmlui.general.publish_here</i18n:text>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                        <xsl:attribute name="href"><xsl:value-of select="concat($context-path, '/submit')" /></xsl:attribute>
                                                                <i18n:text>xmlui.general.publish_now</i18n:text>

                                                </xsl:otherwise>
                                                </xsl:choose>
                                        </xsl:otherwise>
                                </xsl:choose>
                                </a>
                        </div>
	    <!-- <xsl:apply-templates/> -->
	    <xsl:if test="//dri:userMeta/@authenticated='yes'">
		    <xsl:apply-templates select="dri:list[@n='account']"/>
	    </xsl:if>
	    <xsl:apply-templates select="dri:list[@n='browse']"/>
	    <xsl:apply-templates select="dri:list[@n='context']"/>
	    <xsl:apply-templates select="dri:list[@n='administrative']"/>
	    <xsl:apply-templates select="dri:list[@n='discovery']"/>
	    <xsl:apply-templates select="dri:list[@n='statistics']"/>
	    <h1 class="ds-option-set-head"><i18n:text>xmlui.navigation.help.header</i18n:text></h1>
            <div id="static.help" class="list-group">
                                        <a class="list-group-item ds-option" href="{$context-path}/help/fullpublication"><i18n:text>xmlui.navigation.help.publication_process</i18n:text></a>
                                        <a class="list-group-item ds-option" href="{$context-path}/help/pdf-howto"><i18n:text>xmlui.navigation.help.pdf_howto</i18n:text></a>
                                        <!--<li><a class="list-group-item ds-option" href="{$context-path}/help/cumulative-diss"><i18n:text>xmlui.navigation.help.cumulative_dissertation</i18n:text></a></li> -->
                                        <a class="list-group-item ds-option" href="{$context-path}/help/deposit-license"><i18n:text>xmlui.deposit.license.title</i18n:text></a>
                                        <a class="list-group-item ds-option" href="{$context-path}/help/good-to-know"><i18n:text>xmlui.navigation.help.general</i18n:text></a>

            </div>
            <!-- DS-984 Add RSS Links to Options Box -->
	    <!-- <xsl:if test="count(/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='feed']) != 0">
                <div>
                    <h2 class="ds-option-set-head h6">
                        <i18n:text>xmlui.feed.header</i18n:text>
                    </h2>
                    <div id="ds-feed-option" class="ds-option-set list-group">
                        <xsl:call-template name="addRSSLinks"/>
                    </div>
                </div>

	    </xsl:if> -->
        </div>
    </xsl:template>

    <!-- Add each RSS feed from meta to a list -->
    <xsl:template name="addRSSLinks">
        <xsl:for-each select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='feed']">
            <a class="list-group-item">
                <xsl:attribute name="href">
                    <xsl:value-of select="."/>
                </xsl:attribute>

                <img src="{concat($context-path, '/static/icons/feed.png')}" class="btn-xs" alt="xmlui.mirage2.navigation.rss.feed" i18n:attr="alt"/>

                <xsl:choose>
                    <xsl:when test="contains(., 'rss_1.0')">
                        <xsl:text>RSS 1.0</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(., 'rss_2.0')">
                        <xsl:text>RSS 2.0</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(., 'atom_1.0')">
                        <xsl:text>Atom</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@qualifier"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="dri:options//dri:list">
        <xsl:apply-templates select="dri:head"/>
        <xsl:apply-templates select="dri:item"/>
        <xsl:apply-templates select="dri:list"/>
    </xsl:template>

    <xsl:template match="dri:options/dri:list" priority="3">
        <xsl:apply-templates select="dri:head"/>
        <div>
            <xsl:call-template name="standardAttributes">
                <xsl:with-param name="class">list-group</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates select="dri:item"/>
            <xsl:apply-templates select="dri:list"/>
        </div>
    </xsl:template>


    <xsl:template match="dri:options//dri:item">
        <div>
            <xsl:call-template name="standardAttributes">
                <xsl:with-param name="class">list-group-item ds-option</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="dri:options//dri:item[dri:xref]">
        <a href="{dri:xref/@target}">
            <xsl:call-template name="standardAttributes">
                <xsl:with-param name="class">list-group-item ds-option</xsl:with-param>
            </xsl:call-template>
            <xsl:choose>
                <xsl:when test="dri:xref/node()">
                    <xsl:apply-templates select="dri:xref/node()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="dri:xref"/>
                </xsl:otherwise>
            </xsl:choose>

        </a>
	<xsl:if test="contains(dri:xref/@target, '/csv/handle')">
		<xsl:if test="string-length(//dri:list[@n='administrative']) != 0">
			<xsl:variable name="handle"><xsl:value-of select="substring-after(dri:xref/@target, '/csv/')"/></xsl:variable>
			<!-- append links to bill and confirmation forms for admin
			<a class="list-group-item ds-option">
				<xsl:attribute name="href"><xsl:value-of select="concat('/bill/', $handle)"/></xsl:attribute>
				<i18n:text>xmlui.navigation.bill</i18n:text>
			</a> -->
			<a class="list-group-item ds-option">
				<xsl:attribute name="href"><xsl:value-of select="concat('/confirm-default/', $handle)"/></xsl:attribute>
                                <i18n:text>xmlui.navigation.confirm.default</i18n:text>
			</a>
			<a class="list-group-item ds-option">
				<xsl:attribute name="href"><xsl:value-of select="concat('/confirm-med/', $handle)"/></xsl:attribute>
                                <i18n:text>xmlui.navigation.confirm.med</i18n:text>
			</a>
			<a class="list-group-item ds-option">
				<xsl:attribute name="href"><xsl:value-of select="concat('/confirm-med-examen/', $handle)"/></xsl:attribute>
                                <i18n:text>xmlui.navigation.confirm.med.examen</i18n:text>
			</a>
			<a class="list-group-item ds-option">
                                <xsl:attribute name="href"><xsl:value-of select="concat('/confirm-postpone/', $handle)"/></xsl:attribute>
                                <i18n:text>xmlui.navigation.confirm.postpone</i18n:text>
			</a>
			<a class="list-group-item ds-option">
                                <xsl:attribute name="href"><xsl:value-of select="concat('/confirm-abstract-ggnb/', $handle)"/></xsl:attribute>
                                <i18n:text>xmlui.navigation.confirm.abstract-ggnb</i18n:text>
                        </a>
		</xsl:if>
	</xsl:if>
    </xsl:template>

    <xsl:template match="dri:options/dri:list/dri:head" priority="3">
        <xsl:call-template name="renderHead">
            <xsl:with-param name="class">ds-option-set-head</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dri:options/dri:list//dri:list/dri:head" priority="3">
        <a class="list-group-item active">
            <span>
                <xsl:call-template name="standardAttributes">
                    <xsl:with-param name="class">
                        <xsl:value-of select="@rend"/>
                        <xsl:text> list-group-item-heading</xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
                <xsl:apply-templates/>
            </span>
        </a>
    </xsl:template>

    <xsl:template match="dri:list[count(child::*)=0]"/>

</xsl:stylesheet>
