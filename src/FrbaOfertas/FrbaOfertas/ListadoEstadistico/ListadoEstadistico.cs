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

namespace FrbaOfertas.ListadoEstadistico
{
    public partial class ListadoEstadistico : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public ListadoEstadistico()
        {
            InitializeComponent();
            cargarDatosListado();
            cargarDatosSemestre();
        }

        public void cargarDatosListado()
        {
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.seleccionarListado", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
          
            comboBox1.ValueMember = "listado_id";
            comboBox1.DisplayMember = "listado_id";
            comboBox1.DataSource = dt;

        }

        public void cargarDatosSemestre()
        {
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.seleccionarSemestre", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            
            comboBox2.ValueMember = "semestre_id";
            comboBox2.DisplayMember = "semestre_id";
            comboBox2.DataSource = dt;

        }

        private void confeccionarListado(string listado_id, string semestre_id)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand query = new SqlCommand("LIL_MIX.crearListadoEstadistico", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@semestre", Convert.ToInt64(semestre_id)));
            query.Parameters.Add(new SqlParameter("@listado", Convert.ToInt64(listado_id)));
            query.Parameters.Add(new SqlParameter("@anio", Convert.ToInt64(this.txtAnio.Text)));

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();

        }

        private void btnVolver_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin cre = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            cre.Show();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void listado()
        {
            try
            {
                if (comboBox1.SelectedValue.ToString() != null)
                {
                    if (comboBox2.SelectedValue.ToString() != null)
                    {
                        string listado_id = comboBox1.SelectedValue.ToString();
                        string semestre_id = comboBox2.SelectedValue.ToString();
                        confeccionarListado(listado_id, semestre_id);
                    }
                }
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
            }
        }

        private void btnSeleccionar_Click(object sender, EventArgs e)
        {
            if (txtAnio.TextLength == 0)
                MessageBox.Show("Ingrese el año en el que desea facturar");
            else
            {
                listado();
            }
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();

        }

        private void limpiarCampos()
        {
            txtAnio.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }

        private void txtAnio_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
