console.log('rpReply Module......');

	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			return [(hh>9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			return [yy, '/', (mm > 9 ? '' : '0')+mm, '/', (dd > 9 ? '' : '0') + dd].join('');
		}
	}

	var ReportService = (function(){

		function add(rpprocess, callback, error){
			console.log('addRpReply...');
			
			$.ajax({
				type : 'post',
				url : '/admin/rpReplyRegister',
				data : JSON.stringify(rpprocess),
				contentType : 'application/json; charset=utf-8',
				success : function(result, status, xhr){
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er){
					if (error) {
						error(er);
					}
				}
			});
		}
		
		function getRpReplyList(param, callback, error){
			console.log('getRpReplyList...');
			var rpno = param.rpno;
			
			$.ajax({
				type : 'get',
				url : '/admin/' + rpno + '.json',
				success : function(result, status, xhr){
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er){
					if (error) {
						error(er);
					}
				}
			});
		}
		
		return {
			add : add,
			getList : getRpReplyList,
		};
		
	})();