<?php
$valor = 'algo desde algun lugar';

setcookie("CookieDePrueba", $valor);
setcookie("CookieDePrueba", $valor, time()+3600);  /* expirar en 1 hora */
setcookie("CookieDePrueba", $valor, time()+3600, "/~rasmus/", ".example.com", 1);
?> 