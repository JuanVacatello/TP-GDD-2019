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
    public partial class CambiarContraAUsuarios : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public CambiarContraAUsuarios()
        {
            InitializeComponent();
        }

        private void Atrás_Click(object sender, EventArgs e)
        {
            FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }

        private void cambiarContra()
        {
            try
            {
                SqlCommand query = new SqlCommand("LIL_MIX.modificarContrasenia", cn);
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add(new SqlParameter("@usuario_nombre", this.textBox1.Text));
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
            if (textBox1.TextLength == 0)
                MessageBox.Show("Ingrese el nombre de usuario al que le desea cambiar la contraseña");
            else if(txtContraActual.TextLength == 0)
                MessageBox.Show("Ingrese su contraseña actual");
            else if (txtContraNueva.TextLength == 0)
                MessageBox.Show("Ingrese su nueva contraseña");
            else
            {
                cambiarContra();

            }
        }
    }
}
