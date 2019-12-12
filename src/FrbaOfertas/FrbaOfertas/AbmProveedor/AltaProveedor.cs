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


namespace FrbaOfertas.AbmProveedor
{
    public partial class AltaProveedor : Form
    {
        public AltaProveedor()
        {
            InitializeComponent();
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnRegistrar_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.altaUsuarioProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@usuario_nombre", this.txtNombreUsuario.Text));
            query.Parameters.Add(new SqlParameter("@usuario_password", this.txtContrasenia.Text));
            query.Parameters.Add(new SqlParameter("@cuit", this.txtCUIT.Text));
            query.Parameters.Add(new SqlParameter("@rubro", this.txt_rubro.Text));
            query.Parameters.Add(new SqlParameter("@razon_social", this.txtRazonSocial.Text));
            query.Parameters.Add(new SqlParameter("@mail", this.txtMail.Text));
            query.Parameters.Add(new SqlParameter("@nombre_contacto", this.txtNombreContacto.Text));
            query.Parameters.Add(new SqlParameter("@telefono", Convert.ToInt32(this.txtTelefono.Text)));
            query.Parameters.Add(new SqlParameter("@codigo_postal", this.txtCodigoPostal.Text));
            query.Parameters.Add(new SqlParameter("@calle", this.txtDireccion.Text));
            query.Parameters.Add(new SqlParameter("@ciudad", this.txtCiudad.Text));
            query.Parameters.Add(new SqlParameter("@piso", this.txtPiso.Text));
            query.Parameters.Add(new SqlParameter("@dpto", this.txtDepto.Text));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Proveedor registrado");

            ABMDeProveedor abm = new ABMDeProveedor();
            this.Hide();
            abm.Show();

            cn.Close();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            ABMDeProveedor abm = new ABMDeProveedor();
            this.Hide();
            abm.Show();
        }
    }
}
