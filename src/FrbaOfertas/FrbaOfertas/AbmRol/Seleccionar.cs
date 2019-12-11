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
    public partial class Seleccionar : Form
    {
        public Seleccionar()
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

        private void button3_Click(object sender, EventArgs e)
        {
            AbmRol.ModificarRol abmrol = new AbmRol.ModificarRol();
            this.Hide();
            abmrol.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ABM_de_Rol abmrol = new ABM_de_Rol();
            this.Hide();
            abmrol.Show();
        }

        public void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
