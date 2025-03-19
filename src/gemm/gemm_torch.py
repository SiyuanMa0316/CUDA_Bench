import torch
import argparse
import time
import numpy as np


# Code block to be timed
time.sleep(2)


# Parse command line arguments
parser = argparse.ArgumentParser()
parser.add_argument("M", help="Matrix dimension M",
                    type=int)
parser.add_argument("K", help="Matrix dimension K",
                    type=int)
parser.add_argument("N", help="Matrix dimension N",
                    type=int)
parser.add_argument("-i", help="number of iterations",
                    type=int)
parser.add_argument('--gpu', action='store_true', help='Use GPU') 
parser.add_argument('--numpy', action='store_true', help='Use numpy')

args = parser.parse_args()
# Check if CUDA is available
if torch.cuda.is_available() and args.gpu:
    device = torch.device('cuda')
else:
    device = torch.device('cpu')
print(f"Device: {device}")
iter = args.i
print(f"Number of iterations: {iter}")
# Define matrices
M = args.M
K = args.K
N = args.N
if args.numpy:
    A = np.random.rand(M, K)
    B = np.random.rand(K, N)
    print(f"Matrix A: {A.shape}")
    print(f"Matrix B: {B.shape}")
    # Perform GEMM
    start_time = time.perf_counter()
    for i in range(10):
        C = np.matmul(A, B)
    for i in range(iter):
        C = np.matmul(A, B)
    end_time = time.perf_counter()
else:
    # torch.set_num_threads(torch.get_num_threads())
    A = torch.randn(M, K).to(device)
    B = torch.randn(K, N).to(device)
    print(f"Matrix A: {A.shape}")
    print(f"Matrix B: {B.shape}")
    # Perform GEMM
    for i in range(10):
        C = torch.matmul(A, B)
    start_time = time.perf_counter()
    for i in range(iter):
        C = torch.matmul(A, B)
    end_time = time.perf_counter()
execution_time = (end_time - start_time) * 1000
gemm_time = execution_time / iter
print(f"Time taken for {iter} iterations: {execution_time:.4f} ms")
print(f"Time taken for one iteration: {gemm_time:.4f} ms")