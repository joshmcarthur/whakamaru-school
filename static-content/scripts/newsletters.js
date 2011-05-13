// JavaScript Document



	function ViewNewsletter(doc_path)
	{
		var gdocs_view_url = "http://docs.google.com/viewer?embedded=true&url=";
		
		if(doc_path == null)
		{
			//Attempt to get the selected value
			var doc_path = $('#newsletter-list').val();
		}
		
		var url = gdocs_view_url + escape(doc_path);
		
		var iframe = $('<iframe>').attr(
										{
											'name': 'newsletter_iframe',
											'id': 'newsletter_iframe',
											'class': 'newsletter_iframe',
											'width': '650',
											'height': '400',
											'src': url
										});
		
		$('#newsletter_iframe').replaceWith(iframe);
	}