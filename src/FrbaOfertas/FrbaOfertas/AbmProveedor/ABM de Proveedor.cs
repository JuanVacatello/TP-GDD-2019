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
            alta.ShowDialog();
            if (alta.DialogResult == DialogResult.Yes) { }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            BajaProveedor baja = new BajaProveedor();
            baja.ShowDialog();
            if (baja.DialogResult == DialogResult.Yes)
            { }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            FiltradoModificacionProveedor modi = new FiltradoModificacionProveedor();
            modi.ShowDialog();
            if (modi.DialogResult == DialogResult.Yes) { }
        }
    }
}
