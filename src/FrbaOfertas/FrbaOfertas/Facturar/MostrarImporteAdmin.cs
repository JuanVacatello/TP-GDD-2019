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

namespace FrbaOfertas.Facturar
{
    public partial class MostrarImporteAdmin : Form
    {
        DateTime fecha = Properties.Settings.Default.fecha_actual;
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public MostrarImporteAdmin()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand select = new SqlCommand("LIL_MIX.mostrarImporteFactura", cn);
            select.CommandType = CommandType.StoredProcedure;
            select.Parameters.Add(new SqlParameter("@fecha_inicio", ElegirFechayProveedor.inicio));
            select.Parameters.Add(new SqlParameter("@fecha_fin", ElegirFechayProveedor.fin));
            select.Parameters.Add(new SqlParameter("@proveedor_cuit", ElegirFechayProveedor.cuit_prov));
            SqlDataAdapter da = new SqlDataAdapter(select);

            cn.Open();
            da.Fill(dt);
            compranumeroDGV.DataSource = dt;
            compranumeroDGV.ReadOnly = true;
            cn.Close();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin adm = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            adm.Show();
        }
    }
}
