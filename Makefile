all: pre clean build post
	@echo ALL tasks complete!
pre:
	@echo Welcome to makefile exercise
post:
	@echo Leaving the Make
build: clean
	@echo Rinning Build task
	@mkdir build
	@javac -d build -cp build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar src/main/java/*.java src/test/java/*.java
	@if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi

run: build
	@echo "Running application..."
	@java -cp build RunEdgeConvert

test: build
	@echo "Running unit tests..."
	@java -cp build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore EdgeConnectorTest
	@if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

jar: build
	@echo Building executable Jar
	@rm -rf target
	@mkdir target
	@jar cfev target/EdgeConvert.jar RunEdgeConvert -C build .

clean: pre 
	@echo Rinning Clean task
	@rm -rf ./build