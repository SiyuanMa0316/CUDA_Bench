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
                    type=int, default=1)
parser.add_argument("-p", help="precision",
                    type=str, default="fp16")

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
    if args.p == "fp32":
        A = np.random.rand(M, K).astype(np.float32)
        B = np.random.rand(K, N).astype(np.float32)
    elif args.p == "fp16":
        A = np.random.rand(M, K).astype(np.float16)
        B = np.random.rand(K, N).astype(np.float16)
    else:
        raise ValueError("Unsupported precision. Use 'fp32' or 'fp16'.")
    print(f"Matrix A: {A.shape}")
    print(f"Matrix B: {B.shape}")
    # Perform GEMM
    start_time = time.perf_counter()
    for i in range(10):
        C = np.matmul(A, B)
    for i in range(iter):
        C = np.matmul(A, B)
    torch.cuda.synchronize()
    end_time = time.perf_counter()
else:
    # torch.set_num_threads(torch.get_num_threads())
    if args.p == "fp32":
        A = torch.randn(M, K, dtype=torch.float32).to(device)
        B = torch.randn(K, N, dtype=torch.float32).to(device)
    elif args.p == "fp16":
        A = torch.randn(M, K, dtype=torch.float16).to(device)
        B = torch.randn(K, N, dtype=torch.float16).to(device)
    # elif args.p == "int8":
    #     A = torch.randint(-128, 127, (M, K), dtype=torch.int8).to(device)
    #     B = torch.randint(-128, 127, (K, N), dtype=torch.int8).to(device)
    else:
        raise ValueError("Unsupported precision. Use 'fp32' or 'fp16'.")
    print(f"Matrix A: {A.shape}")
    print(f"Matrix B: {B.shape}")
    # Perform GEMM
    for i in range(10):
        C = torch.matmul(A, B)
    start_time = time.perf_counter()
    for i in range(iter):
        C = torch.matmul(A, B)
    torch.cuda.synchronize()
    end_time = time.perf_counter()
execution_time = (end_time - start_time) * 1000
gemm_time = execution_time / iter
print(f"Time taken for {iter} iterations: {execution_time:.4f} ms")
print(f"Time taken for one iteration: {gemm_time:.4f} ms")