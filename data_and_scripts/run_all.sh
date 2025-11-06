#!/bin/bash
dim_i=(4096 16384 16384 32 1024)
dim_j=(4096 16384 32 16384 4096)
dim_k=(4096 16384 4096 4096 16384)
num_tests=${#dim_i[@]}

#make logs directory if it doesn't exist
mkdir -p logs

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "../src/gemm/gemm_naive_float -wA=${dim_k[i]} -hA=${dim_i[i]} -wB=${dim_j[i]} -hB=${dim_k[i]}" -o logs/gemm_cuda_fp32_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "python3 ../src/gemm/gemm_torch.py -i 1000 -p fp32 --gpu ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_torch_fp32_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "../bin/gemm_cuda_bench --usecublas --cudacoresonly --mulprecision fp32 --accprecision fp32 --iterations 1000 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_cublas_fp32_cc_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "../bin/gemm_cuda_bench --cudacoresonly --mulprecision fp32 --accprecision fp32 --iterations 1000 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_cutlass_fp32_cc_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ./nvml_gpu_profiler -c "../bin/gemm_cuda_bench --usecublas --cudacoresonly --mulprecision fp16 --accprecision fp16 --iterations 1000 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_cublas_fp16_cc_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "../bin/gemm_cuda_bench --cudacoresonly --mulprecision fp16 --accprecision fp16 --iterations 1000 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_cutlass_fp16_cc_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "python3 ../src/gemm/gemm_torch.py -i 1000 -p fp16 --gpu ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_torch_fp16_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "../bin/gemm_cuda_bench --usecublas --mulprecision fp16 --accprecision fp16 --iterations 1000 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_cublas_fp16_tc_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done

for ((i=0; i<num_tests; i++)); do
  ../nvml_gpu_profiler -c "../bin/gemm_cuda_bench --mulprecision fp16 --accprecision fp16 --iterations 1000 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]}" -o logs/gemm_cutlass_fp16_tc_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_nvml_log.csv
done



