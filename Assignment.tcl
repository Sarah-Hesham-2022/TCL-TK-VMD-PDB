#Task One
#1. Load File ( Task Load 10% )
#1.1. Implement a function that asks the user for the file name/path to load the file.
#1.2. If user entered a directory print a list with all pdb files in this directory.
#1.3. If user entered a file name, make sure it exists and accessible (print proper error message if not)

proc first {myfile} {

#The supposed return of loading a molecule on vmd
set id -1

#remove quotes as incase user enters in quotes it would cause error as double double quotes will be added 
set myfile [string map {\" {}} $myfile]

#Check if file exists
if {![catch {{open $myfile r}}]} {
    puts "Could not open $myfile for reading\n"

} else {

set test1 [file isfile $myfile]
set test2 [file isdirectory $myfile]
set test3 [file exist $myfile]

if {$test3 && $test2} { 

#We have to change directory to be able to list the name of files in it
cd $myfile

#list pdb files in current directory 
if { ![catch {glob *.pdb }]} {

set files [glob *.pdb]
puts "\nFiles pdb in directory are:\n"
foreach x $files { puts $x}
puts "\nPlease enter the file name to load the file\n"
gets stdin myfile2
first $myfile2

} else {

puts "No PDB Files  found in this directory.\n"
return $id

}

} elseif {$test3 && $test1} {

#Check if it is a normal pbd or one was saved by TK colsole 
if { [catch { set id [mol new $myfile]} ] } {

#Incase the file was saved by TK console before ,as it won't be read by VMD except using "play" command not anything else
  play $myfile
}

 #I return the id because I need it in task 6
 return $id

} else {

puts "\nError Incorrect file/directory name, doesn't exist/inaccessible\n"

return -1

}
}

}

#Task two
#2. Select a residue ( Task Load 20% )
#2.1. Implement a function which asks the user for the residue name/range.
#2.2. Draw a box surrounding the selected atoms.
#2.3. Make sure that user has already loaded a file

proc second {id1 id2} {

set crystal {}

#Is id1 integer or string check
set isInteger [ string is integer $id1]

if { $id1 == "all" } { 

set crystal [atomselect top "all"]

} elseif { $isInteger } {

#get dimensions of reidues from id1 to id2
set crystal [atomselect top "resid $id1 to $id2"]

} else {
set crystal [atomselect top "resname $id1"]
}

set mylist [$crystal get {x y z}]

#I didn't find a ready made function to make a box ,so I will get minx,miny,minz,maxz,maxy,maxz and get the other 6 points and draw 12 lines connecting them together

#get min x
set minx 10000
foreach i $mylist {
set j [lindex $i 0]
if {$j < $minx} {set minx $j}
}

#get min y
set miny 10000
foreach i $mylist {
set j [lindex $i 1]
if {$j < $miny} {set miny $j}
}

#get min z
set minz 10000
foreach i $mylist {
set j [lindex $i 2]
if {$j < $minz} {set minz $j}
}

#get max x
set maxx -10000
foreach i $mylist {
set j [lindex $i 0]
if {$j > $maxx} {set maxx $j}
}

#get max y
set maxy -10000
foreach i $mylist {
set j [lindex $i 1]
if {$j > $maxy} {set maxy $j}
}

#get max z
set maxz -10000
foreach i $mylist {
set j [lindex $i 2]
if {$j > $maxz} {set maxz $j}
}

set p1 {}
append p1 " " $minx
append p1 " " $miny
append p1 " " $minz

set p2 {}
append p2 " " $maxx
append p2 " " $maxy
append p2 " " $maxz

set newy3  $maxy
set p3 {}
append p3 " " $minx 
append p3 " " $newy3
append p3 " " $minz 

set newy4 $miny
append p4 " " $maxx 
append p4 " " $newy4 
append p4 " " $maxz 

set newz5 $maxz
append p5 " " $minx
append p5 " " $miny
append p5 " " $newz5

set newz6 $minz
append p6 " " $maxx
append p6 " " $maxy
append p6 " " $newz6

set newz7 $maxz
set newy7 $maxy
append p7 " " $minx
append p7 " " $newy7
append p7 " " $newz7

set newz8 $minz
set newy8 $miny
append p8 " " $maxx
append p8 " " $newy8
append p8 " " $newz8

#orange
graphics top color 3 

graphics top line $p1 $p8 width 5 style solid
graphics top line $p1 $p5 width 5 style solid
graphics top line $p1 $p3 width 5 style solid
graphics top line $p2 $p7 width 5 style solid

graphics top line $p2 $p6 width 5 style solid
graphics top line $p2 $p4 width 5 style solid
graphics top line $p3 $p7 width 5 style solid
graphics top line $p3 $p6 width 5 style solid

graphics top line $p4 $p8 width 5 style solid
graphics top line $p4 $p5 width 5 style solid
graphics top line $p5 $p7 width 5 style solid
graphics top line $p6 $p8 width 5 style solid

}

#Task three
#3. Save Selection ( Task Load 20% )
#3.1. Implement a function that saves a selection
#3.2. Make sure that user has already selected atoms before
#3.3. Ask the user for a folder/path to save data in 
#3.4. Make sure that the path exist (print proper error message if not)
#3.5. Make sure user have access to save in the path (print proper error message if not)
#3.6. Ask user for file name
#3.7. Save the file as pdb
 
proc third {} {

puts "\nPlease enter the folder/path to save data in\n"
gets stdin myfile

#remove quotes as incase user enters in quotes
set myfile [string map {\" {}} $myfile]

#Check if file exists
if {![catch {set x{open $myfile r}}]} {
    puts "Could not open $myfile for saving\n"

} else {

set test1 [file isdirectory $myfile]
set test2 [file exist $myfile]

if {!$test1 || !$test2} {

puts "\nError no such directory\n"

} else {

#writable ............ Returns 1 if file is writeable by user 
set testaccess [file writable [file nativename [file join "test1" $myfile]]]

if {!$testaccess} {

puts "\nError, file is not authorized to be accessed\n"

} else {

puts "\nPlease enter the desired file name\n"
gets stdin filename

append myfile "/"
append myfile $filename
append myfile ".pdb"

set fp [open $myfile w]

#Becareful when you want to load this previously saved file you use "play filename/path" not mol new
#To save current data in vmd loaded
save_state $myfile

close $fp
}
}
}
}

#Task four
#Analyze ( Task Load 10% )
#4.1. Implement a function which prints all information for a selection
#• Number of atoms
#• Number of bonds
#• Number of residues
#4.2. Make sure that output is formatted well (Hint: Use string format)
#Number of atoms: 660
#Number of bonds: 608
#Number of residues: 134

proc fourth {id1 id2} {

set noAtoms 0
set noBonds 0 


#Is id1 integer or string check
set isInteger [ string is integer $id1]

set crystal {}

if { $id1 == "all" } { 

set crystal [atomselect top "all"]

} elseif { $isInteger } {

#get dimensions of reidues from id1 to id2
set crystal [atomselect top "resid $id1 to $id2"]

} else {
set crystal [atomselect top "resname $id1"]
}

set noAtoms [expr $noAtoms + [$crystal num]]

set noResidues [lsort -unique [$crystal get residue]]
set noResidues [llength $noResidues]

#This part ,how to get the number of bonds: first you need to know that function getbonds returns a list of the number of bonds where each element is itself another list
#carrying the indices of the attached indices of other atoms of the current index
#so to do it ,we will have to count the indices greater than or equal to current index to avoid repaetition as there is in getbonds

set index [ $crystal list]
set bonds [ $crystal getbonds]

foreach a $index b $bonds { foreach c $b { if { $c >= $a} { set noBonds [expr $noBonds + 1]} } }

#Formatting my string output

puts [format "%-10s %10s" "Number of atoms: " "$noAtoms"]
puts [format "%-10s %10s" "Number of bonds: " "$noBonds"]
puts [format "%-8s %8s"   "Number of residues: " "$noResidues\n"]


}

#Task five
#5. Process Residues ( Task Load 20% )
#5.1. Implement a function that gets all residues
#5.2. Print number of atoms in each residue
#5.3. Draw each residue with different color 
#(e.g. first residue with beta 0 second with beta 10 etc.)
#5.4. Output formatted as in table (Hint: use format string function)

proc fifth {} {

set crystal [atomselect top "all"]
set Residues [lsort -unique [$crystal get resname]]

set betaincr 0

foreach i $Residues {

 set crystal [atomselect top "resname $i"]
 $crystal set beta $betaincr
 set betaincr [expr $betaincr + 10]
 set no [$crystal num]

 #Formatting my string output
 puts [format "%-6s %6s" "$i " "$no"]

}
}

#Task six
#6. Align molecules ( Bonus Task with Load 20% )
#Implement a function that do the following functions
#6.1. Make sure that the openGL menu have no drawing (clear window)
#6.2. Ask user to enter 2 file names
#6.3. Load files
#6.4. Move the molecules to be aligned on top of each other

proc sixth {id1 id2} {

set molID1 [atomselect $id2 "all"]
set molID2 [atomselect $id1 "all"]
set num1 [$molID1 num]
set num2 [$molID2 num]

if {$num2 != $num1} {

puts "Error, can't align two molecules of unequal atoms numbers, they must be equal."

} else {

#calculates the best fit matrix
set M [measure fit $molID1 $molID2]

#Move by best fit matrix to align
$molID1 move $M
}
}

#End

#Main Program

#I will make default coloring method Beta and default style VDW for better graphics visualization
mol default color Beta
mol default style VDW

puts "Hello User, Choose your action with number from 1 to 6
1. Load File
2. Select a residue
3. Save Selection
4. Analyze
5. Process Residues
6. Align Molecules\n
"
gets stdin choice

switch $choice {
1 {
   puts "\nPlease enter the file name/path to load the file\n"
   gets stdin myfile
   global id
   first $myfile
}

2 {
  #This is how to check if a molecule is loaded already
  if {![catch {set x [atomselect top "all"]}]} {

 puts "\nPlease enter the id of the first residue and the last one ORR enter the word \"all\" ORR enter a residue name\n"
 gets stdin id1
 set isInteger [ string is integer $id1]
 if { $id1 == "all" } {set id2 -1} elseif { $isInteger } {gets stdin id2} else { set id2 -1}
 second $id1 $id2

} else {

puts "\nCan't do this as no file is loaded\n"

}

}

3 {


#This is how to check if a selection is made already
if { ![catch {set x [atomselect top "all"]}] } {

third 

} else {

puts "\nCan't save selection as no selection is made\n"
}

}

4 {

#This is how to check if a selection is made already
if { ![catch {set x [atomselect top "all"]}] } {

puts "\nPlease enter the id of the first residue and the last one ORR enter the word \"all\"  ORR Residue name \n"
gets stdin id1

set isInteger [ string is integer $id1]

if { $id1 == "all" } {set id2 -1} elseif { $isInteger } {gets stdin id2} else { set id2 -1}

fourth $id1 $id2

} else {

puts "\nCan't anlayze as no selection is made\n"
}
}

5 {
#This is how to check if a molecule is loaded already
if { ![catch {set x [atomselect top "all"]}] } {

fifth

} else {

puts "\nCan't do this as no file is loaded\n"
}
}

6 {
#This is how to check if a molecule isnot loaded already and make sure openGL is clear as required for aligning
if { [catch {set x [atomselect top "all"]}] } {

puts "\nPlease enter the file name/path to load the file\n"
gets stdin myfile
set id1 [first $myfile]

#Incase user enters wrong data
while { $id1 == -1 } {
puts "\nPlease enter the file name/path to load the file as the last one was wrong\n"
gets stdin myfile
set id1 [first $myfile]
}

puts "\nPlease enter the file name/path to load the file\n"
gets stdin myfile2
set id2 [first $myfile2]

#Incase user enters wrong data
while { $id2 == -1 } {
puts "\nPlease enter the file name/path to load the file as the last one was wrong\n"
gets stdin myfile2
set id2 [first $myfile2]
}

sixth $id1 $id2

} else {
puts "\nError, you have to clean your OpenGL\n"
}
}

default {
puts "Incorrect choice only enter form 1-6 "
}
}

#End













