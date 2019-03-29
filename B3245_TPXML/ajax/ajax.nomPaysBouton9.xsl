<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <html>
    <body>
        <xsl:apply-templates select = "//country/name/common" />

    </body>
    </html>
</xsl:template>


<xsl:template match="country/name/common">
        <span><xsl:value-of select="."/></span>
</xsl:template>

</xsl:stylesheet>
