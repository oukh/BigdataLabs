#!/usr/bin/env python3
# Reducer: sum counts per product
import sys

current = None
count = 0
for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    parts = line.rsplit('\t', 1)
    if len(parts) != 2:
        continue
    product, v = parts
    try:
        v = int(v)
    except ValueError:
        continue
    if current == product:
        count += v
    else:
        if current:
            print('%s\t%s' % (current, count))
        current = product
        count = v
if current:
    print('%s\t%s' % (current, count))
