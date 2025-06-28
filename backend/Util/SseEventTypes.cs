namespace SSEShowcase.Util;

public enum SseEventTypes
{
  Numbers
}

public static class SseEventTypesExtensions
{
  public static string GetEventName(this SseEventTypes eventType)
  {
    return eventType.ToString().ToLower();
  }
}