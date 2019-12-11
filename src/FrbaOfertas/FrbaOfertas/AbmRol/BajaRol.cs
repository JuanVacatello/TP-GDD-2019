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

namespace FrbaOfertas.AbmRol
{
    public partial class BajaRol : Form
    {
        public BajaRol()
        {
            InitializeComponent();
            cargarDatos();
        }

        public void cargarDatos()
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoRol", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["rol_nombre"] = "Seleccione un rol";
            dt.Rows.InsertAt(fila, 0);

            comboBox1.ValueMember = "rol_nombre";
            comboBox1.DisplayMember = "rol_nombre";
            comboBox1.DataSource = dt;

        }

        public void eliminarRol(string rol_nombre)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.bajaRol", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            
            cn.Open();
            query.ExecuteNonQuery();
            cn.Close();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABM_de_Rol abmrol = new ABM_de_Rol();
            this.Hide();
            abmrol.Show();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedValue.ToString() != null)
            {
                string rol_nombre = comboBox1.SelectedValue.ToString();
                eliminarRol(rol_nombre);
            }
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            //BOTON ELIMINAR

            if (comboBox1.SelectedValue.ToString() != null)
            {
                string rol_nombre = comboBox1.SelectedValue.ToString();

                eliminarRol(rol_nombre);
            }
            MessageBox.Show("Rol eliminado");
            ABM_de_Rol abmrol = new ABM_de_Rol();
            this.Hide();
            abmrol.Show();
        }
    }
}
