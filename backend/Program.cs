using SSEShowcase.Util;

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

app.Run();
