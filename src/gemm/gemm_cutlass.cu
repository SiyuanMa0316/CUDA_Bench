// Matrix-matrix Multiplication using cutlass
// (C) 2022 Bagus Hanindhito

#include <CUDA_Bench/gemm/gemm_cutlass.cuh>
#include <CUDA_Bench/gemm/gemm_cutlass_launch_int.cuh>
#include <CUDA_Bench/gemm/gemm_cutlass_launch_fp.cuh>
#include <CUDA_Bench/util/gpuinfo.cuh>
#include <CUDA_Bench/util/gpucheck.cuh>
#include <CUDA_Bench/util/precision_select.cuh>

#include <cutlass/cutlass.h>
#include <cutlass/gemm/device/gemm.h>

int gemm_cutlass(int dim_M, int dim_N, int dim_K, Precision mulprecision, Precision accprecision, int num_iter, bool print_result, bool tensor_cores, bool profiling)
{
     // Detect Available CUDA Devices
    int nDevices;
    gpuErrchk(cudaGetDeviceCount(&nDevices));
    print_cuda_device_info(nDevices);
    if(nDevices>0) {std::cout << "[WARN] This program does not currently support Multi-GPU run.\n";}

    // Detect Device Capability
    cudaDeviceProp props;
    gpuErrchk(cudaGetDeviceProperties(&props, 0));
    GPUARCH gpuarch;

    switch(props.major * 10 + props.minor)
    {
        case 70: {gpuarch=GPUARCH_VOLTA;  break;}
        case 75: {gpuarch=GPUARCH_TURING; break;}
        case 80: {gpuarch=GPUARCH_AMPERE; break;}
        case 86: {gpuarch=GPUARCH_AMPERE; break;}
        default: {gpuarch=GPUARCH_OTHER; break;}
    }


    // Precision Compability Check
    if(mulprecision==PRECISION_FP64 && accprecision==PRECISION_FP64)
    {
        if(tensor_cores)
        {
            std::cout << "[WARN] Currently Tensor Cores are not supporting FP64 multiplication and accumulation\n";            
        }
        
        switch(gpuarch)
        {
            case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_fp64_fp64_fp64_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
            case GPUARCH_TURING: {gemm_cutlass_launch_turing_fp64_fp64_fp64_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
            case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_fp64_fp64_fp64_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
            default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
        }
    }
    else if(mulprecision==PRECISION_FP32 && accprecision==PRECISION_FP32)
    {
        if(tensor_cores)
        {
            std::cout << "[WARN] Currently Tensor Cores are not supporting FP32 multiplication and accumulation\n";
            std::cout << "[WARN] Use CUBLAS for FP32 multiplication and accumulation on Tensor Cores with lossy precision\n";
        }
        switch(gpuarch)
        {
            case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_fp32_fp32_fp32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
            case GPUARCH_TURING: {gemm_cutlass_launch_turing_fp32_fp32_fp32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
            case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_fp32_fp32_fp32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
            default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
        }
    }
    else if(mulprecision==PRECISION_FP16 && accprecision==PRECISION_FP32)
    {
        if(tensor_cores)
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_fp32_fp16_fp32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_fp32_fp16_fp32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_fp32_fp16_fp32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
            
        }
        else
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_fp32_fp16_fp32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_fp32_fp16_fp32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_fp32_fp16_fp32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
        }

    }
    else if(mulprecision==PRECISION_FP16 && accprecision==PRECISION_FP16)
    {
        if(tensor_cores)
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_fp16_fp16_fp16_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_fp16_fp16_fp16_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_fp16_fp16_fp16_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
            
        }
        else
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_fp16_fp16_fp16_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_fp16_fp16_fp16_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_fp16_fp16_fp16_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
        }

    }
    else if(mulprecision==PRECISION_INT8 && accprecision==PRECISION_INT8)
    {
        std::cout << "[WARN] Promoting accumulation precision to int32 to maintain compability\n";
        if(tensor_cores)
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {std::cout << "[ERR!] Volta Tensor Cores do not support int8. Please use CUDA Cores instead\n"; exit(1); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_int32_int8_int32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_int32_int8_int32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
            
        }
        else
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {gemm_cutlass_launch_volta_int32_int8_int32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_int32_int8_int32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_int32_int8_int32_ntc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
        }
    }
    else if(mulprecision==PRECISION_INT4 && (accprecision==PRECISION_INT8 || accprecision==PRECISION_INT4))
    {
        std::cout << "[WARN] Promoting accumulation precision to int32 to maintain compability\n";
        if(tensor_cores)
        {
            switch(gpuarch)
            {
                case GPUARCH_VOLTA : {std::cout << "[ERR!] Volta Tensor Cores do not support int4\n"; exit(1); break;}
                case GPUARCH_TURING: {gemm_cutlass_launch_turing_int32_int4_int32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                case GPUARCH_AMPERE: {gemm_cutlass_launch_ampere_int32_int4_int32_tc(dim_M, dim_N, dim_K, num_iter, print_result, profiling); break;}
                default: {std::cout << "[ERR!] GPU Compute Capability is lower than it is required\n"; exit(1); break;}
            }
            
        }
        else
        {
            std::cout << "[ERR!] Operations involving int4 requires the use of Tensor Cores\n"; 
            exit(1);
        }
    }
    return 0;
}