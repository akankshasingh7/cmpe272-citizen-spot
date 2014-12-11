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
	      <input type="text" class="form-control" id="searchValue" placeholder= "search by ZIP or problem">
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
	      	&nbsp;
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
				</div>
			</div>
		</div>
	</div>
	<div class="row" id="thumbs"></div>
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
		<form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/rest/User/login" method="post">
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
		<form class="form-horizontal" id="register-form" role="form" action="<%=request.getContextPath()%>/rest/User/register" method="post">
		  
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
		  
		  <div class="form-group">
		    <label for="address1" class="col-sm-3 control-label">Street Address</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="address1" name="address1" placeholder="Street Address">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="street" class="col-sm-3 control-label">Street Address 2</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="street" name="street" placeholder="Street Address 2">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="city" class="col-sm-3 control-label">City</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="city" name="city" placeholder="City">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="state" class="col-sm-3 control-label">State</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="state" name="state" placeholder="State">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="zip" class="col-sm-3 control-label">Zip</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="zip" name="zip" placeholder="Zip">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="country" class="col-sm-3 control-label">Country</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="country" name="country" placeholder="Country">
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
					<div class="col-md-6"><img height="150" width="150" id="problemImage" ></div>
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
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/moment.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="<%=request.getContextPath()%>/js/citizenspot.js"></script>
<script>
$(function(){
	function getMarkersforZip(zip) {
		var problemsArray = [];
		console.log("zip- ",zip);
		$.ajax({
		    url : "<%=request.getContextPath()%>/rest/Problems/SearchByZipcode/"+zip,
		    type: "GET",
		    dataType: 'json',
		    success: function(data, textStatus, jqXHR)
		    {	
		    	var response = "";
		    	var bigList = "";
		    	console.log("problem resp 	data- ",data);
		    	var i = 1;
		    	data.forEach(function(entry) {
		    		response += '<a href="#" class="pull-left"><img height="75" width="75" src="'+entry.image+'"'+
		    		'class="thumb-pic" alt="Sample Image"></a><a href="#" class="pull-left"></a><div class="media-body"><h4>'+entry.problemName+'<small>'+entry.street+"  "+entry.city+'</small></h4><div class="post-date">'+new Date(entry.date)+'</div><p class="short-desc">'+entry.description+
			            '<a data-toggle="modal" href="#bigViewModal" onclick="fetchProblemDetails('+entry.id+')" data-event-id=""> ...more</a></p></div> <hr/>';
			        bigList += '<div class="item"><div class="thumb"><div class="row rating-share"><span class="severity pull-left">'+
			        '</span><span class="actions pull-right"><i class="fa fa-share-alt"></i></span></div><div class="row"><img src="'+entry.image+'"></div><div class="row"><p>'+
			        entry.description+'<a data-toggle="modal" href="#bigViewModal" onclick="fetchProblemDetails('+entry.id+')" data-event-id=""> ...more</a></p></div></div></div>';
				    	
			      var problemArr = [];
			      problemArr.push(entry.problemName);
			      problemArr.push(entry.latitude);
			      problemArr.push(entry.longitude);
			      problemArr.push(i++);
			      problemsArray.push(problemArr);
		    	});
		    	
		        //console.log("problemsArray- ",problemsArray);
		        $("#thumbs").html(bigList);
		        $(".media").html(response);
		     	var map = new google.maps.Map(document.getElementById('mapPlaceholder'), {
	     	      zoom: 10,
	     	      center: new google.maps.LatLng(37.3571342, -121.96100820000001),
	     	      mapTypeId: google.maps.MapTypeId.ROADMAP
	     	    });
		  	
		  	    var infowindow = new google.maps.InfoWindow();
		  	    var marker, i;
		  	
		  	    for (i = 0; i < problemsArray.length; i++) {  
		  	      marker = new google.maps.Marker({
		  	        position: new google.maps.LatLng(problemsArray[i][1], problemsArray[i][2]),
		  	        map: map
		  	      });
		  	
		  	      google.maps.event.addListener(marker, 'click', (function(marker, i) {
		  	        return function() {
		  	          infowindow.setContent(problemsArray[i][0]);
		  	          infowindow.open(map, marker);
		  	        }
		  	      })(marker, i));
		  	    }
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {	
		    	console.log("jqXHR- ",jqXHR);
		        $("#errorMsg").html("No data fetched!");
		   
		    }
		});
	}
	
 	var map = new google.maps.Map(document.getElementById('mapPlaceholder'), {
      zoom: 10,
      center: new google.maps.LatLng(37.3571342, -121.96100820000001),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
	console.log("here- ");
	getMarkersforZip("00000");
	$( "#submitSearchValue" ).bind( "click", function() {
		var zip = $("#searchValue").val().trim();
		if(zip !== "" ) {
			
			getMarkersforZip(zip);
		}
	});
});

function fetchProblemDetails(value) {
	$("#successSearch").html();
	$.ajax({
	    url : "<%=request.getContextPath()%>/rest/Problems/listById/"+value,
	    type: "GET",
	    dataType: 'json',
	    success: function(data, textStatus, jqXHR)
	    { 	console.log(data);
	    	$("#displayProblemName").html(data.problemName);
	    	$("#problemLocationValue").html(data.street);
	    	$("#problemDateValue").html(new Date(data.date));
	    	$("#problemSeverityValue").html(data.severity);
	    	$("#problemDescriptionValue").html(data.description);
	    	var str = data.image;
	    	console.log(str);
	    	$("#problemImage").attr('src',str);
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