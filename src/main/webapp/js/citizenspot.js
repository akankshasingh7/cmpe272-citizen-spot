$(function () {
	//listProblems();
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
		console.log("Geolocation API not supported.");
	}
	
	$( "#street" ).bind( "blur", function() {
		placeMultiMarkers();
	});
	$( "#city" ).bind( "blur", function() {
		placeMultiMarkers();
	});
	$( "#state" ).bind( "blur", function() {
		placeMultiMarkers();
	});
	$( "#country" ).bind( "blur", function() {
		placeMultiMarkers();
	});
	$( "#zip" ).bind( "blur", function() {
		placeMultiMarkers();
	});
//	var bar = $('.bar');
//	var percent = $('.percent');
//	var status = $('#status');

	function placeMultiMarkers() {
		var address = $("#street").val()+", "+$("#city").val()+", "+$("#state").val()+", "+$("#country").val()+", "+$("#zip").val();
		$.ajax({
			url : "http://maps.googleapis.com/maps/api/geocode/json?address="+address+"&sensor=false",
		    method: "POST",
		    success:function(data){
		        var latLong = {};
		        console.log("data- ",data);
		        latLong.latitude = data.results[0].geometry.location.lat;
		        latLong.longitude = data.results[0].geometry.location.lng;
		    	$('#latitude').val(latLong.latitude);
		    	$('#longitude').val(latLong.longitude);
		        return latLong;
			}
        });
	}
	
	$('#upload-form').ajaxForm({
	    beforeSend: function(formData, jqForm, options) {
	    	console.log("formData- ",formData);
	        $(".progress").show();
	    },
	    success: function() {
	        $(".progress").hide();
	        $("#uploadModal").modal("hide");
	        getMarkersforZip("94041");
	    },
		complete: function(xhr) {
			status.html(xhr.responseText);
	        $(".progress").hide();
	        $("#uploadModal").modal("hide");
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
         		console.log('No results found');
      		}
    	} else {
    		console.log('Geocoder failed due to: ' + status);
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
	    {
	    	console.log(data);
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
		            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id=""> ...more</a></p></div> <hr/>';
		      
	    	}); 
			}else
			{	
	            response+='<div class="media-body"><h4>No Content for the searched Zipcode!</h4></div>'; 
			}
		  	$(".media").html(response);
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {	
	    	console.log(jqXHR);
	        $("#errorMsg").html("No data fetched!");
	   
	    }
	});
});

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
		            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id=""> ...more</a></p></div> <hr/>';
		      
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