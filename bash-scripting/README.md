### ⚔️ Bash Battle Arena

The Bash Battle Arena is a command line game designed to improve Bash scripting through level based challenges. Players solve each mission by writing Bash scripts, then share their solutions in their GitHub learning repositories.

There is no interactive VM or website yet. The game runs locally on a laptop.

The game follows a level system. Difficulty increases each level. A Boss Battle appears every 5 levels to combine and reinforce the previous levels. A future version will include an interface and scoring based on script efficiency and speed.

#### 🎯 Objective

Complete each mission using Bash scripts. Missions start with basic file operations and progress into more advanced scripting tasks. The end goal is to complete every level and reach Bash Master level.

#### 🧩 Game Structure

- Level based progression from Level 1 upward
- A Boss Battle every 5 levels
- Local play on a laptop
- Script solutions shared on GitHub
- Future scoring based on speed and efficiency

#### 🕹️ Levels Completed

Level 1. The Basics  
Mission. Create a directory named `Arena`, create `warrior.txt`, `mage.txt`, and `archer.txt` inside it, then list the contents.

Level 2. Variables and Loops  
Mission. Output the numbers 1 to 10, one number per line.

Level 3. Conditional Statements  
Mission. Check if `hero.txt` exists in `Arena`. Print `Hero found!` if it exists, otherwise print `Hero missing!`.

Level 4. File Manipulation  
Mission. Copy all `.txt` files from `Arena` into a new directory called `Backup`.

Level 5. Boss Battle 1. Combining Basics  
Mission.
1. Create a directory named `Battlefield`
2. Create `knight.txt`, `sorcerer.txt`, and `rogue.txt` inside `Battlefield`
3. Check if `knight.txt` exists, if it does move it into a new directory called `Archive`
4. List the contents of `Battlefield` and `Archive`

Level 6. Argument Parsing  
Mission. Accept a filename as an argument and print the number of lines in that file. If no filename is provided, print `No file provided`.

Level 7. File Sorting Script  
Mission. Sort all `.txt` files in a directory by size from smallest to largest and print the sorted list.

Level 8. Multi File Searcher  
Mission. Search for a word or phrase across all `.log` files in a directory and output the names of files that contain the word or phrase.

Level 9. Monitor Directory Changes  
Mission. Monitor a directory for file creation, modification, or deletion, then log each change with a timestamp.

Level 10. Boss Battle 2. Intermediate Scripting  
Mission.
1. Create a directory called `Arena_Boss`
2. Create 5 text files named `file1.txt` to `file5.txt`
3. Generate a random number of lines between 10 and 20 in each file
4. Sort the files by size and display the list
5. Check if any file contains the word `Victory`, if found move the file into `Victory_Archive`

## 🧩 Bash Challenges and Reflection

This directory includes a set of standalone Bash challenges alongside a written reflection file. The challenges focus on practising specific Bash concepts in isolation before combining them in larger scripts.

The challenges cover core areas such as arithmetic using `$(( ))`, directory and file creation, logging with timestamps, file existence checks, permission testing, and simple backup automation. Each script targets one main concept and is designed to reinforce correct Bash syntax, quoting, and control flow based on exit codes rather than printed output.

The `reflection.txt` file documents learning gained from completing these challenges. It explains how Bash syntax rules affect script behaviour, why arithmetic and conditionals must follow strict patterns, and how wildcard expansion behaves differently depending on context. It also records problems encountered during development, such as broken `if` logic caused by incorrect parentheses and path errors caused by repeated use of `cd`.

The reflection highlights how these issues were resolved by relying on command exit codes, quoting variables consistently, and building full paths instead of depending on the current working directory. Together, the challenges and reflection show progression from basic scripting tasks to a clearer understanding of how Bash executes commands in real scenarios.
