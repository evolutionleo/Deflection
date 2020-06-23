#macro JSON_START 1
#macro JSON_LIST 2
#macro JSON_MAP 3

#macro JSON_MAP_KEY 10
#macro JSON_MAP_VALUE 11
#macro JSON_LIST_VALUE 12

_dependencies = [
	ArrayClass(),
	MapClass()
]
/// WARNING!!! Cuts all spaces from strings. Use '_' instead
/// Also list of forbidden symbols, that'll break the parser: 
/// ',' '[' ']' '{' '}' ':'
/// Probably I'll fix the issue with escaping strings in next release

Json = new function() constructor
{
	parse = function(str)
	{
		if !is_string(str)
			throw "TypeError: Json.parse() expected string, got "+typeof(str)
		
		str = string_replace_all(str, " ", "")
		
		var ans = undefined
		
		var global_state = JSON_START
		var local_state = JSON_START
		
		var key = ""
		var value = ""
		
		for(var i = 1; i <= string_length(str); i++)
		{
			var symb = string_char_at(str, i)
			switch (symb)
			{
				case "[":
					if global_state == JSON_START {
						global_state = JSON_LIST
						local_state = JSON_LIST_VALUE
						ans = new Array()
					}
					else {
						#region Inseption
						
						var idx1 = i
						var idx2 = string_pos("]", str)+1
						var sub_str = string_copy(str, idx1, idx2-idx1)
						
						//str = string_replace(str, sub_str, "")
						i += idx2-idx1-1
						
						var result = self.parse(sub_str)
						
						switch(local_state) {
							case JSON_MAP_VALUE:
								value = result
								break
							case JSON_LIST_VALUE:
								value = result
								break
							case JSON_MAP_KEY:
								key = result
								break
						}
						#endregion
					}
					break
				case "{":
					if global_state == JSON_START {
						global_state = JSON_MAP
						local_state = JSON_MAP_KEY
						ans = new Map()
					}
					else {
						#region Inseption
						
						var idx1 = i
						var idx2 = string_pos("}", str)+1
						var sub_str = string_copy(str, idx1, idx2-idx1)

						i += idx2-idx1-1
						
						
						var result = self.parse(sub_str)
						
						switch(local_state) {
							case JSON_MAP_VALUE:
								value = result
								break
							case JSON_LIST_VALUE:
								value = result
								break
							case JSON_MAP_KEY:
								key = result
								break
						}
						#endregion
					}
					break
				case ",":
					if is_string(value) {
						if string_pos("\"", value) == 0
							value = real(value)
						else
							value = string_replace_all(value, "\"", "")
					}
					
					if local_state == JSON_MAP_VALUE {
						ans.Set(key, value)
						
						key = ""
						value = ""
						
						local_state = JSON_MAP_KEY
					}
					else if local_state == JSON_LIST_VALUE {
						ans.Append(value)
						
						value = ""
					}
					break
				case ":":
					if local_state == JSON_MAP_KEY {
						local_state = JSON_MAP_VALUE
					}
					break
				case "}":
					if is_string(value) {
						if string_pos("\"", value) == 0
							value = real(value)
						else
							value = string_replace_all(value, "\"", "")
					}
					
					ans.Set(key, value)
						
					key = ""
					value = ""
					
					local_state = JSON_START
					global_state = JSON_START
					break
				case "]":
					if is_string(value) {
						if string_pos("\"", value) == 0 {
							value = real(value)
							
						}
						else {
							value = string_replace_all(value, "\"", "")
							
						}
					}
					
					ans.Append(value)

					value = ""
					
					local_state = JSON_START
					global_state = JSON_START
					break
				//case " ":
				
				//	break
				default:
					if local_state == JSON_LIST_VALUE or local_state == JSON_MAP_VALUE {
						value += symb
					}
					else if local_state == JSON_MAP_KEY {
						key += symb
					}
					break
			}
		}
		
		return ans.content
	}
}()

//Json = new Json_parser()

global.Json = Json

//Tests
//var ans = Json.parse("{b:\"abc\", list:[12, \"monkaS\"]}")
//show_debug_message(ans)
//show_debug_message(ans.list)
//show_debug_message(ans.list[1])