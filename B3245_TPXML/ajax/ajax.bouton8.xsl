<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:param name="NomPays"/>


<xsl:template match="/">
    <html>
    <body>
        <xsl:apply-templates select = "//country" />
    </body>
    </html>
</xsl:template>


<xsl:template match="country">
        <xsl:if test="name/common = $NomPays">
          <tr>
            <td class="classNomPays">
              <xsl:value-of select="name/common"/>
            </td>
            <td>
              <xsl:value-of select="capital"/>
            </td>
            <td>

              <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
              <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

              <xsl:variable name="codePays" select="codes/cca2"/>
              <xsl:variable name="url">
                http://www.geonames.org/flags/x/<xsl:value-of select="translate($codePays,$uppercase,$lowercase)"/>.gif
              </xsl:variable>
              <img src="{$url}" alt="" height="40" width="60"/>

            </td>
          </tr>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
