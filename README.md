*ascend*
======

Better-than-nothing ASP Classic framework & boilerplate in Javascript

Getting Started
==============
1. Use something besides Classic ASP instead. If this fails, continue to step 2.
2. Copy everything to wherever you want on your web server.
3. Go through `/config/config.asp` and make it your own.
4. That's about it.


Included Technologies
==================
Client side
-----------
- Bootstrap
- jQuery
- jQuery datatable
- JSON2

Server side
-------------
- JSON2
- underscore


Utilities
==============
pad(number, length)
--------------------
- Pads with zeroes to the desired length

sqldate( [date object] )
---------------------
- Returns a string with a formatted datetime formatted to play nice with SQL server. 
- With no argument, returns current datetime.
- Values are padded with zeroes.
- 24 hour format

`YYYY-MM-DD hh:mm:ss`

JSON
-----------------
- See http://json.org for details.

