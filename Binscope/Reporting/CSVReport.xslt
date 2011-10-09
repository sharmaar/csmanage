<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl">

  <xsl:output method="text" indent="no" omit-xml-declaration="yes"/>

  <xsl:strip-space elements="*"/>
  
  <xsl:template match="/RED">
          <xsl:apply-templates select="items/item[result='FAIL']"/>
          <xsl:apply-templates select="items/item[result='ERROR']"/>
          <xsl:apply-templates select="items/item[result='PASS']"/>
  </xsl:template>
  <xsl:template match="item[type='BinScopeCheck']">"<xsl:value-of select="targetPath"/>","<xsl:value-of select="issueType"/>",<xsl:value-of select="result"/>
    <xsl:text>
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
