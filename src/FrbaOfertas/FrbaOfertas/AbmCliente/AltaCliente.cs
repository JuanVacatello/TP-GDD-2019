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
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public RegistroCliente()
        {
            InitializeComponent();
        }

        private void AltaCliente_Load(object sender, EventArgs e)
        {
           
        }

        void CrearCliente()
        {
            try
            {
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

                ABMDeCliente abm = new ABMDeCliente();
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


        private void btnRegistrar_Click(object sender, EventArgs e)
        { 
            if (txtNombreUsuario.TextLength == 0)
                MessageBox.Show("Ingrese un nombre de usuario");
            else if (txtContrasenia.TextLength == 0)
                MessageBox.Show("Ingrese una contraseña");
            else if (txtNombre.TextLength == 0)
                MessageBox.Show("Ingrese su nombre");
            else if (txtApellido.TextLength == 0)
                MessageBox.Show("Ingrese su apellido");
            else if (txtDNI.TextLength != 8)
                MessageBox.Show("Ingrese un DNI valido");
            else if (txtMail.TextLength == 0)
                MessageBox.Show("Ingrese su mail");
            else if ((txtTelefono.TextLength != 8))
                MessageBox.Show("Ingrese un numero de teléfono valido");
            else if (txtDirec.TextLength == 0)
                MessageBox.Show("Ingrese su direccion");
            else if (txtCiudad.TextLength == 0)
                MessageBox.Show("Ingrese su ciudad");
         
            else
            {
                CrearCliente();

            }

         }

        private void btnAtras_Click(object sender, EventArgs e)
        { 
            ABMDeCliente abm = new ABMDeCliente();
            this.Hide();
            abm.Show();

        }

        private void txtDNI_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void limpiarCampos()
        {
            txtNombreUsuario.Clear();
            txtContrasenia.Clear();
            txtNombre.Clear();
            txtApellido.Clear();
            txtDNI.Clear();
            txtMail.Clear();
            txtTelefono.Clear();
            txtDirec.Clear();
            txtCiudad.Clear();
            txtPiso.Clear();
            txtDpto.Clear();
            txtCP.Clear();
            dateTimePicker1.Value = DateTime.Now;

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }
        }
    }


