# tbdiff

show the difference of two tables

## Usage

### show the difference of 2 json files

	lua json_diff.lua <file1> <file2>

You must have dkjson installed in you lua system.
You can call `luarocks install dkjson` to install it

### show the difference if 2 lua tables

You can use the function table_diff provide in table_diff.lua