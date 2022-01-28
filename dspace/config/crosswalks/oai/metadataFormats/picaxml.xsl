<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
        xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:urn="http://www.d-nb.de/standards/urn/"
	xmlns:hdl="http://www.d-nb.de/standards/hdl/"
	xmlns:doi="http://www.d-nb.de/standards/doi/"
	xmlns:picaxml="info:srw/schema/5/picaXML-v1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="info:srw/schema/5/picaXML-v1.0 http://www.oclcpica.org/xml/picaplus.xsd"
	xmlns:mets="http://www.loc.gov/METS/" 
	xmlns:xlink="http://www.w3.org/TR/xlink/" 
	version="1.0">
	<xsl:output indent="yes"/>

<!-- RDA-Records in PicaXML Format für das GVK -->

	<!-- global variables -->
	<xsl:variable name="baseURL">http://localhost:8080</xsl:variable>
	<xsl:variable name="metsURL" select="concat($baseURL, 'metadata/handle')"/>
	

       <xsl:template match="text()"/>
       <xsl:template match="/">
	<picaxml xmlns="info:srw/schema/5/picaXML-v1.0" xmlns:picaxml="info:srw/schema/5/picaXML-v1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="info:srw/schema/5/picaXML-v1.0 http://www.oclcpica.org/xml/picaplus.xsd">	
		<datafield>
			<xsl:attribute name="tag">002C</xsl:attribute>
			<subfield>
                        <xsl:attribute name="code">a</xsl:attribute>
                                <xsl:text>Text</xsl:text>
                        </subfield>
			<subfield>
                        <xsl:attribute name="code">b</xsl:attribute>
                                <xsl:text>txt</xsl:text>
                        </subfield>
		</datafield>
		<datafield>
                        <xsl:attribute name="tag">002D</xsl:attribute>
                        <subfield>
                        <xsl:attribute name="code">a</xsl:attribute>
                                <xsl:text>Computermedien</xsl:text>
                        </subfield>
                        <subfield>
                        <xsl:attribute name="code">b</xsl:attribute>
                                <xsl:text>c</xsl:text>
                        </subfield>
                </datafield>
                <datafield>
                        <xsl:attribute name="tag">002E</xsl:attribute>
                        <subfield>
                        <xsl:attribute name="code">a</xsl:attribute>
                                <xsl:text>Online-Ressource</xsl:text>
                        </subfield>
                        <subfield>
                        <xsl:attribute name="code">b</xsl:attribute>
                                <xsl:text>cr</xsl:text>
                        </subfield>
                </datafield>
		<datafield>
                       <xsl:attribute name="tag">004U</xsl:attribute>
                        <subfield>
                        <xsl:attribute name="code">0</xsl:attribute>
                                <xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='urn']/doc:element/doc:field" />
                        </subfield>
                </datafield>
		<xsl:call-template name="ppn"/>
		<xsl:call-template name="uri"/>
		<xsl:call-template name="linkedurn" />
                <xsl:call-template name="rda"/>
		<xsl:call-template name="language"/>
		<xsl:call-template name="issued"/>
		<xsl:call-template name="issued-year"/>
		<xsl:call-template name="static1" />
			<xsl:call-template name="title" />
			<xsl:call-template name="author" />
			<xsl:call-template name="otherPersons" />
			<xsl:call-template name="static2" />
			<xsl:call-template name="filedata" /> 
			<xsl:call-template name="translatedTitle" /> 
			<xsl:call-template name="ddc" />
			<xsl:call-template name="abstracts" />
			
                        <!--<xsl:call-template name="gok" /> -->
                        <xsl:call-template name="gok2" /> 
			<xsl:call-template name="localLinks" />
			<xsl:call-template name="staticFields" /> 
	<!--	<xsl:call-template name="linkedurn" />
		<xsl:call-template name="uri" /> -->
		<!-- <record>


		<identifier scheme="urn:nbn:de">
                                <xsl:value-of select="//dim:field[@element ='identifier'][@qualifier='urn']"/>
                </identifier>

		<resource>
                                <identifier scheme="url" type="frontpage" role="primary">
                                        <xsl:value-of select="//dim:field[@element ='identifier'][@qualifier='uri']"/>
                                </identifier>
                                <format scheme="imt">text/html</format>
                        </resource> -->


		<!-- <xsl:call-template name="urn"/>
		<xsl:call-template name="resource"/> 
		
		</record> -->
	  </picaxml>
	</xsl:template>

	<xsl:template name="ppn">
                <!-- Dspace uris zeigen auf die abstrakte Publikation: text/html or text/pdf ist richtig? Was soll in das Subfield y?? -->
	   <xsl:if test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='ppn']">

                <datafield>
                        <xsl:attribute name="tag">003@</xsl:attribute>
                        <subfield>
                                <xsl:attribute name="code">0</xsl:attribute>

                                <xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='ppn']/doc:element/doc:field" />
                        </subfield>
                </datafield>
		</xsl:if>
        </xsl:template>

	<xsl:template name="uri">
		<!-- Dspace uris zeigen auf die abstrakte Publikation: text/html or text/pdf ist richtig? Was soll in das Subfield y?? -->
		
		
		<datafield>
			<xsl:attribute name="tag">017C</xsl:attribute>
			<!-- <xsl:attribute name="occurence">03</xsl:attribute> -->
			<subfield>
				<xsl:attribute name="code">u</xsl:attribute>
				<xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='uri']/doc:element/doc:field" />
			</subfield>
                        <subfield>
                                <xsl:attribute name="code">x</xsl:attribute>
                                <xsl:text>R</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">3</xsl:attribute>
                                <xsl:text>Volltext</xsl:text>
                        </subfield>
			<subfield>
				<xsl:attribute name="code">4</xsl:attribute>
				<xsl:text>LF</xsl:text>
			</subfield>
			<subfield>
                                <xsl:attribute name="code">5</xsl:attribute>
                                <xsl:text>34</xsl:text>
                        </subfield> 
		</datafield>                
      
		<datafield>
                        <xsl:attribute name="tag">209R</xsl:attribute>
                        <xsl:attribute name="occurence">1</xsl:attribute> 
                        <subfield>
                                <xsl:attribute name="code">u</xsl:attribute>
                                <xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='uri']/doc:element/doc:field" />
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">x</xsl:attribute>
                                <xsl:text>R</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">3</xsl:attribute>
                                <xsl:text>Volltext</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">4</xsl:attribute>
                                <xsl:text>LF</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">5</xsl:attribute>
                                <xsl:text>34</xsl:text>
                        </subfield>
                </datafield>
 
	</xsl:template>

	<xsl:template name="linkedurn">
		<datafield>
			<xsl:attribute name="tag">017C</xsl:attribute>
			<!-- <xsl:attribute name="occurence">03</xsl:attribute> -->
			<subfield>
				<xsl:attribute name="code">u</xsl:attribute>
				<xsl:value-of select="concat('http://nbn-resolving.org/',//doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='urn']/doc:element/doc:field)" />
			</subfield>
                        <subfield>
                                <xsl:attribute name="code">x</xsl:attribute>
                                <xsl:text>R</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">3</xsl:attribute>
                                <xsl:text>Volltext</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">4</xsl:attribute>
                                <xsl:text>LF</xsl:text>
                        </subfield>
                        <subfield>
                                <xsl:attribute name="code">5</xsl:attribute>
                                <xsl:text>34</xsl:text>
                        </subfield>
		</datafield>              
    </xsl:template>

	<xsl:template name="language">
	<!-- GVK requires ISO-639-2 Bibliographic -->
		<datafield>
			<xsl:attribute name="tag">010@</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">a</xsl:attribute>
			
			<xsl:choose>
				<xsl:when test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='language']/doc:element[@name='iso']/doc:element/doc:field = 'deu'">
					<xsl:text>ger</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='language']/doc:element[@name='iso']/doc:element/doc:field" />
				</xsl:otherwise>
			</xsl:choose>
			</subfield>
		</datafield>
	</xsl:template>

        <xsl:template name="rda">
                <datafield>
                        <xsl:attribute name="tag">010E</xsl:attribute>
                        <subfield>
                                <xsl:attribute name="code">e</xsl:attribute>
				<xsl:text>rda</xsl:text>
                        </subfield>
                </datafield>
        </xsl:template>

	<xsl:template name="issued">
		<datafield>
			<xsl:attribute name="tag">091O</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">t</xsl:attribute>
				<xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field" />
			</subfield>
		</datafield>
	</xsl:template>

	<xsl:template name="issued-year">
                <!-- handle year only -->
                <datafield>
                        <xsl:attribute name="tag">011@</xsl:attribute>
                        <subfield>
                                <xsl:attribute name="code">a</xsl:attribute>
                                <xsl:value-of select="substring-before(//doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field, '-')" />
                        </subfield>
                </datafield>
        </xsl:template>

		<xsl:template name="static1">
		<!-- All eDISS-Types are in pica "ho" -->
		<!-- <datafield>
			<xsl:attribute name="tag">013@</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">0</xsl:attribute>
				<xsl:text>ho</xsl:text>
			</subfield>
		
		</datafield>
		<datafield>
			<xsl:attribute name="tag">016D</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">0</xsl:attribute>
				<xsl:text>cr</xsl:text>
			</subfield>
		
		</datafield> -->
		<!-- Erscheinungsland Code: XA-DE-NI; Pflicht für GVK-Import -->
		<datafield>
			<xsl:attribute name="tag">019@</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">a</xsl:attribute>
				<xsl:text>XA-DE-NI</xsl:text>
			</subfield>

		</datafield>
	</xsl:template>
		
		
		<!-- Original title with alternative title in $d, translated title in $f if existent and author together -->
	<xsl:template name="title">
		<datafield>
			<xsl:attribute name="tag">021A</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">a</xsl:attribute>
				<!-- <xsl:value-of select="//dim:field[@element='title' and not(@qualifier)]" /> -->
				<xsl:call-template name="strip-tags">
				    <xsl:with-param name="text" select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:element/doc:field"/>
				</xsl:call-template>
			</subfield>
                        <!-- <subfield>
                                <xsl:attribute name="code">d</xsl:attribute>
                                <xsl:call-template name="strip-tags">
                                    <xsl:with-param name="text" select="//dim:field[@element='title' and @qualifier='alternative']"/>
                                </xsl:call-template>
                        </subfield> -->
			<subfield>
				<xsl:attribute name="code">h</xsl:attribute>
				<xsl:variable name="person"><xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field" /></xsl:variable>
				<xsl:value-of select="concat('vorgelegt von ' ,substring-after($person, ', '), ' ', substring-before($person, ', '))" />
			</subfield>
		</datafield>
	</xsl:template>

	<xsl:template name="author">
		<!-- Verfasser: Unterfelder $d Vorname, $d Vorname, $n Zählung?, $B Funktionsbezeichnung -->
		<xsl:variable name="author"><xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field" /></xsl:variable>
		<datafield>
			<xsl:attribute name="tag">028A</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">d</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-after($author, ','))" />
			</subfield>
			<subfield>
				<xsl:attribute name="code">a</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-before($author, ','))" />
			</subfield>
			<subfield>
                                <xsl:attribute name="code">B</xsl:attribute>
				<xsl:text>VerfasserIn</xsl:text>
                        </subfield>
			<subfield>
                                <xsl:attribute name="code">4</xsl:attribute>
                                <xsl:text>aut</xsl:text>
                        </subfield>
		</datafield>
		
	</xsl:template>	

	<xsl:template name="otherPersons">
	<!-- sonstige nichtbeteilige Personen: Unterfelder $a Familienname, $d Vorname, $n Zählung?, $B Funktionsbezeichnung -->
	<!-- VORKOMMNISSE MÜSSEN GEZÄHLT WERDEN!!! -->
		<xsl:if test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='advisor']">
			<xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='advisor']">
			<xsl:variable name="temp"><xsl:value-of select="substring-after(doc:element/doc:field, ', ')" /></xsl:variable>
			
			<datafield>
			<xsl:attribute name="tag">028C</xsl:attribute>

			<!-- <xsl:if test="position() != 1"> -->
					<xsl:attribute name="occurence"><xsl:value-of select="concat('0', position() - 1 )" /></xsl:attribute>
			<!-- </xsl:if> -->
			<subfield>
				<xsl:attribute name="code">d</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-before($temp, ' '))" />
			</subfield>

			<subfield>
				<xsl:attribute name="code">a</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-before(doc:element/doc:field, ','))" />
			</subfield>

			<subfield>
				<xsl:attribute name="code">B</xsl:attribute>
				<xsl:text>AkademischeR BetreuerIn</xsl:text>
			</subfield>

                        <subfield>
                                <xsl:attribute name="code">4</xsl:attribute>
                                <xsl:text>dgs</xsl:text>
                        </subfield>
			
			</datafield>
			</xsl:for-each>
		</xsl:if>
                <xsl:if test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[contains(@name, 'eferee')]">
                        <xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[contains(@name, 'eferee')]">
                        <xsl:variable name="temp"><xsl:value-of select="substring-after(doc:element/doc:field, ', ')" /></xsl:variable>

                        <datafield>
                        <xsl:attribute name="tag">028C</xsl:attribute>

                        <!-- <xsl:if test="position() != 1"> -->
                                        <xsl:attribute name="occurence"><xsl:value-of select="concat('0', position() - 1 )" /></xsl:attribute>
                        <!-- </xsl:if> -->
                        <subfield>
                                <xsl:attribute name="code">d</xsl:attribute>
                                <xsl:value-of select="normalize-space(substring-before($temp, ' '))" />
                        </subfield>

                        <subfield>
                                <xsl:attribute name="code">a</xsl:attribute>
                                <xsl:value-of select="normalize-space(substring-before(doc:element/doc:field, ','))" />
                        </subfield>
			<subfield>
                                <xsl:attribute name="code">B</xsl:attribute>
                                <xsl:text>AkademischeR BetreuerIn</xsl:text>
                        </subfield>

                        <subfield>
                                <xsl:attribute name="code">4</xsl:attribute>
                                <xsl:text>dgs</xsl:text>
                        </subfield>

                        </datafield>
                        </xsl:for-each>
                </xsl:if>
	</xsl:template>	

		<xsl:template name="static2">
		<xsl:variable name="type"><xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field" /></xsl:variable>
		<datafield>
		<xsl:attribute name="tag">037C</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">d</xsl:attribute>
						<xsl:choose>
							<xsl:when test="contains($type,'doctoralThesis')">
								<xsl:text>Dissertation</xsl:text>
							</xsl:when>
							<xsl:when test="$type='cumulativeThesis'">
                                                                <xsl:text>Dissertation</xsl:text>
                                                        </xsl:when>
							<xsl:when test="contains($type,'bachelor')">
								<xsl:text>Bachelorarbeit</xsl:text>
							</xsl:when>
							<xsl:when test="contains($type, 'master')">
								<xsl:text>Masterarbeit</xsl:text>
							</xsl:when>
							<xsl:when test="contains($type, 'magister')">
								<xsl:text>Magisterarbeit</xsl:text>
							</xsl:when>
							<xsl:when test="$type='diplomaThesis'">
								<xsl:text>Diplomarbeit</xsl:text>
							</xsl:when>
							<xsl:when test="$type='habilitation' or $type='Text.Habilitation'">
								<xsl:text>Habilitationsschrift</xsl:text>
							</xsl:when>
							<xsl:when test="$type='studyThesis'">
                                                                <xsl:text>Hausarbeit</xsl:text>
                                                        </xsl:when>
					</xsl:choose>
			</subfield>
			<subfield>
				<xsl:attribute name="code">e</xsl:attribute>
				<xsl:text>Georg-August-Universität Göttingen</xsl:text>
			</subfield>
			<subfield>
				<xsl:attribute name="code">f</xsl:attribute>
				<xsl:value-of select="substring-before(//doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued'], '-')" />
			</subfield>
		</datafield>
	</xsl:template>

	<xsl:template name="filedata">
		<datafield>
		<xsl:attribute name="tag">034D</xsl:attribute>
			<subfield>
				<xsl:attribute name="code">a</xsl:attribute>
				<xsl:text>1 Online-Ressource</xsl:text>
			</subfield>
		<!--	<subfield>
			<xsl:attribute name="code">a</xsl:attribute>
				<xsl:text>Online-Ressource (PDF-Datei: </xsl:text> -->
	<!--			<xsl:variable name="size"><xsl:value-of select="//mets:fileGrp[@USE='CONTENT']/mets:file[1]/@SIZE" /></xsl:variable>
				<xsl:choose>
					<xsl:when test="$size &lt; 1000">
						<xsl:value-of select="concat($size, 'Bytes')"/>	
					</xsl:when>
					<xsl:when test="$size &lt; 1000000">
						<xsl:value-of select="translate(substring(string($size div 1000),1,3), '.', ',')"/><xsl:text> KB</xsl:text>
					</xsl:when>
					<xsl:when test="$size &lt; 1000000000">
						<xsl:value-of select="translate(substring(string($size div 1000000),1,3), '.', ',')"/><xsl:text> MB</xsl:text>
					</xsl:when>
					<xsl:when test="$size &lt; 1000000000000">
						<xsl:value-of select="substnslate(ring(string($size div 1000000000),1,3), '.', ',')"/><xsl:text> GB</xsl:text>
					</xsl:when>
				</xsl:choose> -->
			<!--	<xsl:text>)</xsl:text>
			</subfield> -->
		</datafield>
	</xsl:template> 

		<xsl:template name="translatedTitle">
		<xsl:if test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element[@name='translated']">
		<datafield>
		<xsl:attribute name="tag">021G</xsl:attribute>
		<subfield>
		<xsl:attribute name="code">a</xsl:attribute>
		<!--		<xsl:value-of select="//dim:field[@element='title'][@qualifier='translated']" /> -->
		<xsl:call-template name="strip-tags">
		<xsl:with-param name="text" select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element[@name='translated']/doc:element/doc:field"/>
		</xsl:call-template>
		</subfield>
		</datafield>
		</xsl:if>


		</xsl:template>

		<xsl:template name="ddc">
		<!-- 941.081 ; 943 $e DDC Version $a Kategorie -->
		<xsl:if test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='ddc']">
		<datafield>
		<xsl:attribute name="tag">045F</xsl:attribute>
		<subfield>
		<xsl:attribute name="code">e</xsl:attribute>
		<xsl:text>22</xsl:text>
		</subfield>
		<subfield>
		<xsl:attribute name="code">a</xsl:attribute>
		<xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='ddc']">	
		<xsl:value-of select="normalize-space(/doc:element/doc:field)" />
		<xsl:if test="position() != last()" >
		<xsl:text> ; </xsl:text>
		</xsl:if>
		</xsl:for-each>
		</subfield>
		</datafield>
		</xsl:if>
		</xsl:template>

		<xsl:template name="ssgCode">
		<datafield>
		<xsl:attribute name="tag">045Y</xsl:attribute>
		<subfield>
		<xsl:attribute name="code">a</xsl:attribute>
		<!-- Fakultät Code Mapping anwenden -->
		</subfield>
		</datafield>
		</xsl:template>

		<xsl:template name="abstracts">
		<xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstractger']">
		<datafield>
		<xsl:attribute name="tag">047I</xsl:attribute>
		<subfield>
		<xsl:attribute name="code">a</xsl:attribute>
		<xsl:call-template name="strip-tags">
		<xsl:with-param name="text" select="substring(normalize-space(doc:element/doc:field), 1, 597)" /> 
		<!-- <xsl:with-param name="text" select="util:shortenString(normalize-space(.), 597, 25)" /> -->
		</xsl:call-template>
		<xsl:if test="string-length(//doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstractger']/doc:element/doc:field &gt; 597)">
		<xsl:text>...</xsl:text>
		</xsl:if>
		</subfield>
		</datafield>
		</xsl:for-each>
		<xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstracteng']">
		<datafield>
		<xsl:attribute name="tag">047I</xsl:attribute>
		<subfield>
		<xsl:attribute name="code">a</xsl:attribute>
		<xsl:call-template name="strip-tags">
		<xsl:with-param name="text" select="substring(normalize-space(doc:element/doc:field), 1, 597)" />
		<!-- <xsl:with-param name="text" select="util:shortenString(normalize-space(.), 597, 25)" /> -->
		</xsl:call-template>
		<xsl:if test="string-length(//doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstracteng']/doc:element/doc:field &gt; 597)">
		<xsl:text>...</xsl:text>
		</xsl:if>
		</subfield>
		</datafield>
		</xsl:for-each>
		</xsl:template>

		<xsl:template name="cc-license">
		<xsl:if test="//doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element[@name='uri']">
		<datafield>
		<xsl:attribute name="tag">017C</xsl:attribute>
					<subfield>
						<xsl:attribute name="code">u</xsl:attribute>
						<xsl:value-of select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstracteng']/doc:element/doc:field" />
					</subfield>
					<subfield>
						<xsl:attribute name="code">y</xsl:attribute>
						<xsl:text>Linzenz</xsl:text>
					</subfield>
				</datafield>
			</xsl:if>
	</xsl:template>

	<!-- <xsl:template name="gok"> -->
		<!-- VORKOMMNISSE MÜSSEN GEZÄHLT WERDEN -->
	<!--	<xsl:for-each select="//dim:field[@element='subject'][@qualifier='gok']">
			
			<xsl:if test="contains(., 'PPN')">
			<xsl:variable name="temp"><xsl:value-of select="substring-after(., '(PPN')" /></xsl:variable>

				
				<datafield>
					<xsl:attribute name="tag">145Z</xsl:attribute>
					<xsl:if test="position() != 1">
						<xsl:attribute name="occurence"><xsl:value-of select="concat('0', position() - 1)" /></xsl:attribute>
					</xsl:if> 
					<subfield>
						<xsl:attribute name="code">9</xsl:attribute>
						<xsl:value-of select="substring-before($temp, ')')" />
					</subfield>

				</datafield>
			</xsl:if>
		</xsl:for-each>
		
	</xsl:template> -->

	<xsl:template name="gok2"> 

                <!-- VORKOMMNISSE MÜSSEN GEZÄHLT WERDEN -->
                <xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='gokfull']"> 

		 			<xsl:if test="contains(., 'PPN')">
					<xsl:variable name="temp"><xsl:value-of select="substring-after(/doc:element/doc:field, '(PPN')" /></xsl:variable>
		
						
						<datafield>
							<xsl:attribute name="tag">145Z</xsl:attribute>
							<xsl:if test="position() &gt; 1">
								<xsl:attribute name="occurence"><xsl:value-of select="concat('0', position() - 1)" /></xsl:attribute>
							</xsl:if>
							<subfield>
								<xsl:attribute name="code">9</xsl:attribute>
								<xsl:value-of select="substring-before($temp, ')')" />
							</subfield>
		
						</datafield>
		
					</xsl:if>
		        </xsl:for-each>

        </xsl:template> 

	<xsl:template name="subjects">
		<xsl:for-each select="//doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='eng' or @name='ger']">
			<datafield>
				<xsl:attribute name="tag">045D</xsl:attribute>
					<subfield>
						<xsl:attribute name="code">a</xsl:attribute>
								<xsl:value-of select="/doc:element/doc:field" />
					</subfield>
			</datafield>
		</xsl:for-each>
	</xsl:template>
	
		 <xsl:template name="localLinks">
			<datafield>
				<xsl:attribute name="tag">209O</xsl:attribute>
				<xsl:attribute name="occurence">01</xsl:attribute>
					<subfield>
						<xsl:attribute name="code">a</xsl:attribute>
								<xsl:text>ediss</xsl:text>
					</subfield>
					<subfield>
						<xsl:attribute name="code">x</xsl:attribute>
								<xsl:text>00</xsl:text>
					</subfield>
			</datafield>

        </xsl:template>


        <xsl:template name="staticFields">
                     <datafield>
        	             <xsl:attribute name="tag">033A</xsl:attribute>
                	             <subfield>
                                     	<xsl:attribute name="code">p</xsl:attribute>
                                        <xsl:text>Göttingen</xsl:text>       
                                     </subfield>
                     </datafield>
		     <datafield>
                             <xsl:attribute name="tag">033D</xsl:attribute>
				     <subfield>
                                        <xsl:attribute name="code">9</xsl:attribute>
                                        <xsl:text>106313819</xsl:text>
                                     </subfield>	
                                     <subfield>
                                        <xsl:attribute name="code">8</xsl:attribute>
                                        <xsl:text>Göttingen</xsl:text>
                                     </subfield>
				     <subfield>
                                        <xsl:attribute name="code">4</xsl:attribute>
                                        <xsl:text>uvp</xsl:text>
                                     </subfield>
                     </datafield>
		     <datafield>
                             <xsl:attribute name="tag">034M</xsl:attribute>
                                     <subfield>
                                        <xsl:attribute name="code">a</xsl:attribute>
                                        <xsl:text>Illustrationen, Diagramme</xsl:text>
                                     </subfield>
                     </datafield>
        </xsl:template>

<xsl:template name="strip-tags">
    <xsl:param name="text"/>
    <xsl:choose>
        <xsl:when test="contains($text, '&lt;')">
            <xsl:value-of select="substring-before($text, '&lt;')"/>
            <xsl:call-template name="strip-tags">
                    <xsl:with-param name="text" select="substring-after($text, '&gt;')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>

