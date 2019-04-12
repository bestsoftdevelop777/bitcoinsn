#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINSND=${BITCOINSND:-$BINDIR/bitcoinsnd}
BITCOINSNCLI=${BITCOINSNCLI:-$BINDIR/bitcoinsn-cli}
BITCOINSNTX=${BITCOINSNTX:-$BINDIR/bitcoinsn-tx}
BITCOINSNQT=${BITCOINSNQT:-$BINDIR/qt/bitcoinsn-qt}

[ ! -x $BITCOINSND ] && echo "$BITCOINSND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BSNVER=($($BITCOINSNCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoinsnd if --version-string is not set,
# but has different outcomes for bitcoinsn-qt and bitcoinsn-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINSND --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINSND $BITCOINSNCLI $BITCOINSNTX $BITCOINSNQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BSNVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BSNVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
