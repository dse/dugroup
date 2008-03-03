.PHONY: install stow-install clean

program = dugroup
prefix  = /usr/local
stow    = $(prefix)/stow/$(program)

stow-install:
	mkdir -p -m 0755 $(stow)
	make install prefix=$(stow)
	(cd "`dirname $(stow)`" && stow $(program))

install: $(program).1
	install -d -m 0755           $(prefix)/bin
	install -d -m 0755           $(prefix)/share/man/man1
	install -m 0755 $(program)   $(prefix)/bin
	install -m 0644 $(program).1 $(prefix)/share/man/man1

clean:
	/bin/rm *~ $(program).1

# generate man page(s)
%.1: %.pod Makefile
	pod2man --center=' ' $< $@

-include MyMakefile

