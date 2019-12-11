using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.AbmRol
{
    public partial class ABM_de_Rol : Form
    {
        public ABM_de_Rol()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            AltaRol alta = new AltaRol();
            this.Hide();
            alta.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ModificarRol modi = new ModificarRol();
            this.Hide();
            modi.Show();
        }

        private void btnBajaRol_Click(object sender, EventArgs e)
        {
            BajaRol baja = new BajaRol();
            this.Hide();
            baja.Show();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin funadm = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            funadm.Show();
        }
    }
}
