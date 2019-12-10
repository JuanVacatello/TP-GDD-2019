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
    public partial class RegistroCliente : Form
    {
        public RegistroCliente()
        {
            InitializeComponent();
        }

        private void AltaCliente_Load(object sender, EventArgs e)
        {
           
        }       

        private void btnRegistrar_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.altaUsuarioCliente", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@usuario_nombre", this.txtNombreUsuario.Text));
            query.Parameters.Add(new SqlParameter("@usuario_password", this.txtContrasenia.Text));
            query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));
            query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));
            query.Parameters.Add(new SqlParameter("@dni", Convert.ToInt32(this.txtDNI.Text)));
            query.Parameters.Add(new SqlParameter("@mail", this.txtMail.Text));
            query.Parameters.Add(new SqlParameter("@telefono", Convert.ToInt32(this.txtTelefono.Text)));
            query.Parameters.Add(new SqlParameter("@direccion_calle", this.txtDirec.Text));
            query.Parameters.Add(new SqlParameter("@ciudad", this.txtCiudad.Text));
            query.Parameters.Add(new SqlParameter("@direccion_piso", this.txtPiso.Text));
            query.Parameters.Add(new SqlParameter("@direccion_dpto", this.txtDpto.Text));
            query.Parameters.Add(new SqlParameter("@codigopostal", this.txtCP.Text));
            query.Parameters.Add(new SqlParameter("@fechanacimiento", this.dateTimePicker1.Value));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Cliente registrado");
            cn.Close();
         }

        private void btnAtras_Click(object sender, EventArgs e)
        { 
            ABMDeCliente abm = new ABMDeCliente();
            this.Hide();
            abm.Show();

        }
    }
}
