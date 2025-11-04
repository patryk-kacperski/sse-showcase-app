namespace SSEShowcase.Util;

public enum Shape
{
  Circle,
  Triangle,
  Square,
  Hexagon
}

public static class ShapeExtensions
{
  public static string GetShapeName(this Shape shape)
  {
    return shape.ToString().ToLower();
  }
}

