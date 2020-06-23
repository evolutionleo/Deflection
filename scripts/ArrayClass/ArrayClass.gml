///@function	Array(*item1, *item2, ...)
///@description	Constructor function for Array objects
///@param		{any} *item
function Array() constructor {
	content = [];
	Size = 0;
	
	///@function	Append(value)
	///@description	Adds a value to the end of the array
	///@param		{any} value
	Append = function(value) {
		content[self.Size] = value;
		++Size;
		
		return self;
	}
	
	///@function	Concat(other)
	///@description	Adds every element of the second array to this array
	///@param		{Array} other
	Concat = function(_other) {
		if(!is_Array(_other)) {
			throw "TypeError: trying to concat "+typeof(_other)+" with Array";
		}
		
		for(var i = 0; i < _other.Size; i++) {
			self.Append(_other.Get(i));
		}
		
		return self;
	}
	
	///@function	Copy()
	///@description	Returns a copy of the array object
	Copy = function() {
		ans = new Array();
		
		self.ForEach(function(el) {
			ans.Append(el);
		});
		
		return ans;
	}
	
	///@function	Clear()
	///@description	Clears an array object
	Clear = function() {
		self.content = [];
		self.Size = 0;
	}
	
	///@function	Delete(pos)
	///@description	Deletes the value at given position
	///@param		{real} pos
	Delete = function(pos) {
		if(pos < 0)
			pos += Size;
		
		if(Size == 0) {
			throw "Error: trying to delete value from an empty Array";
		}
		else if(pos < 0 or pos > Size - 1) {
			throw "Error: index "+string(pos)+" is out of range [0, "+string(Size-1)+"]";
		}
		
		var part1 = self.Slice(0, pos);
		var part2 = self.Slice(pos+1);
		
		part1.Concat(part2);
		
		self.content = part1.content;
		self.Size--;
		
		return self;
	}
	
	///@function	Empty()
	///@description	Returns true if the array is empty and false otherwise
	Empty = function() {
		return self.Size == 0;
	}
	
	///@function	Equal(other)
	///@description	Returns true if arrays are equal and false otherwise
	Equal = function(_other) {
		if(!is_Array(_other)) {
			throw "TypeError: trying to compare "+typeof(_other)+" with Array";
		}
		
		if(self.Size != _other.Size)
			return false;
		
		for(var i = 0; i < self.Size; i++) {
			var c1 = self.Get(i);
			var c2 = _other.Get(i);
			
			
			if(typeof(c1) != typeof(c2))
				return false;
			
			
			if(is_array(c1) and is_array(c2)) {
				if(!array_equals(c1, c2))
					return false;
			}
			else if(is_Array(c1) and is_Array(c2)) {
				if(!c1.Equal(c2))
					return false;
			}
			else if c1 != c2
				return false;
		}
		
		return true;
	}
	
	///@function	Exists(value)
	///@description	Returns true if the value exists in the array and false otherwise
	Exists = function(_val) {
		val = _val;
		ans = false;
		
		self.ForEach(function(x, pos) {
			if(x == val) {
				ans = true;
				return 1; //Break out of ForEach()
			}
		});
		
		return ans;
	}
	
	///@function	Filter(func)
	///@description	Loops through the array and passes each value into a function.
	///				Returns a new array with only values, that returned true.
	///				Function func gets (x, *pos) as input
	///				Note: Does not affect the original array!
	///@param		{function} func
	Filter = function(_func) {
		func = _func;
		ans = new Array();
		
		self.ForEach(function(x, pos) {
			if(func(x, pos))
				ans.Append(x);
		});
		
		//self.content = ans.content;
		//return self;
		return ans;
	}
		
	///@function	Find(value)
	///@description	Finds a value and returns its position. -1 if not found
	///@param		{any} value
	Find = function(_val) {
		val = _val;
		ans = -1;
		
		self.ForEach(function(x, pos) {
			if(x == val) {
				ans = pos;
				return 1; //Break out of ForEach()
			}
		});
		
		return ans;
	}
	
	///@function	FindAll(value)
	///@description	Finds all places a value appears and returns an Array with all the positions. Empty set if not found
	///@param		{any} value
	FindAll = function(_val) {
		val = _val;
		ans = new Array();
		
		self.ForEach(function(x, pos) {
			if(x == val)
				ans.Append(pos);
		});
		
		return ans;
	}

	///@function	First()
	///@description	Returns the first value of the array
	First = function() {
		return self.Get(0);
	}
	
	///@function	ForEach(func)
	///@description	Loops through the array and runs the function with each element as an argument
	///				Function func gets (x, *pos) as arguments
	///				Note: Loop will stop immediately if the function returns anything but zero
	///@param		{function} func(x, *pos)
	ForEach = function(func) {
		for(var i = 0; i < self.Size; i++) {
			var res = func(self.Get(i), i)
			if(!is_undefined(res) and res != 0) {
				break;
			}
		}
		
		return self;
	}
	
	///@function	Get(pos)
	///@description	Returns value at given pos
	///@param		{real} pos
	Get = function(pos) {
		if(pos < 0)
			pos += Size; //i.e. Array.Get(-1) = Array.Last()
		
		if(Size == 0) {
			throw "Error: trying to achieve value from empty Array";
		}
		else if(pos < 0 or pos > Size-1) {
			throw "Error: index "+string(pos)+" is out of range [0, "+string(Size-1)+"]";
		}
		
		
		return content[pos];
	}
	
	///@function	Insert(pos, value)
	///@description	Inserts a value into the array at given position
	///@param		{real} pos
	///@param		{any} value
	Insert = function(pos, value) {
		if(pos < 0)
			pos += Size;
		
		if(pos < 0 or (pos > Size-1 and Size != 0)) {
			throw "Error: trying to insert a value outside of the array. Use Array.Set() or Array.Append() instead";
		}
		
		var part1 = self.Slice(0, pos);
		var part2 = self.Slice(pos);
		
		part1.Append(value);
		part1.Concat(part2);
		
		self.content = part1.content;
		self.Size++;
		
		return self;
	}
	
	///@function	Lambda(func)
	///@description	Loops through the array and applies the function to each element
	///@param		{function} func(x, *pos)
	Lambda = function(func) {
		for(var i = 0; i < self.Size; i++) {
			self.Set(i, func(self.Get(i), i) );
		}
		
		return self;
	}
	
	///@function	Last()
	///@description	Returns the last value of the array
	Last = function() {
		return self.Get(-1);
	}
	
	///@function	Max()
	///@description	Returns a maximum of the array. Only works with numbers
	Max = function() {
		ans = self.Get(0);
		
		self.ForEach(function(x) {
			if(!is_numeric(x))
				throw "TypeError: Trying to calculate maximum of "+typeof(x)+"";
			
			if(x > ans)
				ans = x;
		});
		
		return ans;
	}
	
	///@function	Min()
	///@description	Returns a minimum of the array. Only works with numbers
	Min = function() {
		ans = self.content[0];
		
		self.ForEach(function(x) {
			if(!is_numeric(x))
				throw "TypeError: Trying to calculate minimum of "+typeof(x)+"";
			
			if(x < ans)
				ans = x;
		});
		
		return ans;
	}
	
	///@function	Number(value)
	///@description	Returns the amount of elements equal to given value in the array
	///@param		{any} value
	Number = function(_val) {
		val = _val;
		ans = 0;
		
		self.ForEach(function(x, pos) {
			if(x == val)
				ans++;
		});
		
		return ans;
	}
	
	///@function	Pop()
	///@description	Deletes a value from the end of the array and returns it
	Pop = function() {
		ans = self.Last();
		if(self.Empty())
			throw "Error: trying to pop value from empty Array";
		
		self.Delete(-1);
		
		return ans;
	}
	
	///@function	PopBack()
	///@description	Deletes a value from the beginning of the array and returns it
	PopBack = function() {
		ans = self.First();
		self.Delete(0);
		
		return ans;
	}
	
	///@function	PushBack(value)
	///@description	Inserts a value to the beginning of the array
	///@param		{any} value
	PushBack = function(val) {
		self.Insert(0, val);
	}
	
	///@function	Resize(size)
	///@description	Resizes the array. Sizing up leads to filling the empty spots with zeros
	///@param		{real} size
	Resize = function(size) {
		if(size < 0)
			throw "Error: array size cannot be negative";
		
		while(self.Size < size) {
			self.Append(0);
		}
		while(self.Size > size) {
			self.Pop();
		}
		
		return self;
	}
	
	///@function	Reverse()
	///@description	Reverses the array, affecting it
	Reverse = function() {
		ans = new Array();
		self.ForEach(function(element, pos) {
			ans.Set(Size-pos-1, element);
		});
		
		self.content = ans.content;
		return self;
	}
	
	///@function	Reversed()
	///@description	Returns reversed version of the array, without affecting the original
	Reversed = function() {
		ans = new Array();
		self.ForEach(function(element, pos) {
			ans.Set(Size-pos-1, element);
		});
		
		return ans;
	}
	
	///@function	Set(pos, value)
	///@description	Sets value in the array at given index
	///@param		{real} pos
	///@param		{any} item
	Set = function(pos, value) {
		if(pos < 0)
			pos += Size;
		
		if(pos > Size-1)
			Size = pos+1;
		
		
		content[pos] = value;
		
		return self;
	}
	
	///@function	Slice(begin, end)
	///@description	Returns a slice from the array with given boundaries. If begin > end - returns reversed version
	///@param		{real} begin
	///@param		{real} end
	Slice = function(_begin, _end) {
		if(is_undefined(_begin))
			_begin = 0;
		
		if(is_undefined(_end))
			_end = self.Size;
		
		ans = new Array();
		
		
		if(_begin > _end) {
			for(var i = _end; i < _begin; i++) {
				ans.PushBack(content[i]);
			}
		}
		else {
			for(var i = _begin; i < _end; i++) {
				ans.Append(content[i]);
			}
		}
		
		return ans;
	}
	
	///@function	Sort(func, *startpos, *endpos)
	///@description	Bubble sorts through the array in given range, comparing values using provided function. 
	///Function gets (a, b) as input and must return True if A has more priority than B and False otherwise.
	///@example myarray.Sort(function(a, b) { return a > b }) will sort myarray in descending order
	///@param		{function} func(a, b)
	///@param		{real} *startpos	Default - 0
	///@param		{real} *endpos		Default - Size
	Sort = function(compare, _begin, _end) {
		if(is_undefined(_begin))
			_begin = 0;
		
		if(is_undefined(_end))
			_end = self.Size;
		
		
		if(!is_numeric(_begin) or round(_begin) != _begin or !is_numeric(_end) or round(_end) != _end)
			throw "TypeError: sort boundaries must be integers";
		
		for(var i = _begin; i < _end; i++) {	// Bubble sort LUL
			for(var j = i; j > _begin; j--) {
				if(compare(self.Get(j), self.Get(j-1))) {
					self.Swap(j, j-1);
				}
			}
		}
		
		return self;
	}
	
	///@function	Summ()
	///@description	Returns the summ of all the elements of the array. Concats strings.
	///NOTE: Works only with strings or numbars and only if all the elements are the same type.
	Summ = function() {
		if(is_string(self.Get(0)))
			ans = "";
		else if(is_numeric(self.Get(0)))
			ans = 0;
		else
			throw "TypeError: trying to summ up elements, that aren't strings or reals";
		
		self.ForEach(function(el) {
			if(typeof(el) != typeof(ans))
				throw "TypeError: Array elements aren't the same type: got "+typeof(el)+", "+typeof(ans)+" expected.";
			
			ans += el;
		});
		
		return ans;
	}
	
	///@function	Swap(pos1, pos2)
	///@description	Swaps 2 values at given positions
	///@param		{real} pos1
	///@param		{real} pos2
	Swap = function(pos1, pos2) {
		var temp = self.Get(pos1);
		self.Set(pos1, self.Get(pos2));
		self.Set(pos2, temp);
		
		return self;
	}
	
	///@function	Unique()
	///@description	Returns an Array object, containing a copy of this, but without repeats
	Unique = function() {
		ans = new Array();
		
		self.ForEach(function(x) {
			if(!ans.Exists(x))
				ans.Append(x);
		});
		
		return ans;
	}

	
	// Initialization
	for(var i = 0; i < argument_count; i++) {
		self.Append(argument[i]);
	}
	
	
	toString = function() {
		str = "[";
		
		self.ForEach(function(el, i) {
			str += string(el);
			if(i < Size-1)
				str += ", ";
		});
		
		str += "]";
		
		return str;
	}
}

