# README for Assignment 1
- First of all, though we created assignment_01 through _08 in class, the instructions explicitly say to have this directory named assignment_1. I think that _01 would be a better name, as we discussed in class, but for the sake of following the instructions as of the time of writing this since they have not been changed, I will be sticking to assignment_1. 

- The following is a list of commands which one could run sequentially to replicate the structure of this assignment directory. These commands assume one starts inside the assignment_1 directory.

- This directory structure is based on the example provided in the assignment 1 instructions, but in my mind it makes more sense to store anything related to code in a src directory, with a main.py to run something, which is why I moved everything code-related to src and created the palceholder_main.py directly in the assignment_1 directory. Additionally, I created a figures folder (which presumably would be created using reproducible data and scripts, which is why it is also in the src directory) because I felt this was missing and would be an important part of most projects.

mkdir src
mkdir docs
touch placeholder_main.py
cd src
mkdir placeholder_functions_01 placeholder_functions_02
mkdir results config logs figures data
cd data
mkdir raw clean
touch clean/placeholder_clean.csv
touch raw/placeholder_raw.csv
cd ..
touch config/placeholder_config.py
touch figures/placeholder_figure_wouldbepng.txt
touch logs/placeholder_log.txt
touch placeholder_functions_01/placeholder_functions_01.py
touch placeholder_functions_02/placeholder_functions_02.py
touch results/results.csv
cd ..
touch docs/placeholder_doc.md

- running these commands line-by-line would end in the assignment_1 directory.