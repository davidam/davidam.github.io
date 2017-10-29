<?php
$a = "&iexcl;Hola ";
$b = $a . "Mundo!"; // ahora $b contiene "&iexcl;Hola Mundo!"
echo "b es $b <br />";
$a = "&iexcl;Hola ";
$a .= "Mundo!";    // ahora $a contiene "&iexcl;Hola Mundo!"
echo "a es $a <br />";

?> 