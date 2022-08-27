# Simple Text Output
#___________________#
puts "This is line 1"; puts "this is line 2"
puts $Hello $world; #consider as 2 argument for puts
#______________________________________________________________________________________________________________________________#
#  Assigning values to variables:
#___________________________________#
# Tcl passes data to subroutines either by name or by value. 
# Commands that don't change the contents of a variable usually have their arguments passed by value. [puts]
# Commands that do change the value of the data must have the data passed by name. [set]
set X "This is a string"

puts $X
#______________________________________________________________________________________________________________________________#
# Evaluation & Substitutions 1: Grouping arguments with "":
#_________________________________________________________#

# TCL evaluates in 2 phases:
# single pass substitutions
# Evaluating of the resulting command

# Meaning of single substitution:
set y "Hello World"
set x y
puts $y
puts $x
puts $$x

# Substituation
# [] => result
# "word" / [word] single argument
set varName 1
puts "The current stock value is $varName"
puts "The current stock value is \$varName"

#Except For:
#String 	Output 	Hex Value
#\a 	Audible Bell 	0x07
#\b 	Backspace 	0x08
#\f 	Form Feed (clear screen) 	0x0c
#\n 	New Line 	0x0a
#\r 	Carriage Return 	0x0d
#\t 	Tab 	0x09
#\v 	Vertical Tab 	0x0b
#\0dd 	Octal Value 	d is a digit from 0-7
#\uHHHH 	H is a hex digit 0-9,A-F,a-f. This represents a 16-bit Unicode character.
#\xHH.... 	Hex Value 	H is a hex digit 0-9,A-F,a-f. Note that the \x substitution "keeps going" as long as it has hex digits, and only uses the last two, meaning that \xaa and \xaaaa are equal, and that \xaaAnd anyway will "eat" the A of "And". Using the \u notation is probably a better idea. 

#example
set Z Albany
set Z_LABEL "The Capitol of New York is: "

puts "$Z_LABEL $Z"   ;# Prints the value of Z
puts "$Z_LABEL \$Z"  ;# Prints a literal $Z instead of the value of Z

puts "\nBen Franklin is on the \$100.00 bill"

set a 100.00
puts "Washington is not on the $a bill"    ;# This is not what you want
puts "Lincoln is not on the $$a bill"      ;# This is OK
puts "Hamilton is not on the \$a bill"     ;# This is not what you want
puts "Ben Franklin is on the \$$a bill"    ;# But, this is OK

puts "\n................. examples of escape strings"
puts "Tab\tTab\tTab"
puts "This string prints out \non two lines"
puts "This string comes out\
on a single line"

#______________________________________________________________________________________________________________________________#
#Evaluation & Substitutions 2: Grouping arguments with {}
#_________________________________________________________#
# grouping words within double braces disables substitution within the braces. Characters within braces are passed to a command exactly as written. The only "Backslash Sequence" that is processed within braces is the backslash at the end of a line. This is still a line continuation character. 

#No Substituation 

#example
set Z Albany
set Z_LABEL "The Capitol of New York is: "

puts "\n................. examples of differences between  \" and \{"
puts "$Z_LABEL $Z"
puts {$Z_LABEL $Z}

puts "\n....... examples of differences in nesting \{ and \" "
puts "$Z_LABEL {$Z}"
puts {Who said, "What this country needs is a good $0.05 cigar!"?}

puts "\n................. examples of escape strings"
puts {There are no substitutions done within braces \n \r \x0a \f \v}
puts {But, the escaped newline at the end of a\
string is still evaluated as a space}
#______________________________________________________________________________________________________________________________#
# Evaluation & Substitutions 3: Grouping arguments with []:
#________________________________________________________#
# IMPORTANT: If a portion of the string is grouped with square brackets, then the string within the square brackets is evaluated as a command by the interpreter, and the result of the command replaces the square bracketed string
set a "[set x {This is a string within braces within quotes}]"
puts "See how the set is executed: $a"
puts "\$x is: $x\n"

