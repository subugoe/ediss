<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.1">

	<xsl:param name="purl"/>
	<xsl:param name="query"/>
	<xsl:variable name="baseURL">https://ediss.uni-goettingen.de</xsl:variable>
	<xsl:variable name="mapfile">purl-mapping.xml</xsl:variable>
	<xsl:variable name="purlMapping" select="document($mapfile)" />

	<!-- <xsl:variable name="purl">eiruoerup</xsl:variable> -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="resolvedLPIs">
		<resolvedLPIs>
			<LPI>
				<requestedLPI>
                                                <xsl:value-of select="concat($baseURL, '/resolvexml?', $query)"/>
                                        </requestedLPI>
                                       <service>eDISS Göttingen</service>
                                       <servicehome><xsl:value-of select="$baseURL"/></servicehome>

		<xsl:choose>
			<xsl:when test="$purlMapping//nodes/node[@webdocID=$query]">
				       <url>
						<xsl:value-of select="concat($baseURL, '/handle/', $purlMapping//nodes/node[@webdocID=$query])" />
					</url>
			</xsl:when>
			<xsl:otherwise>
				<URL />
			</xsl:otherwise>
		</xsl:choose>

		
                 <xsl:apply-templates select="@*|node()"/> 
				<!--  <mime>text/html</mime>
                        	   <access>free</access> -->
				<version />
                          </LPI>
		</resolvedLPIs>
        </xsl:template>


</xsl:stylesheet>

