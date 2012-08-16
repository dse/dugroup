# dugroup

dugroup(1) is a program that takes the output of the Unix utility
du(1) and, for each directory containing listed files, collects
certain classes of files (such as backup files or images) together
into groups.  For each group of files, dugroup(1) outputs its
collective disk space utilization as a fake subdirectory, and also
lists its constituent files individually under that fake subdirectory.

dugroup(1) is typically executed as the middle of a pipeline between
du(1) [typically invoked with the -a option] and a disk space
utilization display program such as xdu(1) or tdu(1).

dugroup(1) was written as a companion program to tdu(1), but you
should be able to use it with any program that accepts the output of
du(1).

# More Information

The web site: http://webonastick.com/dugroup/

# Source Code

The github: https://github.com/dse/dugroup/

# See Also

tdu:
- http://webonastick.com/tdu/
- https://github.com/dse/tdu/

