#include <stdio.h>

FILE *stream = stdout;/* no es constante */
int i = 10;
int j = 2 * i;        /* no es constante */

int
main (void)
{
  fprintf (stream, "¡Hola Mundo!\n");
  return 0;
}
