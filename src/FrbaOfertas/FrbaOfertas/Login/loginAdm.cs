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
    public partial class loginAdm : Form
    {
        public loginAdm()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
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

            FuncionalidadesRol.FuncionalidadesAdmin funadm = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            funadm.Show();

            cn.Close();
        }
    }
}