#Except:
#case1:
set b "\[set y {This is a string within braces within quotes}]"
puts "Note the \\ escapes the bracket:\n \$b is: $b"
puts "\$y is: $y"

#case2:
set z {[set x "This is a string within quotes within braces"]}
puts "Note the curly braces: $z\n"
#_______________________________________________________________________________________________________#
# Results of a command - Math 101:
#__________________________________#

# expr used by if, while and for to evaluate test expression
# expr takes all of its arguments and return expression with vaue
# includes all standard math functions
# logical operators 
# bitwise operator 
# math fn as rand(), sqrt(), cosh() ...
# expression always numeric result [integer or float]

# Performance Tips:  enclosing the arguments to expr in curly braces will result in faster code. So do expr {$i * 10} instead of simply expr $i * 10

# IMPORTANT:  You should always use braces when evaluating expressions (expr, if and while) that may contain user input,
# to avoid possible security breaches. 
# The expr command performs its own round of substitutions on variables and commands, 
# so you should use braces to prevent the Tcl interpreter doing this as well (leading to double substitution)

set userinput {[puts DANGER!]}

expr $userinput == 1; # DANGER! 0
expr {$userinput == 1}; #0 

#  Integer values may be specified in decimal (the normal case), in octal (if the first character of the operand is 0), or in hexadecimal (if the first two characters of the operand are 0x)
expr {"\x32"}; # 2, Octal
expr {"0x32"}; # 50, hexa
expr {"0700"}; # 448, Octal

# All the following is interpreted as decimal 
2.1
3.
6E4
7.91e+16
.000001

#Except:
2,1; # a decimal comma, instead of a decimal point
2,100; # a thousands separator
0900; #invalid Octal Number at most 7

#Explore each operand - + ~ ! ** * / %  + - << >> <> <= >= & ^ | && || x?y:z
#String operand => * / < > <= >= eq ne in ni

# MATH FUNCTION
#abs         acos        asin        atan
#atan2       bool        ceil        cos
#cosh        double      entier      exp
#floor       fmod        hypot       int
#isqrt       log         log10       max
#min         pow         rand        round
#sin         sinh        sqrt        srand
#tan         tanh        wide

# TYPE CONVERSIONS
# double int wide entier
# double() converts a number to a floating-point number
# int() converts a number to an ordinary integer number (by truncating the decimal part). 
# wide() converts a number to a so-called wide integer number (these numbers have a larger range)
# entier() coerces a number to an integer of appropriate size to hold it without truncation. This might return the same as int() or wide() or an integer of arbitrary size.

# MATH FUNCTION and OPERAND Example 
set X 100
set Y 256
set Z [expr {$Y + $X}]
set Z_LABEL "$Y plus $X is "

puts "$Z_LABEL $Z"
puts "The square root of $Y is [expr { sqrt($Y) }]\n"

puts "Because of the precedence rules \"5 + -3 * 4\"   is: [expr {-3 * 4 + 5}]"
puts "Because of the parentheses      \"(5 + -3) * 4\" is: [expr {(5 + -3) * 4}]"

#
# The trigonometric functions work with radians ...
#
set pi6 [expr {3.1415926/6.0}]
puts "The sine and cosine of pi/6: [expr {sin($pi6)}] [expr {cos($pi6)}]"

#
# Working with arrays
#
set a(1) 10
set a(2) 7
set a(3) 17
set b    2
puts "Sum: [expr {$a(1)+$a($b)}]"

#Bit-wise operand Example:
set a 60  ;# 60 = 0011 1100   
set b 13  ;# 13 = 0000 1101 

set c [expr $a & $b] ;# 12 = 0000 1100 
puts "Line 1 - Value of c is $c\n"

set c [expr $a | $b;] ;# 61 = 0011 1101 
puts "Line 2 - Value of c is $c\n"

