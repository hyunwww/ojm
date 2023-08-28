
var menuList = [];

//메뉴 모듈
var menuService = (function() {

  
  console.log("menu Module...");
  
  
  
  function add(info, callback, error) {
    console.log("add menu...");

    $.ajax({
      type: "post",
      url: "/menu/add",
      data: JSON.stringify(info),
      contentType: "application/json; charset=utf-8",
      success: function (result, status, xhr) {
      	menuList.push(result);
      	
        var str = '<div class="row mb-3">';
        str += '<div class="col-2">'+result.mname+'</div>';
        str += '<div class="col-auto">';
        str += '<button type="button" class="btn btn-secondary btn-sm">-</button>';
        str += '</div>';
        str += '</div>';
        
        $("#menuContainer").append(str);
        
        console.log(menuList);
      },
      error: function (xhr, status, er) {
        if (error) {
          error(er);
        }
      }
    });
  }
	
	function getMenuList() {
			
        	$.ajax({
			      type: "get",
			      url: "/menu/"+sno,
			      dataType: 'json',
			      success: function (result, status, xhr) {
			    	  for (var menu of result) {
			    		  menuService.add(menu);
			    		  // 큰 문제는 아니지만 수정페이지에서 새로고침 시 일정 확률로 순서가 뒤바뀜
					}
			    	  
			      }
			});
        	
        	
		}
	
	
	
  return { add : add,
  			getMenuList : getMenuList
  			};

})();


