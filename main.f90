program main
    use,intrinsic :: iso_c_binding
    use,intrinsic :: iso_fortran_env
    use :: profile
    !$ use omp_lib
    implicit none

     enum, bind(c)
        enumerator :: Year = 1
        enumerator :: Month
        enumerator :: Day
        enumerator :: TimeDifference_min
        enumerator :: Hour
        enumerator :: Minute
        enumerator :: Second
        enumerator :: Millisecond
    end enum

    integer(int32),parameter :: N = 2**13
    real(real64),allocatable :: a(:,:),b(:,:),c(:,:)
    integer(int32) :: i,j

    integer(int64) :: time_begin_c,time_end_c,count_per_sec
    real(real32)   :: time_begin_s,time_end_s
    !$ real(real64)   :: time_begin_ws,time_end_ws     ! w (means wall-clock time) is added to avoid name conflict
    integer :: time_begin_values(8),time_end_values(8) ! integer with default kind
    real(real32),parameter :: to_second = 1e-3

    integer(c_long_long) :: time_begin_qhc, time_end_qhc, freq
    logical(c_bool) :: is_supproted, is_succeeded

    allocate(a(N,N))
    allocate(b(N,N))
    allocate(c(N,N))

    ! set number of threads
    !$ call omp_set_num_threads(4)

    !$omp parallel
    ! initialize arrays
    !$omp do
    do j = 1,N
    do i = 1,N
        a(i,j) = 1._real64
        b(i,j) = 2._real64
        c(i,j) = 0._real64
    end do
    end do
    !$omp end do

    ! system_clock
    !$omp master
    call system_clock(time_begin_c)
    !$omp end master
    !$omp do
    do j = 1,N
    do i = 1,N
        c(i,j) = a(i,j) + b(i,j)
    end do
    end do
    !$omp end do
    !$omp master
    call system_clock(time_end_c,count_per_sec)
    print *,real(time_end_c - time_begin_c)/count_per_sec,"sec",sum(c)/N**2
    !$omp end master

    ! cpu_time
    !$omp master
    call cpu_time(time_begin_s)
    !$omp end master
    !$omp do
    do j = 1,N
    do i = 1,N
        c(i,j) = a(i,j) + b(i,j)
    end do
    end do
    !$omp end do
    !$omp master
    call cpu_time(time_end_s)
    print *,time_end_s - time_begin_s,"sec",sum(c)/N**2
    !$omp end master

    ! date_and_time
    !$omp master
    call date_and_time(values = time_begin_values)
    !$omp end master
    !$omp do
    do j = 1,N
    do i = 1,N
        c(i,j) = a(i,j) + b(i,j)
    end do
    end do
    !$omp end do
    !$omp master
    call date_and_time(values = time_end_values)
    print *,time_end_values(     Second)-time_begin_values(     Second) &
          +(time_end_values(Millisecond)-time_begin_values(Millisecond))*to_second,"sec",sum(c)/N**2
    !$omp end master

    ! omp_get_wtime
    !$omp master
    !$ time_begin_ws = omp_get_wtime()
    !$omp end master
    !$omp do
    do j = 1,N
    do i = 1,N
        c(i,j) = a(i,j) + b(i,j)
    end do
    end do
    !$omp end do
    !$omp master
    !$ time_end_ws = omp_get_wtime()
    !$ print *,real(time_end_ws - time_begin_ws,real32),"sec",sum(c)/N**2
    !$omp end master

#ifdef _WIN32 || _WIN64
    ! query performance counter
    is_supproted = QueryPerformanceFrequency(freq)
    if(is_supproted)then
        !$omp master
        is_succeeded = QueryPerformanceCounter(time_begin_qhc)
        !$omp end master
        !$omp do
        do j = 1,N
        do i = 1,N
            c(i,j) = a(i,j) + b(i,j)
        end do
        end do
        !$omp end do
        !$omp master
        is_succeeded = QueryPerformanceCounter(time_end_qhc)
        print *,real(time_end_qhc - time_begin_qhc,real32)/real(freq,real32), "sec", sum(c)/N**2
        !$omp end master
    end if
#endif

    !$omp end parallel

    deallocate(a)
    deallocate(b)
    deallocate(c)
end program main
