﻿using System;
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
    public partial class CambiarContraAdmin : Form
    {
        public CambiarContraAdmin()
        {
            InitializeComponent();
        }

        private void Atrás_Click(object sender, EventArgs e)
        {
            FuncionalidadesAdmin fun = new FuncionalidadesAdmin();
            this.Hide();
            fun.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.modificarContrasenia", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@usuario_nombre", Login.loginAdm.nombre_usuario));
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
    }
}
