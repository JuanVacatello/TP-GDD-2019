using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.AbmCliente
{
    public partial class BajaCliente : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public BajaCliente()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABMDeCliente abm = new ABMDeCliente();
            this.Hide();
            abm.Show();
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@nombre", this.txtNombreFiltro.Text));
            query.Parameters.Add(new SqlParameter("@apellido", this.txtApellidoFiltro.Text));
            query.Parameters.Add(new SqlParameter("@email", this.txtMailFiltro.Text));
            query.Parameters.Add(new SqlParameter("@dni", this.txtDniFiltro.Text));
            

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dgvBajaCliente.DataSource = dt;
            dgvBajaCliente.ReadOnly = true;
            cn.Close();
        }

        void limpiarCampos()
        {
            txtNombreFiltro.Clear();
            txtApellidoFiltro.Clear();
            txtMailFiltro.Clear();
            txtDniFiltro.Clear();
            dgvBajaCliente.DataSource = null;
            dgvBajaCliente.Refresh();

        }


        private void button3_Click(object sender, EventArgs e)
        {
            limpiarCampos();
        }

        private void button4_Click(object sender, EventArgs e)
        {

        }
    }
}
