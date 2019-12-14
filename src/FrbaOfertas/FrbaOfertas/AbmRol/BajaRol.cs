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
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public BajaRol()
        {
            InitializeComponent();
            cargarDatos();
        }

        public void cargarDatos()
        {
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoRolHabilitados", cn);
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
            SqlCommand query = new SqlCommand("LIL_MIX.bajaRol", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", rol_nombre));
            
            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Rol eliminado");

            ABM_de_Rol abmrol = new ABM_de_Rol();
            this.Hide();
            abmrol.Show();

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
            try
            {
                if (comboBox1.SelectedValue.ToString() != null)
                {
                    string rol_nombre = comboBox1.SelectedValue.ToString();
                    eliminarRol(rol_nombre);
                }
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
                cn.Close();
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
        }
    }
}
