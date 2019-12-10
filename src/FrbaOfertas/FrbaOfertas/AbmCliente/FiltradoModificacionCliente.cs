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

namespace FrbaOfertas.AbmCliente
{
    public partial class FiltradoModificacionCliente : Form
    {
        public FiltradoModificacionCliente()
        {
            InitializeComponent();
        }

        private void btnAtras_Click(object sender, EventArgs e)
        {
            ABMDeCliente abm = new ABMDeCliente();
            this.Hide();
            abm.Show();
           
        }

        /* private void CargarFiltro()
         {

             try
             {
                
                 string nombre1;
                 string apellido1;
                 string mail1;
                 string dni1;
                 dataGridFiltradoClientes.DataSource = null;
                 if (txtNombre.TextLength == 0) Id_Crucero = "NULL"; else Id_Crucero = txtID_Crucero.Text;
                 if (txtNombre.TextLength == 0) nombre1 = "NULL"; else nombre1 = "'" + txtNombre.Text + "'";
                 //Marca = "NULL";
                 if (txtModelo.TextLength == 0) modelo1 = "NULL"; else modelo1 = "'" + txtModelo.Text + "'";
                 if (txtMarca.TextLength == 0) marca1 = "NULL"; else marca1 = "'" + txtMarca.Text + "'";
                 SQLConnector con = new SQLConnector();
                 // MessageBox.Show("" + Modelo + "'," + idMarca + ",'" + Nombre + "'," + Id_Crucero);
                 dataGridFiltradoClientes.DataSource = con.DameDT("exec SQL_INJECTION.FiltrarCruceros " + modelo1 + "," + marca1 + "," + nombre1 + "," + Id_Crucero);

             }
             catch (Exception Em)
             {

                 MessageBox.Show(Em.Message.ToString());
             }
         } 

         private void FiltradoModificacionCliente_Load(object sender, EventArgs e)
         {
             dataGridFiltradoClientes.DataSource = GetListaClientes();
         }

         private DataTable GetListaClientes(){
             DataTable query1 = new DataTable();
             string cn = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
             using (SqlConnection con = new SqlConnection(cn)) {
                 using (SqlCommand query = new SqlCommand(Select bla bla, cn)){
                        cn.Open();
                        SqlDataReader reader = query.ExecuteReader();
                 }

             }


             SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
             SqlCommand query = new SqlCommand("LIL_MIX.listadoClientes", cn);
             query.CommandType = CommandType.StoredProcedure;
             query.Parameters.Add(new SqlParameter("@nombre", this.txtNombre.Text));
             query.Parameters.Add(new SqlParameter("@apellido", this.txtApellido.Text));
             query.Parameters.Add(new SqlParameter("@dni", this.txtDni.Text));
             query.Parameters.Add(new SqlParameter("@mail", this.txtMail.Text));
             cn.Open();
             query.ExecuteNonQuery();
             cn.Close();

             return query1;
             }
         * */

    }
}
