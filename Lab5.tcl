#*########################################################################################################################################################*########################################################################################################################################################*
#########################################################################################################################################			https://www.tcl.tk [14 to 24]		###########################################################################################################################													
#*########################################################################################################################################################*########################################################################################################################################################*

#Brief Content:
# String
# List 
# Command

# Adding new commands to Tcl - proc [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl11.html ]
#*___________________________________________*___________________________________________*

# format: proc name args body
# The value that the body of a proc returns can be defined with the return command. 
# The return command will return its argument to the calling program. 
# If there is no return, then body will return to the caller when the last of its commands has been executed. 
# The return value of the last command becomes the return value of the procedure


# override sum ... with return statement
proc sumWithReturn {arg0 arg1} {
	set arg2 [expr {arg0+arg1}]
}

# override sum ... without return statement
# The return value of the last command becomes the return value of the procedure
proc sum {arg0 arg1} {
	set arg2 [expr {arg0+arg1}]
}


sumWithReturn 1 2; 			 # expected output 3
sum 1 2;		   			 # expected output 3 			
sum {1} {2};	   			 # expected output 3
puts [sum [expr {1+2}] 3];   # expected output 6


#you can also overwrite the already found command 
proc for {arg0 arg1 arg2} {
	puts "arg0\narg1\narg2"
}

for {set i 0} {i <= 10} {8}; # set i 0 #i <= 10 #8

#*_________________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________________*
# Variations in proc arguments and return values [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl12.html ]
#*___________________________________________________*___________________________________________________*

# default value 
proc defaultValueForArgs {arg0 {arg1 1}} {
	puts "defaultValueForArgs command was called by arg { $arg0,$arg1 } "
}

defaultValueForArgs 6;		# defaultValueForArgs command was called by arg { 6,1 } 
defaultValueForArgs 2 5;	# defaultValueForArgs command was called by arg { 2,5 } 

# Number of args
proc variableNumberArgs {args} {
	puts "$args"
}

variableNumberArgs 1 2 3; # 1 2 3 


proc notCompile {{arg0 1} arg1} {
	puts "notCompile command was called by arg { $arg0,$arg1 } "
}

# this will lead to error
# you can't set default value to intermidate variable

notCompile 2; # ERROR!!!! wrong # args: should be "notCompile ?arg0? arg1" while executing "notCompile 2"

notCompile 1 2; # notCompile command was called by arg { 1,2 } 

# but, you can define args variable in example command after default variable  
proc example { first {second 1} args } {
	puts "example command was $first $second $args"
}

example 1 2 3 ; 	# example command was 1 2 3
example 6 ;			# example command was 6 1 
example 2 3 ;		# example command was 2 3 
example 2 3 4 5 ; 	# example command was 2 3 4 5

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# Variable scope - global and upvar [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl13.html ]
#*___________________________________________*___________________________________________*

# Tcl evaluates variables within a scope delineated by procs, namespaces, and at the topmost level, the global scope. 

# The scope in which a variable will be evaluated can be changed with the global and upvar commands.
# The global command will cause a variable in a local scope (inside a procedure) to refer to the global variable of that name. 

set arg1 {Hello World};
set arg0 "Everyone";

proc example {arg0} {
    global arg1;		
    puts "$arg1 $arg0"; # "Hello World Everyone"
}


example $arg0

# upvar ?level? otherVar1 myVar1 ?
# The upvar command causes myVar1 to become a reference to otherVar1, and myVar2 to become a reference to otherVar2, etc. 
# The otherVar variable is declared to be at level relative to the current procedure. By default level is 1, the next level up.

proc example {arg0} {
    upvar arg1 myvar;		
    puts "$myvar $arg0"; # "Hello World Everyone"
}


example $arg0

# same as:
proc example {arg0} {
    upvar 1 arg1 myvar;		
    puts "$myvar $arg0"; # "Hello World Everyone"
}


example $arg0

# same as:
proc example {arg0} {
    upvar #0 arg1 myvar;		
    puts "$myvar $arg0"; # "Hello World Everyone"
}


example $arg0

# But Take Care ... 
# This will get an error because the level of the variable so take care ... 
proc example {arg0} {
    upvar 1 arg1 myvar;		
    puts "$myvar $arg0"; # "Hello World Everyone"
}

