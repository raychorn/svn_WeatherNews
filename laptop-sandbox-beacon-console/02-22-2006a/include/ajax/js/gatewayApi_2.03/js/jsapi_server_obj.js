// jsapi_server_obj.js -- JsAPIserverObj

JsAPIserverObj = function(){
	this.keys = [];
	this.cache = [];
};

JsAPIserverObj.position = 0;
JsAPIserverObj.instances = [];

JsAPIserverObj.getInstance = function() {
	var instance = JsAPIserverObj.instances[JsAPIserverObj.instances.length];
	if(instance == null) {
		instance = JsAPIserverObj.instances[JsAPIserverObj.instances.length] = new JsAPIserverObj();
	}
	return instance;
};

JsAPIserverObj.prototype = {
	keys : [],
	cache : [],
	toString : function() {
		var aKey = -1;
		var s = '(';
		s += '\n';
		for (var i = 0; i < this.keys.length; i++) {
			aKey = this.keys[i];
			s += aKey + ' = [' + this.getValueFor(aKey) + ']' + '\n';
		}
		s += ')';
		return s;
	},
	push : function(key, value) {
		var _f = -1;
		var _key = key.trim().toUpperCase();
		for (var i = 0; i < this.keys.length; i++) {
			if (this.keys[i].trim().toUpperCase() == _key) {
				_f = i;
				break;
			}
		}
		if (_f == -1) {
			this.keys.push(key);
			this.cache[key] = value;
			return true;
		}
		return false;
	},
	getValueFor : function(key) {
		return (this.cache[key]);
	},
	getKeys : function() {
		return (this.keys);
	},
	length : function() {
		return (this.keys.length);
	},
	clearOut : function() {
		this.keys = [];
		this.cache = [];
	},
	dummy : function() {
		return false;
	}
};
