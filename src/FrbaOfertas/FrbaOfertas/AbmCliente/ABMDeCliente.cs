using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.AbmCliente
{
    public partial class ABMDeCliente : Form
    {
        public ABMDeCliente()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {

        }

        private void button1_Click_2(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button7_Click(object sender, EventArgs e)
        {

        }

        private void btnAltaCliente_Click(object sender, EventArgs e)
        {
            RegistroCliente alta = new RegistroCliente();
            this.Hide();
            alta.Show();
        }

        private void btnBajaCliente_Click(object sender, EventArgs e)
        {
            BajaCliente baja = new BajaCliente();
            this.Hide();
            baja.Show();
        }

        private void btnModificarCliente_Click(object sender, EventArgs e)
        {
            FiltradoModificacionCliente modi = new FiltradoModificacionCliente();
            this.Hide();
            modi.Show();
        }

        private void button1_Click_3(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin funcadm = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            funcadm.Show();
        }
    }
}
