<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	
	<xsl:template name="countChildren">
		<xsl:param name="node"/>
		<xsl:value-of select="count($node/lapsed/inimene)"/>
	</xsl:template>

	
	<xsl:template match="/sugupuu">

		<h2>Vanaema nimi ja tema lapsed:</h2>
		<xsl:for-each select="inimene[nimi='Ninna']">
			<xsl:value-of select="nimi"/>:
			<xsl:for-each select="lapsed/inimene">
				<xsl:text> </xsl:text>
				<xsl:value-of select="nimi"/>
				<xsl:if test="position() != last()">,</xsl:if>
			</xsl:for-each>
		</xsl:for-each>

		<br/>
		<br/>

		<h2>Kõik andmed tabelina</h2>
		<table border="1" cellpadding="5" cellspacing="0">
			<tr bgcolor="#ccc">
				<th>Nimi</th>
				<th>Sünniaasta</th>
				<th>Elukoht</th>
				<th>Laste arv</th>
			</tr>
			<xsl:for-each select="inimene">
				<tr>
					
					<td>
						<xsl:choose>
							<xsl:when test="contains(nimi, 'a')">
								<span style="color:red;">
									<xsl:value-of select="nimi"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="nimi"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>

					<td>
						<xsl:value-of select="@synniaasta"/>
					</td>

					<td>
						
						<xsl:value-of select="@elukoht"/>
						
					</td>

					<td>
						
						<xsl:variable name="Lastekogus" select="count(lapsed/inimene)"/>
						<xsl:value-of select="$Lastekogus"/>
					</td>

				
					<xsl:if test="Lastekogus &gt;= 2">
						<xsl:attribute name="style">background-color:yellow;</xsl:attribute>
					</xsl:if>
				</tr>

			
			
			</xsl:for-each>
		</table>

		<br/>

		<h2>Inimeste arv elukohtade kaupa</h2>
		<table border="1" cellpadding="5" cellspacing="0">
			<tr bgcolor="#ccc">
				<th>Elukoht</th>
				<th>Inimeste arv</th>
			</tr>
			
			<xsl:for-each select="inimene[not(@elukoht = preceding-sibling::inimene/@elukoht)]">
				<tr>
					<td>
						<xsl:value-of select="@elukoht"/>
					</td>
					<td>
						<xsl:value-of select="count(/sugupuu/inimene[@elukoht = current()/@elukoht])"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>

	</xsl:template>
</xsl:stylesheet>
