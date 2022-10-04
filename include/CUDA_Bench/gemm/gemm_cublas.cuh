#pragma once
#include <CUDA_Bench/util/precision_select.cuh>

int gemm_cublas(int dim_M, int dim_N, int dim_K, Precision mulprecision, Precision accprecision, int num_iter, bool print_result, bool tensor_cores, bool profiling);

