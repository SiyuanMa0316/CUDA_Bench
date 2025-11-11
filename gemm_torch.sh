#!/bin/bash
python3 src/gemm/gemm_torch.py -i 1000 -p fp16 --gpu 4096 4096 4096
# python3 src/gemm/gemm_torch.py -i 1000 -p fp32 --gpu 1024 4095 1024