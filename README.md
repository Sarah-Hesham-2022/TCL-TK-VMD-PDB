# TCL-TK
TCL-TK for VMD Processing PDB files.

Introduction
• Write a Tcl code
• You are required to practice the concepts learned throughout course
Requirements
Main Program
Write a Tcl program that starts with displaying a menu for the user to choose a specific action and 
based on his/her action start to call the appropriate answer
e.g. 
Hello User, Choose your action with number from 1 to 6
1. Load File
2. Select a residue
3. Save Selection
4. Analyze
5. Process Residues
6. Align Molecules
Detailed Description
1. Load File 
1.1. Implement a function that asks the user for the file name/path to load the file.
1.2. If user entered a directory print a list with all pdb files in this directory.
1.3. If user entered a file name, make sure it exists and accessible (print proper error 
message if not) 
2. Select a residue
2.1. Implement a function which asks the user for the residue name/range.
2.2. Draw a box surrounding the selected atoms.
2.3. Make sure that user has already loaded a file
3. Save Selection 
3.1. Implement a function that saves a selection
3.2. Make sure that user has already selected atoms before
3.3. Ask the user for a folder/path to save data in 
3.4. Make sure that the path exist (print proper error message if not)
3.5. Make sure user have access to save in the path (print proper error message if not)
3.6. Ask user for file name
3.7. Save the file as pdb 
4. Analyze 
4.1. Implement a function which prints all information for a selection
• Number of atoms
• Number of bonds
• Number of residues
4.2. Make sure that output is formatted well (Hint: Use string format)
Number of atoms: 660
Number of bonds: 608
Number of residues: 134
5. Process Residues 
5.1. Implement a function that gets all residues
5.2. Print number of atoms in each residue
5.3. Draw each residue with different color 
(e.g. first residue with beta 0 second with beta 10 etc.)
5.4. Output formatted as in table (Hint: use format string function)
6. Align molecules
Implement a function that do the following functions
6.1. Make sure that the openGL menu have no drawing (clear window)
6.2. Ask user to enter 2 file names
6.3. Load files
6.4. Move the molecules to be aligned on top of each other

This video is compressed, for better resolution, check out this video link.
https://drive.google.com/file/d/1a9EzV06cvcGel4q1DdU5ckduJXD5SWJ9/view?usp=sharing

https://user-images.githubusercontent.com/112272836/192060730-7e7859c0-e2ac-4acf-8ddc-267cda89e7b6.mp4
