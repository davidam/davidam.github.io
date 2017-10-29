#include <stdio.h>

void 
set_fpu (unsigned int mode)
{
  asm ("fldcw %0" : : "m" (*&mode));
}

int
main (void)
{
  double a = 3.0, b = 7.0, c;
#ifdef DOUBLE       /* Activación de uso */
  set_fpu (0x27F);  /* de redondeo en */
#endif              /* doble precisión */
  c = a / b;

  if (c == a / b) {
    printf ("comparación exitosa\n");
  } else {
    printf ("resultado inesperado\n");
  }
  return 0;
}
