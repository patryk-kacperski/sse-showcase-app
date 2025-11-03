namespace SSEShowcase.Util;

public enum SseEventTypes
{
  Numbers,
  LoremIpsum
}

public static class SseEventTypesExtensions
{
  public static string GetEventName(this SseEventTypes eventType)
  {
    return eventType.ToString().ToLower();
  }
}