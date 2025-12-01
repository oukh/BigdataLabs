#!/usr/bin/env python3
# Exercise: Find top products purchased
# Input: purchases.txt with format: product_name\tquantity
import sys

for line in sys.stdin:
    line = line.strip()
    if line and '\t' in line:
        parts = line.rsplit('\t', 1)
        if len(parts) == 2:
            product = parts[0].strip()
            try:
                quantity = int(parts[1].strip())
                print('%s\t%s' % (product, quantity))
            except ValueError:
                continue
