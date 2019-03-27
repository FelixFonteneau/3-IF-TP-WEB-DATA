<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />


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
        
            <xsl:for-each select="//country/infosContinent/continent[not(preceding::country/infosContinent/continent/. = . )]">
                
                <xsl:value-of select = "."/>
                <xsl:apply-templates name = "//country">
                    <xsl:with-param name = "conti" select = "." />
                </xsl:apply-templates>
        
            </xsl:for-each>
        
	</body>
	</html>
	</xsl:template>


	<xsl:template match="metadonnees">
 	<p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
 	</p><hr/>
	</xsl:template>



	<xsl:variable name= "codePays" select="codes/cca3"/>



	<xsl:template match="country">
        <xsl:param name = "conti" />
        <xsl:if test = "infosContinent/continent=$conti">
            <table border="3" width="1024" align="center">
            
            <tr>
            <td>
                <xsl:value-of select="position()"/>
            </td>
            <td>
                <span style="color:green"><xsl:value-of select="name/common"/> </span> (<xsl:value-of select="name/official"/>)<br/>
                <span style="color:brown"><xsl:value-of select="name/native_name[@lang='fra']/official"/> </span>
            </td>
            <td>  
                <xsl:value-of select="capital"/>
            </td>
            <td>

                <xsl:if test="count(borders/neighbour) = 0">
                    île
                </xsl:if>
                <xsl:variable name= "codePays" select="codes/cca3"/>
                <xsl:for-each select="//country/borders/neighbour">
                    <xsl:if test=". =  $codePays">
                        <xsl:value-of select="../../name/common"/>,
                    </xsl:if>
                </xsl:for-each>

            </td>
            <td>
                Latitude : <xsl:value-of select="coordinates/@lat"/> <br/>
                Longitude : <xsl:value-of select="coordinates/@long"/>
            </td>
            <td>
                <xsl:variable name="codePays" select="codes/cca2"/>
                <xsl:variable name="url">
				http://www.geonames.org/flags/x/<xsl:value-of select="translate($codePays,$uppercase,$lowercase)"/>.gif
                </xsl:variable>
                <img src="{$url}" alt="" height="40" width="60"/>
                
            </td>
            </tr>
            </table>
        </xsl:if>
        
	</xsl:template>
    
</xsl:stylesheet>