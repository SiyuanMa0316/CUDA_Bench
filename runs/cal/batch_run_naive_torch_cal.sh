#!/bin/bash
dim_i=(4096 16384 16384 32 1024)
dim_j=(4096 16384 32 16384 4096)
dim_k=(4096 16384 4096 4096 16384)
num_tests=${#dim_i[@]}
#gpu=0
#export HIP_VISIBLE_DEVICES=$gpu
#make logs directory if it doesn't exist
mkdir -p logs

#for ((i=0; i<num_tests; i++)); do
#  ./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_cuda_fp32_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_log.csv"  "./run_naive.sh ${dim_k[i]} ${dim_i[i]} ${dim_j[i]} ${dim_k[i]} gemm_cuda_fp32_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_log.out"
#done

for ((i=0; i<num_tests; i++)); do
  ./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_torch_fp32_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_log.csv"  "./run_pytorch.sh 1000 fp32 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]} gemm_torch_fp32_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_log.out"
done

for ((i=0; i<num_tests; i++)); do
  ./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_torch_fp16_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_log.csv"  "./run_pytorch.sh 1000 fp16 ${dim_i[i]} ${dim_j[i]} ${dim_k[i]} gemm_torch_fp16_${dim_i[i]}x${dim_j[i]}x${dim_k[i]}_log.out"
done