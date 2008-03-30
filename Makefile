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
	/bin/rm -fr *~ $(program).1 $(program).1* || true

.PHONY: tar
tar:
	tar cvvzf dugroup-`date +%Y-%m-%d`.tar.gz \
		--transform='s:^\.:dugroup:' \
		--show-transformed-names \
		* \
		--exclude=MyMakefile \
		--exclude=.svn \
		--exclude=test \
		--exclude=CVS \
                --exclude='#*#' \
                --exclude='.#*' \
                --exclude='.cvsignore' \
                --exclude='*~' \
                --exclude='.*~' \
		--exclude='*.o' \
		--exclude='*.d' \
		--exclude='.deps' \
		--exclude='*.1.*' \
		--exclude=TAGS \
		--exclude='*.tar.gz' \
		--exclude='*.tmp' \
		--exclude '*.log'

# generate man page(s)
%.1: %.pod Makefile
	pod2man --center=' ' $< $@
	mv $@ .$@

%.1.tex: %.pod Makefile
	pod2latex -full -out $@ $<
%.dvi: %.tex Makefile
	latex $<
%.ps: %.dvi Makefile
	dvips -tletter $<
%.1.txt: %.pod Makefile
	pod2text $< $@.
	mv $@. $@
%.1.html: %.pod Makefile
	pod2html $< > $@.
	mv $@. $@

-include MyMakefile

