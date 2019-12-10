using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.AbmProveedor
{
    public partial class ABMDeProveedor : Form
    {
        public ABMDeProveedor()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            AltaProveedor alta = new AltaProveedor();
            alta.Show();
            this.Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            BajaProveedor baja = new BajaProveedor();
            baja.Show();
            this.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            FiltradoModificacionProveedor modi = new FiltradoModificacionProveedor();
            modi.Show();
            this.Hide();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin adm = new FuncionalidadesRol.FuncionalidadesAdmin();
            adm.Show();
            this.Hide();
        }
    }
}
