///@function	Vector2(x, y)
///@param		{real} x
///@param		{real} y
function Vector2(_x, _y) constructor {
	if(is_undefined(_x) or is_undefined(_y)) {
		self.Zero();
	}
	else {
		x = _x;
		y = _y;
	}
	
	///@function toString()
	function toString() {
		var str = "(x: "+string(self.x)+" y: "+string(self.y)+")";
		return str;
	}
	
	///@function	Zero()
	///@description	Nullifies a vector
	static Zero = function() {
		x = 0;
		y = 0;
		
		return self;
	}
	
	///@function	Add(Vec)
	///@description	Adds one vector to another (affecting the first one)
	///@param		{Vector2} Vec
	static Add = function(_other) {
		x += _other.x;
		y += _other.y;
		
		return self;
	};
	
	///@function	Added(Vec)
	///@description	Adds one vector to another an returns the result
	///@param		{Vector2} Vec
	static Added = function(_other) {
		var temp = new Vector2(x + _other.x, y + _other.y)

		return temp;
	};
	
	///@function	Multiplied(Vec)
	///@description	Multiplies one vector by another an returns the result
	///@param		{Vector2} Vec
	static Multiplied = function(_other) {
		var temp = new Vector2(x * _other.x, y * _other.y)

		return temp;
	};
	
	///@function	Set(Vec)
	///@description	Sets values equal to another vector
	///@param		{Vector2} Vec
	static Set = function(_other) {
		x = _other.x;
		y = _other.y;
		
		return self;
	};
	
	///@function	Multiply(Vec)
	///@description	Multiplies one vector by another
	///@param		{Vector2} Vec
	static Multiply = function(_other) {
		x *= _other.x;
		y *= _other.y;
		
		return self;
	};
	
	///@function	Subtract
	static Subtract = function(_other) {
		x -= _other.x;
		y -= _other.y;
		
		return self;
	}
	
	///@function	Clamp(MinVec, MaxVec)
	///@description Clamps the vector within given range
	///@param		{Vector2} MinVec
	///@param		{Vector2} MaxVec
	static Clamp = function(_min, _max) {
		if(x < _min.x)
			x = _min.x;
		else if(x > _max.x)
			x = _max.x;
		
		if(y < _min.y)
			y = _min.y;
		else if(y > _max.y)
			y = _max.y;
		
		return self;
	};
	
	///@function	Function(func)
	///@param		{function} func
	static Function = function(func) {
		x = func(x);
		y = func(y);
		
		return self;
	}
}


function toVector2(val) {
	return new Vector2(val, val)
}