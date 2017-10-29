char *
f (const char *s)
{
  *s = '\0'; /* asigna dato en modo solo */
  return s; /* lectura descartando const */
}
