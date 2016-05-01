#!/usr/bin/env python
"""
Adds a text to the reel model parameterized by a CSV table.
"""

import os
import pandas as pd

df = pd.read_csv('reel_texts.csv', dtype=str)

template = """use <../reel.scad>;

reel([%s], %s, %s);
"""

dir_name = 'reels_scad'
os.makedirs(dir_name, exist_ok=True)
for index, row in df.iterrows():
    normalized_text = row['text'].replace(' ', '_').replace('/', '')
    file_name = '%s/reel_%02d_%s.scad' % (dir_name, index, normalized_text)
    with open(file_name, 'w') as f:
        text = ', '.join(['"%s"' % t for t in row['text'].split(' ')])
        f.write(template % (text, row['size'], row['y_pos']))
