#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 4000

void initialize_matrix(_Float16 matrix[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matrix[i][j] = (_Float16)rand() / RAND_MAX;
        }
    }
}

void multiply_matrices(_Float16 A[N][N], _Float16 B[N][N], _Float16 C[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main() {
    static _Float16 A[N][N], B[N][N], C[N][N];
    clock_t start, end;
    double cpu_time_used;

    srand(time(NULL));

    initialize_matrix(A);
    initialize_matrix(B);

    start = clock();
    multiply_matrices(A, B, C);
    end = clock();

    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;

    printf("Time taken to multiply matrices: %f seconds\n", cpu_time_used);

    return 0;
}