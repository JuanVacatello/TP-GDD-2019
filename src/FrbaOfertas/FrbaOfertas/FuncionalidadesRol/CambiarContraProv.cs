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
    public partial class CambiarContraProv : Form
    {
        public CambiarContraProv()
        {
            InitializeComponent();
        }

        private void Atrás_Click(object sender, EventArgs e)
        {
            FuncionalidadesProveedor fun = new FuncionalidadesProveedor();
            this.Hide();
            fun.Show();
        }

        private void cambiarContra()
        {
            try
            {
                SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
                SqlCommand query = new SqlCommand("LIL_MIX.modificarContrasenia", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@usuario_nombre", Login.loginProv.nombre_usuario));
                query.Parameters.Add(new SqlParameter("@anteriorcontra", this.txtContraActual.Text));
                query.Parameters.Add(new SqlParameter("@nuevacontra", this.txtContraNueva.Text));

                cn.Open();
                query.ExecuteNonQuery();

                MessageBox.Show("Contraseña actualizada con exito");

                FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
                this.Hide();
                fun.Show();

                cn.Close();
            }
            catch (Exception Em)
            {
                MessageBox.Show(Em.Message.ToString());
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (txtContraActual.TextLength == 0)
                MessageBox.Show("Ingrese su contraseña actual");
            else if (txtContraNueva.TextLength == 0)
                MessageBox.Show("Ingrese su nueva contraseña");
            else
                cambiarContra();
        }

        private void CambiarContraProv_Load(object sender, EventArgs e)
        {

        }
    }
}
