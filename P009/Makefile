all:\
test-c-gcc test-c-clang\
test-cpp-g++ test-cpp-clang++\
test-java test.class\
test-go\
test-ada\
test_python.pyc test_python_cython.so\
test_numpy.pyc test_numpy_cython.so\
test_cython.so\
test-pascal

test-c-gcc: test.c
	gcc -O3 -o test-c-gcc test.c
test-c-clang: test.c
	clang -O3 -o test-c-clang test.c

test-cpp-g++: test.cpp
	g++ -O3 -o test-cpp-g++ test.cpp
test-cpp-clang++: test.cpp
	clang++ -O3 -o test-cpp-clang++ test.cpp

test-java: test.java
	gcj -O3 --main=test -o test-java test.java
test.class: test.java
	javac test.java

test-go: test.go
	go build -o test-go test.go

test-ada: test.adb
	gnatmake -O3 -o test-ada test.adb

test_python.pyc: test_python.py test-python.py
	python -m py_compile test_python.py
	python -m py_compile test-python.py
test_python_cython.so: test_python_cython.pyx setup_python_cython.py test-python-cython.py
	python setup_python_cython.py build_ext --inplace
	python -m py_compile test-python-cython.py

test_numpy.pyc: test_numpy.py test-numpy.py
	python -m py_compile test_numpy.py
	python -m py_compile test-numpy.py
test_numpy_cython.so: test_numpy_cython.pyx setup_numpy_cython.py test-numpy-cython.py
	python setup_numpy_cython.py build_ext --inplace
	python -m py_compile test-numpy-cython.py

test_cython.so: test_cython.pyx setup_cython.py test-cython.py
	python setup_cython.py build_ext --inplace
	python -m py_compile test-cython.py

test-pascal: test.pas
	fpc -O3 -otest-pascal test.pas

clean:
	rm -f *.o *.so *.pyc
	rm -f test-c-gcc test-c-clang test-cpp-g++ test-cpp-clang++
	rm -f test-java test.class test-go test-ada test.ali
	rm -rf build test_python_cython.c test_numpy_cython.c test_cython.c
	rm -f test-pascal

run_test: all
	echo "-------------------------------------"
	time -p ./test-c-gcc 100
	time -p ./test-c-clang 100
	time -p ./test-cpp-g++ 100
	time -p ./test-cpp-clang++ 100
	time -p ./test-java 100
	time -p java test 100
	time -p ./test-ada 100
	time -p ./test-go 100
	echo "Multiply the test-python.pyc time by 100 for comparison."
	time -p python test-python.pyc 1
	echo "Multiply the test-python-cython.pyc time by 100 for comparison."
	time -p python test-python-cython.pyc 1
	echo "Multiply the test-numpy.pyc time by 100 for comparison."
	time -p python test-numpy.pyc 1
	echo "Multiply the test-numpy-cython.pyc time by 100 for comparison."
	time -p python test-numpy-cython.pyc 1
	time -p python test-cython.pyc 100
	time -p ./test.js 100
	echo "Multiply the test.pl time by 100 for comparison."
	time -p ./test.pl 1
	echo "Multiply the test.rb time by 100 for comparison."
	time -p ./test.rb 1
	time -p ./test-pascal 100
	echo "Multiply the test.lua time by 100 for comparison."
	time -p ./test.lua 1
	echo "Multiply the test.php time by 100 for comparison."
	time -p ./test.php 1
