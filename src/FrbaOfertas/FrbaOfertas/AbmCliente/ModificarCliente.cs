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
    public partial class ModificarCliente : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public ModificarCliente()
        {
            InitializeComponent();
        }

        private void label14_Click(object sender, EventArgs e)
        {

        }

        private void ModificarCliente_Load(object sender, EventArgs e)
        {

        }

        private void ModificarNombre_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteNombre", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@nombre_nuevo", this.txtNuevoNombre.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Nombre actualizado");
            cn.Close();
        }

        private void btnModificarApellido_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteApellido", cn);
            query.CommandType = CommandType.StoredProcedure;
          //  query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@apellido_nuevo", this.txtNuevoApellido.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Apellido actualizado");
            cn.Close();
        }

        private void btnModificarDNI_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteDNI", cn);
            query.CommandType = CommandType.StoredProcedure;
           // query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@dni_nuevo", this.txtNuevoDni.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("DNI actualizado");
            cn.Close();
        }

        private void btnModificarTelefono_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteTelefono", cn);
            query.CommandType = CommandType.StoredProcedure;
          //  query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@telefono_nuevo", this.txtNuevoTelefono.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Telefono actualizado");
            cn.Close();
        }

        private void btnModificarMail_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteMail", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@telefono_nuevo", this.txtNuevoMail.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Mail actualizado");
            cn.Close();
        }

        private void btnModificarCP_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteCP", cn);
            query.CommandType = CommandType.StoredProcedure;
           // query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@codigopostal_nuevo", this.txtNuevoCP.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Codigo postal actualizado");
            cn.Close();
        }

        private void btnModificarDirec_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarCalleDirecCliente", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@direccion_calle_nuevo", this.txtNuevaDirec.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Dirección actualizada");
            cn.Close();
        }

        private void btnModificarPiso_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarPisoDirecCliente", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@direccion_piso_nuevo", this.txtNuevoPiso.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Piso actualizado");
            cn.Close();
        }

        private void btnModificarCiudad_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarCiudadCliente", cn);
            query.CommandType = CommandType.StoredProcedure;
           // query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@ciudad_nueva", this.txtNuevaCiudad.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Ciudad actualizada");
            cn.Close();
        }

        private void btnModificarDpto_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarDptoDirecCliente", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@direccion_dpto_nuevo", this.txtNuevoDpto.Text));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Dpto actualizado");
            cn.Close();
        }

        private void btnModificarFecha_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteFechaNacimiento", cn);
            query.CommandType = CommandType.StoredProcedure;
            //query.Parameters.Add(new SqlParameter("@usuario_nombre", ---));
            query.Parameters.Add(new SqlParameter("@fechanacimiento_nueva", this.dateTimePickerNuevaFecha.Value));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Fecha de nacimiento actualizada");
            cn.Close();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            FiltradoModificacionCliente filt = new FiltradoModificacionCliente();
            filt.ShowDialog();
            if (filt.DialogResult == DialogResult.Yes)
            { }
        }

        private void btnListo_Click(object sender, EventArgs e)
        {
            ABMDeCliente abm = new ABMDeCliente();
            abm.ShowDialog();
            if (abm.DialogResult == DialogResult.Yes)
            { }
        }
    }
}
