<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"     
	xmlns:mets="http://www.loc.gov/METS/" 
	xmlns:xlink="http://www.w3.org/TR/xlink/"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" 
	exclude-result-prefixes="mets xlink dim"
	version="1.0">
	<xsl:output indent="yes" encoding="utf8"/>


   <xsl:template match="text()"/>
       <xsl:template match="/">
		<xsl:call-template name="confirmation"/>
	</xsl:template>


	<xsl:template name="confirmation">
		<html>
			<head>
				<title>eDiss Bestätigung</title>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
				<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0" name="viewport" />
				<link type="text/css" rel="stylesheet" media="all" href="/static/confirm.css" />
					
			</head>

			<body>
				<img id="logo" src="/themes/Mirage2/images/sub-logo.png" alt="SUB Göttingen" />

				<h1>Elektronische Publikation der Dissertation</h1>

				<dl>
					<dt>Autor: </dt>
					<dd><xsl:value-of select="//dim:field[@element='contributor'][@qualifier='author']"/></dd>
					<dt>Titel: </dt>
					<dd><xsl:value-of select="//dim:field[@element='title' and  not(@qualifier)]"/>
							
					<xsl:if test="//dim:field[@element='title'][@qualifier='alternative']">
						 <xsl:text> - </xsl:text>
						<xsl:value-of select="//dim:field[@element='title'][@qualifier='alternative']"/>
					</xsl:if>
					 </dd>
				</dl>
			
				<p class="clearfix">
				Es wird hiermit bestätigt, dass die Dissertation des oben genannten Antragstellers von der Niedersächsischen Staats- und Universitätsbibliothek in elektronischer Form veröffentlicht wurde.
				Die Adresse der Veröffentlichung lautet:
				</p>
				<p class="uri"><xsl:value-of select="//dim:field[@element='identifier'][@qualifier='uri']"/></p>
				<p>Eine schriftliche Bestätigung des Antragstellers, dass die der SUB Göttingen übergebenen ausgedruckten Exemplare mit der elektronischen Fassung identisch sind, liegt vor.</p>
				
				<p></p>
				<div class="two-cols">
					<p class="left">Ort, Datum <span class="fill">Göttingen, den <xsl:text>&#160;</xsl:text><xsl:value-of select="document('date.xml')/date" /></span></p>
					<p class="right">Stempel, Unterschrift</p>
				</div>
			</body>
		</html>	
	</xsl:template>

	
</xsl:stylesheet>


