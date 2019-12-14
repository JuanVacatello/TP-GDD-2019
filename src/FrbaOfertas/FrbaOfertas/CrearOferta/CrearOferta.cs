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

namespace FrbaOfertas.CrearOferta
{
    public partial class CrearOferta : Form
    {
        DateTime fecha = Properties.Settings.Default.fecha_actual;
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public CrearOferta()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin cre = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            cre.Show();

        }

        void crearOferta()
        {
            try
            {
                SqlCommand query = new SqlCommand("LIL_MIX.crearOferta", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@usuario_nombre", this.txtUsuario.Text));
                query.Parameters.Add(new SqlParameter("@oferta_descripcion", this.txtDescrip.Text));
                query.Parameters.Add(new SqlParameter("@oferta_fecha_vencimiento", this.dateTimePicker1.Value));
                query.Parameters.Add(new SqlParameter("@oferta_precio_oferta", this.txtPrecioOferta.Text));
                query.Parameters.Add(new SqlParameter("@oferta_precio_lista", this.txtPrecioLista.Text));
                query.Parameters.Add(new SqlParameter("@oferta_stock", this.txtStock.Text));
                query.Parameters.Add(new SqlParameter("@oferta_restriccion_compra", this.txtMaximo.Text));
                query.Parameters.Add(new SqlParameter("@fechaactualdelsistema", fecha));

                cn.Open();
                query.ExecuteNonQuery();

                MessageBox.Show("Oferta cargada");

                FuncionalidadesRol.FuncionalidadesAdmin cre = new FuncionalidadesRol.FuncionalidadesAdmin();
                this.Hide();
                cre.Show();

                cn.Close();
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
                cn.Close();
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (txtUsuario.TextLength == 0)
                MessageBox.Show("Ingrese el usuario del proveedor dueño de la oferta");
            else if (txtDescrip.TextLength == 0)
                MessageBox.Show("Ingrese la descripcion de la oferta");
            else if (txtPrecioOferta.TextLength == 0)
                MessageBox.Show("Ingrese el precio de oferta de la oferta");
            else if (txtPrecioLista.TextLength == 0)
                MessageBox.Show("Ingrese el precio de lista de la oferta");
            else if (txtStock.TextLength == 0)
                MessageBox.Show("Ingrese el stock de la oferta");
            else if (txtMaximo.TextLength == 0)
                MessageBox.Show("Ingrese cantidad de compra máxima que puede hacer un cliente");
            else
                crearOferta();
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin cre = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            cre.Show();
        }
        }
    }