///@function	array_to_Array(array)
///@description	Returns an instance of Array object with all the contents of an array
///@param		{array}	array
function array_to_Array(array) {
	if(!is_array(array))
		throw "TypeError: expected array, got "+typeof(array);
	
	ans = new Array();
	
	for(var i = 0; i < array_length(array); i++) {
		ans.Append(array[i]);
	}
	
	return ans;
}

///@function	ds_list_to_Array(list)
///@description	Returns an instance of Array object with all the contents of an array
///@param		{real} list
function ds_list_to_Array(list) {
	if(!ds_exists(list, ds_type_list))
		throw "Error: ds_list with given index does not exist";
	
	ans = new Array();
	
	for(var i = 0; i < ds_list_size(list); i++) {
		ans.Append(list[| i]);
	}
	
	return ans;
}

///@function	is_Array(Arr)
///@description	Checks if a variable holds reference to an Array object
///@param		{any} arr
function is_Array(Arr) {
	return is_struct(Arr) and instanceof(Arr) == "Array";
}

///@function	Array_to_array(Arr)
///@description	Returns contents of an Array object in format of regular array
///@param		{Array} Arr
function Array_to_array(Arr) {
	if !is_Array(Arr)
		throw "Error in function Array_to_array(): expected Array(), got "+typeof(Arr)
	return Arr.content
}

///@function	ds_list_from_Array(Arr)
///@description	Returns contents of an Array object in format of ds_list
///@param		{Array} Arr
function ds_list_from_Array(Arr) {
	if !is_Array(Arr)
		throw "Error in function ds_list_from_Array(): expected Array(), got "+typeof(Arr)
	
	var list = ds_list_create()
	Arr.ForEach(function(item) {
		ds_list_add(list, item)
	})
	return list
}