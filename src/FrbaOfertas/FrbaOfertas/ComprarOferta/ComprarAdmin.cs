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
    public partial class ComprarAdmin : Form
    {
        DateTime dte = new DateTime(2023, 3, 9, 16, 5, 7, 123); //reemplazar por fecha sistema
       // string fecha = ConfigurationManager.AppSettings["current_date"];
        //query.Parameters.Add(new SqlParameter("@diaactual", Convert.ToDateTime(fecha)))
        public ComprarAdmin()
        {
            InitializeComponent();
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

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        void efectuarCompra()
        {
            try
            {
                SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
                SqlCommand query = new SqlCommand("LIL_MIX.comprarOferta", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@nombre_usuario", this.txtUsuario.Text));
                query.Parameters.Add(new SqlParameter("@oferta_codigo", this.txtOferta.Text));
                query.Parameters.Add(new SqlParameter("@cantidad", this.txtCantidad.Text));
                query.Parameters.Add(new SqlParameter("@diadecompra", dte)); // aca tambien
                query.Parameters.Add(new SqlParameter("@clientedestino", this.txtTransferir.Text));

                cn.Open();
                query.ExecuteNonQuery();

                MessageBox.Show("Compra efectuada. El numero de compra es: ");

                FuncionalidadesRol.FuncionalidadesAdmin fun = new FuncionalidadesRol.FuncionalidadesAdmin();
                this.Hide();
                fun.Show();

                cn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
            //cmd.Parameters.AddWithValue("@name", nombre_s); //Parametrizamos la consulta

        private void button2_Click(object sender, EventArgs e)
        {   
            if(txtOferta.TextLength == 0)
                MessageBox.Show("Seleccione la oferta que desea comprar");
            else if (txtCantidad.TextLength == 0)
                MessageBox.Show("Ingrese la cantidad que desea comprar");
            else if(txtUsuario.TextLength == 0)
                MessageBox.Show("Ingrese el usuario del cliente que realiza la compra");
            else
                efectuarCompra();
              
        }
        
        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            dataGridView1.CurrentRow.Selected = true;
            this.txtOferta.Text = dataGridView1.Rows[e.RowIndex].Cells[1].FormattedValue.ToString();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin fun = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }

        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {

        }

        void limpiarCampos()
        {
            txtOferta.Clear();
            txtCantidad.Clear();
            txtUsuario.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

     
    }
}
