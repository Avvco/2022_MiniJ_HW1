1. make clean
-- remove all derived files

2. make mjparse
-- build executable for HW#1

3. ./mjparse test1.mj
-- test run with test1.mj
-- need to run with test2.mj and test3.mj

4. docker run -it --rm -v $(pwd):/tmp -w /tmp knordman/bison-flex-builder
