#include <stdio.h>

int
main (void)
{
  int i = 0;
  if (i = 1) {  /* = debería ser == */
    printf ("resultado inesperado\n");
  }
  return 0;
}
