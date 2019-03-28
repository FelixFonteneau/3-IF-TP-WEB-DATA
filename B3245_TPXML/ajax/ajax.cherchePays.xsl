<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="NomPays" select = "'France'"/>

<xsl:template match="/">
    <html>
    <body>  
        <xsl:apply-templates select = "//country/name/common" />
        
    </body>
    </html>        
</xsl:template>


<xsl:template match="country/name/common">
    <xsl:if test=". = $NomPays">
        <xsl:value-of select="."/> 
         - Capitale :
        <xsl:value-of select="../../capital"/><br/>
    </xsl:if>
</xsl:template>
    
</xsl:stylesheet>
