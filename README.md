# fortran time measurement

## compilers

|compiler|version|
|:--|:--|
|Intel Parallel Studio XE Composer Edition for Fortran|17.0.4.210|
|PGI Visual Fortran for Windows|18.7|
|GNU gfortran|7.3.0 (for Ubuntu on WSL)|


## compiler options
|compiler|options|
|:--|:--|
|Intel|`/O2 /Qopenmp`|
|PGI|`-mp -fast -tp=px`|
|GNU|`-fopenmp -Ofast`|

## results

|compiler|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|:--|
|Intel|`system_clock` |0.113|0.069|0.048|
|     |`cpu_time`     |0.109|0.115|0.109|
|     |`date_and_time`|0.114|0.060|0.029|
|     |`omp_get_wtime`|0.112|0.057|0.027|
|PGI  |`system_clock` |0.112|0.063|0.050|
|     |`cpu_time`     |0.111|0.057|0.028|
|     |`date_and_time`|0.112|0.057|0.028|
|     |`omp_get_wtime`|0.111|0.057|0.028|
|GNU  |`system_clock` |0.113|0.063|0.045|
|     |`cpu_time`     |0.109|0.094|0.031|
|     |`date_and_time`|0.113|0.058|0.029|
|     |`omp_get_wtime`|0.113|0.057|0.028|
