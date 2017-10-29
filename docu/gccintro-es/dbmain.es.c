#include <stdio.h>
#include <gdbm.h>

int
main (void)
{
  GDBM_FILE dbf;
  datum key = { "clavetest", 7 };   /* clave, tamaño */
  datum value = { "valortest", 9 }; /* valor, tamaño */

  printf ("Almacenado el par clave-valor... ");
  dbf = gdbm_open ("test", 0, GDBM_NEWDB, 0644, 0);
  gdbm_store (dbf, key, value, GDBM_INSERT);
  gdbm_close (dbf);
  printf ("hecho.\n");
  return 0;
}
