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

        public void cargarMasDatos(string rol_nombre)
        {

            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoFuncionalidadesExistentes", cn);
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["funcionalidad_descripcion"] = "Seleccione una funcionalidad";
            dt.Rows.InsertAt(fila, 0);

            comboBox2.ValueMember = "funcionalidad_descripcion";
            comboBox2.DisplayMember = "funcionalidad_descripcion";
            comboBox2.DataSource = dt;
        }

        public void cargarFuncionalidades(string rol_nombre)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoFuncionalidadesNoExistentes", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["funcionalidad_descripcion"] = "Seleccione una funcionalidad";
            dt.Rows.InsertAt(fila, 0);

            comboBox1.ValueMember = "funcionalidad_descripcion";
            comboBox1.DisplayMember = "funcionalidad_descripcion";
            comboBox1.DataSource = dt;

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

            comboBox3.ValueMember = "rol_nombre";
            comboBox3.DisplayMember = "rol_nombre";
            comboBox3.DataSource = dt;

        }

        private void habilitarRol(string rol_nombre)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.habilitarRol", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Rol habilitado");

            cn.Close(); 
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBox3.SelectedValue.ToString() != null)
            {
                string rol_nombre = comboBox3.SelectedValue.ToString();
                habilitarRol(rol_nombre);
            }
        }

        private void ModificarRol_Load(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            ABM_de_Rol abm = new ABM_de_Rol();
            this.Hide();
            abm.Show();
        }

        public void agregarFuncionalidad(string rol_nombre, string funcionalidad_descripcion)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.modificarRolAgregarFuncionalidad", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            query.Parameters.Add(new SqlParameter("@funcionalidad_descripcion", funcionalidad_descripcion));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Funcionalidad agregada");

            cn.Close();
        }

        public void eliminarFuncionalidad(string rol_nombre, string funcionalidad_descripcion)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.modificarRolEliminarFuncionalidad", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            query.Parameters.Add(new SqlParameter("@funcionalidad_descripcion", funcionalidad_descripcion));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Funcionalidad eliminada");

            cn.Close();
        }

        public void modificarNombre(string rol_nombre)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.modificarRolNombre", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            query.Parameters.Add(new SqlParameter("@rol_nombre_nuevo", this.txtNombreNuevo.Text));

            cn.Open();
            query.ExecuteNonQuery();
            cn.Close();
          }


        public void button5_Click(object sender, EventArgs e)
        {
            //BOTON MODIFICAR NOMBRE

            if (comboBox3.SelectedValue.ToString() != null)
            {
                string rol_nombre = comboBox3.SelectedValue.ToString();
                modificarNombre(rol_nombre);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
                        
        }

        private void comboBox3_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void button4_Click_1(object sender, EventArgs e)
        {
            // BOTON AGREGAR FUNCIONALIDAD

            if (comboBox3.SelectedValue.ToString() != null)
            {
                if (comboBox1.SelectedValue.ToString() != null)
                {
                    string funcionalidad_descricion = comboBox1.SelectedValue.ToString();
                    string rol_nombre = comboBox3.SelectedValue.ToString();
                    agregarFuncionalidad(rol_nombre, funcionalidad_descricion);
                }
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void button3_Click(object sender, EventArgs e)
        {
            // BOTON DE ELIMINAR FUNCIONALIDAD

            if (comboBox3.SelectedValue.ToString() != null)
            {
                if (comboBox2.SelectedValue.ToString() != null)
                {
                    string funcionalidad_descricion = comboBox1.SelectedValue.ToString();
                    string rol_nombre = comboBox3.SelectedValue.ToString();
                    eliminarFuncionalidad(rol_nombre, funcionalidad_descricion);
                }
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Los cambios fueron efectuados con exito");
            ABM_de_Rol abm = new ABM_de_Rol();
            this.Hide();
            abm.Show();
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (comboBox3.SelectedValue.ToString() != null)
            {
                string rol_nombre = comboBox3.SelectedValue.ToString();
                cargarFuncionalidades(rol_nombre);
                cargarMasDatos(rol_nombre);
            }
        }
    }
}
