using Microsoft.AspNetCore.SignalR;

namespace FlutterSignalR.Hubs
{
    public class Contador:Hub
    {
        public async Task ContadorViewFromServer(int number)
        {
            await Clients.Others.SendAsync("ReciveNewNumber", number);
            Console.WriteLine($"Recive number from Server app: {number}");
        }
    }
}
