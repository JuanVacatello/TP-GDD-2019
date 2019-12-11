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
    public partial class FuncionalidadesProveedor : Form
    {
        public FuncionalidadesProveedor()
        {
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            CrearOferta.ConfeccionOfertaProve cre = new CrearOferta.ConfeccionOfertaProve();
            this.Hide();
            cre.Show();
        }

        
    }
}
