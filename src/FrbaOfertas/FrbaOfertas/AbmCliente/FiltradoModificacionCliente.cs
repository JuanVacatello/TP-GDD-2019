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
        public static string nombre_usuario;
        public static DateTime fecha_nac;
        public static string dni_usuario;

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

            if (txtDni.TextLength != 0){
           
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes1", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@dni", this.txtDni.Text));

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();
            }
            else if(txtMail.TextLength != 0 & txtNombre.TextLength != 0 & txtApellido.TextLength != 0){
                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes2", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));
                query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));
                query.Parameters.Add(new SqlParameter("@email", this.txtMail.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }
            else if (txtApellido.TextLength != 0 & txtMail.TextLength !=0){
                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes3", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));
                query.Parameters.Add(new SqlParameter("@email", this.txtMail.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtNombre.TextLength != 0 & txtMail.TextLength != 0)
            {
                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes4", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));
                query.Parameters.Add(new SqlParameter("@email", this.txtMail.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtApellido.TextLength != 0 & txtNombre.TextLength != 0)
            {
                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes5", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));
                query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));

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
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes6", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@email", this.txtMail.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtApellido.TextLength != 0 )
            {
                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes7", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }

            else if (txtNombre.TextLength != 0)
            {
                DataTable dt = new DataTable();
                dt.Clear();
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes8", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));

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
                SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes9", cn);
                query.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(query);
                cn.Open();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.ReadOnly = true;
                cn.Close();
            }



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

        private void button1_Click(object sender, EventArgs e)
        {
            if (dni_usuario == null)
            {
                MessageBox.Show("No seleccionó ningún cliente");
            }
            else{

            ModificarCliente mod = new ModificarCliente();
            this.Hide();
            mod.Show();
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentRow.Selected = true;
            nombre_usuario = dataGridView1.Rows[e.RowIndex].Cells[0].FormattedValue.ToString();
            fecha_nac = Convert.ToDateTime(dataGridView1.Rows[e.RowIndex].Cells[5].FormattedValue.ToString());
            dni_usuario = dataGridView1.Rows[e.RowIndex].Cells[4].FormattedValue.ToString();
        }

       

    }
}
