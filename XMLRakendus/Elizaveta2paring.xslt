<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
		<strong>Näitame kõik nimed</strong>
		<ul>
			<xsl:for-each select="//inimene">
				
				<xsl:sort select="@aasta" order="descending"/>
				<!--descending - suuremast väiksemani-->
				<li>
					<xsl:value-of select="nimi"/>
					,
					<xsl:value-of select="@saasta"/>
					:
					<i>
					<xsl:value-of select="concat(nimi, ', ', @aasta, '.')"/>
					</i>
				, vanus:
				<xsl:value-of select="2025-@saasta"/>
				</li>
				
			</xsl:for-each>
		</ul>
		<strong>Kõik andmed tabelin vanematega</strong>
		<table border="1">
			<tr>
				<th>Nimi</th>
				<th>Laps</th>
				<th>Sünnipäev</th>
				<th>Vanus</th>
				
				
			</tr>
			<xsl:for-each select="//inimene">
				<tr>
					<td>
						<xsl:value-of select="../../nimi"/>
					</td>
					<td>
						<xsl:value-of select="nimi"/>
					</td>
					<td>
						<xsl:value-of select="@saasta"/>
					</td>
					<td>
						<xsl:value-of select="2025 - number(@saasta)"/>
					</td>
					<td>
						
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<strong> Iga inimese kohta näita mitmendal oma vanema sünniaastal ta sündis</strong>
		<ul> <xsl:for-each select="//inimene">
			<li>
				<xsl:value-of select="nimi"/>
				<xsl:if test="../../@saasta">
					- Lapsevanema vanus oli
					<xsl:value-of select="number(../../@saasta) - number(@saasta)"/> aastat vana
				</xsl:if>


			</li>
			
		</xsl:for-each>
		</ul>
		<strong>
			<ol>
				<li>
					Count() - kogus -üldkogus- kõik nimed xmal jadas:
					<xsl:value-of select ="count(inimene/nimi)"/>
				</li>
				<li>
					substring() - eraldab kolm esimest tähte nimest
					<xsl:for-each select="//inimene">
					<xsl:value-of select ="substring(nimi, 0, 3)"/> |
				</xsl:for-each>
			</li>
				<li>
					substring() - eraldab kolm viimast tähte nimest
					<xsl:for-each select="//inimene">
						<xsl:value-of select="substring(nimi, string-length(nimi) - 2, 3)"/> |

					</xsl:for-each>
				</li>
				<li>starts-with</li>
				<xsl:for-each select="//inimene[starts-with(nimi, 'A')]">
					<xsl:value-of select="nimi"/>, 
				</xsl:for-each>
			</ol>
		</strong>

	</xsl:template>
</xsl:stylesheet>
