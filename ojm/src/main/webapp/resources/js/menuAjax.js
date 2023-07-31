
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
      	console.log(result);
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
	
	
	
	
	
  return { add : add
  			};

})();


