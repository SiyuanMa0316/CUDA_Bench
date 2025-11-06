#!/bin/bash

python3 batch_process.py --input ./logs
python3 generate_latex.py --input merged_results.csv