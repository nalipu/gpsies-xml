<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gps="https://github.com/StevenMohr/gpsies-xml/schema/database.xsd"
                xmlns="https://github.com/StevenMohr/gpsies-xml/schema/database.xsd">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" />
    <xsl:template match="/">
    	<gps:track 
    	xmlns="https://github.com/StevenMohr/gpsies-xml/schema/database.xsd">
                    <uid><xsl:value-of select="track/fileId"/></uid>
                    <title><xsl:value-of select="track/title"/></title>
                    <description><xsl:value-of select="track/description"/></description>
                    <createdDate><xsl:value-of select="track/createdDate"/></createdDate>
                    <trackLength><xsl:value-of select="track/trackLengthM"/></trackLength>
                    <altitudeMinHeight><xsl:value-of select="track/altitudeMinHeightM"/></altitudeMinHeight>
                    <altitudeMaxHeight><xsl:value-of select="track/altitudeMaxHeightM"/></altitudeMaxHeight>
                    <totalAscent><xsl:value-of select="track/totalAscentM"/></totalAscent>
                    <totalDescent><xsl:value-of select="track/totalDescentM"/></totalDescent>
                   </gps:track>
    </xsl:template>
</xsl:stylesheet>