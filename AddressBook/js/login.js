$(function() {
	$("#sigupForm").validate({
		rules : {
			"username" : {
				"required" : true
			},
			"password" : {
				"required" : true
			}
		},
		messages : {
			"username" : {
				"required" : "用户名不能为空"
			},
			"password" : {
				"required" : "密码不能为空"
			}
		}
	});
});