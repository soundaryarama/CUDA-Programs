# Optimizing Parallel Reduction

Assuming we have really huge arrays like 2<sup>10 </sup> or more entries, a tree-based approach is used within each block of threads to sum all entries in such an array. 
  
  
  ![image](https://user-images.githubusercontent.com/113553039/230997372-6447ac6c-4300-484a-9608-ebcea062162d.png)

  
  Multiple thread blocks reduce a chunk of the given array to one single value. To synchronize these thread blocks, multiple kernel launches are used here. 
  
  
