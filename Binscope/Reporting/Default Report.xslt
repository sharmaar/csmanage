<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl">

  <xsl:output method="html" indent="no"/>

  <xsl:template match="/RED">
    <html>
      <head>
        <title>BinScope RED Result</title>
      </head>
      <body>
        <h1>
          Results for <xsl:value-of select="settings/toolName"/> run on <xsl:value-of select="settings/machineName"/>
        </h1>
        <div style="width:100%;overflow:hidden;cursor:pointer;font-style:underline;" onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='block')?'none':'block'">
          <a><u>show run settings</u></a>
        </div>
        <div style="background-color:#F0F0F0;oveflow=hidden;border-bottom:solid 1px #336699;display=none;">
          <ul>
            <xsl:for-each select="settings/*">
              <xsl:choose>
                <xsl:when test="name() = 'checksExecuted'">
                  <li>Checks executed:</li>
                  <ul>
                    <xsl:for-each select="*">
                      <li>
                        <xsl:value-of select="text()"/>
                      </li>
                    </xsl:for-each>
                  </ul>
                </xsl:when>
                <xsl:when test="name() = 'contractAssemblies'"></xsl:when>
                <xsl:when test="name() = 'configuration'"></xsl:when>
                <xsl:otherwise>
                  <li>
                    <xsl:value-of select="name()"/> : <xsl:value-of select="text()"/>
                  </li>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </ul>
        </div>

        <h2>Failed checks</h2>
        <ul>
          <xsl:apply-templates select="items/item[result='FAIL']"/>
          <span/>
        </ul>
        <h2>Checks that didn't complete</h2>
        <ul>
          <xsl:apply-templates select="items/item[result='ERROR']"/>
          <span/>
        </ul>
        <br/>
        <h2>Passed checks</h2>
        <ul>
          <xsl:apply-templates select="items/item[result='PASS']"/>
          <span/>
        </ul>
        <br/>
        <h2>All scanned items</h2>
        <ul>
          <xsl:apply-templates select="items/item[type='BinScopeAttackSurface']"/>
          <span/>
        </ul>
        <br/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="item[type='BinScopeCheck']">
    <li>
      <!--List of additional details, skipping the less relevant ones-->
      <div style="width:100%;overflow:hidden;cursor:pointer;font-style:underline;" onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='block')?'none':'block'">
        <!--The main check title: target and the check type-->
        <xsl:value-of select="targetPath"/> - <xsl:value-of select="issueType"/> (
        <xsl:choose>
          <xsl:when test="child::result = 'PASS'">
            <font size="1" color="#008000" >
              <u><xsl:value-of select="result"/></u>
            </font>
          </xsl:when>
          <xsl:when test="child::result = 'FAIL'">
            <font size="1" color="#FF0000" >
              <u><xsl:value-of select="result"/></u>
            </font>
          </xsl:when>
          <xsl:otherwise>
            <font size="1" color="#800000">
              <b>
                <u><xsl:value-of select="result"/></u>
              </b>
            </font>
          </xsl:otherwise>
        </xsl:choose>
        )
      </div>
      <div style="background-color:#F0F0F0;oveflow=hidden;border-bottom:solid 1px #336699;display=none;">
        <ul>
          <xsl:for-each select="*">
            <xsl:choose>
              <xsl:when test="name() = 'key'"/>
              <xsl:when test="name() = 'result'"/>
              <xsl:when test="name() = 'instance'"/>
              <xsl:when test="name() = 'type'"/>
              <xsl:when test="name() = 'logTime'"/>
              <xsl:when test="name() = 'issueClass'"/>
              <xsl:when test="name() = 'issueType'"/>
              <xsl:when test="name() = 'targetPath'"/>
              <xsl:when test="name() = 'targetVersion'"/>
              <xsl:when test="name() = 'testTarget'"/>
              <xsl:otherwise>
                <li>
                  <xsl:value-of select="name()"/> : <pre><xsl:value-of select="text()"/></pre>
                </li>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </ul>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="item[type='BinScopeAttackSurface']">
    <li>
      <div style="width:100%;overflow:hidden;cursor:pointer;font-style:underline;" onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='block')?'none':'block'">
        <xsl:value-of select="path"/>
      </div>
      <div style="background-color:#F0F0F0;oveflow=hidden;border-bottom:solid 1px #336699;display=none;">
        <ul>
          <xsl:for-each select="*">
            <xsl:choose>
              <xsl:when test="name() = 'objects'"/>
              <xsl:when test="name() = 'category'"/>
              <xsl:when test="name() = 'type'"/>
              <xsl:when test="name() = 'logTime'"/>
              <xsl:when test="name() = 'versionString'">
                <li>
                  <xsl:value-of select="name()"/> : <pre><xsl:value-of select="text()"/></pre>
                </li>
              </xsl:when>
              <xsl:otherwise>
                <li>
                  <xsl:value-of select="name()"/> : <xsl:value-of select="text()"/>
                </li>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </ul>        
      </div>     
      </li>
  </xsl:template>


</xsl:stylesheet>
