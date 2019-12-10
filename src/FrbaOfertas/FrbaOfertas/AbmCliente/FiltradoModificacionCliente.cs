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
    public partial class FiltradoModificacionCliente : Form
    {
        public FiltradoModificacionCliente()
        {
            InitializeComponent();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            ABMDeCliente abm = new ABMDeCliente();
            abm.ShowDialog();
            if (abm.DialogResult == DialogResult.Yes)
            {
            }
        }
    }
}
