#!/usr/bin/env python
# Lara Maia <dev@lara.click> 2015~2016

import sys

if len(sys.argv) < 3:
    print("Usage: {} <in file> <out file>".format(sys.argv[0]))
    sys.exit(1)

data = open(sys.argv[1]).readlines()

rows = []
for text in data:
    tdList = text.split('|')
    tdList = ['<td>{}</td>'.format(td.strip()) for td in tdList]
    rows.append(tdList)

with open(sys.argv[2], 'w+') as fp:
    fp.write('<table>')
    for row in rows:
        fp.write('<tr>\n')
        for td in row:
            fp.write('    {}\n'.format(td))
        fp.write('</tr>\n')
    fp.write('</table>')

print("Success!")
sys.exit(0)
