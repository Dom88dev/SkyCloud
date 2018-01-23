/**
 * ajax.js
 */
var httpRequest = null;

function getXMLHttpRequest() {
	return new XMLHttpRequest();
}

function sendRequest(method, action, param, callback) {
	httpRequest = getXMLHttpRequest();
	
	var httpMethod = method?(method=="GET"||method=="POST"?method:"GET"):"GET";
	
	var httpParam = (!param||param=="")?null:param;
	
	var httpUrl = (httpMethod=="GET"&&httpParam)?(action+"?"+httpParam):action;
	
	httpRequest.open(httpMethod, httpUrl, true);
	httpRequest.onreadystatechange = callback;
	httpRequest.send(httpMethod=="POST"?httpParam:null);
}