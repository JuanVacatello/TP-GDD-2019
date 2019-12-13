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
    public partial class NumeroDeCompra : Form
    {
        public NumeroDeCompra()
        {
            InitializeComponent();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesCliente fun = new FuncionalidadesRol.FuncionalidadesCliente();
            this.Hide();
            fun.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand select = new SqlCommand("LIL_MIX.mostrarCompra", cn);
            select.CommandType = CommandType.StoredProcedure;
            select.Parameters.Add(new SqlParameter("@usuario_nombre", login.nombre_usuario));
            select.Parameters.Add(new SqlParameter("@ofertacodigo", ComprarCliente.codigo));
            select.Parameters.Add(new SqlParameter("@cantidad", ComprarCliente.cantidad));
            SqlDataAdapter da = new SqlDataAdapter(select);

            cn.Open();
            da.Fill(dt);
            compranumeroDGV.DataSource = dt;
            compranumeroDGV.ReadOnly = true;
            cn.Close();

        }

        private void compranumeroDGV_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
