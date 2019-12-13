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
    public partial class FiltradoModificacionCliente : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public FiltradoModificacionCliente()
        {
            InitializeComponent();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            ABMDeCliente abm = new ABMDeCliente();
            this.Hide();
            abm.Show();
           
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));
            query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));
            query.Parameters.Add(new SqlParameter("@dni", this.txtDni.Text));
            query.Parameters.Add(new SqlParameter("@email", this.txtMail.Text));

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();
            
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        void limpiarCampos()
        {
            txtNombre.Clear();
            txtApellido.Clear();
            txtDni.Clear();
            txtMail.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

       

    }
}
