# Group Number: 11
# Author: Brittany Given
# Assignment: Assignment 7
# Date: 3/22/2023
# File Description: *copied and slightly modified from assignment 3*
#                   opens a text file, created by team, and generates a list 
#                   containing all words in the file

import re
from collections import defaultdict

# initialize list to hold all words
word_list = []
# initialize dictionary to hold count of words
word_count = defaultdict(int)
# initialize dictionary to hold wordfrequency count
wordfreq_count = defaultdict(int)

# read the novel.txt file
with open('gameBackground.txt', 'r') as f:
    # loop through all lines in the txt file
    for line in f:
        # skip lines that are empty
        # THIS ISN'T IT??
        if line == '\n':
            print("IN IF")
            word_list.append('***')
        else:
            # split the line into words based around spaces
            line_words = line.split(' ')
            for word in line_words:
                # add words from line being read to word_list
                word_list.append(word)

# create text file containing every word in text file on a new line
with open('allWordsBackground.txt','x') as allwords:
    for word in word_list:
        allwords.write(word + '\n')

