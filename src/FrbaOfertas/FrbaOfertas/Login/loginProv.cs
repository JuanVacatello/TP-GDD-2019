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

namespace FrbaOfertas.Login
{
    public partial class loginProv : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public static string nombre_usuario;

        public loginProv()
        {
            InitializeComponent();
        }

        void loginProveedor()
        {

            try
            {

                SqlCommand query = new SqlCommand("LIL_MIX.login", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@usuario", this.txtUsuario.Text));
                query.Parameters.Add(new SqlParameter("@password_ingresada", this.txtPass.Text));
                cn.Open();
                query.ExecuteNonQuery();
                MessageBox.Show("Login exitoso");

                FuncionalidadesRol.FuncionalidadesProveedor fun = new FuncionalidadesRol.FuncionalidadesProveedor();
                this.Hide();
                fun.Show();

                nombre_usuario = this.txtUsuario.Text;

                cn.Close();

            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
                cn.Close();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            LoginSegun log = new LoginSegun();
            this.Hide();
            log.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (txtUsuario.TextLength == 0)
                MessageBox.Show("Ingrese un nombre de usuario");
            else if (txtPass.TextLength == 0)
                MessageBox.Show("Ingrese una contraseña");
            else
            {
                this.loginProveedor();

            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Login.RegistrarProveedor prov = new Login.RegistrarProveedor();
            this.Hide();
            prov.Show();
        }

        private void txtUsuario_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
