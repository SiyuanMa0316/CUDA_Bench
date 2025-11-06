#!/usr/bin/env python3
"""
Compute total energy consumption from GPU log CSV file.
Usage: python energy.py --input log.csv
"""

import argparse
import pandas as pd
import sys

def main():
    parser = argparse.ArgumentParser(description="Compute total energy consumption from GPU log file.")
    parser.add_argument("--input", type=str, required=True, help="Path to input CSV file")
    args = parser.parse_args()

    try:
        df = pd.read_csv(args.input)
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)

    # Check required columns
    if "ElapsedTime(s)" not in df.columns or "Power(W)" not in df.columns:
        print("Error: CSV must contain 'ElapsedTime(s)' and 'Power(W)' columns.")
        sys.exit(1)

    time = df["ElapsedTime(s)"].values
    power = df["Power(W)"].values

    if len(time) < 2:
        print("Error: Not enough data points.")
        sys.exit(1)

    # Compute total energy using trapezoidal rule
    total_energy = 0.0
    for i in range(len(time) - 1):
        dt = time[i + 1] - time[i]
        avg_power = 0.5 * (power[i + 1] + power[i])
        total_energy += avg_power * dt  # Joules (W·s)

    print(f"Total Energy Consumption: {total_energy:.3f} Joules")

if __name__ == "__main__":
    main()
