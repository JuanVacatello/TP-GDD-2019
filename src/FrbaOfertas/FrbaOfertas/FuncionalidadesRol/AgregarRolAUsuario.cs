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

namespace FrbaOfertas.FuncionalidadesRol
{
    public partial class AgregarRolAUsuario : Form
    {
        public AgregarRolAUsuario()
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

        public void agregarRol(string rol_nombre)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.agregarRolAUsuario", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            query.Parameters.Add(new SqlParameter("@usuario_nombre", this.txtUsuario.Text));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Rol asignado con exito");

            FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
            this.Hide();
            fun.Show();

            cn.Close();

        }

        public void agregarRolAUsuario()
        {
            try
            {
                if (comboBox1.SelectedValue.ToString() != null)
                {
                    string rol_nombre = comboBox1.SelectedValue.ToString();
                    agregarRol(rol_nombre);
                }
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (txtUsuario.TextLength == 0)
                MessageBox.Show("Ingrese un nombre de usuario al que le desea agregar el rol");

            else
            {
                agregarRolAUsuario();

            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}
