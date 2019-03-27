<?xml version="1.0"?>

<xsl:stylesheet version  ="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="NomPays" />
    
<xsl:template match="/">
    <html>
    <body>  
        <xsl:apply-templates name = "//country" />
    </body>
    </html>
        
</xsl:template>
    
    
<xsl:template match="country[name/official = $NomPays]">
    <xsl:value-of select="name/official"/><br/>
</xsl:template>