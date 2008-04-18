program = dugroup
prefix  = /usr/local

.PHONY: all
all:

.PHONY: install
install:
	install -d -m 0755           $(prefix)/bin
	install -d -m 0755           $(prefix)/share/man/man1
	install -m 0755 $(program)   $(prefix)/bin
	install -m 0644 $(program).1 $(prefix)/share/man/man1

.PHONY: clean
clean:
	/bin/rm -fr *~ $(program).1.* || true

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
		--exclude='*.log'

%.1.txt: %.1 Makefile
	nroff -man $< | col -bx > $@.
	mv $@. $@
%.1.ps: %.1 Makefile
	groff -Tps -man $< >$@.
	mv $@. $@
%.1.html: %.1 Makefile
	groff -Thtml -man $< >$@.
	mv $@. $@
%.pdf: %.ps Makefile
	ps2pdf $< $@.
	mv $@. $@

-include MyMakefile

