#!/usr/bin/env python3
"""
Batch process GPU log files to compute energy, runtime, and average power.
Output: merged_results.csv sorted by Test Name and GEMM Size.

Usage:
    python batch_energy.py --input_dir ./logs
"""

import os
import re
import argparse
import pandas as pd

def parse_filename(filename):
    # Expected pattern: gemm_cublas_fp16_cc_32x16384x4096_nvml_log.csv
    pattern = r"gemm_(.+)_(\d+x\d+x\d+)_nvml_log\.csv"
    match = re.match(pattern, filename)
    if match:
        return match.group(1), match.group(2)
    return None, None

def compute_energy_runtime(file_path):
    import pandas as pd
    import numpy as np

    try:
        df = pd.read_csv(file_path)
    except Exception:
        return None, None, None

    if "ElapsedTime(s)" not in df.columns or "Power(W)" not in df.columns:
        return None, None, None

    time = df["ElapsedTime(s)"].values
    power = df["Power(W)"].values
    if len(time) < 2:
        return None, None, None

    # Mask: only keep samples where workload is active (power > 100 W)
    active_mask = power > 100

    # If there are no active samples, skip this file
    if not np.any(active_mask):
        return None, None, None

    # Extract continuous segments where power > 100
    active_indices = np.where(active_mask)[0]

    # Optionally, handle discontinuous segments — keep only between first and last active samples
    start_idx, end_idx = active_indices[0], active_indices[-1]

    active_time = time[start_idx:end_idx + 1]
    active_power = power[start_idx:end_idx + 1]

    # Compute total energy using trapezoidal rule
    total_energy = np.trapezoid(active_power, active_time)  # Joules (W·s)
    total_runtime = active_time[-1] - active_time[0]
    avg_power = total_energy / total_runtime if total_runtime > 0 else 0

    return total_energy, total_runtime, avg_power

def main():
    parser = argparse.ArgumentParser(description="Compute total energy, runtime, and average power for multiple GPU logs.")
    parser.add_argument("--input_dir", type=str, required=True, help="Directory containing GPU log CSV files")
    args = parser.parse_args()

    results = []

    for fname in os.listdir(args.input_dir):
        if not fname.endswith(".csv"):
            continue

        test_name, gemm_size = parse_filename(fname)
        if not test_name or not gemm_size:
            continue

        file_path = os.path.join(args.input_dir, fname)
        total_energy, total_runtime, avg_power = compute_energy_runtime(file_path)
        if total_energy is None:
            continue

        results.append([test_name, gemm_size, total_energy, total_runtime, avg_power])

    # Create DataFrame and sort
    df = pd.DataFrame(results, columns=[
        "Test Name", "GEMM Size", "Total Energy (J)", "Total Runtime (s)", "Average Power (W)"
    ])
    df.sort_values(by=["Test Name", "GEMM Size"], inplace=True)

    output_path = "merged_results.csv"
    df.to_csv(output_path, index=False)
    print(f"✅ Computation complete. Saved results to {output_path}")

if __name__ == "__main__":
    main()
