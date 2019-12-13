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

namespace FrbaOfertas.CargaDeCredito
{
    public partial class CargaCreditoCliente : Form
    {
        DateTime dte = new DateTime(2023, 3, 9, 16, 5, 7, 123); //reemplazar por fecha sistema

        public CargaCreditoCliente()
        {
            InitializeComponent();
            cargarDatos();
        }

        public void cargarDatos()
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.listadoTiposDePago", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["tipo_de_pago_descripcion"] = "Seleccione un tipo de pago";
            dt.Rows.InsertAt(fila, 0);

            comboBox1.ValueMember = "tipo_de_pago_descripcion";
            comboBox1.DisplayMember = "tipo_de_pago_descripcion";
            comboBox1.DataSource = dt;
        }

        public void cargarCredito(string tipo_de_pago_descripcion)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.cargarCredito", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@tipo_de_pago", tipo_de_pago_descripcion));
            query.Parameters.Add(new SqlParameter("@monto", this.txtMonto.Text));
            query.Parameters.Add(new SqlParameter("@tarjeta_numero", this.txtTarjetaNumero.Text));
            query.Parameters.Add(new SqlParameter("@tarjeta_fecha_vencimiento", this.dateTimePicker1.Value));
          //  string fecha = ConfigurationManager.AppSettings["current_date"];
            query.Parameters.Add(new SqlParameter("@fechadecarga", dte)); // aca tambien
            query.Parameters.Add(new SqlParameter("@tarjeta_tipo", comboBox2.SelectedValue.ToString()));
            query.Parameters.Add(new SqlParameter("@usuario_nombre", login.nombre_usuario));

            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Credito Cargado");

            FuncionalidadesRol.FuncionalidadesCliente abmrol = new FuncionalidadesRol.FuncionalidadesCliente();
            this.Hide();
            abmrol.Show();

            cn.Close();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesCliente fun = new FuncionalidadesRol.FuncionalidadesCliente();
            this.Hide();
            fun.Show();
        }

        private void carga()
        {
            try
            {
                if ((comboBox1.SelectedValue.ToString() != null))
                {
                    string tipo_de_pago_descripcion = comboBox1.SelectedValue.ToString();
                    cargarCredito(tipo_de_pago_descripcion);

                }
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
            }

        }
        

        private void button2_Click(object sender, EventArgs e)
        {
            //BOTON CARGAR
            if (comboBox1.SelectedValue.ToString() == null)
                MessageBox.Show("Ingrese el tipo de pago");
            else if (txtMonto.TextLength == 0)
                MessageBox.Show("Ingrese el monto que desea cargar");
            else
                carga();    
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void CargaCreditoCliente_Load(object sender, EventArgs e)
        {

        }
    }
}
