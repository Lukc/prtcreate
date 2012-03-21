
VERSION = 0.1

# Prefixes, pathes and dirnames
DESTDIR ?= 
PREFIX ?= /usr
BINDIR ?= ${PREFIX}/bin
SYSCONFDIR ?= /etc

# Real rules.
prtcreate: prtcreate.in
	sed -e "s/#VERSION#/${VERSION}/" \
	    -e "s|#SYSCONFDIR#|${SYSCONFDIR}|" \
		prtcreate.in > prtcreate
	chmod +x prtcreate

install: prtcreate install-recipes install-dirs
	install -m 0755 prtcreate ${DESTDIR}${BINDIR}/prtcreate

install-recipes: install-dirs
	install -m 0644 default_recipe ${DESTDIR}${SYSCONFDIR}/prtcreate/default_recipe
	cp -r pkgfiles ${DESTDIR}${SYSCONFDIR}/prtcreate/
	mkdir -p ${DESTDIR}${SYSCONFDIR}/prtcreate/pkgfiles

install-dirs:
	mkdir -p ${DESTDIR}${BINDIR}
	mkdir -p ${DESTDIR}${SYSCONFDIR}/prtcreate

clean:
	rm -f prtcreate

dist: clean
	mkdir prtcreate-${VERSION}
	cp -r Makefile prtcreate.in default_recipe pkgfiles prtcreate-${VERSION}
	tar czf prtcreate-${VERSION}.tar.gz prtcreate-${VERSION}
	tar czf prtcreate-${VERSION}.tar.bz2 prtcreate-${VERSION}
	# Very few people use/have xz, so a failure in building this tarball 
	#+ is not really important.
	-tar cJf prtcreate-${VERSION}.tar.xz prtcreate-${VERSION}
	rm -rf prtcreate-${VERSION}

