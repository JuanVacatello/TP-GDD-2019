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
    public partial class BajaProveedor : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);
        public static string cuit;
        public static string telefono;
        public static string razonsocial;

        public BajaProveedor()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABMDeProveedor abm = new ABMDeProveedor();
            this.Hide();
            abm.Show();
        }

        private void limpiarCampos()
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

            if (txtRS.TextLength != 0 & txtMail.TextLength != 0)
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

            if (txtMail.TextLength != 0)
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

            if (txtRS.TextLength != 0)
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

        private void button2_Click(object sender, EventArgs e)
        {
            if (telefono == null)
            {
                MessageBox.Show("No ingresó proveedor a eliminar");
            } 
            else{
            SqlCommand query = new SqlCommand("LIL_MIX.bajaProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@razon_social", razonsocial));
            query.Parameters.Add(new SqlParameter("@cuit", cuit));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Proveedor dado de baja.");
            cn.Close();
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentRow.Selected = true;
            cuit = dataGridView1.Rows[e.RowIndex].Cells[1].FormattedValue.ToString();
            razonsocial = dataGridView1.Rows[e.RowIndex].Cells[2].FormattedValue.ToString();
            telefono = dataGridView1.Rows[e.RowIndex].Cells[4].FormattedValue.ToString();
        }
    }
}
