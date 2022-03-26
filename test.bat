docker run -it --rm -v %cd%:/tmp -w /tmp knordman/bison-flex-builder ./mjparse.exe test1.mj
docker run -it --rm -v %cd%:/tmp -w /tmp knordman/bison-flex-builder ./mjparse.exe test2.mj
docker run -it --rm -v %cd%:/tmp -w /tmp knordman/bison-flex-builder ./mjparse.exe test3.mj
PAUSE