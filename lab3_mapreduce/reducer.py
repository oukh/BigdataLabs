#!/usr/bin/env python
import sys

# Reducer: Sum counts for each word
current_word = None
current_count = 0

for line in sys.stdin:
    line = line.strip()
    if line:
        word, count = line.rsplit('\t', 1)
        count = int(count)
        
        # If this is a different word, output the previous word's count
        if current_word == word:
            current_count += count
        else:
            if current_word:
                print('%s\t%s' % (current_word, current_count))
            current_word = word
            current_count = count

# Don't forget the last word!
if current_word:
    print('%s\t%s' % (current_word, current_count))
