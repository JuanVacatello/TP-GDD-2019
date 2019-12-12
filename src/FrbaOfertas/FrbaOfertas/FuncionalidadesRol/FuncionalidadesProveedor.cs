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
            Login.LoginSegun log = new Login.LoginSegun();
            this.Hide();
            log.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            CrearOferta.ConfeccionOfertaProve cf = new CrearOferta.ConfeccionOfertaProve();
            this.Hide();
            cf.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ListadoEstadistico.ListadoEstadisticoProv lis = new ListadoEstadistico.ListadoEstadisticoProv();
            this.Hide();
            lis.Show();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            CambiarContraProv cam = new CambiarContraProv();
            this.Hide();
            cam.Show();
        }

        
    }
}
