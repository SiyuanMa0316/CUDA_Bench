#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 4000

void initialize_matrix(float matrix[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matrix[i][j] = (float)rand() / RAND_MAX;
        }
    }
}

void multiply_matrices(float A[N][N], float B[N][N], float C[N][N]) {
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
    static float A[N][N], B[N][N], C[N][N];
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