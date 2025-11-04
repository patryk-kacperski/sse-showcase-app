namespace SSEShowcase.Util;

public enum SseEventTypes
{
  Numbers,
  LoremIpsum,
  ChangeShape,
  ChangeColor
}

public static class SseEventTypesExtensions
{
  public static string GetEventName(this SseEventTypes eventType)
  {
    return eventType switch
    {
      SseEventTypes.Numbers => "numbers",
      SseEventTypes.LoremIpsum => "lorem_ipsum",
      SseEventTypes.ChangeShape => "change_shape",
      SseEventTypes.ChangeColor => "change_color",
      _ => eventType.ToString().ToLower()
    };
  }
}