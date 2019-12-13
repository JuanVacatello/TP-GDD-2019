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

namespace FrbaOfertas.ComprarOferta
{
    public partial class NumeroDeCompraAdmin : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public NumeroDeCompraAdmin()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand select = new SqlCommand("LIL_MIX.mostrarCompra", cn);
            select.CommandType = CommandType.StoredProcedure;
            select.Parameters.Add(new SqlParameter("@usuario_nombre", ComprarAdmin.cliente));
            select.Parameters.Add(new SqlParameter("@ofertacodigo", ComprarAdmin.codigo));
            select.Parameters.Add(new SqlParameter("@cantidad", ComprarAdmin.cantidad));
            SqlDataAdapter da = new SqlDataAdapter(select);

            cn.Open();
            da.Fill(dt);
            compranumeroDGV.DataSource = dt;
            compranumeroDGV.ReadOnly = true;
            cn.Close();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin fun = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }
    }
}
