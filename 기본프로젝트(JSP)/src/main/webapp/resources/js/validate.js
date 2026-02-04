var validate = (function() {
  "use strict"; // Start of use strict
	var regType = {
		change : {
			EMAIL		:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
			ID			:/^[0-9a-zA-Z]{1,10}$/,
			PASSWORD	:/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()])[a-zA-Z\d!@#$%^&*()]{8,15}$/,
			PHONE		:/^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/,
			N			:/^[0-9]*$/
		},
		input : {
			EMAIL		:/[^a-zA-Z0-9._%+-@]$/g,
			ID			:/[^a-zA-Z0-9]/g,
			PASSWORD	:/[^a-zA-Z0-9!@#$%^&*()]$/g,
			PHONE		:/[^0-9]$/g,
			N			:/[^0-9]$/g
		}
		
	}
  	var validateData = {
		type : "",
		regType : "",
		required : "N",
		title : "",
		msgType : "TEXT",
		maxLength : 9999,
		minLength : 0,
		availability : false
	}
	var validateObj = {};
	
	validateObj.validateList = [];
	
	validateObj.addValidate = function (target,data){
		if(typeof target === "string"){
		  target = target.indexOf("#") < 0?$("#"+target)[0]:$(target)[0]
		}
		var validateDataClone = Object.assign({}, validateData);
		for(var i in data){
			validateDataClone[i] = data[i];
		}
		
		target.validateData = validateDataClone;
		
		target.title = target.title == "" ?target.validateData.title : target.title;
		
		target.onkeydown = function(event){
			if(!(event.keyCode == 46 || event.keyCode == 8
				||(event.keyCode >= 37 && event.keyCode <= 40))){
				if(this.value.length >= this.validateData.maxLength){
					event.preventDefault();			
				}
				
			}
		}
		target.oninput = function(event){
			if(this.validateData.regType != ""){
				valueChange(this,replaceValidate(this,event));					
				return false
			}
		}
		target.onchange = function(event){
			if(this.validateData.regType != "" && !checkValidate(this,event)){
				showMsg(this," 형식에 맞지 않습니다.");
				this.validateData.availability = false;
				event.stopImmediatePropagation();
				return false;
			}
			if(target.nextElementSibling != null && target.nextElementSibling.nodeName == "P"){
				target.nextElementSibling.remove();
			}
			this.validateData.availability = true;
		}
		this.validateList.push(target);
	}
	validateObj.checkValidate = function (event){
		var list = this.validateList;
		for(var i in list){
			var param = list[i];
			if(param.validateData.required == "Y" && param.value == ""){
				showAlert(param.title + "는 필수 입력사항입니다.");
				return false;
			}
			if(param.validateData.regType != "" && !checkValidate(param,"change")){
				showAlert(param.title + " 형식에 맞지 않습니다.");
				return false;
			}
		}
		return true;
		
	}
	
	return validateObj;
	
	function showMsg(target,msg){
		var textNode = document.createElement('p');
		if(target.validateData.msgType == "TEXT"){
			if(target.nextElementSibling != null && target.nextElementSibling.nodeName == "P"){
				target.nextElementSibling.remove();
			}
			textNode.innerText = target.validateData.title+msg;
			target.insertAdjacentElement('afterend',textNode);
		}else if(target.validateData.msgType == "ALERT"){
			showAlert(target.validateData.title+msg);
		}
	}
	
	function checkValidate(target,event){
		var type = typeof event == "string" ? event:event.type;
		var reg = regType[type][target.validateData.regType]		
		var value =  target.value
		return reg.test(value);
	}
	function replaceValidate(target,event){
		var type = typeof event == "string" ? event:event.type;
		var reg = regType[type][target.validateData.regType];		
		var value =  target.value;
		var returnValue = target.validateData.regType == "PHONE"?changePhone(value.replace(reg,"")):value.replace(reg,"");
		return returnValue;
	}
	function valueChange(target,changeVal){
		var point= target.selectionStart
		var defNum = target.value.length - changeVal.length;
		target.value = changeVal;
		target.setSelectionRange(point - defNum,point - defNum)
	}
	function changePhone(str){
	    var tmp = '';
	    str = str.replaceAll("-","");
	    if( str.length < 4){
	        return str;
	    }else if(str.length < 7){
	        tmp += str.substr(0, 3);
	        tmp += '-';
	        tmp += str.substr(3);
	        return tmp;
	    }else if(str.length < 11){
	        tmp += str.substr(0, 3);
	        tmp += '-';
	        tmp += str.substr(3, 3);
	        tmp += '-';
	        tmp += str.substr(6);
	        return tmp;
	    }else{              
	        tmp += str.substr(0, 3);
	        tmp += '-';
	        tmp += str.substr(3, 4);
	        tmp += '-';
	        tmp += str.substr(7);
	        return tmp;
	    }
	
	    return str;
	}
})(); // End of use strict
