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
    public partial class AltaRol : Form
    {
        public AltaRol()
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
            // LO SACAMOS PARA EVITAR Q NO SE PUEDA ELEGIR FUNCIONALIDAD
            //fila["funcionalidad_descripcion"] = "seleccione una funcionalidad";
            //dt.Rows.InsertAt(fila, 0);

            cmbFuncionalidad.ValueMember = "funcionalidad_descripcion";
            cmbFuncionalidad.DisplayMember = "funcionalidad_descripcion";
            cmbFuncionalidad.DataSource = dt;

        }

        public void registrarRol(string funcionalidad_descripcion) {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.altaRol", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@rol_nombre", this.txtNombre.Text));
            query.Parameters.Add(new SqlParameter("@funcionalidad_descripcion", funcionalidad_descripcion));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Rol registrado");

            ABM_de_Rol abmrol = new ABM_de_Rol();
            this.Hide();
            abmrol.Show();

            cn.Close();
            
        }


        private void checkedListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void altaRol()
        {
            try
            {
                if (cmbFuncionalidad.SelectedValue.ToString() != null)
                {
                    string funcionalidad_descripcion = cmbFuncionalidad.SelectedValue.ToString();
                    registrarRol(funcionalidad_descripcion);
                }
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
            }
        }

        
        private void button2_Click(object sender, EventArgs e)
        {
           
            if (txtNombre.TextLength == 0)
                MessageBox.Show("Ingrese un nombre de rol");
            else
            {
                altaRol();

            }


        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABM_de_Rol abmrol = new ABM_de_Rol();
            this.Hide();
            abmrol.Show();
        }

        private void AltaRol_Load(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void cmbFuncionalidad_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        void limpiarCampos()
        {
            txtNombre.Clear();
           // cmbFuncionalidad.Items.Clear();       FALTA EL COMBO BOX
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }
        

    }
}
