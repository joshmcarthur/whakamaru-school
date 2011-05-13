<?xml version="1.0" encoding="UTF-8"?>
<!--
	WHHAKAMARU SCHOOL WEBSITE
	Author: Joshua McArthur
	
	Date: May 2010
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" version="4.0" />


<xsl:template match="/">



<html>

<head>

	<meta content="text/html; charset=utf-8" http-equiv="Content-Type"></meta>
	
	<!-- SEO -->
	<meta name="keywords" content="whakamaru, school, nz, education, forestry, lake, new zealand"></meta>
	<meta name="description" content="Welcome to Whakamaru School. Come and visit our site and find out more about us!"></meta>
	
	<!-- END SEO -->
	
	
	<!-- Attach additional documents here -->
	<link href="static-content/stylesheets/screen-layout.css" type="text/css" rel="stylesheet" media="screen"></link>
	<link rel="shortcut icon" href="favicon.ico"></link>
	<script language="javascript" type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<script language="javascript" type="text/javascript" src="static-content/scripts/newsletters.js"></script>
	
	<!-- End Document Attachments -->
	
	
	<!-- Additional Scripting -->
	<script type="text/javascript" language="javascript">
	
	</script>
	
	<!-- End Additional Scripting -->

	
	<title>Whakamaru School</title>
	
</head>

<body>

<div id="page-area">



	<div id="page-header">
	<img src="static-content/images/wp-header.jpg" id="header-image" alt="Whakamaru School" width="690" height="70"></img>
	
	<hr class="thick-bar"></hr>
	
	<a href="default.html" class="nav" title="Home">Homepage</a>
	<a href="contact.html" class="nav" title="Contact">Get in Touch with Us</a>
	<a href="news.xml" class="nav" title="News">Stay Up-to-Date with News</a>
	<a href="information.html" class="nav" title="Information">Want to know more?</a>
	
	<hr class="thin-bar"></hr>
	
	</div>
	
	<div id="page-content">
	
		<h2>Stay Up to Date</h2>
		
		<div class="anchor-bar">
			<a href='#iframe_container' title="Read our Newsletter">Read the latest newsletter.</a>
			<span class="divider"></span>
			<a href='#calendar' title="Check our calendar for events">Check the school calendar.</a>
		</div>
		
		<h4>Read our Newsletter</h4>
		
		<p>
		<form name="newsletter_list_form">
		<label for="newsletter-list">Select a document to view: </label>
		
		<select name="newsletter-list" id="newsletter-list" onchange="ViewNewsletter()">
		<xsl:apply-templates select="news-items/item">
			<xsl:sort order="descending" select="position()" />
		</xsl:apply-templates>
		</select>
		</form>
		</p>
		
		
		<div id="iframe_container">
		<iframe id="newsletter_iframe" name="newsletter_iframe" class="newsletter_iframe" width="650" height="400" src="http://docs.google.com/viewer?embedded=true&amp;url={//item[last()]/full_url}"></iframe>
		</div>
		
		
		<h4>What's on?</h4>
		<p>Check out our calendar for details:</p>
		
		<iframe src="http://www.google.com/calendar/embed?showTitle=0&amp;showCalendars=0&amp;showTz=0&amp;mode=AGENDA&amp;height=400&amp;wkst=2&amp;hl=en_GB&amp;bgcolor=%23FFFFFF&amp;src=se53e05v9kgohlolvia3em6f1c%40group.calendar.google.com&amp;color=%232F6309&amp;ctz=Pacific%2FAuckland" style=" border-width:0 " width="650" height="400" frameborder="0" scrolling="no"></iframe>
		
	
		
	</div>
	
	
	<img id="footer-image" src="static-content/images/wp-footer.jpg" width="690" height="200" alt="Forest Landscape"></img>






</div>


</body>

</html>

</xsl:template>


<xsl:template match="item">

<option value="{full_url}"><xsl:value-of select="title" /></option>

</xsl:template>


</xsl:stylesheet>
