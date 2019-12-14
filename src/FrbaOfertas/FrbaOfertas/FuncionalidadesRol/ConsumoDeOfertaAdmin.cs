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
    public partial class ConsumoDeOfertaAdmin : Form
    {
        DateTime fecha = Properties.Settings.Default.fecha_actual;
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public ConsumoDeOfertaAdmin()
        {
            InitializeComponent();
        }

        void consumoOferta()
        {
            try
            {
                SqlCommand query = new SqlCommand("LIL_MIX.consumoDeOferta", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@cuponid", this.txtCupon.Text));
                query.Parameters.Add(new SqlParameter("@diadeconsumo", fecha));
                query.Parameters.Add(new SqlParameter("@nombre_usuario", this.txtProve.Text));

                cn.Open();
                query.ExecuteNonQuery();

                MessageBox.Show("Compra entregada");

                FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
                this.Hide();
                fun.Show();

                cn.Close();
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
                cn.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            FuncionalidadesAdmin adm = new FuncionalidadesAdmin();
            this.Hide();
            adm.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (txtCupon.TextLength == 0)
                MessageBox.Show("Ingrese el codigo de compra");
            if (txtProve.TextLength == 0)
                MessageBox.Show("Ingrese el proveedor dueño de la oferta");
            else
                consumoOferta();
        }
    }
}
