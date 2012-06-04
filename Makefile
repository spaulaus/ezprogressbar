# Windows.
#CXX=cl /D WIN32

.PHONY: html test clean memtest

APP = ezProgressBar
DEVDIR = ezprogressbar-code

all: examples test memtest

clean:
	rm -f example etaExample rateExample test *.exe* *.tmp *.obj

html:
	pygmentize -O full,linenos=1,style=manni -o ezProgressBar.html ezProgressBar.hpp
	pygmentize -O full,linenos=1,style=manni -o ezETAProgressBar.html ezETAProgressBar.hpp
	pygmentize -O full,linenos=1,style=manni -o ezRateProgressBar.html ezRateProgressBar.hpp
	pygmentize -O full,linenos=1,style=manni -o example.html example.cpp
	pygmentize -O full,linenos=1,style=manni -o etaExample.html etaExample.cpp
	pygmentize -O full,linenos=1,style=manni -o rateExample.html rateExample.cpp
	mv *.html html

examples: example.cpp etaExample.cpp rateExample.cpp ezProgressBar.hpp ezETAProgressBar.hpp ezRateProgressBar.hpp
	g++ example.cpp -o example 
	g++ etaExample.cpp -o etaExample
	g++ rateExample.cpp -o rateExample
	./example
	./etaExample
	./rateExample
	
test: test.cpp
	$(CXX) test.cpp -o test;
	./test > test.tmp
	diff test.truth test.tmp
	
memtest:
	valgrind --tool=memcheck --leak-check=full --show-reachable=yes ./example
	valgrind --tool=memcheck --leak-check=full --show-reachable=yes ./etaExample
	valgrind --tool=memcheck --leak-check=full --show-reachable=yes ./rateExample

dist:
  ifndef VER
		@echo "ERROR: VER is not defined. Try: make dist VER=0.1.0"
  else
		cd ..; rm -fr $(APP)-$(VER); mkdir $(APP)-$(VER); rsync --cvs-exclude -a $(DEVDIR)/ $(APP)-$(VER); tar zcvf $(APP)-$(VER).tar.gz $(APP)-$(VER); rm -fr $(APP)-$(VER);
  endif