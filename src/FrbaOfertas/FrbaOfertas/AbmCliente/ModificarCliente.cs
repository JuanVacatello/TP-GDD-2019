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
        private void ModificarCliente_Load(object sender, EventArgs e)
        {

        }
       
        private void btnModificarFecha_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteFechaNacimiento", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
            query.Parameters.Add(new SqlParameter("@fechanacimiento_nueva", this.dateTimePickerNuevaFecha.Value));

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Fecha de nacimiento actualizada");
            cn.Close();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            FiltradoModificacionCliente filt = new FiltradoModificacionCliente();
            this.Hide();
            filt.Show();
        }

        void modificarCliente(){

            try {

                if (txtNuevoNombre.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteNombre", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@nombre_nuevo", this.txtNuevoNombre.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoApellido.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteApellido", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@apellido_nuevo", this.txtNuevoApellido.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoDni.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteDNI", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@dni_nuevo", this.txtNuevoDni.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoTelefono.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteTelefono", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@telefono_nuevo", this.txtNuevoTelefono.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoCP.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteCP", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@codigopostal_nuevo", this.txtNuevoCP.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoMail.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarClienteMail", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@mail_nuevo", this.txtNuevoMail.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevaDirec.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarCalleDirecCliente", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@direccion_calle_nuevo", this.txtNuevaDirec.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoPiso.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarPisoDirecCliente", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@direccion_piso_nuevo", this.txtNuevoPiso.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevaCiudad.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarCiudadCliente", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@ciudad_nueva", this.txtNuevaCiudad.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                if (txtNuevoDpto.TextLength != 0)
                {
                    SqlCommand query = new SqlCommand("LIL_MIX.modificarDptoDirecCliente", cn);
                    query.CommandType = CommandType.StoredProcedure;
                    query.Parameters.Add(new SqlParameter("@nombre_usuario", FiltradoModificacionCliente.nombre_usuario));
                    query.Parameters.Add(new SqlParameter("@direccion_dpto_nuevo", this.txtNuevoDpto.Text));

                    cn.Open();
                    query.ExecuteNonQuery();
                    cn.Close();
                }

                MessageBox.Show("Cliente actualizado");


                ABMDeCliente abm = new ABMDeCliente();
                this.Hide();
                abm.Show();
                }

            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
                cn.Close();
            }
        }

        private void btnListo_Click(object sender, EventArgs e)
        {          
                modificarCliente();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.habilitarCliente", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@usuario_nombre", FiltradoModificacionCliente.nombre_usuario));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Cliente habilitado");

            cn.Close(); 
        }
    }
}
