<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/> 
	
	<xsl:template match="/">
	<html>
	   <head> 
   		 <title> 
   			 Pays du monde 
  		</title>
	   </head>		
		
	<body style="background-color:white;"> 
		   <h1>Les pays du monde</h1> 
      		Mise en forme par : Quentin Ferro, Fonteneau Felix (B3245)
      		 <xsl:apply-templates select = "//metadonnees"/>
      		 <xsl:apply-templates select = "//country"/>
	</body>
	</html>
	</xsl:template>
	

	<xsl:template match="metadonnees">
 	<p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
 	</p><hr/>
	</xsl:template>
	
	<xsl:template match="country">
		<tr>
		<td> 
			<span style="color:green"><xsl:value-of select="name/common"/> </span> (<xsl:value-of select="name/official"/>)<br/>
			
			<span style="color:brown"><xsl:value-of select="name/native_name[@lang='fra']/official"/> </span>
		</td>
		<td>
			<xsl:value-of select="capital"/>
		</td>	
		<td>		
			
			<xsl:if test="count(borders/neighbour) = 0">île
			</xsl:if>
			<xsl:variable name= "codePays" select="codes/cca3"/> 
			<xsl:for-each select="//country/borders/neighbour">
				<xsl:if test=". =  $codePays">
					<xsl:value-of select="../../name/common"/>,
				</xsl:if>
    			</xsl:for-each>
			
		</td>	
		</tr>
	</xsl:template>
	
</xsl:stylesheet>


