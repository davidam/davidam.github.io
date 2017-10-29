#include <stdio.h>

int
main (void)
{
#ifdef TEST
  printf ("Modo test\n");
#endif
  printf ("Ejecutando...\n");
  return 0;
}
