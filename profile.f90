module profile
    use, intrinsic :: iso_c_binding
    implicit none
    private
    public :: QueryPerformanceCounter
    public :: QueryPerformanceFrequency

    interface
        !! get the current value of the performance counter.
        function QueryPerformanceCounter(lPerformanceCount_count) result(is_succeeded) &
                                                                  bind(c, name="QueryPerformanceCounter") !&
            use, intrinsic :: iso_c_binding
            implicit none
            integer(c_long_long) :: lPerformanceCount_count
                !! current performance-counter value [count]
            logical(c_bool) :: is_succeeded
                !! nonzero (i.e. .true.) if the function succeeds
        end function QueryPerformanceCounter

        !! get the frequency of the performance counter.
        function QueryPerformanceFrequency(lFrequency_countPerSec) result(is_supported) &
                                                                   bind(c, name="QueryPerformanceFrequency") !&
            use, intrinsic :: iso_c_binding
            implicit none
            integer(c_long_long) :: lFrequency_countPerSec
                !! current performance-counter frequency [count/sec]<br>
                !! nonzero if the hardware running the program supports a high-resolution performance counter.
            logical(c_bool) :: is_supported
                !! nonzero (i.e. .true.) if the hardware supports a high-resolution performance counter
        end function QueryPerformanceFrequency
    end interface
end module profile
