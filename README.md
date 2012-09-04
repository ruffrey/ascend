*ascend*
======

Better-than-nothing ASP Classic framework & boilerplate in Javascript

Getting Started
==============
1. Use something besides Classic ASP instead. If this fails, continue to step 2.
2. Copy everything to wherever you want on your web server.
3. Go through `/config/config.asp` & `/asp/ascend.asp` and make them your own.
4. If things are crashing, make sure all dependencies are included in `/asp/ascend.asp` & `/asp/ascend/main.asp`.
5. You'll need to have a global user object available and map it in `/config/config.asp`.


Included Technologies
==================
Client side
-----------
- Bootstrap
- jQuery
- jQuery datatables plugin
- JSON2

Server side
-------------
- JSON2
- underscore


Utilities
==============
`pad(number, length)`
--------------------
- Pads with zeroes to the desired length

`sqldate( [date object] )`
---------------------
- Returns a string with a formatted datetime formatted to play nice with SQL server. 
- With no argument, returns current datetime.
- Values are padded with zeroes.
- 24 hour format

`timestring.get()`
-----------------
- Takes no arguments.
- Returns a padded 24 hour datetime string of the following format: `2012-05-10[14:17:01]`.

`timestring.getstrict()`
----------------------
- Takes no arguments.
- Returns a padded 24 hour datetime string of the following format: `20120510141701`.
- `YYYY-MM-DD hh:mm:ss`

`JSON`
-----------------
- See http://json.org for details.

`TitleCase(string)`
---------------------
- Returns the string formatted in Title Case.
- Separates works with space and dash.
- Place overrides in `fixedCase[]` in `/config/fixedCase.asp`.

`isNumber(string)`
------------------
- Simple test for if a string is a number.
- Returns true or false.

