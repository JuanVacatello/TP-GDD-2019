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
    public partial class OfertasVigentes : Form
    {
        public OfertasVigentes()
        {
            InitializeComponent();
        }

     
        private void button2_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin of = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            of.Show();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }



        private void button1_Click(object sender, EventArgs e)
        {
            //using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString))
            //{

            //    cn.Open();
            //    string fecha = ConfigurationManager.AppSettings["current_date"];
            //    SqlCommand query = new SqlCommand("LIL_MIX.modificaRolNombre", cn);
            //    query.Parameters.Add(new SqlParameter("@diaactual", Convert.ToDateTime(fecha)));
            //    SqlDataAdapter da = new SqlDataAdapter(query, cn);
                
            //}

        }

     

        
    }
}
