int
foo (unsigned int x)
{
  if (x < 0)
    return 0;  /* no puede ocurrir */
  else
    return 1;
}
