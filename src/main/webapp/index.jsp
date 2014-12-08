<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico">
<title>CitizenSpot</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/citizenspot.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/menu.css">
<body>

<header>
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	  <div class="navbar-header">
	    <a class="navbar-brand" id="brand-name" href="#">Citizen Spot</a>
	  </div>
	  <div class="search">
	    <div class="input-group">
	      <span class="input-group-addon">Search</span>
	      <input type="text" class="form-control" id="searchValue" placeholder= "search by address or ZIP"> <!--manami-->
	      <span id="submitSearchValue" class="input-group-addon search-icon glyphicon glyphicon-search"></span>
	    </div>
	  </div>
	  <div class="navbar-collapse collapse">
	    <ul class="nav navbar-nav navbar-left">
	    </ul>
	    <ul class="nav navbar-nav navbar-right">
	      <li><a data-toggle="modal" href="#loginModal" data-event-id=""><i class="glyphicon glyphicon-log-in"></i> Login to upload a problem</a></li>
	      <li><a data-toggle="modal" href="#registerModal" data-event-id=""><i class="glyphicon glyphicon-cloud-upload"></i>Register</a></li>
	      <li>
	      <!--  <div class="demo"><span id="demo-setting"><i class="fa fa-cog txt-color-blueDark"></i></span></div> -->
	      </li>
	    </ul>
	  </div>
	</nav>
	<hr/>
</header>

<div id="main" class="container-fluid">
	<div class="row fixed-row">
		<div class="col-md-8 map" id="mapPlaceholder"><img src="<%=request.getContextPath()%>/images/busy.gif"></div>
		<div class="col-md-4">
			<div id="local-spot-list">
				<div class="section-heading">Recent incidents near your current location</div>
				<div class="incident-list">
				
				  <div class="media">
				      				     
				  </div>
				  <hr/>
				
				</div>
			</div>
		</div>
	</div>
	<div class="row" id="thumbs">
		
		<div class="item" id="listOfProblems">
		  <div class="thumb">
		    <div class="row rating-share">
		      <span class="severity pull-left">
		        <i class="glyphicon glyphicon-star"></i><i class="glyphicon glyphicon-star"></i>
		        <i class="glyphicon glyphicon-star"></i><i class="glyphicon glyphicon-star-empty"></i>
		        <i class="glyphicon glyphicon-star-empty"></i>
		      </span>
		      <span class="actions pull-right"><i class="fa fa-share-alt"></i></span>
		    </div>
		    <div class="row">
		      <img src="<%=request.getContextPath()%>/images/problems/pothole1_bg.jpg">
		    </div>
		    <div class="row">
		      <p>blah blah blah blah blah blah blah blah blah blah blah blahblah b.....
		        <a data-toggle="modal" href="#myModal1" data-event-id="">more</a>
		      </p>
		    </div>
		  </div>
		</div>
		
	</div>
</div>
<footer></footer>

<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
        <h4 class="modal-title">Please Log In</h4>
      </div>
   <div class="modal-body">
		<form class="form-horizontal" role="form" action="rest/User/login" method="post">
		  <div class="form-group">
		    <label for="username" class="col-sm-3 control-label">Username</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="Enter your Username">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="password" class="col-sm-3 control-label">Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password" placeholder="Password">
		    </div>
		  </div>
		  
      
      <div class="modal-footer">
      	<button type="submit" id="login" class="btn btn-default pull-right">Log In</button></div>
      	</form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
        <h4 class="modal-title">Please Register</h4>
      </div>
      
		    <div class="modal-body">
		<form class="form-horizontal" role="form" action="rest/User/register" method="post">
		  
		  <div class="form-group">
		    <label for="firstname" class="col-sm-3 control-label">First Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="lastname" class="col-sm-3 control-label">Last Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="lastname" name="lastName" placeholder="Last Name">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="email" class="col-sm-3 control-label">Email</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="email" name="email" placeholder="Enter your Email Id">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="username" class="col-sm-3 control-label">Username</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="Choose a Username">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class="col-sm-3 control-label">Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password" placeholder="Password">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="password" class="col-sm-3 control-label">Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="Re enter Password">
		    </div>
		  </div>
		    
      <div class="modal-footer">
      	<button type="submit" id="register" class="btn btn-default pull-right">Register</button></div>
      	</form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="bigViewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
        <h4 class="modal-title" id="displayProblemName">Title</h4>
      </div>
      <div class="modal-body">
				<div class="row">
					<div class="col-md-6"><img src="<%=request.getContextPath()%>/images/problems/pothole1_bg.jpg"></div>
					<div class="col-md-6">
						<div><span class="col-label">Location: </span><span id="problemLocationValue" class="col-value">asds</span></div>
						<div><span class="col-label">Uploaded on: </span><span id="problemDateValue" class="col-value">asds</span></div>
						<div><span class="col-label">Severity: </span><span id="problemSeverityValue" class="col-value">asds</span></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<p id="problemDescriptionValue"> This is an uploaded problem </p>
					</div>
				</div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/js/citizenspot.js"></script>
<script type="text/javascript">
    $(function () {
    	listProblems();
    	$('#problem-date').datetimepicker({
    		format:	'yyyy-mm-dd hh:mm:ss'
    	});
        
        
    });
</script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script>
			var geocoder;
			var context = '<%=request.getContextPath()%>';


		if (navigator.geolocation)
		{
				navigator.geolocation.getCurrentPosition(showCurrentLocation);
		}
		else
		{
			alert("Geolocation API not supported.");
		}

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
			        	var currentZipcode = results[0].address_components[6].long_name;
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
			var context = '<%=request.getContextPath()%>';
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
				    	response += '<div class="thumb">'+
			    					'<div class="row rating-share">'+
			    					'<span class="severity pull-left">';
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
			    					 response+=	'</span>'+
				       				'<span class="actions pull-right"><i class="fa fa-share-alt"></i></span>'+
				       				'</div>'+
				       				'<div class="row"><img height="200" width="200" src="'+context+entry.image+'" ></div>'+
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
			    	data.forEach(function(entry) {
			    		response += '<a href="#" class="pull-left"><img height="75" width="75" src="'+context+entry.image+'"'+
			    		'class="thumb-pic" alt="Sample Image"></a><a href="#" class="pull-left"></a><div class="media-body"><h4>'+entry.problemName+'<small>'+entry.addressLine+'</small></h4><div class="post-date">'+entry.city+'</div><p class="short-desc">'+entry.description+
				            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id="">more</a></p></div> <hr/>';
				      
			    	}); 
			        
			        $(".media").html(response);
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {	
			    	console.log(data);
			        $("#errorMsg").html("No data fetched!");
			   
			    }
			});
		});

		function fun(value)
		{
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
			    {	
			    	var response = "";
			    	data.forEach(function(entry) {
			    		response += '<a href="#" class="pull-left"><img height="75" width="75" src="'+context+entry.image+'"'+
			    		'class="thumb-pic" alt="Sample Image"></a><a href="#" class="pull-left"></a><div class="media-body"><h4>'+entry.problemName+'<small>'+entry.addressLine+"  "+entry.city+'</small></h4><div class="post-date">'+entry.date+'</div><p class="short-desc">'+entry.description+
				            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id="">more</a></p></div> <hr/>';
				      
			    	}); 
			        
			        $(".media").html(response);
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {	
			    	console.log(data);
			        $("#errorMsg").html("No data fetched!");
			   
			    }
			});	
		}
</script>
</body>
</html>