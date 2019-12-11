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

namespace FrbaOfertas.FuncionalidadesRol
{
    public partial class DarDeBajaUsuario : Form
    {
        public DarDeBajaUsuario()
        {
            InitializeComponent();
        }

        private void Atras_Click(object sender, EventArgs e)
        {
            FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.darDeBajaUsuario", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@usuario_nombre", this.txtUsuario.Text));

            cn.Open();
            query.ExecuteNonQuery();

            FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
            
            cn.Close();
            
        }
    }
}
