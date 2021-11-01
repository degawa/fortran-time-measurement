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

## using QueryPerformanceCounter on Windows

### compiler
|compiler|version|
|:--|:--|
|Intel OneAPI|2021.1|

### compiler options
`/O2 /Qopenmp /fpp`

### interface

```Fortran
    interface
        !! get the current value of the performance counter.
        function QueryPerformanceCounter(lPerformanceCount_count) result(is_succeeded) &
                                                                  bind(c, name="QueryPerformanceCounter")
            use, intrinsic :: iso_c_binding
            implicit none
            integer(c_long_long) :: lPerformanceCount_count
                !! current performance-counter value [count]
            logical(c_bool) :: is_succeeded
                !! nonzero (i.e. .true.) if the function succeeds
        end function QueryPerformanceCounter

        !! get the frequency of the performance counter.
        function QueryPerformanceFrequency(lFrequency_countPerSec) result(is_supported) &
                                                                   bind(c, name="QueryPerformanceFrequency")
            use, intrinsic :: iso_c_binding
            implicit none
            integer(c_long_long) :: lFrequency_countPerSec
                !! current performance-counter frequency [count/sec]<br>
                !! nonzero if the hardware running the program supports a high-resolution performance counter.
            logical(c_bool) :: is_supported
                !! nonzero (i.e. .true.) if the hardware supports a high-resolution performance counter
        end function QueryPerformanceFrequency
    end interface
```

### results

The benchmark was run on a computer different from the one that ran the benchmark in the table above.

#### average
|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|
|`system_clock`           |0.1206000 |0.0668000 |0.0486000 |
|`cpu_time`               |0.1250000 |0.1218750 |0.1156250 |
|`date_and_time`          |0.1228000 |0.0636000 |0.0312000 |
|`omp_get_wtime`          |0.1215305 |0.0630220 |0.0306592 |
|`QueryPerformanceCounter`|0.1225477 |0.0632070 |0.0307012 |

#### run 1
|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|
|`system_clock`           |0.1210000 |0.0670000 |0.0580000 |
|`cpu_time`               |0.1250000 |0.1250000 |0.1093750 |
|`date_and_time`          |0.1230000 |0.0640000 |0.0310000 |
|`omp_get_wtime`          |0.1207541 |0.0637126 |0.0313544 |
|`QueryPerformanceCounter`|0.1213031 |0.0639479 |0.0307539 |

### run 2
|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|
|`system_clock`           |0.1210000 |0.0670000 |0.0460000 |
|`cpu_time`               |0.1250000 |0.1093750 |0.1250000 |
|`date_and_time`          |0.1230000 |0.0640000 |0.0300000 |
|`omp_get_wtime`          |0.1218192 |0.0626389 |0.0303834 |
|`QueryPerformanceCounter`|0.1245900 |0.0634314 |0.0321276 |

### run 3
|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|
|`system_clock`           |0.1210000 |0.0670000 |0.0470000 |
|`cpu_time`               |0.1250000 |0.1250000 |0.1093750 |
|`date_and_time`          |0.1210000 |0.0630000 |0.0310000 |
|`omp_get_wtime`          |0.1215437 |0.0627777 |0.0300892 |
|`QueryPerformanceCounter`|0.1215240 |0.0620971 |0.0307394 |

### run 4
|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|
|`system_clock`           |0.1200000  |0.0660000 |0.0460000 |
|`cpu_time`               |0.1250000  |0.1250000 |0.1250000 |
|`date_and_time`          |0.1230000  |0.0630000 |0.0310000 |
|`omp_get_wtime`          |0.1217981  |0.0629676 |0.0299242 |
|`QueryPerformanceCounter`|0.1223847  |0.0627128 |0.0300906 |


### run 5
|subroutine|execution time [s]<br>1 thread|<br>2 threads|<br>4 threads|
|:--|:--|:--|:--|
|`system_clock`           |0.1200000 |0.0670000 |0.0460000 |
|`cpu_time`               |0.1250000 |0.1250000 |0.1093750 |
|`date_and_time`          |0.1240000 |0.0640000 |0.0310000 |
|`omp_get_wtime`          |0.1217372 |0.0630133 |0.0298754 |
|`QueryPerformanceCounter`|0.1229365 |0.0638458 |0.0297715 |
