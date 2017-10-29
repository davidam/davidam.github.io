#
#
po4a-translate -f texinfo -m gccintro.texi -p gccintro.es.po -l gccintro.es.texi -k 0.15
#
texi2pdf gccintro.es.texi 
#
rm -f gccintro.es.aux
rm -f gccintro.es.cp
rm -f gccintro.es.cps
rm -f gccintro.es.fn
rm -f gccintro.es.ky
rm -f gccintro.es.pg
rm -f gccintro.es.toc
rm -f gccintro.es.tp
rm -f gccintro.es.vr
# 
