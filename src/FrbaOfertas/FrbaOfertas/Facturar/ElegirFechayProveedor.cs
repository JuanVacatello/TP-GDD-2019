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
    public partial class ElegirFechayProveedor : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public static DateTime inicio;
        public static DateTime fin;
        public static String cuit_prov; 

        public ElegirFechayProveedor()
        {
            InitializeComponent();
        }


        private void button2_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin fun = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }

        void elegirProveedorAFacturar()
        {
            Factura fa = new Factura();
            this.Hide();
            fa.Show();

            inicio = this.dateTimePicker1.Value;
            fin = this.dateTimePicker2.Value;
            cuit_prov = this.textBox1.Text;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.TextLength == 0)
                MessageBox.Show("Elija a qué proveedor desea facturar");
            else
                elegirProveedorAFacturar();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentRow.Selected = true;
            this.textBox1.Text = dataGridView1.Rows[e.RowIndex].Cells[3].FormattedValue.ToString();
        }

        public void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        void verProveedoresAFacturar()
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand query = new SqlCommand("LIL_MIX.proveedores", cn);
            query.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (dateTimePicker1.Value > dateTimePicker2.Value)
                MessageBox.Show("Seleccione un período valido"); //NO ESTA FUNCIONANDO BIEN NO SE SI LO QUIEREN DEJAR O QUE
            else
                verProveedoresAFacturar();
        }

        void limpiarCampos()
        {
            textBox1.Clear();
            //falta el clear del datetimepicker
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();

        }


        private void button4_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }
    }
}