set c [expr $a ^ $b;] ;# 49 = 0011 0001 
puts "Line 3 - Value of c is $c\n"

set c [expr $a << 2] ;# 240 = 1111 0000 
puts "Line 4 - Value of c is $c\n"

set c [expr $a >> 2] ;# 15 = 0000 1111 
puts "Line 5 - Value of c is $c\n"
#____________________________________________________________________________________________________________________________________________________________________#
# Computers and numbers:
#____________________________#
# two integer numbers pow(-2,31) to pow(2,31)-1
# The typical range for floating-point numbers is roughly:
# -1.0e+300 to -1.0e-300, 0.0 and 1.0e-300 to 1.0e+300.
# Floating-point numbers have a limited precision: 
# usually about 12 decimals. 

puts [expr {1000000*1000000}];  # -727379968
puts [expr {1000000*1000000.}]; # 1e+012


# If you add, subtract, multiply and divide two integer numbers,
# then the result is an integer.
# If the result fits within the range you have the exact answer. 
# If not, you end up with something that appears to be completely wrong. 
# (Note: not too long ago, floating-point computations were much more time-consuming than integer computations. 
# And most computers do not warn about integer results outside the range, because that is too time-consuming too: a computer typically uses lots of such operations, most of which do fit into the designated range.)
# If you add, subtract, multiply and divide an integer number and a floating-point number, 
# then the integer number is first converted to a floating-point number with the same value 
# and then the computation is done, resulting in a floating-point number. 

puts [expr {1.0e300/1.0e-300}]; # inf, floating-point value too large to represent

# Additional warning to take care of

puts "1/2 is [expr {1/2}]"; # 0; try to be evaluated as integer fails and return 0 which wrong behaviour
puts "-1/2 is [expr {-1/2}]"; # 1; try to be evaulated as integer fails and return -1 which wrong behaviour 
#or 
puts "1/3 is [expr {double(1)/3}]"

# To fix it ...
puts "1/2 is [expr {1.0/2.0}]"; #0.5
puts "1/2 is [expr {1.0/2.0}]"; #-0.5

#to set the Percision use magic variable 
set tcl_precision 17
set c [expr {10.0/3.0}]
set d [expr {2.0/3.0}]
puts "(10.0/3.0) / (2.0/3.0) is [expr {$c/$d}]"; #5.0000000000000009, not 5 because computers can only deal with numbers with a limited precision: floating-point numbers are not our mathematical real numbers. 

set number [expr {int(1.2/0.1)}]  ;# Force an integer -
                                  ;# accidentally number = 11

for { set i 0 } { $i <= $number } { incr i } {
   set x [expr {$i*0.1}]
   puts "$x"
}

set x     0.0
set delta 0.1
while { $x < 1.2+0.5*$delta } {
   puts "$x"
   set x [expr {$x + $delta}]
}

# set tcl_precision 12
# Some practical consequences to be read by student
#____________________________________________________________________________________________________________________________________________________________________#
#Numeric Comparisons 101 - if
#____________________________#

# if expr1 ?then? body1 elseif expr2 ?then? body2 elseif ... ?else? ?bodyN?


#True/False Representation 
# 				  False 	True
#a numeric value 	0 	  all others
#yes/no 			no 	     yes
#true/false 	   false 	 true

#IMPORTANT : Avoid using the test in quotes because it will be executed in 2 substitution phase, that the second one can cause unexpected trouble-avoid it.

set x 1

if {$x == 2} {puts "$x is 2"} else {puts "$x is not 2"}

if {$x != 1} {
	puts "$x is != 1"
} else {
	puts "$x is 1"
}

if $x==1 {puts "GOT 1"}

#Avoid it can be dangerous and not clear 
#why it prints "$x is 1" as it make one round only

set y x

if "$$y != 1" {
	puts "$$y is != 1"
}else {
	puts "$$y is 1"
}

#____________________________________________________________________________________________________________________________________________________________________#
#Textual Comparison - switch:
#____________________________#
 
