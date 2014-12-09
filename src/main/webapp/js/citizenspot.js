$(function () {
	listProblems();
	$('#problem-date').datetimepicker({
		format:	'YYYY-MM-DD hh:mm:ss'
	});

	var geocoder;
	if (navigator.geolocation)
	{
		navigator.geolocation.getCurrentPosition(showCurrentLocation);
	}
	else
	{
		alert("Geolocation API not supported.");
	}
	
	var bar = $('.bar');
	var percent = $('.percent');
	var status = $('#status');
	   
	$('#upload-form').ajaxForm({
	    beforeSend: function() {
	        status.empty();
	        var percentVal = '0%';
	        bar.width(percentVal)
	        percent.html(percentVal);
	    },
	    uploadProgress: function(event, position, total, percentComplete) {
	        var percentVal = percentComplete + '%';
	        bar.width(percentVal)
	        percent.html(percentVal);
	    },
	    success: function() {
	        var percentVal = '100%';
	        bar.width(percentVal)
	        percent.html(percentVal);
	    },
		complete: function(xhr) {
			status.html(xhr.responseText);
		}
	});
});

function showCurrentLocation(position)
{
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;
	var coords = new google.maps.LatLng(latitude, longitude);
	codeLatLng(coords);
	var mapOptions = {
		zoom: 15,
		center: coords,
		mapTypeControl: true,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};

	//create the map, and place it in the HTML map div
	map = new google.maps.Map(
		document.getElementById("mapPlaceholder"), mapOptions
	);

	//place the initial marker
	var marker = new google.maps.Marker({
		position: coords,
		map: map,
		title: "Current location!"
	});
}
function codeLatLng(coords) {
	geocoder = new google.maps.Geocoder();
	geocoder.geocode({'latLng': coords}, function(results, status) {
   		if (status == google.maps.GeocoderStatus.OK) {
 			if (results[0]) {
        		var address_components = results[0].address_components;
        		var currentZipcode; 
        		for (var i = 0; i < address_components.length; ++i) {
					if ('postal_code' == address_components[i].types[0]) {
						currentZipcode = address_components[i].long_name;
						break;
					}
		    	}
				funCurrentLocationProblems(currentZipcode);
         	} else {
        		alert('No results found');
      		}
    	} else {
    		alert('Geocoder failed due to: ' + status);
    	}
	});
}

function listProblems() {
	$("#listOfProblems").html();
	var i;
	$.ajax({
	    url : "rest/Problems/listProblems",
	    type: "GET",
	    success: function(data, textStatus, jqXHR)
	    {	console.log(data);
	    	var response = "";
	    	data.forEach(function(entry) {
		    	var val=entry.severity;
		    	var i=0;
		    	var j=0;
		    	response += '<div class="thumb"><div class="row rating-share"><span class="severity pull-left">';
				while(i<5)
				{
					 
					 if(j<val)
    				{	
    					response+=	'<i class="glyphicon glyphicon-star"></i>';
    					 
    				}
	    				else
	    			{
    					response+=	'<i class="glyphicon glyphicon-star-empty"></i>';
	    			}
				 	i++;
				 	j++;
				 }
				response += '</span><span class="actions pull-right"><i class="fa fa-share-alt"></i></span></div>'+
							'<div class="row"><img height="200" width="200" src="'+entry.image+'" ></div>'+
							'<div class="row"><p>'+entry.description+'<a data-toggle="modal" onclick="fun('+entry.id+')" href="#myModal1" data-event-id="">more</a>'+
							'</p></div></div>';
			});
	        $("#listOfProblems").html(response);
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {

	    }
	});
}

$("#submitSearchValue").click(function(event){
	event.preventDefault();
	$(".media").html();
	var zipcode = $("#searchValue").val();
	$.ajax({
	    url : "rest/Problems/SearchByZipcode/"+zipcode,
	    type: "GET",
	    dataType: 'json',
	    success: function(data, textStatus, jqXHR)
	    {	
		  	var response = "";
		  	if(data.length!=0)
			{
	    	data.forEach(function(entry) {
	    		response += '<a href="#" class="pull-left"><img height="75" width="75" src="'+entry.image+'"'+
	    		'class="thumb-pic" alt="Sample Image"></a><a href="#" class="pull-left"></a><div class="media-body"><h4>'+entry.problemName+'<small>'+entry.addressLine+'</small></h4><div class="post-date">'+entry.city+'</div><p class="short-desc">'+entry.description+
		            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id="">more</a></p></div> <hr/>';
		      
	    	}); 
			}else
			{	
	            response+='<div class="media-body"><h4>No Content for the searched Zipcode!</h4></div>'; 
			}
		  	$(".media").html(response);
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {	
	    	console.log(data);
	        $("#errorMsg").html("No data fetched!");
	   
	    }
	});
});

function fun(value) {
	$("#successSearch").html();
	$.ajax({
	    url : "rest/Problems/listById/"+value,
	    type: "GET",
	    dataType: 'json',
	    success: function(data, textStatus, jqXHR)
	    { 	console.log(data);
	    	$("#displayProblemName").html(data.problemName);
	    	$("#problemLocationValue").html(data.addressLine+" "+data.street);
	    	$("#problemDateValue").html(data.date);
	    	$("#problemSeverityValue").html(data.severity);
	    	$("#problemDescriptionValue").html(data.description);
	    	var str = data.image;
	    	alert(str);
	    	$("#problemImage").attr('src',str);
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {
	    	console.log(data);
	        $("#errorMsg").html("No data fetched!");
	   
	    }
});
}
function funCurrentLocationProblems(currentZip)
{
	$.ajax({
	    url : "rest/Problems/SearchByZipcode/"+currentZip,
	    type: "GET",
	    dataType: 'json',
	    success: function(data, textStatus, jqXHR)
	    {	var response = "";
	   
		if(data.length!=0)
		{
		    
	    	data.forEach(function(entry) {
	    		response += '<a href="#" class="pull-left"><img height="75" width="75" src="'+entry.image+'"'+
	    		'class="thumb-pic" alt="Sample Image"></a><a href="#" class="pull-left"></a><div class="media-body"><h4>'+entry.problemName+'<small>'+entry.addressLine+"  "+entry.city+'</small></h4><div class="post-date">'+entry.date+'</div><p class="short-desc">'+entry.description+
		            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id="">more</a></p></div> <hr/>';
		      
	    	}); 
		}
		else if(data.length==0)
		{	
			response+='<div class="media-body"><h4>No Content for the searched Zipcode!</h4></div>';	
		}
	        
	        $(".media").html(response);
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {	
	    	console.log(data);
	        $("#errorMsg").html("No data fetched!");
	   
	    }
	});	
}