<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/facetConcepts">
        <facetsConfiguration>
            <xsl:apply-templates select="facetConcept"/>
        </facetsConfiguration>
    </xsl:template>

    <xsl:template match="facetConcept">
        <facet>
            <xsl:if test="./@name">
                <xsl:attribute name="name" select="./@name"/>
            </xsl:if>
            <xsl:if test="./@allowMultipleValues">
                <allowMultipleValues>
                    <xsl:value-of select="./@allowMultipleValues"/>
                </allowMultipleValues>
            </xsl:if>
            <xsl:if test="./@multilingual">
                <multilingual>
                    <xsl:value-of select="./@multilingual"/>
                </multilingual>
            </xsl:if>
            <xsl:if test="./@isCaseInsensitive">
                <caseInsensitive>
                    <xsl:value-of select="./@isCaseInsensitive"/>
                </caseInsensitive>
            </xsl:if>
            <xsl:if test="./@description">
                <description>
                    <xsl:value-of select="./@description"/>
                </description>
            </xsl:if>
            <xsl:if test="./@definition">
                <definition>
                    <xsl:value-of select="./@definition"/>
                </definition>
            </xsl:if>
        </facet>
    </xsl:template>

</xsl:stylesheet>
