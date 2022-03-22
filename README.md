# Diskspd-Download-Runner

THis is a PowerShell script which downloads and runs a Microsoft diskspd app for testing purposes.

It runs the following diskspd parameters which creates a 

C:\DISKSPD-Ready\amd64\DiskSpd -t2 -o32 -b4k -r4k -w50 -d120 -Sh -D -L -c1G C:\ProgramData\Kofax\TS\IO.dat > C:\$env:computername-DiskspdResults.txt

-t2: This indicates the number of threads per target/test file. This number is often based on the number of CPU cores. In this case, two threads were used to stress all of the CPU cores.

-o32: This indicates the number of outstanding I/O requests per target per thread. This is also known as the queue depth, and in this case, 32 were used to stress the CPU.

-b4K: This indicates the block size in bytes, KiB, MiB, or GiB. In this case, 4K block size was used to simulate a random I/O test.

-r4K: This indicates the random I/O aligned to the specified size in bytes, KiB, MiB, Gib, or blocks (Overrides the -s parameter). The common 4K byte size was used to properly align with the block size.

-w50: This specifies the percentage of operations that are write requests (-w0 is equivalent to 100% read). In this case, 0% writes were used for the purpose of a simple test.

-d120: This specifies the duration of the test, not including cool-down or warm-up. The default value is 10 seconds, but we recommend using at least 60 seconds for any serious workload. In this case, 120 seconds were used to minimize any outliers.

-Suw: Disables software and hardware write caching (equivalent to -Sh).

-D: Captures IOPS statistics, such as standard deviation, in intervals of milliseconds (per-thread, per-target).

-L: Measures latency statistics.

-c1g: Sets the sample file size used in the test. It can be set in bytes, KiB, MiB, GiB, or blocks. In this case, a 1 GB target file was used.

For a complete list of parameters, refer to the GitHub repository. https://github.com/Microsoft/diskspd/wiki/Command-line-and-parameters
