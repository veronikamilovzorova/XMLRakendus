<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:variable name="koigePopulaarsemLinn">
			<xsl:for-each select="//inimene[not(@elukoht = preceding::inimene/@elukoht)]">
				<!--soorterime kõik inimesed atribuutiga (elukoht) , iga linna puhul loendame, mitu korda see esineb ja valime linn mis on kõige populaarsem -->
				<!--preceding::inimene tähendab kõiki eelnevaid elemente -->
				<!--inimene/@elukoht on atribuut, kus valitakse inimese elukoht -->
				<!--not(@elukoht) kontrollib, kas praegune elukoht on eelmiste seas unikaalne. -->
				<xsl:sort select="count(//inimene[@elukoht = current()/@elukoht])" data-type="number" order="descending"/>
				<!--inimene valitab kõik inimesed -->
				<!--[@elukoht = current()/@elukoht] valin ainult need "inimene" elementid, mille elukoht atribuudi väärtus-->
				<!--count usub -->
				<!--order="descending" määrab sortimisjärjestuse -->
				<!--current() töödeldav element -->
				<!--Sorteerime "inimene" elemente sama linna elanike arvu järgi. -->
				<xsl:if test="position() = 1">
				<!--võimaldab valida elemendi, millel on maksimaalne väärtus -->
					<xsl:value-of select="@elukoht"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<h2>Sugupuu</h2>
		<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
			<tr bgcolor="#ccc">
				<th>Vanema nimi</th>
				<th>Vanema sünniaasta</th>
				<th>Vanema elukoht</th>
				<th>Laste nimed</th>
				<th>Laste sünniaastad</th>
				<th>Laste elukohad</th>
				<th>Laste arv</th>
				<th>Kõige populaarsem linn</th>
			</tr>

			<xsl:apply-templates select="//inimene[lapsed/inimene]">
				<!--valime ainult need inimesed, kellel on lapsed -->
				<xsl:sort select="@synniaasta" data-type="number" order="ascending"/>
			</xsl:apply-templates>
		</table>

		<p>
			<strong>Vastus:</strong> Kõige populaarsem linn: <span style="color:green">
				<xsl:value-of select="$koigePopulaarsemLinn"/>
			</span>
		</p>
	</xsl:template>
	<xsl:template match="inimene">
		<!--match näitab millistele XML-i osadele seda malli rakendada -->
		<xsl:variable name="lasteArv" select="count(lapsed/inimene)"/>
		<xsl:variable name="koigePopulaarsemLinn">
			<xsl:for-each select="//inimene[not(@elukoht = preceding::inimene/@elukoht)]">
				<xsl:sort select="count(//inimene[@elukoht = current()/@elukoht])" data-type="number" order="descending"/>
				<xsl:if test="position() = 1">
					<xsl:value-of select="@elukoht"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<tr>
			<xsl:if test="$lasteArv &gt;= 2">
				<!--&gt onsuurem või võrdne -->
				<xsl:attribute name="style">background-color: yellow;</xsl:attribute>
			</xsl:if>
			<td>
				<xsl:choose>
					<xsl:when test="contains(nimi, 'a')">
						<span style="color: red;">
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
				<xsl:choose>
					<xsl:when test="@elukoht = $koigePopulaarsemLinn">
						<strong>
							<xsl:value-of select="@elukoht"/>
						</strong>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@elukoht"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:for-each select="lapsed/inimene">
					<xsl:value-of select="nimi"/>
					<xsl:if test="position() != last()">, </xsl:if>
					<!-- != last() tähendab, et lõppuks ei tule koma -->
				</xsl:for-each>
			</td>
			<td>
				<xsl:for-each select="lapsed/inimene">
					<xsl:value-of select="@synniaasta"/>
					<xsl:if test="position() != last()">, </xsl:if>
				</xsl:for-each>
			</td>
			<td>
				<xsl:for-each select="lapsed/inimene">
					<xsl:value-of select="@elukoht"/>
					<xsl:if test="position() != last()">, </xsl:if>
				</xsl:for-each>
			</td>
			<td>
				<xsl:value-of select="$lasteArv"/>
			</td>
			<td>
				<xsl:value-of select="$koigePopulaarsemLinn"/>
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>
