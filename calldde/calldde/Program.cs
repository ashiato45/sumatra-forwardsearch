using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using NDde;

namespace calldde
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            var args = Environment.GetCommandLineArgs();
            if (args.Length < 3)
            {
                return;
            }
            var inputline = 0;
            if (int.TryParse(args[2], out inputline) == false)
            {
                MessageBox.Show("Invalid line");
                return;
            }
            if (System.IO.File.Exists(args[1]) == false)
            {
                MessageBox.Show("Invalid filename");
                return;
            }

            using (NDde.Client.DdeClient client = new NDde.Client.DdeClient("SUMATRA", "control"))
            {
                client.Connect();
                var sourcefilepath = args[1];
                var line = inputline;
                var column = 0;
                var newwindow = 0;
                var setforcus = 1;
                var cmd = string.Format(@"[ForwardSearch(""{1}"",{2},{3},{4},{5})]",
                                               "",
                                               sourcefilepath,
                                               line.ToString(),
                                         column.ToString(),
                                         newwindow.ToString(),
                                         setforcus.ToString());
                client.Execute(cmd, 10000);
            }
        }
    }
}
