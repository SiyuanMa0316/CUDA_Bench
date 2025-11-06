#!/usr/bin/env python3
"""
Generate compact LaTeX tables (rows=test names, columns=GEMM sizes)
with makecell headers, formatted for research papers:
- Latency in ms (2 decimals)
- Energy in J (2 decimals)
- Power in W (integer)
"""

import argparse
import pandas as pd
import re

def latex_escape(s: str) -> str:
    """Escape underscores for LaTeX."""
    return str(s).replace("_", "\\_")

def split_gemm_size(size: str):
    """Return a makecell with multi-line GEMM dimensions."""
    parts = size.split("x")
    if len(parts) == 3:
        return f"\\makecell{{{parts[0]}\\\\x{parts[1]}\\\\x{parts[2]}}}"
    return size

def extract_first_number(s):
    """Helper to sort GEMM sizes numerically by first dimension."""
    m = re.match(r"(\d+)", s)
    return int(m.group(1)) if m else 0

def make_matrix_table(df, value_col, caption, label, unit, fmt):
    """Create a matrix-style LaTeX table with makecell headers and formatted values."""
    pivot = df.pivot(index="Test Name", columns="GEMM Size", values=value_col)
    sorted_cols = sorted(pivot.columns, key=extract_first_number)
    pivot = pivot[sorted_cols]

    pivot.index = [latex_escape(i) for i in pivot.index]

    latex = []
    latex.append("\\begin{table}[t]")
    latex.append("    \\centering")
    latex.append(f"    \\caption{{{caption}}}")
    latex.append(f"    \\label{{tab:{label}}}")
    latex.append("    \\setlength{\\tabcolsep}{2pt}")
    latex.append("    \\renewcommand{\\arraystretch}{1.05}")
    latex.append("    \\resizebox{\\columnwidth}{!}{")
    col_fmt = "l" + "c" * len(pivot.columns)
    latex.append(f"    \\begin{{tabular}}{{{col_fmt}}}")
    latex.append("        \\toprule")

    header_cells = ["\\textbf{Test Name}"] + [f"\\textbf{{{split_gemm_size(c)}}}" for c in pivot.columns]
    latex.append("        " + " & ".join(header_cells) + " \\\\")
    latex.append("        \\midrule")

    for test_name, row in pivot.iterrows():
        formatted_values = []
        for v in row:
            if fmt == "int":
                formatted_values.append(f"{int(round(v))}")
            elif fmt == ".2f":
                formatted_values.append(f"{v:.2f}")
            else:
                formatted_values.append(f"{v:.2f}")
        latex.append(f"        {test_name} & " + " & ".join(formatted_values) + " \\\\")

    latex.append("        \\bottomrule")
    latex.append("    \\end{tabular}")
    latex.append("    }")
    latex.append("")
    latex.append(f"    \\vspace{{2pt}}\\scriptsize{{Values in {unit}.}}")
    latex.append("\\end{table}")
    latex.append("")
    return "\n".join(latex)

def main():
    parser = argparse.ArgumentParser(description="Generate LaTeX tables for latency, energy, and power.")
    parser.add_argument("--input", type=str, required=True, help="Path to merged_results.csv")
    args = parser.parse_args()

    df = pd.read_csv(args.input)
    # Convert latency to ms
    df["Latency (ms/iter)"] = (df["Total Runtime (s)"] / 1000) * 1000  # per iteration, in ms
    df["Energy (J/iter)"] = df["Total Energy (J)"] / 1000
    df["Power (W)"] = df["Average Power (W)"]

    latency_tex = make_matrix_table(df, "Latency (ms/iter)",
                                    "Average Latency per Iteration",
                                    "latency_matrix", "milliseconds", ".2f")

    energy_tex = make_matrix_table(df, "Energy (J/iter)",
                                   "Average Energy per Iteration",
                                   "energy_matrix", "joules", ".2f")

    power_tex = make_matrix_table(df, "Power (W)",
                                  "Average Power Consumption",
                                  "power_matrix", "watts", "int")

    with open("gpu_metrics.tex", "w") as f:
        f.write("% Auto-generated LaTeX tables with proper units and formatting\n\n")
        f.write(latency_tex + "\n")
        f.write(energy_tex + "\n")
        f.write(power_tex + "\n")

    print("✅ Generated gpu_metrics.tex")

if __name__ == "__main__":
    main()
