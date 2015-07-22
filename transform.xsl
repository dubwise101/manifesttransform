<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="2.0"
                xmlns:android="http://schemas.android.com/apk/res/android"
                exclude-result-prefixes="android">
    
    <xsl:output method="text" 
                encoding="UTF-8"/>

    <xsl:template match="manifest">
      \begin{landscape}
      {\small {
        <xsl:for-each-group select="*" group-starting-with="permission-group">
            \begin{longtable}{p{6cm}|l|l}
            <xsl:apply-templates select="current-group()"/>
            \end{longtable}
        </xsl:for-each-group>
        }}
        \end{landscape}
    </xsl:template>    
    
    <xsl:template match="permission-group">
        Group &amp; \multicolumn{2}{|l|}{Description} \\
        \hline
        \verb|<xsl:value-of select="substring(@android:name, 26, 35)" />| &amp; \multicolumn{2}{|l|}{<xsl:value-of select="normalize-space(preceding-sibling::comment()[1])" />}\\
        \hline
        \textbf{Permission} &amp; \textbf{Permission Level} &amp; \textbf{Description} \\
        \hline
        \hline
    </xsl:template>    
    
    <xsl:template match="permission">
        \verb|<xsl:value-of select="substring(@android:name, 20, 35)" />| &amp; <xsl:value-of select="@android:protectionLevel" /> &amp;  <xsl:if test="preceding-sibling::comment()[1]">
            <xsl:variable name="s1" select="normalize-space(preceding-sibling::comment()[1])"/>
            <xsl:value-of  select="translate(replace(replace($s1, '_', concat('\\', '_')),'#',''),'&amp;','')"/>
          </xsl:if><xsl:text>\\</xsl:text>
    </xsl:template>    
    
</xsl:transform>
