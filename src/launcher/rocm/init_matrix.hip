#include <hip/hip_runtime.h>
#include <hip/hip_runtime_api.h>
#include <GPU_Roofline_Tools/launcher/rocm/init_matrix.hip.h>

template<typename T>
__global__ void initialize_matrix(T* matrix, int n_rows, int n_cols, T val)
{
    int workerID = hipBlockDim_x * hipBlockIdx_x + hipThreadIdx_x;
    int n_elements = n_rows * n_cols;
    if(workerID<n_elements)
    {
        matrix[workerID] = val;
    }
}

template<typename T>
__global__ void initialize_colnegpos_matrix(T* matrix, int n_rows, int n_cols, T val)
{
    int workerID = hipBlockDim_x * hipBlockIdx_x + hipThreadIdx_x;
    int n_elements = n_rows * n_cols;
    int col = workerID / n_rows;
    if(workerID<n_elements)
    {
        if(col % 2 == 0)
        {
            matrix[workerID] = +val;
        }
        else
        {
            matrix[workerID] = -val;
        }
    }
}

template<typename T>
__global__ void initialize_rownegpos_matrix(T* matrix, int n_rows, int n_cols, T val)
{
    int workerID = hipBlockDim_x * hipBlockIdx_x + hipThreadIdx_x;
    int n_elements = n_rows * n_cols;
    int row = workerID % n_rows;
    if(workerID<n_elements)
    {
        if(row % 2 == 0)
        {
            matrix[workerID] = +val;
        }
        else
        {
            matrix[workerID] = -val;
        }
    }
}

template<typename T>
__global__ void initialize_colposneg_matrix(T* matrix, int n_rows, int n_cols, T val)
{
    int workerID = hipBlockDim_x * hipBlockIdx_x + hipThreadIdx_x;
    int n_elements = n_rows * n_cols;
    int col = workerID / n_rows;
    if(workerID<n_elements)
    {
        if(col % 2 == 0)
        {
            matrix[workerID] = -val;
        }
        else
        {
            matrix[workerID] = +val;
        }
    }
}


template <typename T>
__global__ void view_matrix_fp(T* matrix, int n_rows, int n_cols)
{
    for(int col=0; col<n_cols; col++)
    {
        for(int row=0; row<n_rows; row++)
        {
            double temp = matrix[col*n_rows+row];
            printf("%f ", temp);
        }
        printf("\n");
    }
}

template <typename T>
__global__ void view_matrix_int(T* matrix, int n_rows, int n_cols)
{
    for(int col=0; col<n_cols; col++)
    {
        for(int row=0; row<n_rows; row++)
        {
            int temp = matrix[col*n_rows+row];
            printf("%d ", temp);
        }
        printf("\n");
    }
}