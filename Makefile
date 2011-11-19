
# Just remove the -`git part if you want to release.
VERSION = 0.1-`git rev-list --all 2>/dev/null | wc -l | sed -e 's| *||g'`

# Prefixes, pathes and dirnames
DESTDIR ?= 
PREFIX ?= /usr
BINDIR ?= ${PREFIX}/bin

# Real rules.
prtcreate: prtcreate.in
	sed -e "s/#VERSION#/${VERSION}/" prtcreate.in > prtcreate
	chmod +x prtcreate

install: prtcreate
	mkdir -p ${DESTDIR}${BINDIR}
	install -m 0755 prtcreate ${DESTDIR}${BINDIR}/prtcreate

clean:
	rm -f prtcreate

dist:
	mkdir prtcreate-${VERSION}
	cp Makefile prtcreate.in prtcreate-${VERSION}
	tar czf prtcreate-${VERSION}.tar.xz prtcreate-${VERSION}
	# Very few people use/have xz, so a failure in building this tarball 
	#+ is not really important.
	-tar cJf prtcreate-${VERSION}.tar.xz prtcreate-${VERSION}
	rm -rf prtcreate-${VERSION}

