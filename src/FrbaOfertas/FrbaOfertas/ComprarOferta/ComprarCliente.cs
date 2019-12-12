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
    public partial class ComprarCliente : Form

    {
        DateTime dte = new DateTime(2023, 3, 9, 16, 5, 7, 123); //reemplazar por fecha sistema

        public ComprarCliente()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {

            DataTable dt = new DataTable();
            dt.Clear();
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.ofertasVigentesHastaDiaActual", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@diaactual", dte)); //aca tambien

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.comprarOferta", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@nombre_usuario", this.txtUsuario.Text));
            query.Parameters.Add(new SqlParameter("@oferta_codigo", this.textBox1.Text));
            query.Parameters.Add(new SqlParameter("@cantidad", this.txtCantidad.Text));
            query.Parameters.Add(new SqlParameter("@diadecompra", dte)); // aca tambien
            query.Parameters.Add(new SqlParameter("@clientedestino", this.txtTransferir.Text));

            string numeroComp = "SELECT TOP 1 compra_id FROM LIL_MIX.compra ORDER BY 1 DESC";
            SqlCommand cmd = new SqlCommand(numeroComp, cn);

            cn.Open();
            query.ExecuteNonQuery();
            MessageBox.Show("Compra efectuada. El numero de compra es: ");
            MessageBox.Show(numeroComp);
            cn.Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentRow.Selected = true;
            this.textBox1.Text = dataGridView1.Rows[e.RowIndex].Cells[1].FormattedValue.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesCliente cli = new FuncionalidadesRol.FuncionalidadesCliente();
            this.Hide();
            cli.Show();
        }
    }
}
