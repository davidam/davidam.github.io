#!/bin/sh
# Éste script reemplaza acentos por acutes y otros caracteres especiales por su equivalente en XML/HTML usando sed
#
# GeoX & Léndir
#
tmp="/tmp/xmltemporal"
clear
echo "Cambiando acentos por acutes ..."
sed -e 's/\&aacute;/á/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&eacute;/é/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&iacute;/í/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&oacute;/ó/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&uacute;/ú/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Aacute;/Á/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Eacute;/É/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Iacute;/Í/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Oacute;/Ó/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Uacute;/Ú/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&ntilde;/ñ/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Ntilde;/Ñ/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&uuml;/ü/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&Uuml;/Ü/g' $1 > $tmp && cp $tmp $1
sed -e 's/\&iquest;/¿/g' $1 > $tmp && cp $tmp $1 && rm /tmp/xmltemporal
