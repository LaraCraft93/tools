#!/usr/bin/env python
# Lara Maia <dev@lara.click> 2019

import math

images = int(input('How many images? '))
pages = math.ceil(images / 2)
sheets = math.ceil(pages / 2)
front_print = [1, 4]
back_print = [3, 2]

for paper in range(sheets):
    if paper > 0:
        for front, back in zip(front_print[:2], back_print[:2]):
            current = paper * 4

            if front + current <= images:
                front_print.append(front + current)

            if back + current <= images:
                back_print.append(back + current)

print('Pages' + ' ' * 8 + f': {pages}')
print('Papers' + ' ' * 7 + f': {sheets}')
print(f'Front Images : {front_print}')
print(f'Back Images  : {back_print}')

if len(front_print) != len(back_print):
    print("REMOVE THE LAST PAGE BEFORE FLIP!!!")
