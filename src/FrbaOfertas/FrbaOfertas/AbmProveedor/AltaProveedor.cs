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
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public AltaProveedor()
        {
            InitializeComponent();
        }

        void CrearProveedor()
        {
            try
            {
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
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
                cn.Close();
            }
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnRegistrar_Click(object sender, EventArgs e)
        {
            if (txtNombreUsuario.TextLength == 0)
                MessageBox.Show("Ingrese un nombre de usuario");
            else if (txtContrasenia.TextLength == 0)
                MessageBox.Show("Ingrese una contraseña");
            else if (txtRazonSocial.TextLength == 0)
                MessageBox.Show("Ingrese su razon social");
            else if (txt_rubro.TextLength == 0)
                MessageBox.Show("Ingrese su rubro");
            else if (txtCUIT.TextLength != 13)
                MessageBox.Show("Ingrese un CUIT valido");
            else if (txtMail.TextLength == 0)
                MessageBox.Show("Ingrese su mail");
            else if ((txtTelefono.TextLength != 8))
                MessageBox.Show("Ingrese un numero de teléfono valido");
            else if (txtNombreContacto.TextLength == 0)
                MessageBox.Show("Ingrese su nombre de contacto");
            else if (txtCiudad.TextLength == 0)
                MessageBox.Show("Ingrese su ciudad");
            else if (txtDireccion.TextLength == 0)
                MessageBox.Show("Ingrese su calle");
            else
            {
                CrearProveedor();

            }
            
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            ABMDeProveedor abm = new ABMDeProveedor();
            this.Hide();
            abm.Show();
        }
        
        private void limpiarCampos()
        {
            txtNombreUsuario.Clear();
            txtContrasenia.Clear();
            txtCUIT.Clear();
            txt_rubro.Clear();
            txtRazonSocial.Clear();
            txtMail.Clear();
            txtTelefono.Clear();
            txtNombreContacto.Clear();
            txtDireccion.Clear();
            txtCiudad.Clear();
            txtPiso.Clear();
            txtDepto.Clear();
            txtCodigoPostal.Clear();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }     


    }
}
