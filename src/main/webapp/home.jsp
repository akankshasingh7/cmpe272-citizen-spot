<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico">
<title>CitizenSpot</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-tour.min.css">
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
	      <input type="text" class="form-control" placeholder= "search by address or ZIP">
	      <span class="input-group-addon search-icon glyphicon glyphicon-search"></span>
	    </div>
	  </div>
	  <div class="navbar-collapse collapse">
	    <ul class="nav navbar-nav navbar-left">
	    </ul>
	    <ul class="nav navbar-nav navbar-right">
	      <li class="user-thumb">
	        <span id="activity" class="activity-dropdown">
	          <i class="fa fa-user"></i>
	          <b class="badge bg-color-red bounceIn animated"> 21 </b>
	        </span>
	      </li>
	      <li><a data-toggle="modal" href="#chartModal" id="chart-menu" data-event-id=""><i class="glyphicon glyphicon-cloud-upload"></i> Chart</a></li>
	      <li><a data-toggle="modal" href="#uploadModal" id="upload-menu" data-event-id=""><i class="glyphicon glyphicon-cloud-upload"></i> Upload</a></li>
	      <!-- <li class="custom-dpd"><a href="#about"><i class="fa fa-gear"></i> Settings</a></li> -->
	
	      <li class="logout"><a href="#contact" id="logout-menu"><i class="fa fa-power-off"></i> Logout</a></li>
	      <li>
	        <div class="demo"><span id="demo-setting"><i class="fa fa-cog txt-color-blueDark"></i></span></div>
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
				      <a href="#" class="pull-left">
				          <img src="<%=request.getContextPath()%>/images/problems/pothole1.jpg" class="thumb-pic" alt="Sample Image">
				      </a>
				      <div class="media-body">
				          <h4>Pothole <small>i280 & Central Exp.</small></h4>
				          <div class="post-date">Posted on: January 10, 2014</div>
				          <p class="short-desc">A big pothole and water logging near San J.....
				            <a data-toggle="modal" href="#bigViewModal" data-event-id="">more</a></p>
				      </div>
				  </div>
				  <hr/>
				
				</div>
			</div>
		</div>
	</div>
	<div class="row" id="thumbs">
		<%
			for(int i=0; i<20; i++) {
		%>
		<div class="item">
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
		<%
			}
		%>
	</div>
</div>
<footer></footer>

<!-- Modal -->
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
        <h4 class="modal-title">Upload a problem</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal" role="form" id="upload-form" action="<%=request.getContextPath()%>/rest/Incident/upload" enctype="multipart/form-data"  method="post">
		  <div class="form-group">
		    <label for="problemType" class="col-sm-3 control-label">Type of problem</label>
		    <div class="col-sm-9">
		      <select class="form-control" id="problemType" name="problemType">
		      	<option value="2">Pot Hole</option>
		      	<option value="3">Broken Pipe</option>
		      	<option value="4">Fallen tree</option>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="problemName" class="col-sm-3 control-label">Problem Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="problemName" name="problemName" placeholder="Problem Name.">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="problemSeverity" class="col-sm-3 control-label">Severity</label>
		    <div class="col-sm-9">
		      <select class="form-control" id="problemSeverity" name="problemSeverity">
		      	<option value="0">Select severity where 1 being lowest and 5 being highest</option>
		      	<option value="1">1</option>
		      	<option value="2">2</option>
		      	<option value="3">3</option>
		      	<option value="4">4</option>
		      	<option value="5">5</option>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="problem-date" class="col-sm-3 control-label">Date</label>
		    <div class="col-sm-9">
		      <div class='input-group date' id='problem-date' data-date-format="YYYY-MM-DD hh:mm:ss">
				<input type='text' name="problem-date" class="form-control" />
                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
              </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="street" class="col-sm-3 control-label">Street</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="street" name="street" placeholder="Street Address.">
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
		    <label for="country" class="col-sm-3 control-label">Country</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="country" name="country" placeholder="Country">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="zip" class="col-sm-3 control-label">ZIP</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="zip" name="zip" placeholder="ZIP">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="side-of-road" class="col-sm-3 control-label">Side of the Road</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" id="side-of-road" name="side-of-road" placeholder="Side of the Road">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="picture" class="col-sm-3 control-label">Picture</label>
		    <div class="col-sm-9">
		      <input type="file" class="form-control" id="picture" name="picture" placeholder="Upload a picture.">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="description" class="col-sm-3 control-label">Description</label>
		    <div class="col-sm-9">
		      <textarea class="form-control" id="description" name="description" placeholder="Please describe the issue"></textarea>
		    </div>
		  </div>
		  <input type="hidden" name="latitude" id="latitude">
		  <input type="hidden" name="longitude" id="longitude">
      
      <div class="modal-footer">
		<div class="progress pull-left">
			<img src="<%=request.getContextPath()%>/images/busy_small.gif">
		</div>
      	<button type="submit" id="save" class="btn btn-default pull-right">Save</button></div>
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
        <h4 class="modal-title">Title</h4>
      </div>
      <div class="modal-body">
				<div class="row">
					<div class="col-md-6"><img src="<%=request.getContextPath()%>/images/problems/pothole1_bg.jpg"></div>
					<div class="col-md-6">
						<div><span class="col-label">Location: </span><span class="col-value">asds</span></div>
						<div><span class="col-label">Uploaded on: </span><span class="col-value">asds</span></div>
						<div><span class="col-label">Uploaded by: </span><span class="col-value">asds</span></div>
						<div><span class="col-label">Comment: </span><span class="col-value">asds</span></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<p> Description , big description big description big description big description big description
							big description big description big description
							big description big description big description big description big description big description
							big description big description
							big description big description big description big description big description big description big description big description
							big description big description big description big description big description big description
							big description big description big description big description big description big description
							big description big description big description big description big description big description</p>
					</div>
				</div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="chartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
        <h4 class="modal-title">Problem Charts</h4>
      </div>
      <div class="modal-body">
			
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-tour.min.js"></script>
<script src="<%=request.getContextPath()%>/js/moment.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="<%=request.getContextPath()%>/js/citizenspot.js"></script>
<%-- <script src="<%=request.getContextPath()%>/js/apptour.js"></script> --%>
<script>
$(function(){
	function getMarkersforZip(zip) {
		var problemsArray = [];
		console.log("zip- ",zip);
		$.ajax({
		    url : "<%=request.getContextPath()%>/rest/Problems/SearchByZipcode/94041",//+zip,
		    type: "GET",
		    dataType: 'json',
		    success: function(data, textStatus, jqXHR)
		    {	
		    	var response = "";
		    	console.log("problem resp 	data- ",data);
		    	var i = 1;
		    	data.forEach(function(entry) {
		    		response += '<a href="#" class="pull-left"><img height="75" width="75" src="'+entry.image+'"'+
		    		'class="thumb-pic" alt="Sample Image"></a><a href="#" class="pull-left"></a><div class="media-body"><h4>'+entry.problemName+'<small>'+entry.street+"  "+entry.city+'</small></h4><div class="post-date">'+new Date(entry.date)+'</div><p class="short-desc">'+entry.description+
			            '<a data-toggle="modal" href="#bigViewModal" onclick="fun('+entry.id+')" data-event-id="">more</a></p></div> <hr/>';
			      var problemArr = [];
			      problemArr.push(entry.problemName);
			      problemArr.push(entry.latitude);
			      problemArr.push(entry.longitude);
			      problemArr.push(i++);
			      problemsArray.push(problemArr);
		    	}); 
		        console.log("problemsArray- ",problemsArray);
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
	getMarkersforZip("95051");
});
</script>

</body>
</html>