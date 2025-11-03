using SSEShowcase.Util;

const string LoremIpsumText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin id turpis semper, euismod nisi ut, viverra sapien. Proin imperdiet, ligula eget gravida ullamcorper, orci elit eleifend ante, vel dictum leo magna sit amet dolor. Etiam quis gravida diam, vel scelerisque purus. Nunc et fermentum nisi, sit amet convallis elit. Etiam convallis sagittis pretium. Nullam sit amet lacinia eros. Cras hendrerit lobortis augue, sed tempor justo ullamcorper quis. Duis imperdiet ante sed lobortis efficitur. Duis at hendrerit est, commodo hendrerit ipsum. Quisque metus purus, bibendum in hendrerit vel, ornare eu sem. Fusce in lobortis augue. Curabitur ultricies nunc id neque interdum sollicitudin.\n\nProin et ipsum eu lectus mattis sollicitudin. Phasellus vel gravida lacus. Praesent a condimentum felis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam eget eros sed libero egestas dignissim eu vitae enim. Donec ullamcorper metus nec lacus convallis, sed mollis sapien ultricies. Sed rhoncus, augue vel vehicula tempus, nisi mauris efficitur quam, vel fringilla orci quam porta justo. In vel felis elit.";

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add CORS services
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend", policy =>
    {
        policy.WithOrigins(
                "http://localhost:3000" // Flutter web dev server
              )
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Enable CORS
app.UseCors("AllowFrontend");

app.MapGet("/numbers", async (HttpResponse response) =>
{
    response.Headers.Append("Content-Type", "text/event-stream");
    response.Headers.Append("Cache-Control", "no-cache");
    response.Headers.Append("Connection", "keep-alive");

    var random = new Random();
    var eventType = SseEventTypes.Numbers;
    var eventName = eventType.GetEventName();

    for (int i = 1; i <= 10; i++)
    {
        var data = $"event: {eventName}\ndata: {i}\n\n";
        await response.WriteAsync(data);
        await response.Body.FlushAsync();

        var delay = random.NextDouble() * 1.5 + 0.5;
        await Task.Delay(TimeSpan.FromSeconds(delay));
    }
})
.WithName("GetNumbers")
.WithOpenApi();

app.MapGet("/text-stream", async (HttpResponse response) =>
{
    response.Headers.Append("Content-Type", "text/event-stream");
    response.Headers.Append("Cache-Control", "no-cache");
    response.Headers.Append("Connection", "keep-alive");

    var random = new Random();
    var eventType = SseEventTypes.LoremIpsum;
    var eventName = eventType.GetEventName();

    int totalLength = LoremIpsumText.Length;
    int charactersSent = 0;
    int charactersRemaining = totalLength;

    while (charactersSent < totalLength)
    {
        int chunkSize = Math.Min(random.Next(1, 5), charactersRemaining);

        var chunk = LoremIpsumText.Substring(charactersSent, chunkSize);
        charactersSent += chunkSize;
        charactersRemaining = totalLength - charactersSent;

        var jsonData = System.Text.Json.JsonSerializer.Serialize(new
        {
            chunk = chunk,
            characters_sent = charactersSent,
            characters_remaining = charactersRemaining
        });

        var data = $"event: {eventName}\ndata: {jsonData}\n\n";
        await response.WriteAsync(data);
        await response.Body.FlushAsync();

        if (charactersSent < totalLength)
        {
            var delay = random.NextDouble() * 0.2 + 0.1;
            await Task.Delay(TimeSpan.FromSeconds(delay));
        }
    }
})
.WithName("GetTextStream")
.WithOpenApi();

app.Run();
