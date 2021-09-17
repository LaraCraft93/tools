#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# Converte arquivos binários em hexadecimal
# e arquivos hexadecimais em binário
# Lara Maia <dev@lara.monster> © 2013~2021
# Versão: 0.2

import argparse
import binascii
import sys

default_delim = 80

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert binary files to hex')
    action = parser.add_mutually_exclusive_group(required=True)
    action.add_argument('-d', '--tohex', action='store_true')
    action.add_argument('-c', '--tobin', action='store_true')
    parser.add_argument('input_file')
    output = parser.add_mutually_exclusive_group(required=True)
    output.add_argument('-s', '--stdout', action='store_true')
    output.add_argument('-o', '--output_file')
    console_params = parser.parse_args()

    if console_params.tohex:
        with open(console_params.input_file, 'rb') as f:
            binary = f.read()

        hex = binascii.hexlify(binary).decode()

        delim = default_delim
        hex_with_delim = str()
        while delim <= len(hex):
            hex_with_delim += hex[(delim-default_delim):delim] + '\n'
            delim += default_delim

        if console_params.stdout:
            print(hex_with_delim)
        else:
            with open(console_params.output_file, 'w') as d:
                d.write(hex_with_delim)

    if console_params.tobin:
        with open(console_params.input_file, 'rb') as f:
            hex = f.read().replace(b'\n', b'')

        binary = binascii.unhexlify(hex).decode()

        if console_params.stdout:
            print(binary)
        else:
            with open(console_params.output_file, 'w') as d:
                d.write(binary)
