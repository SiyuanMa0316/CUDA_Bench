#!/bin/bash
./bin/gemm_cuda_bench --usecublas --mulprecision fp16 --accprecision fp16 --iterations 1000 4000 4000 4000