./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp32_mc_4096x4096x4096_rsmi_log.csv"    "./run_mblas.sh 0 ROCBLAS fp32 fp32 fp32 4096  4096  4096  gemm_rocblas_fp32_mc_4096x4096x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp32_mc_16384x16384x16384_rsmi_log.csv" "./run_mblas.sh 0 ROCBLAS fp32 fp32 fp32 16384 16384 16384 gemm_rocblas_fp32_mc_16384x16384x16384"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp32_mc_16384x32x4096_rsmi_log.csv"     "./run_mblas.sh 0 ROCBLAS fp32 fp32 fp32 16384 32    4096  gemm_rocblas_fp32_mc_16384x32x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp32_mc_32x16384x4096_rsmi_log.csv"     "./run_mblas.sh 0 ROCBLAS fp32 fp32 fp32 32    16384 4096  gemm_rocblas_fp32_mc_32x16384x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp32_mc_1024x4096x16384_rsmi_log.csv"   "./run_mblas.sh 0 ROCBLAS fp32 fp32 fp32 1024  4096  16384 gemm_rocblas_fp32_mc_1024x4096x16384"

./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp16_mc_4096x4096x4096_rsmi_log.csv"    "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp16 4096  4096  4096  gemm_rocblas_fp16_mc_4096x4096x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp16_mc_16384x16384x16384_rsmi_log.csv" "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp16 16384 16384 16384 gemm_rocblas_fp16_mc_16384x16384x16384"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp16_mc_16384x32x4096_rsmi_log.csv"     "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp16 16384 32    4096  gemm_rocblas_fp16_mc_16384x32x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp16_mc_32x16384x4096_rsmi_log.csv"     "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp16 32    16384 4096  gemm_rocblas_fp16_mc_32x16384x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp16_mc_1024x4096x16384_rsmi_log.csv"   "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp16 1024  4096  16384 gemm_rocblas_fp16_mc_1024x4096x16384"

./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp1632_mc_4096x4096x4096_rsmi_log.csv"    "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp32 4096  4096  4096  gemm_rocblas_fp1632_mc_4096x4096x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp1632_mc_16384x16384x16384_rsmi_log.csv" "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp32 16384 16384 16384 gemm_rocblas_fp1632_mc_16384x16384x16384"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp1632_mc_16384x32x4096_rsmi_log.csv"     "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp32 16384 32    4096  gemm_rocblas_fp1632_mc_16384x32x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp1632_mc_32x16384x4096_rsmi_log.csv"     "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp32 32    16384 4096  gemm_rocblas_fp1632_mc_32x16384x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_rocblas_fp1632_mc_1024x4096x16384_rsmi_log.csv"   "./run_mblas.sh 0 ROCBLAS fp16 fp16 fp32 1024  4096  16384 gemm_rocblas_fp1632_mc_1024x4096x16384"




./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp32_mc_4096x4096x4096_rsmi_log.csv"    "./run_mblas.sh 0 HIPBLASLT fp32 fp32 fp32 4096  4096  4096  gemm_hipblaslt_fp32_mc_4096x4096x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp32_mc_16384x16384x16384_rsmi_log.csv" "./run_mblas.sh 0 HIPBLASLT fp32 fp32 fp32 16384 16384 16384 gemm_hipblaslt_fp32_mc_16384x16384x16384"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp32_mc_16384x32x4096_rsmi_log.csv"     "./run_mblas.sh 0 HIPBLASLT fp32 fp32 fp32 16384 32    4096  gemm_hipblaslt_fp32_mc_16384x32x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp32_mc_32x16384x4096_rsmi_log.csv"     "./run_mblas.sh 0 HIPBLASLT fp32 fp32 fp32 32    16384 4096  gemm_hipblaslt_fp32_mc_32x16384x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp32_mc_1024x4096x16384_rsmi_log.csv"   "./run_mblas.sh 0 HIPBLASLT fp32 fp32 fp32 1024  4096  16384 gemm_hipblaslt_fp32_mc_1024x4096x16384"

./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp16_mc_4096x4096x4096_rsmi_log.csv"    "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp16 4096  4096  4096  gemm_hipblaslt_fp16_mc_4096x4096x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp16_mc_16384x16384x16384_rsmi_log.csv" "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp16 16384 16384 16384 gemm_hipblaslt_fp16_mc_16384x16384x16384"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp16_mc_16384x32x4096_rsmi_log.csv"     "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp16 16384 32    4096  gemm_hipblaslt_fp16_mc_16384x32x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp16_mc_32x16384x4096_rsmi_log.csv"     "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp16 32    16384 4096  gemm_hipblaslt_fp16_mc_32x16384x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp16_mc_1024x4096x16384_rsmi_log.csv"   "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp16 1024  4096  16384 gemm_hipblaslt_fp16_mc_1024x4096x16384"

./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp1632_mc_4096x4096x4096_rsmi_log.csv"    "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp32 4096  4096  4096  gemm_hipblaslt_fp1632_mc_4096x4096x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp1632_mc_16384x16384x16384_rsmi_log.csv" "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp32 16384 16384 16384 gemm_hipblaslt_fp1632_mc_16384x16384x16384"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp1632_mc_16384x32x4096_rsmi_log.csv"     "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp32 16384 32    4096  gemm_hipblaslt_fp1632_mc_16384x32x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp1632_mc_32x16384x4096_rsmi_log.csv"     "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp32 32    16384 4096  gemm_hipblaslt_fp1632_mc_32x16384x4096"
#./run_workload_monitor.sh "../../monitors/scripts/amd_mi300x_power_clock_temp.sh 0 1 gemm_hipblaslt_fp1632_mc_1024x4096x16384_rsmi_log.csv"   "./run_mblas.sh 0 HIPBLASLT fp16 fp16 fp32 1024  4096  16384 gemm_hipblaslt_fp1632_mc_1024x4096x16384"

