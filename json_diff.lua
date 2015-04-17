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

local json = require("dkjson")
local table_diff = require("table_diff")

local function usage()
	print("lua ".. arg[0] .." <file1> <file2>")
	print("  YOU MUST make sure dkjson has installed.")
end

-- test
-- local t1 = {1,2,3, ff="kk", gg=9, kk= 10, 8, 12, 14, ll = {1,2,4,7, ["3"]=34, {d=7, k = 0} }}
-- local t2 = {1,4,3, gg=9, kk="10", 8, ff="kk", 12, mm="87", ll = {1,3,5,7, ["3"]= 35, {d=7, k = 10} }}
-- local s = {
-- 	json.encode(t1),
-- 	json.encode(t2)
-- }
-- for i = 1, 2 do
-- 	local f = io.open(arg[i], "w")
-- 	if f then
-- 		f:write(s[i])
-- 		f:close()
-- 	end
-- end

local files = { arg[1], arg[2] }
local t = {}
for i = 1, 2 do
	local file = arg[i]
	if file then
		local f = io.open(file)
		if f then
			local content = f:read("*a")
			f:close()
			t[i] = json.decode(content)
			if not t[i] then
				print("Parse json file Error.", file)
				os.exit(1)
			end
		else
			print("Cann't read file " .. file)
			os.exit(1)
		end
	else
		print("bad argument " .. i)
		usage()
		os.exit(1)
	end
end

table_diff(t[1], t[2])
