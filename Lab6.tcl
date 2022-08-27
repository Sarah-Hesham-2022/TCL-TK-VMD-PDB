################################################################################################################################################################################
# Associative Arrays (https://www.tcl.tk/man/tcl8.5/tutorial/Tcl22.html) (https://www.tcl.tk/man/tcl8.5/tutorial/Tcl23.html) 
################################################################################################################################################################################
set name(first) "Mary"
set name(last) "Poppins"

puts "Full name: $name(first) $name(last)"

array exists name
array names name
array names fi*

array size name

array get name

array set array1 [list {123} {Hello World}\
{124} {Hello Everyone}\
{125} {Hello Lab 3}\
{234} {Hello Lab 2}\
{343} {Hello Lab 1}
]

array unset name first

parray name

foreach name [array names mydata] {
	puts "Data on \"$name\":$mydata($name) "
}

foreach {name value} [array get mydata] {
	puts "Data on \"$name\": $mydata($name)"
	
}
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#

# not compile
proc print12 {a} {
   puts "$a(1), $a(2)"
}

set array(1) "A"
set array(2) "B"

print12 array

# to compile it
proc print12 {array} {
   upvar $array a
   puts "$a(1), $a(2)"
}

set array(1) "A"
set array(2) "B"

print12 array

# or compile
proc print12 {} {
   global array
   puts "$array(1), $array(2)"
   set array(3) "C"
}


set array(1) "A"
set array(2) "B"

print12

parray array


#######################################################################################################################################################################################
# Dictionaries as alternative to arrays (https://www.tcl.tk/man/tcl8.5/tutorial/Tcl23a.html)
#######################################################################################################################################################################################
# This provides efficient access to key-value pairs, just like arrays, but dictionaries are pure values

dict set clients 1 forename Joe
dict set clients 1 surname Schmoe
dict set clients 2 forename Anne
dict set clients 2 surname Other


puts "Number of clients: [dict size $clients]"
dict for {id info} $clients {
	puts "client $id:"
	dict with info {
		puts "Name : $forename $surname"
	}
}

#######################################################################################################################################################################################
# File Access 101 (https://www.tcl.tk/man/tcl8.5/tutorial/Tcl24.html) (https://www.tcl.tk/man/tcl8.5/tutorial/Tcl25.html)
#######################################################################################################################################################################################

#gets, puts, read

# open fileName? access? permission?
# close fileID? #close make flush already
# gets fileID? varName?
# puts ?-nonewline? ?fileID? string
# read fileID numBytes
# seek fileID offset ?origin?
# tell fileID
# flush fileID
# eof fileID
set fp [open "input.txt" w+]
puts $fp "test\ntest"
close $fp
set fp [open "input.txt" r]

while { [gets $fp data] >=0 } {
	puts $data
}
close $fp

#nativename ....... Returns the native name of the file/directory
file nativename [file join ".." "myfile.out"]; 

#list directory in current directory 
glob -nocomplain -type d *

#list files in current directory
glob -nocomplain -type f *

#error -------------------------------------------------------#
file makedir test1

#bad option "makedir": must be atime, attributes, channels, copy, delete, dirname, executable, exists, extension, isdirectory, isfile, join, link, lstat, mtime, mkdir, nativename, normalize, owned, pathtype, readable, readlink, rename, rootname, separator, size, split, stat, system, tail, type, volumes, or writable
#

#mkdir ................ Create a new directory
file mkdir test1

#rename ................ Rename or move a file or directory 
file rename input.txt test1/
file rename input.txt input2.txt
set fp [open "test1/helloWorld.cpp" w+]
puts $fp "#include<iostream>\nusing namespace std;\nint main(){ cout<<\"Hello World\"; return 0; }"
close $fp

#isdirectory ...... Returns 1 if entry is a directory
file isdirectory test1

#isfile .................. Returns 1 if entry is a regular file
file isfile test1
file isfile input2.txt ; # 0
file isfile tes1/input.txt; #1

#exists ................ Returns 1 if file exists
file exists test1/input.txt

#extension ........ Returns file name extension
file extension test1/input.txt

#dirname ........ Returns directory portion of path
 file dirname [pwd]; 

 #rootname ....... Returns file name without extension
 file rootname [pwd];

#join ........ Join directories and the file name to one string
file executable [file nativename [file join "test1" "helloWorld.cpp"]]

#executable ..... Returns 1 if file is executable by user
file executable test1/helloWorld.cpp

#type .................... Returns type of file
file type test1

#split ........ Split the string into directory and file names
file split [file rootname [pwd]]

#size ..................... Returns file size in bytes
file size [file nativename [file join "test1" "helloWorld.cpp"]]

#tail .................... Returns filename without directory 
file tail [file nativename [file join "test1" "helloWorld.cpp"]];

#atime ................ Returns time of last access
puts "test1/helloWprld.cpp - [clock format [file atime test1/helloWprld.cpp] -format %x]"

#mtime ............... Returns time of last data modification
puts "test1/helloWprld.cpp - [clock format [file mtime test1/helloWprld.cpp] -format %x]"
#owned ................ Returns 1 if file is owned by user
file owned test1/helloWprld.cpp
#readable ............ Returns 1 if file is readable by user
file readable test1/helloWprld.cpp

#writable ............ Returns 1 if file is writeable by user 
file writable [file nativename [file join "test1" "helloWprld.cpp"]]

#copy ................ Copy a file or a directory
file copy test1/helloWprld.cpp .

#delete ................ Delete a file or a directory
file delete -force test1

#######################################################################################################################################################################################
# Running other programs from Tcl - exec, open (https://www.tcl.tk/man/tcl8.5/tutorial/Tcl26.html)
#######################################################################################################################################################################################

set tempFileName "helloWorld.tcl"
set outfl [open $tempFileName w]

puts $outfl {
    gets stdin line
    puts "Hello World $line"
    exit 0
}

# Flush and close the file
flush $outfl
close $outfl

#
# Run the new Tcl script:
#
# Open a pipe to the program (for both reading and writing: r+)
#
set io [open "|[info nameofexecutable] $tempFileName" r+]

#
# send a string to the new program
#     *MUST FLUSH*
puts $io "fromOpen."
flush $io

# Get the reply, and display it.
gets $io line

puts "output: $line"
# Run the program with input defined in an exec call

set fromExec [exec [info nameofexecutable] $tempFileName << \
       "from exec"]

# display the results
puts "$fromExec"

# Clean up
file delete $tempFileName
