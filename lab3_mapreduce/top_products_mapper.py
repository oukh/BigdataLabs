#!/usr/bin/env python3
# Mapper: extract product category and emit (product, 1)
import sys

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    parts = line.split()
    # Expect: date time city product... price card
    if len(parts) < 6:
        continue
    # product is from index 3 to -3 (exclusive), price is -2, card is -1
    product_tokens = parts[3:-2]
    if not product_tokens:
        continue
    product = ' '.join(product_tokens)
    print('%s\t1' % product)
