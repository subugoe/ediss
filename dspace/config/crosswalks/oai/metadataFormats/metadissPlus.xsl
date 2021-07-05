<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
	Developed by DSpace @ Lyncode <dspace@lyncode.com>
	
	> http://www.openarchives.org/OAI/2.0/oai_dc.xsd

 -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
	xmlns:xMetaDiss="http://www.d-nb.de/standards/xmetadissplus/"
	xmlns:cc="http://www.d-nb.de/standards/cc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:dcmitype="http://purl.org/dc/dcmitype/"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:pc="http://www.d-nb.de/standards/pc/"
	xmlns:urn="http://www.d-nb.de/standards/urn/"
	xmlns:hdl="http://www.d-nb.de/standards/hdl/"
	xmlns:doi="http://www.d-nb.de/standards/doi/"
	xmlns:thesis="http://www.ndltd.org/standards/metadata/etdms/1.0/"
	xmlns:ddb="http://www.d-nb.de/standards/ddb/"
	xmlns:dini="http://www.d-nb.de/standards/xmetadissplus/type/"
	xmlns="http://www.d-nb.de/standards/subject/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.d-nb.de/standards/xmetadissplus/
	http://files.dnb.de/standards/xmetadissplus/xmetadissplus.xsd"
	xmlns:mets="http://www.loc.gov/METS/" 
	xmlns:xlink="http://www.w3.org/TR/xlink/" 
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" />

	<!-- global variables -->
	<xsl:variable name="baseURL">http://ediss.uni-goettingen.de:8122</xsl:variable>
	<xsl:variable name="metsURL" select="concat($baseURL, '/ediss/metadata/handle')"/>
	<xsl:variable name="lifeURL">http://ediss.uni-goettingen.de</xsl:variable>	
	<!-- language info is needed global -->
       <xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="//doc:element[@name='dc']/doc:element[@name='language']/doc:element[@name='iso']/doc:element/doc:field/text() = 'deu'">
				<xsl:text>ger</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="//doc:element[@name='dc']/doc:element[@name='language']/doc:element[@name='iso']/doc:element/doc:field/text()" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- typeinfo is needed multiple time -->
       <xsl:variable name="type">
		   <xsl:value-of select="//doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field/text()" />
	   </xsl:variable>
	
 <xsl:template match="text()"/>
       <xsl:template match="/">
	<xMetaDiss:xMetaDiss xmlns:xMetaDiss="http://www.d-nb.de/standards/xmetadissplus/" xmlns:cc="http://www.d-nb.de/standards/cc/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:pc="http://www.d-nb.de/standards/pc/" xmlns:urn="http://www.d-nb.de/standards/urn/" xmlns:hdl="http://www.d-nb.de/standards/hdl/" xmlns:doi="http://www.d-nb.de/standards/doi/" xmlns:thesis="http://www.ndltd.org/standards/metadata/etdms/1.0/" xmlns:ddb="http://www.d-nb.de/standards/ddb/" xmlns:dini="http://www.d-nb.de/standards/xmetadissplus/type/" xmlns="http://www.d-nb.de/standards/subject/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.d-nb.de/standards/xmetadissplus/ http://files.dnb.de/standards/xmetadissplus/xmetadissplus.xsd">	


		<xsl:call-template name="titles"/>
		<xsl:call-template name="author"/>
		<!-- <xsl:call-template name="dnb-sg"/> -->
		<xsl:call-template name="subjects"/>
		<xsl:call-template name="abstracts"/> 
		<xsl:call-template name="publisher"/>
		<xsl:call-template name="contributors"/>
		<xsl:call-template name="dates"/>
		<xsl:call-template name="publType"/>
		<xsl:call-template name="version"/>
		<xsl:call-template name="identifiers"/>
		<xsl:call-template name="language"/>
		<xsl:call-template name="degree"/>
		<xsl:call-template name="fileSection"/>
		<xsl:call-template name="ddb:rights"/>
	  </xMetaDiss:xMetaDiss>
	</xsl:template>

	<!-- title data -->
	<xsl:template name="titles">
	                <dc:title xsi:type="ddb:titleISO639-2" lang="{$lang}">
        	                <xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title'][1]/doc:element/doc:field"/>
        	        </dc:title>

			<!-- we do not deliver tranlated title because we do not know the language of that 

       			<xsl:if test="//dim:field[@element ='title' and @qualifier='translated']"> 
		                <dc:title xsi:type="ddb:titleISO639-2" lang="{//dim:field[@element ='title' and @qualifier='translated']/@lang}" ddb:type="translated">
        		                <xsl:value-of select="//dim:field[@element ='title' and @qualifier='translated']"/>
        		        </dc:title>
			</xsl:if> -->


		<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element">
			<xsl:if test="@name='alternative' or @name='transcription'">
	                <dcterms:alternative xsi:type="ddb:talternativeISO639-2" lang="{$lang}">
        	                <xsl:value-of select="doc:element/doc:field"/>
			</dcterms:alternative>
			</xsl:if>
        	</xsl:for-each>

		<!--
        	<xsl:if test="//dim:field[@element ='title' and @qualifier='alternativeTranslated']">
	                <dcterms:alternative xsi:type="ddb:talternativeISO639-2" lang="{//dim:field[@element ='title' and @qualifier='alternativeTranslated']/@lang}">
        	                <xsl:value-of select="//dim:field[@element ='title' and @qualifier='alternativeTranslated']"/>
        	        </dcterms:alternative>
        	</xsl:if>
		-->
		
        </xsl:template>

	<!-- author date -->
	<xsl:template name="author">
		<dc:creator xsi:type="pc:MetaPers">
			<!--<pc:person>
				<pc:name type="nameUsedByThePerson">
					
					<xsl:variable name="tail"><xsl:value-of select="normalize-space(substring-after(//dim:field[@qualifier='author'], ','))"/></xsl:variable>
					<xsl:choose>
						<xsl:when test="contains($tail, ' ')">
							<pc:foreName><xsl:value-of select="substring-before($tail, ' ')" /></pc:foreName>
						</xsl:when>
						<xsl:otherwise>
					
					<pc:foreName><xsl:value-of select="$tail"/></pc:foreName>
						</xsl:otherwise>
					</xsl:choose>
					<pc:surName><xsl:value-of select="substring-before(//dim:field[@element ='contributor' and @qualifier='author'], ',')"/></pc:surName>
				</pc:name>
			</pc:person> -->
			<xsl:variable name="person"><xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field"/></xsl:variable>
				
			<pc:person>
                                <pc:name type="nameUsedByThePerson">

                                        <xsl:variable name="tail"><xsl:value-of select="normalize-space(substring-after($person, ','))"/></xsl:variable>
					<xsl:variable name="head"><xsl:value-of select="substring-before($person, ',')"/></xsl:variable>
                                        <xsl:variable name="prefix">
				 		<xsl:choose>
							<xsl:when test="contains($tail, ' von ') or contains($head, 'von ')">
								<xsl:text>von</xsl:text>
							</xsl:when>
																						
							<xsl:when test="contains($tail, ' van ') or contains($head, 'van ')">
								<xsl:text>van</xsl:text>
							</xsl:when>															
							<xsl:when test="contains($tail, ' Van ') or contains($head, 'Van ')">
								<xsl:text>van</xsl:text>
							</xsl:when>
							<xsl:when test="contains($tail, ' de ') or contains($head, 'de ')">
								<xsl:text>de</xsl:text>
							</xsl:when>
							<xsl:when test="contains($tail, ' de ') or contains($head, 'De ')">
								<xsl:text>de</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>none</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>	
					<pc:foreName>
						<xsl:choose>
                                                	<xsl:when test="($prefix != 'none') and contains($tail, $prefix)">
								<xsl:value-of select="normalize-space(substring-before($tail, $prefix))" />
							</xsl:when>
	                                                <xsl:otherwise>
								<xsl:value-of select="$tail"/>
	                                                </xsl:otherwise>
        	                                </xsl:choose> 
                                        </pc:foreName>
					<pc:surName>
						<xsl:choose>
                                                	<xsl:when test="($prefix != 'none') and contains($head, $prefix)">
								<xsl:value-of select="normalize-space(substring-after($head, $prefix))" />
							</xsl:when>
	                                                <xsl:otherwise>
								<xsl:value-of select="$head"/>
	                                                </xsl:otherwise>
        	                                </xsl:choose>
					</pc:surName>
                                        <xsl:if test="not($prefix = 'none')">
							<pc:prefix><xsl:value-of select="$prefix" /></pc:prefix>
                                        </xsl:if>
                                </pc:name>
                        </pc:person>
		</dc:creator>
        </xsl:template>

	<!-- subjects -->
	<!-- <xsl:template name="dnb-sg">
		<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='dc']/doc:element/doc:field">
			<dc:subject xsi:type="xMetaDiss:DDC-SG"><xsl:value-of select="."/></dc:subject>
		</xsl:for-each>
	</xsl:template> -->

	<xsl:template name="subjects">
		<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element">
			<xsl:choose>
			<xsl:when test="@name='ger' or @name='eng'">
				<dc:subject xsi:type="xMetaDiss:noScheme"><xsl:value-of select="translate(doc:element/doc:field, ';', ',')"/></dc:subject>
			</xsl:when>
			<xsl:when test="@name='dnb'">
                                <dc:subject xsi:type="xMetaDiss:DDC-SG"><xsl:value-of select="doc:element/doc:field"/></dc:subject>
                        </xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- abstract -->
	<xsl:template name="abstracts">
		<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element">
			<xsl:variable name="alang">
				<xsl:choose>
					<xsl:when test="string-length(substring-after(@name, 'abstract')) != 0">
						<xsl:value-of select="substring-after(@name, 'abstract')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$lang" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
				<dcterms:abstract xsi:type="ddb:contentISO639-2">
					<xsl:attribute name="lang"><xsl:value-of select="$alang"/></xsl:attribute>
					<xsl:value-of select="doc:element/doc:field"/>
				</dcterms:abstract>
		</xsl:for-each>
	</xsl:template>


	<!-- publisher -->
	<xsl:template name="publisher">
		<dc:publisher ddb:role="Universitaetsbibliothek" xsi:type="cc:Publisher" type="dcterms:ISO3166" countryCode="DE">
			<cc:universityOrInstitution cc:GKD-Nr="2020450-4">
				<cc:name>Niedersächsische Staats- und Universitätsbibliothek Göttingen</cc:name>
				<cc:place>Göttingen</cc:place>
			</cc:universityOrInstitution>
			<cc:address>Platz der Göttinger Sieben 1, 37073 Göttingen</cc:address>
		</dc:publisher>
	</xsl:template>

	<!-- contributors -->
	<xsl:template name="contributors">
		<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element">
			<dc:contributor xsi:type="pc:Contributor" countryCode="DE">
				<xsl:choose>
					<xsl:when test="contains(@name, 'eferee')">
						<xsl:attribute name="thesis:role">referee</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="thesis:role"><xsl:value-of select="@name"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<pc:person>
					<xsl:variable name="tail" select="substring-after(./doc:element/doc:field, ',')"/>
					
					<xsl:choose>
                                        	<xsl:when test="contains(./doc:element/doc:field, 'Prof.')">
							<pc:name type="otherName">
								
								<pc:foreName><xsl:value-of select="normalize-space(substring-before($tail, 'Prof.'))"/></pc:foreName>
		                                                <pc:surName><xsl:value-of select="substring-before(./doc:element/doc:field, ',')"/></pc:surName>
							</pc:name>
							<pc:academicTitle>
								<xsl:text>Prof.</xsl:text>
								<xsl:if test="contains($tail, 'Prof. em.')">
									<xsl:text> em.</xsl:text>
								</xsl:if> 
							</pc:academicTitle>
							
						</xsl:when>
						
						<xsl:when test="contains(./doc:element/doc:field, 'PD')">
							<pc:name type="otherName">
                                                                <pc:foreName><xsl:value-of select="normalize-space(substring-before($tail, 'PD'))"/></pc:foreName>
                                                                <pc:surName><xsl:value-of select="substring-before(./doc:element/doc:field, ',')"/></pc:surName>
							</pc:name>
                                                        <pc:academicTitle>PD</pc:academicTitle>
                                                </xsl:when>
						<xsl:otherwise>
						    <xsl:choose>
							<xsl:when test="contains(./doc:element/doc:field, 'Dr.')">
							 <pc:name type="otherName">
                                                                <pc:foreName><xsl:value-of select="normalize-space(substring-before($tail, 'Dr.'))"/></pc:foreName>
                                                                <pc:surName><xsl:value-of select="substring-before(./doc:element/doc:field, ',')"/></pc:surName>
                                                        </pc:name>
							</xsl:when>
							<xsl:otherwise>
								<pc:name type="otherName">
                                                                <pc:foreName><xsl:value-of select="normalize-space($tail)"/></pc:foreName>
                                                                <pc:surName><xsl:value-of select="substring-before(./doc:element/doc:field, ',')"/></pc:surName>
							</pc:name>
							</xsl:otherwise>
						     </xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					 <xsl:if test="contains($tail, 'Dr. Dr.')">
                                                <pc:academicTitle>Dr.</pc:academicTitle>
                                        </xsl:if>
					<xsl:if test="contains($tail, 'Dr.')">
                                                <pc:academicTitle>
							<xsl:text>Dr.</xsl:text>
							<xsl:if test="contains($tail, 'Dr. h.c.')">
								<xsl:text> h.c.</xsl:text>
							</xsl:if>
						</pc:academicTitle>
                                        </xsl:if>
				</pc:person>
			</dc:contributor>
		</xsl:for-each>
	</xsl:template>


	<!-- dates -->
	<xsl:template name="dates">
		<dcterms:dateAccepted xsi:type="dcterms:W3CDTF">
			<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='examination']/doc:element/doc:field"/>	
		</dcterms:dateAccepted>
		<dcterms:issued xsi:type="dcterms:W3CDTF">
			<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field"/>
		</dcterms:issued>
	</xsl:template>



	<!-- publication type -->
	<xsl:template name="publType">	
		<dc:type xsi:type="dini:PublType">
			<xsl:choose>
                                <xsl:when test="$type ='magisterThesis'">
                                        <xsl:text>masterThesis</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type ='masterThesis'">
                                        <xsl:text>masterThesis</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type ='bachelorThesis'">
                                        <xsl:text>bachelorThesis</xsl:text>
                                </xsl:when>
				<xsl:when test="$type ='StudyThesis'">
                                        <xsl:text>StudyThesis</xsl:text>
                                </xsl:when>
				<xsl:otherwise>
					<xsl:text>doctoralThesis</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</dc:type>
	</xsl:template>

        <!-- driver version -->
        <xsl:template name="version">
                <dini:version_driver>publishedVersion</dini:version_driver>
        </xsl:template>

	<!-- identifiers -->
	<xsl:template name="identifiers">
		<dc:identifier xsi:type="urn:nbn">
			<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='urn']/doc:element/doc:field"/>
		</dc:identifier>
	</xsl:template>

	<!-- Language -->
	<xsl:template name="language">
		<dc:language xsi:type="dcterms:ISO639-2">
			<xsl:value-of select="$lang"/>
		</dc:language>
	</xsl:template>

	<!-- Degree -->
	<!-- possible values: thesis.doctoral, thesis.habilitation, bachelor, master, post-doctoral, Staatsexamen, Diplom, Lizentiat, M.A., other. -->
	<xsl:template name="degree">
	  <thesis:degree>
		<thesis:level>
                        <xsl:choose>
                                <xsl:when test="$type='magisterThesis'">
                                        <xsl:text>master</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type='masterThesis'">
                                        <xsl:text>master</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type='habilitation'">
                                        <xsl:text>master</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type='bachelorThesis'">
                                        <xsl:text>thesis.habilitation</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type='diplomaThesis'">
                                        <xsl:text>Diplom</xsl:text>
                                </xsl:when>
                                <xsl:when test="$type='Other'">
                                        <xsl:text>other</xsl:text>
                                </xsl:when>
				<xsl:otherwise>
					<xsl:text>thesis.doctoral</xsl:text>
				</xsl:otherwise>
                        </xsl:choose>
		</thesis:level>
		<thesis:grantor>
			<cc:universityOrInstitution  cc:GKD-Nr="2024315-7">
				<cc:name>Georg-August Universität</cc:name>
				<cc:place>Göttingen</cc:place>
				<cc:department>
				   <cc:name>
					<xsl:choose>
						<xsl:when test="contains(doc:metadata/doc:element[@name='dc']/doc:element[@name='affiliation']/doc:element[@name='institute']/doc:element/doc:field, ' (')">
							<xsl:value-of select="substring-before(doc:metadata/doc:element[@name='dc']/doc:element[@name='affiliation']/doc:element[@name='institute']/doc:element/doc:field, ' (')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='affiliation']/doc:element[@name='institute']/doc:element/doc:field"/>
						</xsl:otherwise>
					</xsl:choose>
				   </cc:name>
				</cc:department>
			</cc:universityOrInstitution>
		</thesis:grantor>
	  </thesis:degree>
	</xsl:template>

	<xsl:template name="fileSection">
		<xsl:variable name="handle" select="substring-after(doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='uri']/doc:element/doc:field, 'http://hdl.handle.net')"/>
		<xsl:variable name="docURL" select="concat('http://localhost:8080/metadata/handle', $handle, '/mets.xml')"/>
		<xsl:variable name="doc" select="document($docURL)"/>
		<!-- <xsl:variable name="doc" select="document('test-mets.xml')"/> -->
		<xsl:variable name="fileData" select="$doc//mets:fileGrp[@USE='CONTENT']"/> 
		<!-- <ddb:fileData><xsl:value-of select="$docURL" /></ddb:fileData> -->
		<!--DOCURL: <xsl:value-of select="$docURL"/>	
		HANDLE: <xsl:value-of select="$handle"/>
		FILEDATA: -->
		<xsl:value-of select="$fileData"/>
		<ddb:fileNumber><xsl:value-of select="count($fileData/mets:file)"/></ddb:fileNumber>
		<xsl:for-each select="$fileData/mets:file">
			<ddb:fileProperties>
				<xsl:attribute name="ddb:fileName"><xsl:value-of select="normalize-space(./mets:FLocat/@xlink:title)"/></xsl:attribute>
			</ddb:fileProperties>
		</xsl:for-each>
		<xsl:choose>
		<xsl:when test="count($fileData/mets:file) = 0">
				<!-- Do nothing: no transfer URL available -->
                </xsl:when>
		<xsl:when test="count($fileData/mets:file) = 1">
			 <ddb:transfer ddb:type="dcterms:URI"><xsl:value-of select="concat($lifeURL, normalize-space($fileData/mets:file/mets:FLocat/@xlink:href))"/></ddb:transfer>
		</xsl:when>
		<xsl:when test="$fileData/mets:file[1]/mets:FLocat/@xlink:title = $fileData/mets:file[2]/mets:FLocat/@xlink:title">
			<ddb:transfer ddb:type="dcterms:URI"><xsl:value-of select="concat($lifeURL, normalize-space($fileData/mets:file[1]/mets:FLocat/@xlink:href))"/></ddb:transfer>
		</xsl:when>
		<xsl:otherwise>
			<ddb:transfer ddb:type="dcterms:URI"><xsl:value-of select="concat($lifeURL, '/downloads', $handle, '.zip')"/></ddb:transfer>
		</xsl:otherwise>
		</xsl:choose>
		<ddb:identifier ddb:type="handle"><xsl:value-of select="//dim:field[@element ='identifier'][@qualifier='uri']"/></ddb:identifier>

	</xsl:template>


	<xsl:template name="ddb:rights">
		<ddb:rights ddb:kind="free" />
	</xsl:template>
	<!--
	<ddb:fileNumber>1</ddb:fileNumber>
	<ddb:fileProperties
	ddb:fileName="dissertation.pdf"/> -->
	<!-- Wenn es sich bei dem Dokument um ein einzelnes PDF handelt, dann sollte sich dies in der Transfer-URL widerspiegeln.
	     Besteht die Publikation aus mehrere Dateien, dann muss in der Transfer-URL entsprechend ein Archivordner z. B. ZIP geliefert werden. -->
	<!--<ddb:transfer ddb:type="dcterms:URI">
		http://www.ub-beispielstadt.de/dissertation.pdf</ddb:transfer>
	<ddb:identifier ddb:type="URL">
		http://archiv.tu-chemnitz.de/pub/2003/0162/index.html</ddb:identifier>
	<ddb:rights ddb:kind="free"/> -->
</xsl:stylesheet>
