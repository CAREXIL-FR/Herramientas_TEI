<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="tok[@fform][dtok]">
        <xsl:apply-templates select="dtok" mode="abrev"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="dtok" mode="abrev">
        <tok form="{@form}" fform="{@fform}" mfs="{@mfs}" lemma="{@lemma}">
            <xsl:value-of select="@form"/>
        </tok>
    </xsl:template>
</xsl:stylesheet>