
<html>
<body>
<?php

function hanoi($x) {
  if ($x <= 0) {
    return 0;
  } elseif ($x == 1) {
    return 1;
  } else {
    return 1 + 2 * hanoi($x - 1);
  }
}

echo hanoi($_POST['numero']);

?>

<p>Escribe un n&uacute;mero de discos y te damos el n&uacute;mero de pasos para mover torres de hanoi (<a href="../viejas-ideas-divertidas.html">ver juego</a>):
<form action="hanoi.php" method=post>
<input type=text name=numero></input>
<input type=submit>
</form>
</body>
</html>