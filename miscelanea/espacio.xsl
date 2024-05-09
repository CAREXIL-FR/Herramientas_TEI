<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="no"/>
    <xsl:variable name="precede-espacio" select="('¡', '¿', '(', '«', '“', '[')"/>
    <xsl:variable name="sigue-espacio" select="('.', ',', ':', ';', '!', '?', ')', '»', '”', ']')"/>
    <xsl:variable name="sin-espacio" select="('-')"/>
    <xsl:template match="tok[not(starts-with(@mfs, 'F'))]">
       <xsl:choose>
           <xsl:when test="preceding-sibling::*[1][. = $precede-espacio] and following-sibling::*[1][. = $sigue-espacio]">
               <xsl:copy-of select="preceding-sibling::*[1]"></xsl:copy-of><xsl:copy-of select="."></xsl:copy-of><xsl:copy-of select="following-sibling::*[1]"></xsl:copy-of>
           </xsl:when>
           <xsl:when test="preceding-sibling::*[1][. = $precede-espacio]">
               <xsl:copy-of select="preceding-sibling::*[1]"></xsl:copy-of><xsl:copy-of select="."/>
           </xsl:when>
         <xsl:when test="following-sibling::*[1][. = $sigue-espacio]">
               <xsl:copy-of select="."/><xsl:copy-of select="following-sibling::*[1]"></xsl:copy-of>
           </xsl:when>
   <!--          <xsl:when test="following-sibling::*[1][. = $sin-espacio]">
               <xsl:copy-of select="."/><xsl:copy-of select="following-sibling::*[1]"/><xsl:copy-of select="following-sibling::*[2]"/>
           </xsl:when>           
           <xsl:when test="preceding-sibling::*[1][. = $sin-espacio]"/> -->          
           <xsl:otherwise>
               <xsl:copy-of select="."></xsl:copy-of>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    <xsl:template match="tok[starts-with(@mfs, 'F')]">
        <xsl:choose>
           <xsl:when test="not(. = ($precede-espacio, $sigue-espacio))">
                <xsl:copy-of select="."></xsl:copy-of>
            </xsl:when>           
            <xsl:when test="following-sibling::*[1][starts-with(@mfs, 'F')] and following-sibling::*[2][starts-with(@mfs, 'F')]">
                <xsl:copy-of select="."/><xsl:copy-of select="following-sibling::*[1]"/><xsl:copy-of select="following-sibling::*[2]"/>
            </xsl:when>              
            <xsl:when test="following-sibling::*[1][starts-with(@mfs, 'F')]">
                <xsl:copy-of select="."/><xsl:copy-of select="following-sibling::*[1]"/><xsl:copy-of select="following-sibling::*[2]"/>
            </xsl:when> 
            <xsl:when test="preceding-sibling::*[1][starts-with(@mfs, 'F')]"/>
            <xsl:when test="following-sibling::*[1][name() eq 'tok'][not(starts-with(@mfs, 'F'))] or preceding-sibling::*[1][name() eq 'tok'][not(starts-with(@mfs, 'F'))]"/>
            <xsl:otherwise>
                <xsl:copy-of select="."></xsl:copy-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>