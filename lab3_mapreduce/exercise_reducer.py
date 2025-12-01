#!/usr/bin/env python3
# Exercise: Aggregate product quantities
import sys

current_product = None
total_quantity = 0

for line in sys.stdin:
    line = line.strip()
    if line and '\t' in line:
        product, quantity = line.rsplit('\t', 1)
        try:
            quantity = int(quantity)
        except ValueError:
            continue
        
        if current_product == product:
            total_quantity += quantity
        else:
            if current_product:
                print('%s\t%s' % (current_product, total_quantity))
            current_product = product
            total_quantity = quantity

if current_product:
    print('%s\t%s' % (current_product, total_quantity))
