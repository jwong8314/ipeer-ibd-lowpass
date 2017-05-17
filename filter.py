#!/usr/bin/env python

import sys
import gzip

file = sys.argv[1]
file_stream = gzip.open(file, 'r')

num_samples = 0

try:
  for line in file_stream:
    if line.startswith("#"):
      sys.stdout.write(line)
      continue
    fields = line.split("\t", 9)
    if len(fields) < 10:
      sys.stdout.write(line)
      continue
    chrom = fields[0]
    pos = fields[1]
    id = fields[2]
    ref = fields[3]
    alt = fields[4]
    qual = fields[5]
    filter = fields[6]
    info = fields[7]
    format = fields[8]
    rest = fields[9]

    num_ones = rest.count('1')

    if num_samples == 0:
      num_samples = float(num_ones + rest.count('0'))

    frequency = num_ones / num_samples
    if frequency > 0.05:
      sys.stdout.write(line)

finally:
  file_stream.close()