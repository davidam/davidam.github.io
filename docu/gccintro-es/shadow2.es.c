double
sin_series (double x)
{
  /* series de expansión para x pequeñas */ 
  double sin = x * (1.0 - x * x / 6.0); 
  return sin;
}
