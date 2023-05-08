# FruitRain-Folder

Download all of the files from GitHub as a zip file.

You will need to open the FruitRain.pde file and go to around line 448 and
paste in the file location of QuizQuestions.csv. You can do this by locating them in
your file explorer, right clicking the section that shows all of the folder names,
and clicking "Copy address". Then paste the addresses in place of the pre-written
addresses, add an extra "\" to each one present in the new address, followed by two
backslashes and the file name.

E.g.: C:\\Users\\username\\Downloads\\FruitRain-FolderFruitRain\\QuizQuestions.csv

Confirm that the file paths work as intended; if there is something wrong, an error
should occur upon attempting to run the program.

While you have this file open, you will need to download the Sound library;
to do so, click on Sketch, then hover over Import Library, then click Add Library
(depending on your version of Processing it may be a different option).
Search for the Sound Library and download. If no errors occur when attempting to
play the music, then you've done this step correctly. You will also need to download the GifAnimation library.

Hook up the Makey-Makey controller to your PC and connect an apple, orange,
banana, and lime to the controller's up, down, left, and right dpad areas respectively
with alligator connectors. These dpad directions are automatically mapped to the corresponding
arrow keys on your keyboard, so no further configuration is required. If fruit and/or makey-makey controllers are not available,
we recommend colored stickers on the arrow keys instead, as there is otherwise no
indication of what to press.

Players will tap the fruit that corresponds with their guess to a provided question.
We suggest printing out a word document briefly explaining the following java concepts:
variables, strings (including concatenation), and conditionals (if, else, and
while loops).

The variables2.csv file features questions relating to a wider variety of arithmetic and assignment operators.
To change the quizzes you wish to use, change the file name(s) listed in the keyPressed() method on line 294.
We would also recommend changing lines 189, 191, 193, and/or 195 accordingly.

If you want to create your own quiz for the game (be it to teach programming or any other subject), create a csv file and follow the format of the other files.
We recommend doing this in excel or google sheets because the rows are more clear that way. The correct answer
choice is notated in what would be their arraylist index, as in you start counting from 0 rather than 1.
i.e. if the correct answer is the second choice, put a "1" in the last used cell of that row.

When building the quiz, you have the choice of four answers or two. For four answers, set the third cell of the row to 1. For two answers, set it to 2.

The file names in lines 189-195 must match the quizzes you intend your players to try to complete.
