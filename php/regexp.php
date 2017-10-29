<?php

$cadena = "abcdefgabc";

// Devuelve true si "abc" se encuentra en cualquier lugar de $cadena.
if (ereg("abc", $cadena)) 
echo "mi cadena es $cadena y contiene abc <br />";

// Devuelve true si "abc" es encontrado al comienzo de $cadena
if (ereg("^abc", $cadena))
  echo "mi cadena es $cadena y empieza por abc <br />";



// Devuelve true si "abc" es encontrado al final de $cadena.
if (ereg("abc$", $cadena)) {
  echo "mi cadena es $cadena y acaba por abc <br />";
}

// Devuelve true si el navegador del cliente es Netscape 2, 3 or MSIE 3.
if (eregi("(ozilla.[2345]|MSIE.3)", $HTTP_USER_AGENT)) {
  echo "mi navegador es $HTTP_USER_AGENT y es Netscape 2, 3, 4, 5 o MSIE 3.";
} else {
  echo "mi navegador es $HTTP_USER_AGENT";
}
     

// Coloca tres palabras separadas por espacios en $regs[1], $regs[2] y $regs[3].
ereg("([[:alnum:]]+) ([[:alnum:]]+) ([[:alnum:]]+)", $cadena, $regs);

// Coloca una etiqueta <br /> al comienzo de $cadena.
$cadena = ereg_replace("^", "<br />", $cadena);
echo "$cadena"; 

$cadena = ereg_replace("abc", "123", $cadena);
echo "$cadena"; 


// Coloca una etiqueta <br /> al final de $cadena.
$cadena = ereg_replace("$", "<br />", $cadena);
echo "$cadena"; 
// Se deshace de cualquier caracter de salto de linea en $cadena.
$cadena = ereg_replace("\n", "", $cadena);
echo "$cadena"; 

// MAIL

$mail = "usasdfabdfdwnwshter@ gmail.com";

if (!eregi("^[a-z0-9]+([_\\.-][a-z0-9]+)*"
	   ."@([a-z0-9]+([\.-][a-z0-9]{1,})+)*$",
	   $mail, $regs) ) 
{
  echo "Error: '$mail' isn't a valid mail address! <br />\n";
} elseif( gethostbyname($regs[2]) == $regs[2] ) {
  echo "Error: Can't find the host '$regs[2]'!<br />\n";
} else {
  echo "Your mail is valid! <br />";
}


$date = "04/30/1973";  // Los delimitadores pueden ser barras, puntos o guiones
list( $month, $day, $year ) = split( '[/.-]', $date );
echo "Month: $month; Day: $day; Year: $year<br>\n";

?> 