proc example2 {arg0} {
	example $arg0
}

example2 $arg0

# note it is a good practice to define your variable in scope to avoid conflict when you import another student code
# Real example why would I need The upvar 
proc existence {variable} {
    upvar $variable testVar
    if { [info exists testVar] } {
        puts "$variable Exists"
    } else {
        puts "$variable Does Not Exist"
    }
}

set x 1
set y 2
for {set i 0} {$i < 5} {incr i} {
    set a($i) $i;
}

puts "\ntesting unsetting a simple variable"
# Confirm that x exists.
existence x
# Unset x
unset x
puts "x has been unset"
# Confirm that x no longer exists.
existence x

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# Tcl Data Structures 101 - The list [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl14.html ]
#*___________________________________________*___________________________________________*

# ways to define variable 

#by setting a variable to be a list of values
#    set lst {{item 1} {item 2} {item 3}}
#with the split command
#    set lst [split "item 1.item 2.item 3" "."]
#with the list command.
#    set lst [list "item 1" "item 2" "item 3"] 
 
#list ?arg1? ?arg2? ... ?argN?
#    makes a list of the arguments

#split string ?splitChars?
#    Splits the string into a list of items wherever the splitChars occur in the code. 
#    SplitChars defaults to being whitespace. 
#    Note that if there are two or more splitChars then each one will be used individually to split the string. 
#	 In other words: split  "1234567" "36" would return the following list: {12 45 7}. 
#lindex list index
#    Returns the index'th item from the list. 
#llength list
#    Returns the number of elements in a list.

#foreach varname list body
#    The foreach command will execute the body code one time for each list item in list. 

set y [split 7/4/1776 "/"]

set z {1 2 3 4 5 }

puts $y

puts [lindex $y 1]

set i 0

foreach j $y {
    puts "$j is item number $i in list x"
    incr i
}

foreach {j k} $y {
    puts "$j , $k is item number $i, [expr {$i+1}] in list x"
    incr i 2
}

foreach j $y l $z {
    puts "$j , $l is item number $i in list x"
    incr i
}

puts [llength $y]

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# Adding & Deleting members of a list [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl15.html ]
#*___________________________________________*___________________________________________*

# concat ? arg1 arg2 ... argn?
# Concates the args into single list.

# lappend listName ?arg1 arg2 ... argn?
# Appends the args to the list listName treating each arg as a list element. 

set list1 {a b d e f g}
set list2 {m n o p q r}

set list4 [concat $list1 $list2]
lappend list1  $list2
puts $list1; # a b d e f g {m n o p q r}

puts $list4; # a b d e f g m n o p q r

#linsert listName index arg1 ?arg2 ... argn?
#Returns a new list with the new list elements inserted just before the index th element of listName. 
puts [linsert $list1 2 c]; #a b c d e f 

# lreplace listName first last ?arg1 ... argn?
# Returns a new list with N elements of listName replaced by the args. 
# If there are fewer args than the number of positions between first and last, then the positions for which there are no args are deleted. 

puts [lreplace $list4 3 6 a b] ; # a b c a b n o p q r

# lset varname index newValue
# The lset command can be used to set elements of a list directly, instead of using lreplace. 

puts [lset list4 3 k]; # a b c k e f m n o p q r

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# Simple pattern matching - "globbing" [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl16a.html ]
#*________________________________________________*________________________________________________*

#  By default, lsearch uses the "globbing" method of finding a match. Globbing is the wildcarding technique that most Unix shells use. 

# globbing wildcards are:

#*
#    Matches any quantity of any character 
#?
#    Matches one occurrence of any character 
#\X
#    The backslash escapes a special character in globbing just the way it does in Tcl substitutions. Using the backslash lets you use glob to match a * or ?. 
#[...]
#    Matches one occurrence of any character within the brackets. A range of characters can be matched by using a range between the brackets. For example, [a-z] will match any lower case letter. 

#  string match pattern string
#  Returns 1 if the pattern matches string. The pattern is a glob style pattern. 

# Matches
string match f* foo

# Matches
string match f?? foo

# Doesn't match
string match f foo

