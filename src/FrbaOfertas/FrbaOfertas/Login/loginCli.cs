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

namespace FrbaOfertas
{
    public partial class login : Form
    {
        public login()
        {
            InitializeComponent();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Login.LoginSegun log = new Login.LoginSegun();
            log.ShowDialog();
            if (log.DialogResult == DialogResult.Yes)
            { }
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
            cn.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            AbmCliente.RegistroCliente cli = new AbmCliente.RegistroCliente();
            cli.ShowDialog();
            if (cli.DialogResult == DialogResult.Yes)
            { }
        }
    }
}
