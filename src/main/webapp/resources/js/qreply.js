console.log('qReply Module......');

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

	var QboardReplyService = (function(){

		function add(reply, callback, error){
			console.log('add qReply...');
			
			$.ajax({
				type : 'post',
				url : '/qreplies/qreplyregister',
				data : JSON.stringify(reply),
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
		
		function getQlist(param, callback, error){
			console.log('getList qReply...');
			var qno = param.qno;
			
			$.ajax({
				type : 'get',
				url : '/qreplies/' + qno + '.json',
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
		
		function remove(param, callback, error){
			console.log('remove qReply...');
			
			var qrno = param.qrno;
			var qno = param.qno;
			
			$.ajax({
				type : 'delete',
				url : '/qreplies/' + qrno + '/' + qno,
				success : function(result, status, xhr){
					if(callback){
						callback(result);
					}
				},
				error : function(xhr, status, er){
					if(error){
						error(er);
					}
				}	
			});
		}
		
		return {
			add : add,
			getQlist : getQlist,
			remove : remove
		};
		
	})();