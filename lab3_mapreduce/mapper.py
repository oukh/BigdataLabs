#!/usr/bin/env python
import sys

# Mapper: Read lines from stdin and emit (word, 1) pairs
for line in sys.stdin:
    line = line.strip()  # remove leading and trailing whitespaces
    if line:
        words = line.split()  # split the line into words
        for word in words:
            # Emit word and count
            print('%s\t%s' % (word, 1))
