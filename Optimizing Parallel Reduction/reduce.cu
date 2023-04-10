#include <cuda.h>
#include <stdio.h>
#include "reduce.cuh"

__global__ void reduce_kernel(float *g_idata, float *g_odata, unsigned int n){
    extern __shared__ int sdata[];
    unsigned int tid = threadIdx.x;
    unsigned int i   = blockIdx.x*(blockDim.x) + threadIdx.x;
    if (i >= n) {
        sdata[tid] = 0;
    } else {
        sdata[tid] = g_idata[i];
    }

    __syncthreads();

      for (unsigned int s=blockDim.x/2; s>0; s>>=1) {
    if (tid < s) {
        sdata[tid] += sdata[tid + s];
    }
    __syncthreads();
    }

    if (tid == 0) g_odata[blockIdx.x] = sdata[0];

}

__host__ int reduce(const int* arr, unsigned int N, unsigned int threads_per_block) {
    int *g_idata;
    int *g_odata;
    using namespace std;
    cudaMalloc(&g_idata, N * sizeof(int));

    cudaMemcpy(g_idata, arr, N * sizeof(int), cudaMemcpyHostToDevice);

    for (int l = N; l > 1; l = (l + threads_per_block - 1) / threads_per_block) {
        int block_num = (l + threads_per_block - 1) / threads_per_block;
        cudaMalloc(&g_odata, block_num * sizeof(int));
        reduce_kernel<<<block_num, threads_per_block, threads_per_block * sizeof(int) >>>(g_idata, g_odata, l);


        cudaMemcpy(g_idata, g_odata, block_num * sizeof(int), cudaMemcpyDeviceToDevice);

    }

    cudaDeviceSynchronize();
    
    cudaFree(g_odata);
    cudaFree(g_idata);

    int result;
    cudaMemcpy(&result, g_odata, sizeof(int), cudaMemcpyDeviceToHost);

    return result;
}