# Returns a big list of files on my Debian system.
set bins [glob /usr/bin/*]

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# More list commands - lsearch, lsort, lrange [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl16.html ]
#*________________________________________________*________________________________________________*
set list [list {Washington 1789} {Adams 1797} {Jefferson 1801} \
               {Madison 1809} {Monroe 1817} {Adams 1825} ]

# lsearch list pattern
# Searches list for an entry that matches pattern, and returns the index for the first match, or a -1 if there is no match

set x [lsearch $list Washington*]
set y [lsearch $list Madison*]

# lsort list
# Sorts list and returns a new list in the sorted order. By default, it sorts the list into alphabetic order. Note that this command returns the sorted list as a result, instead of sorting the list in place

set srtlist [lsort $list]

# lrange list first last 
# Returns a list composed of the first through last entries in the list. 

set subsetlist [lrange $list $x $y]

puts "The following presidents served between Washington and Madison"
foreach item $subsetlist {
    puts "Starting in [lindex $item 1]: President [lindex $item 0] "
}

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# String Subcommands - length index range [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl17.html ]
#*________________________________________________*________________________________________________*

# string length string
#    Returns the length of string. 
# string index string index
#    Returns the indexth character from string. 
# string range string first last
#    Returns a string composed of the characters from first to last. 

set string "this is my test string"
set subCn length

puts "There are [string length $string] characters in \"$string\""
puts "There are [string $subCn $string] characters in \"$string\""

puts "[string index $string 1] is the second character in \"$string\""

puts "\"[string range $string 5 10]\" are characters between the 5'th and 10'th"

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# String comparisons - compare match first last wordend [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl18.html ]
#*_________________________________________________________*_________________________________________________________*

# string compare string1 string2
# compares string1 to string2 and returns: 
# *-1 If string1 is less than string2
# *0 If string1 is equal to string2
# *1 If string1 is greater than string2
# done alphabetically

string compare "abc" "cbc"; # -1
string compare "cbc" "abc"; # 0
string compare "abc" "abc"; # 1

# string first string1 string2
# Returns the index of the character in string1 that starts the first match to string2, or -1 if there is no match

set i "Hello World"; 
set j "World";
puts [string first $j $i]; # 6

# string last string1 string2
# Returns the index of the character in string1 that starts the last match to string2, or -1 if there is no match. 

set i "Hello World World";
set j "World";

puts [string last $j $i]; # 12


# string wordend string index
# Returns the index of the character just after the last one in the word which contains the index'th character of string. 
# A word is any contiguous set of letters, numbers or underscore characters, or a single other character.
puts [string wordend $i 6 ]; #11

# string wordstart string index
# Returns the index of the first character in the word that contains the index'th character of string.
puts [string wordstart $st 8 ]; #6

#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
# Modifying Strings - tolower, toupper, trim, format [ https://www.tcl.tk/man/tcl8.5/tutorial/Tcl19.html ]
#*_________________________________________________________________________________________________________________________________________________*_________________________________________________________________________________________________________________________________________________*
set upper "THIS IS A STRING IN UPPER CASE LETTERS"
set lower "this is a string in lower case letters"
set trailer "This string has trailing dots ...."
set leader "....This string has leading dots"
set both  "((this string is nested in parens )))"

puts "tolower converts this: $upper"
puts "              to this: [string tolower $upper]\n"
puts "toupper converts this: $lower"
puts "              to this: [string toupper $lower]\n"
puts "trimright converts this: $trailer"
puts "                to this: [string trimright $trailer .]\n"
puts "trimleft converts this: $leader"
puts "               to this: [string trimleft $leader .]\n"
puts "trim converts this: $both"
puts "           to this: [string trim $both "()"]\n"

set labels [format "%-20s %+10s " "Item" "Cost"]
set price1 [format "|%-20s| |%10d| Cents Each" "Tomatoes" "30"]
set price2 [format "%-20s %10d Cents Each" "Peppers" "200"]
set price3 [format "%-20s %10d Cents Each" "Onions" "10"]
set price4 [format "%-20s %10.2f per Lb." "Steak" "3.59997"]

puts "\n Example of format:\n"
puts "$labels"
puts "$price1"
puts "$price2"
puts "$price3"
puts "$price4"


####################
# Extra Resources: #
####################
# 1. https://wiki.tcl-lang.org/page/Tcl+syntax
