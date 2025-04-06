Run make install after make to set the aliases

Credit to: https://gitlab.com/christosangel/ascii-matrix
I have not set up the options, I'm just gonna copy paste some stuff here messily

n
Short flag
Long flag
Explanation




1
-h
--help
Shows this help text.


2
-f
--file
Defines the path to the ascii txt file to render in the center of the matrix window. If this flag isn't used, the command will still render a matrix screen with no ascii art.


3
-s
--speed
Defines the speed of the matrix falling digits.	Acceptable values 0-9 (default: 5).


4
-d
--dense
Defines the density of the matrix lines. Acceptable values 0-9 (default: 5).








5
-m1
--matrix-color1
Defines the color of first matrix digits (default: yellow).


6
-m2
--matrix-color2 
Defines the color of matrix digits (default: green).


7
-c1
--ascii-color1
The first color of the ascii art (default: blue).


8
-c2
--ascii-color2
The second color of the ascii art (default: red).


9
-c3
--ascii-color3
The third color of the ascii art (default: white).


10
-c4
--ascii-color3
The fourth color of the ascii art (default: yellow).


11
-c5
--ascii-color3
The fifth color of the ascii art (default: green).


12
-c6
--ascii-color6
The sixth color of the ascii art (default: grey).


13
-c7
--ascii-color7
The seventh color of the ascii art (default: black).





Acceptable color values: black, maroon, green, olive, navy, purple, teal, silver, grey, red, lime, yellow, blue, fuchsia, aqua and white. These colors are defined by the color profile of your terminal.









14
-i
--invert
Inverts the colors of the ascii art (background-foreground).








15
-a1
--ascii1
Defines the characters for the first category of the ascii art (default: L).


16
-a2
--ascii2
Defines the characters for the second category of the ascii art (default: L).


17
-a3
--ascii3
Defines the characters for the third category of the ascii art (default: L).


18
-a4
--ascii4
Defines the characters for the fourth category of the ascii art (default: L).


19
-a5
--ascii5
Defines the characters for the fifth category of the ascii art (default: L).


20
-a6
--ascii6
Defines the characters for the sixth category of the ascii art (default: L).


21
-a7
--ascii7
Defines the characters for the seventh category of the ascii art (default: L).




Acceptable -a{1..7} values :






L Random uppercase letters [A-Z]






l Random lowercase letters [a-z]






n Random numbers [0-9]






s Space (best used in combination with -i or -d 9)






X the letter X







p Random punctuation marks '()*+,-./


