var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapGet("/numbers", async (HttpResponse response) =>
{
    response.Headers.Add("Content-Type", "text/event-stream");
    response.Headers.Add("Cache-Control", "no-cache");
    response.Headers.Add("Connection", "keep-alive");

    while (!response.HttpContext.RequestAborted.IsCancellationRequested)
    {
        await response.WriteAsync(":\n\n");
        await response.Body.FlushAsync();
        await Task.Delay(5000);
    }
})
.WithName("GetNumbers")
.WithOpenApi();

app.Run();
