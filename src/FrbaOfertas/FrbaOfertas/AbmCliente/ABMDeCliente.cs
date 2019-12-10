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
            AltaCliente alta = new AltaCliente();
            alta.ShowDialog();
            if (alta.DialogResult == DialogResult.Yes){}
           // this.Close();
        }

        private void btnBajaCliente_Click(object sender, EventArgs e)
        {
           // this.Close();
            BajaCliente baja = new BajaCliente();
            baja.ShowDialog();
            if (baja.DialogResult == DialogResult.Yes)
            { }
        }

        private void btnModificarCliente_Click(object sender, EventArgs e)
        {
           // this.Close();
            FiltradoModificacionCliente modi = new FiltradoModificacionCliente();
            modi.ShowDialog();
            if (modi.DialogResult == DialogResult.Yes)
            {
            }
        }
    }
}
