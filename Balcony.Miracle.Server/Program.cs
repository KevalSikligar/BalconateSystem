using System;
using System.Diagnostics;
using System.ServiceProcess;
using System.Threading;

namespace Balcony.Miracle.Server {

    internal static class Program {

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        private static void Main() {
            if (Debugger.IsAttached) {
                var ms = new MainService();
                ms.Start();
                new AutoResetEvent(false).WaitOne();
            } else {
                ServiceBase.Run(new ServiceBase[] { new MainService() });
            }
        }
    }
}
