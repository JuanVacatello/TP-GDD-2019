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
        DateTime fecha = Properties.Settings.Default.fecha_actual;
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public static string codigo;
        public static string cantidad;

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
            SqlCommand query = new SqlCommand("LIL_MIX.ofertasVigentesHastaDiaActual", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@diaactual", fecha));

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();

        }

        void efectuarCompra() 
        {
            try
            {
                SqlCommand query = new SqlCommand("LIL_MIX.comprarOferta", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@nombre_usuario", login.nombre_usuario));
                query.Parameters.Add(new SqlParameter("@oferta_codigo", this.txtOferta.Text));
                query.Parameters.Add(new SqlParameter("@cantidad", this.txtCantidad.Text));
                query.Parameters.Add(new SqlParameter("@diadecompra", fecha));
                query.Parameters.Add(new SqlParameter("@clientedestino", this.txtTransferir.Text));

                cn.Open();

                query.ExecuteNonQuery();

                MessageBox.Show("Compra efectuada.");

                NumeroDeCompra num = new NumeroDeCompra();
                this.Hide();
                num.Show();

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
            

            if (txtOferta.TextLength == 0)
                MessageBox.Show("Seleccione la oferta que desea comprar");
            else if (txtCantidad.TextLength == 0)
                MessageBox.Show("Ingrese la cantidad que desea comprar");
            else
                efectuarCompra();

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentRow.Selected = true;
            this.txtOferta.Text = dataGridView1.Rows[e.RowIndex].Cells[1].FormattedValue.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesCliente cli = new FuncionalidadesRol.FuncionalidadesCliente();
            this.Hide();
            cli.Show();
        }

        void limpiarCampos() 
        {
            txtOferta.Clear();
            txtCantidad.Clear();
            txtTransferir.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }
           

        private void button3_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void txtOferta_TextChanged(object sender, EventArgs e)
        {
            codigo = this.txtOferta.Text;
        }

        private void compranumeroDGV_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void txtCantidad_TextChanged(object sender, EventArgs e)
        {
            cantidad = this.txtCantidad.Text;
        }
    }
}
