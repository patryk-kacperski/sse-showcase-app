namespace SSEShowcase.Util;

public enum Intensity
{
  Low,
  Medium,
  High
}

public static class IntensityExtensions
{
  public static string GetIntensityName(this Intensity intensity)
  {
    return intensity.ToString().ToLower();
  }
}

