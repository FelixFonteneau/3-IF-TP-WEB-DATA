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

          <!--  <xsl:for-each select="//country/infosContinent/continent[not(preceding::country/infosContinent/continent/. = . )]">

                <xsl:value-of select = "."/>
                <xsl:apply-templates name = "//country">
                    <xsl:with-param name = "conti" select = "." />
                </xsl:apply-templates>

            </xsl:for-each> -->


 					<hr/>
 					<p>Pays avec 6 voisins :
						<xsl:for-each select="//borders[count(neighbour) = 6]">
							<xsl:value-of select="../name/common"/>
							<xsl:if test="position() !=  last()">, </xsl:if>
						</xsl:for-each>
 					</p>Pays ayant le plus court nom :
					<common>
						<xsl:for-each select="//name">
							<xsl:sort select="string-length(common)" data-type="number" order="ascending"/>
							<xsl:if test="position()=1">
								<xsl:copy-of select="common"/>
							</xsl:if>
						</xsl:for-each>
					</common>
					<hr/>
					<xsl:apply-templates select="//infosContinent[not(preceding::continent = continent)]/continent"/>

				<!--<xsl:apply-templates select = "//country"/>
			-->
	</body>
	</html>
	</xsl:template>


	<xsl:template match="metadonnees">
 	<p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
 	</p><hr/>
	</xsl:template>



	<xsl:variable name= "codePays" select="codes/cca3"/>


<xsl:template match="continent">
	<xsl:variable name="Continent" select ="."/>
	<xsl:if test=". != '' ">
		<h3>Pays du continent :   <xsl:value-of select="."/> par sous-regions :</h3>
		<xsl:apply-templates select="//infosContinent[not(preceding::subregion = subregion) and continent = $Continent ]/subregion"/>
	</xsl:if>

</xsl:template>


<xsl:template match="subregion">
	<h4><xsl:value-of select="."/> (27 pays) </h4>
	<xsl:variable name="SousReg" select ="."/>
	<table border="3" width="100%" align="center">
         <tr>
            <th>N</th>
            <th>Nom</th>
            <th>Capitale</th>
            <th>Voisins</th>
            <th>Coordonnes</th>
            <th>Drapeau</th>
         </tr>
	<xsl:apply-templates select="//country[ infosContinent/subregion = $SousReg ]"/>
</table>
</xsl:template>


	<xsl:template match="country">

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

                <xsl:if test="count(borders/neighbour) = 0 and landlocked='false'">
                    île
                </xsl:if>
                <xsl:for-each select="borders/neighbour">
									<xsl:variable name="codePays" select="."/>
									<xsl:value-of select="//country[codes/cca3 = $codePays]/name/common"/>
												<xsl:if test="position() !=  last()">,</xsl:if>
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

	</xsl:template>

</xsl:stylesheet>
