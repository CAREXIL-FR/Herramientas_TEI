<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="no"/>

<!--Crea archivos vacíos si el documento editado contiene menos de 5 tokes-->
    <xsl:template match="/">
        <xsl:if test="count(descendant::tok) gt 5">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <!-- Elementos cuyo nombre comienza con “tei_” y que serían equivalentes 
    al elemento TEI correspondiente -->
    <xsl:template match="tei_address | tei_opener">
        <xsl:variable name="elementName" select="substring-after(name(), 'tei_')"/>
        <xsl:element name="{$elementName}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Elementos que tienen un atributo @id que debe ser sustituido por @xml:id -->
    <xsl:template match="lb | pb | p | placeName | persName | orgName">
        <xsl:variable name="elementName" select="name()"/>
        <xsl:element name="{$elementName}">
            <xsl:if test="@id">
                <xsl:attribute name="xml:id" select="@id"/>
            </xsl:if>
            <xsl:copy-of select="@*[not(name() eq 'id')]"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tok[not(starts-with(@mfs, 'F')) and not(@fform)] | dtok">
        <w xml:id="{@id}">
            <xsl:if test="dtok">
                <xsl:attribute name="orig" select="@form"/>
            </xsl:if>
            <xsl:if test="@nform">
                <xsl:attribute name="norm" select="@nform"/>
            </xsl:if>
            <xsl:if test="@lemma">
                <xsl:attribute name="lemma">
                    <xsl:value-of select="string(@lemma)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@mfs">
                <xsl:attribute name="lemma" select="@msd"/>
            </xsl:if>
            <xsl:if test="@ling or @ling2">
                <xsl:attribute name="ana" select="string-join((@ling, @ling2), ' ')"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="dtok">
                    <xsl:apply-templates select="dtok"/>
                </xsl:when>
                <xsl:when test="@form ne .">
                    <choice>
                        <orig>
                            <xsl:apply-templates/>
                        </orig>
                        <reg>
                            <xsl:value-of select="@form"/>
                        </reg>
                    </choice>
                </xsl:when>
                <xsl:when test="name() eq 'dtok'">
                    <xsl:choose>
                        <xsl:when test="@form">
                            <xsl:value-of select="@form"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@lemma"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </w>
    </xsl:template>
    <xsl:template match="tok[@fform]">
        <choice>
            <abbr>
                <w xml:id="{@id}">
                    <xsl:if test="@nform">
                        <xsl:attribute name="norm" select="@nform"/>
                    </xsl:if>
                    <xsl:if test="@lemma">
                        <xsl:attribute name="lemma" select="@lemma"/>
                    </xsl:if>
                    <xsl:if test="@mfs">
                        <xsl:attribute name="lemma" select="@msd"/>
                    </xsl:if>
                    <xsl:if test="@ling or @ling2">
                        <xsl:attribute name="ana" select="string-join((@ling, @ling2), ' ')"/>
                    </xsl:if>
                    <xsl:apply-templates/>
                </w>
            </abbr>
            <expan>
                <xsl:value-of select="@fform"/>
            </expan>
        </choice>
    </xsl:template>
    <xsl:template match="tok[starts-with(@mfs, 'F')]">
        <pc>
            <xsl:apply-templates/>
        </pc>
    </xsl:template>
</xsl:stylesheet>
