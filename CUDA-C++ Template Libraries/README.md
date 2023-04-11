# thrust and cub

Thrust is a parallel algorithms library which resembles the Standard Template Library (STL) in C++. The reduce feature in thrust is used in this code to compute the sum of all elements in the range [first, last).

Cub is another library like thrust. The DeviceReduce::Sum feature is used to compute the sum of the numbers given as input. 


The plot below tells the time taken to print the result vs the size of the input array (2<sup>10 </sup>, 2<sup>11 </sup>......2<sup>30 </sup>)

![image](https://user-images.githubusercontent.com/113553039/231063679-6678bd8d-07fb-4ac8-8c1b-02c11fa9d463.png)


