using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.ComprarOferta
{
    public partial class OfertasVigentes : Form
    {
        public OfertasVigentes()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin of = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            of.Show();
        }

        private void fillToolStripButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.ofertasVigentesHastaDiaActualTableAdapter.Fill(this.gD2C2019DataSet.ofertasVigentesHastaDiaActual, new System.Nullable<System.DateTime>(((System.DateTime)(System.Convert.ChangeType(diaactualToolStripTextBox.Text, typeof(System.DateTime))))));
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }

        }
    }
}
