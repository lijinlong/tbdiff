--[[
 The MIT License (MIT)

 Copyright (c) 2015 lijinlong

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
]]

local diff = {
	prefix = "",
	-- prefixs = {},
}

local function wrap(key)
	if type(key)~="string" then
		return "["..key.."]"
	else
		return key
	end
end

function diff.pushPrefix(name)
	-- diff.prefixs[#diff.prefixs+1] = name
	diff.prefix = diff.prefix .. ".".. wrap(name)
end
function diff.popPrefix()
	-- table.remove(diff.prefixs)
	diff.prefix = string.gsub(diff.prefix, "%.([^.]*)$", "")
end
function diff.showDiff(key, val1, val2)
	local prefix = diff.prefix --table.concat(diff.prefixs, ".")
	print("KEY " .. prefix .. "." .. wrap(key) .. " DIFF")
	print("---a", type(val1), val1)
	print("+++b", type(val2), val2)
end
function diff.showOneSide(key, val1, val2)
	local prefix = diff.prefix --table.concat(diff.prefixs, ".")
	print("KEY " .. prefix .. "." .. wrap(key) .. " PEERLESS")
	if val1 then
		print("---a", type(val1), val1)
	end
	if val2 then
		print("+++b", type(val2), val2)
	end
end

function table_diff(tb1, tb2)
	local keys = {}

	for k, v in pairs(tb1) do
		keys[k] = true
	end
	for k, v in pairs(tb2) do
		keys[k] = true
	end
	
	for k, _ in pairs(keys) do
		local val1 = tb1[k]
		local val2 = tb2[k]
		if val1~=nil and val2~=nil then
			-- both have key k
			if val1~=val2 then
				diff.showDiff(k, val1, val2)
				if type(val1)=="table" and type(val2)=="table" then
					diff.pushPrefix(k)
					table_diff(val1, val2)
					diff.popPrefix()
				end
			end
		else
			-- only one side has key k
			diff.showOneSide(k, val1, val2)
		end
	end
end

return table_diff

