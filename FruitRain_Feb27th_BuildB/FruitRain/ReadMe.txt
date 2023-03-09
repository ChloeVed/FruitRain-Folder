KeyInputs and Player are not needed, they can be deleted.

March9th_BuildA Notes: full quiz functionality is completed, the remaining features that need to be added include:
- Background
- Replace circles with the following fruit pngs: (apple, orange, banana, lime). Fruit mappings are detailed in the Enemy class's spawnEnemy() method
- Figure out how to manually de-spawn the fruit temporarily after making a guess (this isn't mandatory)
- Have the draw() loop add one health point to the player's score every 6 questions [this must be done in a way that ensures 1 health point is not added every frame when (quizIndex + 1)%6 == 0
- Add music