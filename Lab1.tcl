set crystal [atomselect top all]
$crystal set beta 0
set sel [atomselect top "resname LYS GLY"]
$sel set beta 1
$sel set radius 0.5
$crystal delete
$sel delete