<?xml version='1.0' encoding='ISO-8859-1'?>
<!-- 
/**
 * @author Marcio Ribeiro (mmr)
 * @version $Id: projects.xsl,v 1.16 2006/07/07 11:36:51 mmr Exp $
 */
-->
<xsl:transform version='1.0'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
    xmlns:mmr='http://b1n.org'>

<xsl:output encoding='ISO-8859-1' indent='yes' />
<xsl:strip-space elements='*' />
<xsl:param name='itemsPerTopLink' select='2' />

<!-- Functions -->
    <!-- Build Table Of Contents -->
<xsl:template name='buildToc' match='/'>
    <xsl:param name='toc' />
    <xsl:param name='perLine' />

    <table>
    <xsl:for-each select='$toc[position() mod $perLine = 1]'>
        <tr>
            <xsl:for-each select='.|following-sibling::mmr:project[position() &lt; $perLine]'>
                <td><a href='#{mmr:name}'><xsl:value-of select='mmr:name'/></a></td>
            </xsl:for-each>
        </tr>
    </xsl:for-each>
    </table>
</xsl:template>

<!-- Project Template -->
<xsl:template match='mmr:projects/*/mmr:project'>
    <div class='project'>
        <a name='{mmr:name}'> </a>
        <h2><xsl:value-of select='mmr:name' /></h2>
        <div class='desc'>
            <xsl:value-of select='mmr:desc' />
        </div>
    <xsl:if test='mmr:status'>
        <div class='status'>
            <span class='statusLabel'>Status:</span>
            <span class='statusName'>
            <xsl:choose>
                <xsl:when test='mmr:status = 1'>
                    Concluído
                </xsl:when>
                <xsl:when test='mmr:status = 2'>
                    Não concluído
                </xsl:when>
                <xsl:when test='mmr:status = 3'>
                    Em desenvolvimento
                </xsl:when>
            </xsl:choose>
            </span>
            <span><xsl:value-of select='mmr:works'/></span>
        </div>
    </xsl:if>
    <xsl:if test='mmr:technologies'>
        <div class='technologies'>
            <h3>Tecnologias</h3>
            <ul>
        <xsl:for-each select='mmr:technologies/mmr:technology'>
            <xsl:sort select='.' />
            <li><xsl:value-of select='.' /></li> 
        </xsl:for-each>
            </ul>
        </div>
    </xsl:if>
    <xsl:if test='mmr:path'>
        <div class='path'></div>
    </xsl:if>
    <xsl:if test='position() mod $itemsPerTopLink = 0'>
        <div class='topLink'><a href='#top'>Topo</a></div>
    </xsl:if>
    </div>
</xsl:template>

<!-- Projects -->
<xsl:template match='/'>
<html xml:lang='pt-br'>
    <head>
        <meta http-equiv='content-type' content='text/html; charset=ISO-8859-1'/>
        <meta name='author' content='Marcio Ribeiro' />
        <meta name='description' content='Projects'/>
        <meta name='keywords' content='Marcio Ribeiro, mmr, Projects'/>
        <meta name='robots' content='ALL'/>
        <meta name='language' content='pt-br'/>
        <link rel='shortcut icon' href='img/kartman.png'/>
        <link rel='author' href='Marcio Ribeiro'/>
        <link rel='home' href='http://b1n.org'/>
        <link rel='stylesheet' href='css/global.css' />
        <link rel='stylesheet' href='css/custom.css' />
        <title>Marcio Ribeiro Projects</title>
    </head>
    <body>
        <a name='top'> </a>
        <div id='main'>
            <div id='header'>
                <h1>Meus Projetos</h1>
            </div>
            <div id='toc'>
                <div id='tocWork'>
                    <div class='title'>
                        <h2><xsl:value-of select='mmr:projects/mmr:workProjects/@title' /></h2>
                        <small class='subtitle'><xsl:value-of select='mmr:projects/mmr:workProjects/@subtitle' /></small>
                    </div>
                    <xsl:call-template name='buildToc'>
                        <xsl:with-param name='toc'
                            select='mmr:projects/mmr:workProjects/mmr:project' />
                        <xsl:with-param name='perLine' select='2' />
                    </xsl:call-template>
                </div>
                <div id='tocHobby'>
                    <div class='title'>
                        <h2><xsl:value-of select='mmr:projects/mmr:hobbyProjects/@title' /></h2>
                        <small class='subtitle'><xsl:value-of select='mmr:projects/mmr:hobbyProjects/@subtitle' /></small>
                    </div>
                    <xsl:call-template name='buildToc'>
                        <xsl:with-param name='toc'
                            select='mmr:projects/mmr:hobbyProjects/mmr:project' />
                        <xsl:with-param name='perLine' select='3' />
                    </xsl:call-template>
                </div>
            </div>

            <div id='work'>
                <div class='title'>
                    <h2><xsl:value-of select='mmr:projects/mmr:workProjects/@title' /></h2>
                </div>
                <xsl:apply-templates select='mmr:projects/mmr:workProjects'/>
            </div>

            <div id='hobby'>
                <div class='title'>
                    <h2><xsl:value-of select='mmr:projects/mmr:hobbyProjects/@title' /></h2>
                </div>
                <xsl:apply-templates select='mmr:projects/mmr:hobbyProjects'/>
            </div>

            <div id='footer'>
                <h2>Arquivos</h2>
                <div id='files'>
                    <span>Arquivos usados para gerar esse documento:</span>
                    <ul>
                        <li><a href='projects.xml.txt'>XML</a></li>
                        <li><a href='projects.xsd'>XSD</a></li>
                        <li><a href='projects.xsl'>XSLT : XML para HTML</a></li>
                    </ul>
                    <div class='topLink'><a href='#top'>Topo</a></div>
                </div>
                <div id='copyright'>
                    &#160;2006 <a href='http://b1n.org/cv/'>Marcio Ribeiro</a> (mmr)
                </div>
            </div>
        </div>
    </body>
</html>
</xsl:template>
</xsl:transform>
