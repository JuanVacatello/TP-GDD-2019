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
    public partial class ModificarProveedor : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public ModificarProveedor()
        {
            InitializeComponent();
        }

        private void textBox10_TextChanged(object sender, EventArgs e)
        {

        }

        private void label11_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            FiltradoModificacionProveedor filt = new FiltradoModificacionProveedor();
            filt.ShowDialog();
            if (filt.DialogResult == DialogResult.Yes) { }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorCuit", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@cuit_nuevo", this.txtCuit.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("CUIT actualizado");
            cn.Close();
        }

        private void textBox13_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnModificarNombreContacto_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorNombreContacto", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@nombre_de_contacto_nuevo", this.txtNombreContacto.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Nombre de contacto actualizado");
            cn.Close();
        }

        private void btnModificarTelefono_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorTelefono", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@telefono_nuevo", this.txtTelefono.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Telefono actualizado");
            cn.Close();
        }

        private void btnModificarCodigoPostal_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorCP", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@codigopostal_nuevo", this.txtCodigoPostal.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Codigo postal actualizado");
            cn.Close();
        }

        private void btnModificarRubro_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorRubro", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@rubro_nuevo", this.txtRubro.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Rubro actualizado");
            cn.Close();
        }

        private void btnModificarMail_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorMail", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@mail_nuevo", this.txtMail.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Mail actualizada");
            cn.Close();
        }

        private void btnModificarRazonSocial_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarProveedorRS", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@razon_social_nueva", this.txtRazonSocial.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Razon social actualizada");
            cn.Close();
        }

        private void btnModificarDireccion_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarCalleDirecProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@direccion_calle_nuevo", this.txtDireccion.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Dirección actualizada");
            cn.Close();
        }

        private void btnModificarPiso_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarPisoDirecProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@direccion_piso_nuevo", this.txtPiso.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Piso actualizado");
            cn.Close();
        }

        private void btnModificarCiudad_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarDptoDirecProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@direccion_dpto_nuevo", this.txtDepto.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Departamento actualizado");
            cn.Close();
        }

        private void btnModificarDepto_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarCiudadProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@ciudad_nueva", this.txtCiudad.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Ciudad actualizada");
            cn.Close();
        } 
    }
}
