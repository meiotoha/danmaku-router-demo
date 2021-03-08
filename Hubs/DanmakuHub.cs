using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace DanmakuHub.Hubs
{
    public class DanmakuHub : Hub
    {
        public async Task LaunchDanmaku(string channel, string msg)
        {
            await Clients.All.SendAsync(channel, msg);
        }

    }
}
