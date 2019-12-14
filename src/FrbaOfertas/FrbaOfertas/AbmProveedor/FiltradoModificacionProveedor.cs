using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.AbmProveedor
{
    public partial class FiltradoModificacionProveedor : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);
        public static string nombre_usuario;
        public static string telefono;

        public FiltradoModificacionProveedor()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
             ABMDeProveedor abm = new ABMDeProveedor();
             this.Hide();
             abm.Show();
        }

        void limpiarCampos()
        {
            txtCUIT.Clear();
            txtRS.Clear();
            txtMail.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            limpiarCampos();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (telefono == null)
            {
                MessageBox.Show("No seleccionó ningún proveedor");
            }
            else
            {
                ModificarProveedor mod = new ModificarProveedor();
                this.Hide();
                mod.Show();
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (txtCUIT.TextLength != 0)
            {

                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoProveedores1", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@cuit", this.txtCUIT.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtRS.TextLength != 0 & txtMail.TextLength != 0)
            {

                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoProveedores2", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@razonsocial", this.txtRS.Text));
                query.Parameters.Add(new SqlParameter("@mail", this.txtMail.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtMail.TextLength != 0)
            {

                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoProveedores3", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@mail", this.txtMail.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtRS.TextLength != 0)
            {

                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoProveedores4", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@razonsocial", this.txtRS.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else
            {

                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoProveedores5", cn);
                query.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }


        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentRow.Selected = true;
            nombre_usuario = dataGridView1.Rows[e.RowIndex].Cells[0].FormattedValue.ToString();
            telefono = dataGridView1.Rows[e.RowIndex].Cells[4].FormattedValue.ToString();
        }
    }
}
