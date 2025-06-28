using SSEShowcase.Enums;
using SSEShowcase.Extensions;
using System.Runtime.CompilerServices;

namespace SSEShowcase;

public partial class Program
{
    public static void Main(string[] args)
    {
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

            var random = new Random();

            for (int i = 1; i <= 10; i++)
            {
                if (response.HttpContext.RequestAborted.IsCancellationRequested)
                    break;

                var delay = random.NextDouble() * 1.5 + 0.5; // Random delay between 0.5 and 2.0 seconds
                await Task.Delay(TimeSpan.FromSeconds(delay));

                await response.WriteAsync($"event: {SseEventType.Numbers.ToEventString()}\n");
                await response.WriteAsync($"data: {i}\n\n");
                await response.Body.FlushAsync();
            }
        })
        .WithName("GetNumbers")
        .WithOpenApi();

        app.Run();
    }
}
