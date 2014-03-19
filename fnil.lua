
local existy = function( x) return x ~= nil end

local map = function( list, func)
	local new_list = {}

	local idx = 1
	while idx <= #list do
		table.insert( new_list, func( idx, list[ idx]))
		idx = idx + 1
	end

	return new_list
end

local fnil = function( func, ...)
	local defaults = { ... }

	return function( ...)
		local arguments = map( { ... }, function( key, argument)
				if existy( argument) then
					return argument
				else
					return defaults[ key]
				end
				end)

		return func( unpack( arguments))
	end
end

--[[ usage

local numprint = function( o1, o2, o3, o4, o5)
	print( "numprint-------------------------")
	print( o1.num)
	print( o2.num)
	print( o3.num)
	print( o4.num)
	print( o5.num)
	print( "----------------------------------")
end

-- will be error at o4.
numprint( {num="1"}, {num="2"}, {num="3"}, nil, {num="5"}


-- will be ok even parameter o4 is nil.
local safe_numprint = fnil( numprint, {num="91"}, {num="92"}, {num="93"}, {num="94"}, {num="95"}

-- safe_numprint() will print "1", "2", "3", "94", "5".
safe_numprint( {num="1"}, {num="2"}, {num="3"}, nil, {num="5"})
]]

return fnil
