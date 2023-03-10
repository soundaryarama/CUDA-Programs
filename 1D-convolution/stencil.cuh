#ifndef STENCIL_CUH
#define STENCIL_CUH

// Computes the convolution of image and mask, storing the result in output.
// Each thread should compute _one_ element of output.
// Shared memory should be allocated _dynamically_ only.
//
// image is an array of length n of managed memory.
// mask is an array of length (2 * R + 1) of managed memory.
// output is an array of length n of managed memory.
//
// Assumptions:
// - 1D configuration
// - blockDim.x >= 2 * R + 1
//
// The following should be stored/computed in shared memory:
// - The entire mask
// - The elements of image needed to compute the elements of output corresponding to the threads in the given block
// - The output image elements corresponding to the given block before it is written back to global memory
__global__ void stencil_kernel(const float* image, const float* mask, float* output, unsigned int n, unsigned int R);

// Computes the convolution of image and mask, storing the result in output.
// image is an array of length n of managed memory.
// mask is an array of length (2 * R + 1) of managed memory.
// output is an array of length n of managed memory.
// Makes one call to stencil_kernel with threads_per_block threads per block.
// The kernel call should be followed by a call to cudaDeviceSynchronize for timing purposes.
//
// Assumptions:
// - threads_per_block >= 2 * R + 1
__host__ void stencil(const float* image,
                      const float* mask,
                      float* output,
                      unsigned int n,
                      unsigned int R,
                      unsigned int threads_per_block);

#endif
