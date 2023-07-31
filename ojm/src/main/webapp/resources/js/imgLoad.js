

function imgLoad(sno) {
		$.ajax({
			      type: "get",
			      url: "/store/showImage",
			      data: {sno : sno},
			      dataType : "json",
			      success: function (result, status, xhr) {
			      		console.log(result);
			    	 	
			      }
			});
	}
