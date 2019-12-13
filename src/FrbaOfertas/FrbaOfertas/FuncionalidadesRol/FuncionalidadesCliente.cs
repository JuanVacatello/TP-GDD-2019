using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.FuncionalidadesRol
{
    public partial class FuncionalidadesCliente : Form
    {

        public FuncionalidadesCliente()
        {
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Login.LoginSegun log = new Login.LoginSegun();
            this.Hide();
            log.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            CargaDeCredito.CargaCreditoCliente carg = new CargaDeCredito.CargaCreditoCliente();
            this.Hide();
            carg.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ComprarOferta.ComprarCliente com = new ComprarOferta.ComprarCliente();
            this.Hide();
            com.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ListadoEstadistico.ListadoEstadisticoCli lis = new ListadoEstadistico.ListadoEstadisticoCli();
            this.Hide();
            lis.Show();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            CambiarContraCli cam = new CambiarContraCli();
            this.Hide();
            cam.Show();
        }
    }
}
