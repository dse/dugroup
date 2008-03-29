program = dugroup
prefix  = /usr/local

.PHONY: all
all: $(program).1

.PHONY: install
install: $(program).1
	install -d -m 0755           $(prefix)/bin
	install -d -m 0755           $(prefix)/share/man/man1
	install -m 0755 $(program)   $(prefix)/bin
	install -m 0644 $(program).1 $(prefix)/share/man/man1

.PHONY: clean
clean:
	/bin/rm *~ $(program).1

.PHONY: tar
tar:
	tar cvvzf dugroup-`date +%Y-%m-%d`.tar.gz \
		--transform='s:^\.:dugroup:' \
		--show-transformed-names \
		. \
		--exclude=MyMakefile \
		--exclude=.svn \
		--exclude=test \
		--exclude=CVS \
                --exclude='#*#' \
                --exclude='.#*' \
                --exclude='.cvsignore' \
                --exclude='*~' \
                --exclude='.*~' \
		--exclude='tdu/tdu' \
		--exclude='*.o' \
		--exclude='*.d' \
		--exclude='.deps' \
		--exclude='tdu.1.*' \
		--exclude=tdu \
		--exclude=TAGS \
		--exclude='*.tar.gz'

# generate man page(s)
%.1: %.pod Makefile
	pod2man --center=' ' $< $@
	mv $@ .$@

%.1.txt: %.pod Makefile
	pod2text $< $@.
	mv $@. $@

%.1.html: %.pod Makefile
	pod2html $< $@.
	mv $@. $@

-include MyMakefile

