puts "Welcome to TKcon!"
expr -3*10
set x [expr -3*10]
puts $x
set x 10
puts "the value of x is: $x"
set text "some text"
puts "the value of text is: $text."
expr 3-8
set x 10
expr -3*$x
set result [expr -3 * $x]
puts $result
set file [open "myoutput.dat" w]
for {set x 0} {$x <=10} {incr x} {
	puts $file [ expr -3 * $x ]
}
close $file
less myoutput.dat
#Analysis of Atom and bonds
mol new 1UBQ.pdb
set crystal [atomselect top "all"]
$crystal num
#move 4x4 matrix: Applies the given transformation matrix to the coordinates of each atom in the selection.
#moveby offset: move all the atoms by a given offset.
$crystal moveby {10 0 0}
$crystal move [transaxis x deg] // take matrix
# protein , color bet method VDW
$crystal set beta 0
set sel [atomselect top "hydrophobic"]
$sel set beta 1 #press update
$crystal set radius 1.0
$sel set radius 1.5
#why hydrophobic residues => when hydrophobic residues are almost exclusively contained in the inner core of the protein, small soluble protein ,plays a structure role, means that the hydrophilic residues will have a tendency to stay at the water interface 
$sel get resname
#to show the unique 
puts [lsort -unique [$sel get resname]]
$sel get resid
$sel get {resname resid}
$sel get {x y z}
measure center $sel
measure minmax $sel
$sel delete
source beta.tcl #load script

graphics top point {0 0 10}
graphics top line {-10 0 0} {0 0 0} width 5 style solid
graphics top line {10 0 0} {0 0 0} width 5 style dashed

#change color 
graphics top color 3 #orange

graphics top cylinder {15 0 0} {15 0 10} radius 10 resolution 60 filled no
graphics top cylinder {0 0 0} {-15 0 10} radius 5 resolution 60 filled yes
graphics top cone {40 0 0} {40 0 10} radius 10 resolution 60
graphics top sphere {65 0 5} radius 10 resolution 80
graphics top triangle {80 0 0} {85 0 10} {90 0 0}
graphics top text {40 0 20} "my drawing objects"
graphics top list
graphics top info 6
graphics top delete $ID
