.PHONY: all test clean so dll

all: test

plus: plus.c
		gcc -o plus plus.c -O3

test: plus.py _plus.so test_plus.py
		python test_plus.py

clean:
		rm -f plus *.o *.so *_wrap.* plus.py

dll: so

so: _plus.so

_plus.so: plus.c plus_wrap.c
		gcc -o _plus.so --shared plus.c plus_wrap.c -I /usr/include/python3.5m -lpython3 -fPIC

plus_wrap.c plus.py: plus.c
		swig -python -module plus plus.c
