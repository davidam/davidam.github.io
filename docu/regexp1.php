<?php
$cadena = 'Abril 15, 2003';
$patron = '/(\w+) (\d+), (\d+)/i';
$sustitucion = '${1}1,$3';
echo preg_replace($patron, $sustitucion, $cadena);
?>