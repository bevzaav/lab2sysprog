#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 1024
#endif

static double A[N][N], B[N][N], C[N][N];

static __attribute__((noinline)) void init_matrices(void)
{
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            A[i][j] = (i + j) % 7 + 1;
            B[i][j] = (i * j) % 5 + 1;
            C[i][j] = 0.0;
        }
}

#ifdef OPTIMIZED
static __attribute__((noinline)) void matmul(void)
{
    for (int i = 0; i < N; i++)
        for (int k = 0; k < N; k++) {
            double a = A[i][k];
            for (int j = 0; j < N; j++)
                C[i][j] += a * B[k][j];
        }
}
#else
static __attribute__((noinline)) void matmul(void)
{
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                C[i][j] += A[i][k] * B[k][j];
}
#endif

static __attribute__((noinline)) double checksum(void)
{
    double s = 0.0;
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            s += C[i][j];
    return s;
}

int main(int argc, char **argv)
{
    int repeat = argc > 1 ? atoi(argv[1]) : 1;
    init_matrices();
    for (int r = 0; r < repeat; r++)
        matmul();
    printf("checksum=%.0f\n", checksum());
    return 0;
}
