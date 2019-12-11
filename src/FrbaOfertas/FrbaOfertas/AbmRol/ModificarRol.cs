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
    public partial class ModificarRol : Form
    {
        public ModificarRol()
        {
            InitializeComponent();
            cargarDatos();
        }

        public void cargarDatos()
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoFuncionalidades", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["funcionalidad_descripcion"] = "seleccione una funcionalidad";
            dt.Rows.InsertAt(fila, 0);

            //button4.ValueMember = "funcionalidad_descripcion";
            //button4.DisplayMember = "funcionalidad_descripcion";
            //button4.DataSource = dt;

        }

        private void button1_Click(object sender, EventArgs e)
        {
             SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.habilitarRol", cn);
            query.CommandType = CommandType.StoredProcedure;
           // query.Parameters.Add(new SqlParameter("@rol_nombre", ---);

            cn.Open();
            query.ExecuteNonQuery();
            cn.Close();
        }

        private void ModificarRol_Load(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Seleccionar selec = new Seleccionar();
            this.Hide();
            selec.Show();
        }


        public void button5_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.modificaRolNombre", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@rol_nombre", ---);
            query.Parameters.Add(new SqlParameter("@rol-nombre_nuevo", this.txtNombreNuevo.Text));

            cn.Open();
            query.ExecuteNonQuery();
            cn.Close();
            }

        public void agregarFuncionalidad(string funcionalidad_descripcion)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.modificarRolAgregarFuncionalidad", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@rol_nombre", this.txtNombre.Text));
            query.Parameters.Add(new SqlParameter("@funcionalidad_descripcion", funcionalidad_descripcion));

            cn.Open();
            query.ExecuteNonQuery();
            cn.Close();

        }

       /* private void button4_Click(object sender, EventArgs e)
        {
            if (button4.SelectedValue.ToString() != null)
            {
                string funcionalidad_descripcion = button4.SelectedValue.ToString();

                agregarFuncionalidad(funcionalidad_descripcion);
            }
            MessageBox.Show("Funcionalidad agregada");
        }*/
    }
}
