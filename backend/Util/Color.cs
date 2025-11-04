namespace SSEShowcase.Util;

public enum Color
{
  Red,
  Green,
  Blue,
  Yellow
}

public static class ColorExtensions
{
  public static string GetColorName(this Color color)
  {
    return color.ToString().ToLower();
  }
}

