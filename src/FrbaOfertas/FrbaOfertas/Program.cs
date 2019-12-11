using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
         //   Application.Run(new ComprarOferta.OfertasVigentes());
     //   Application.Run(new AbmRol.ABM_de_Rol());
       Application.Run(new Login.LoginSegun());
        //Application.Run(new ComprarOferta.OfertasVigentes());
        //  Application.Run(new AbmCliente.ABMDeCliente());
           // Application.Run(new AbmProveedor.ABMDeProveedor());
            //Application.Run(new AbmCliente.AltaCliente());
           // Application.Run(new AbmCliente.BajaCliente());
           // Application.Run(new AbmCliente.FiltradoModificacionCliente());
           // Application.Run(new AbmCliente.ModificarCliente());

        }
    }
}
