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
        public loginProv()
        {
            InitializeComponent();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            LoginSegun log = new LoginSegun();
            this.Hide();
            log.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.login", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@usuario", this.txtUsuario.Text));
            query.Parameters.Add(new SqlParameter("@password_ingresada", this.txtPass.Text));
            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Login exitoso");

            FuncionalidadesRol.FuncionalidadesProveedor funpro = new FuncionalidadesRol.FuncionalidadesProveedor();
            this.Hide();
            funpro.Show();

            cn.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Login.RegistrarProveedor prov = new Login.RegistrarProveedor();
            this.Hide();
            prov.Show();
        }
    }
}
