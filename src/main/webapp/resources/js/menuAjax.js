
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
        var str = "<li>";
        str += result.mname;
        str +=  '<input type="button" value="-">';
        str += "</li>";
        
        $("#menuContainer ul").append(str);
        
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


