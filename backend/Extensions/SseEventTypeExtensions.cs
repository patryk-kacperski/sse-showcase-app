using SSEShowcase.Enums;

namespace SSEShowcase.Extensions;

public static class SseEventTypeExtensions
{
  public static string ToEventString(this SseEventType eventType)
  {
    return eventType.ToString().ToLowerInvariant();
  }
}