# IMPORTANT : If you use the brace version of this command, there will be no substitutions done on the patterns
set x "ONE"
set y 1
set z ONE

switch $x  {
	"$z" {
		set y1 [expr {$y+1}]
		puts "MATCH \$z. $y + $z is $y1"
	}
	ONE {
		set y1 [expr {$y+1}]
		puts "MATCH ONE. $y + one is $y1"
	}
	TWO {
		set y1 [expr {$y+2}]
		puts "MATCH TWO. $y + two is $y1"
	}
	THREE {
		set y1 [expr {$y+3}]
		puts "MATCH THREE. $y + three is $y1"
	}
	default {
		puts "$x is NOT A MATCH"
	}
}


switch $x "$z" {
	set y1 [expr {$y+1}]
	puts "MATCH \$z. $y + $z is $y1"
} ONE {
	set y1 [expr {$y+1}]
	puts "MATCH ONE. $y + one is $y1"
} TWO {
	set y1 [expr {$y+2}]
	puts "MATCH TWO. $y + two is $y1"
} THREE {
	set y1 [expr {$y+3}]
	puts "MATCH THREE. $y + three is $y1"
} default {
	puts "$x does not match any of these choices"
}

#Non Readable
switch $x "ONE" "puts ONE=1" "TWO" "puts TWO=2" "default" "puts NO_MATCH"

# you can also write multiple command in the body with done cote
switch $x "ONE" "puts ONE=1; puts HELLOWORLD" "TWO" "puts TWO=2" "default" "puts NO_MATCH"

switch $x \
"ONE"     "puts ONE=1"  \
"TWO"     "puts TWO=2" \
"default"     "puts NO_MATCH";
#____________________________________________________________________________________________________________________________________________________________#
#Looping 101 - if, while , continue and break: 
#____________________________________________#
# while test body
# A continue statement within body will stop the execution of the code and the test will be re-evaluated
# A break within body will break out of the while loop, and execution will continue with the next line of code after body

# IMPORTANT: the substituation will take place in double code but while test will still string that evaluate always same value so It ends up to infinite loop

set x 1

# This is a normal way to write a Tcl while loop.

while {$x < 5} {
    puts "x is $x"
    set x [expr {$x + 1}]
}

puts "exited first loop with X equal to $x\n"

# The next example shows the difference between ".." and {...}
# How many times does the following loop run?  Why does it not
# print on each pass?

set x 0
while "$x < 5" {
    set x [expr {$x + 1}]
    if {$x > 7} break
    if "$x > 3" continue
    puts "x is $x"
}

puts "exited second loop with X equal to $x"
#______________________________________________________________________________________________________________________________#
# Looping 102 - For and incr:
#___________________________#
# for start test next body

#IMPORTANT: the body open bracket must be placed into same line of for

for {set i 0} {$i < 10} {incr i} {
    puts "I inside first loop: $i"
}

for {set i 3} {$i < 2} {incr i} {
    puts "I inside second loop: $i"
}

puts "Start"
set i 0
while {$i < 10} {
    puts "I inside third loop: $i"
    incr i
    puts "I after incr: $i"
}

set i 0
incr i
# This is equivalent to:
set i [expr {$i + 1}]
#______________________________________________________________________________________________________________________________#
#Solved Question During Lab:
#_____________________________#
# what if I wanted to get the $$y value ?!
#________________________________________#
#Solution:
#_______#
# you can use expr as expr can do multiple substituation. but "" can not
set y "Hello World"
set x y

puts [expr $$x]

#________________________________________________________________________________________________________#
#Resources:
#__________#
#1. https://www.tutorialspoint.com/tcl-tk/tcl_bitwise_operators.htm
#2. https://www.tcl.tk/man/tcl8.5/tutorial/Tcl6.html [Main, 1-13]
#3. https://rextester.com/l/tcl_online_compiler [online TCL compiler]

