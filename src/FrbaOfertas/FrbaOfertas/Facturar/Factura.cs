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


namespace FrbaOfertas.Facturar
{
    public partial class Factura : Form
    {
        SqlConnection cn = new SqlConnection(Properties.Settings.Default.GD2C2019ConnectionString);

        public Factura()
        {
            InitializeComponent();
        }

        private void Facturar_Load(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            SqlCommand query = new SqlCommand("LIL_MIX.todasLasOfertasAdquiridas", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@fecha_inicio", ElegirFechayProveedor.inicio));
            query.Parameters.Add(new SqlParameter("@fecha_fin", ElegirFechayProveedor.fin));
            query.Parameters.Add(new SqlParameter("@proveedor_cuit",ElegirFechayProveedor.cuit_prov));

            SqlDataAdapter da = new SqlDataAdapter(query);
            cn.Open();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.ReadOnly = true;
            cn.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommand query = new SqlCommand("LIL_MIX.facturacionProveedor", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@fecha_inicio", ElegirFechayProveedor.inicio));
            query.Parameters.Add(new SqlParameter("@fecha_fin", ElegirFechayProveedor.fin));
            query.Parameters.Add(new SqlParameter("@proveedor_cuit", ElegirFechayProveedor.cuit_prov));


            cn.Open();
            query.ExecuteNonQuery();

            MessageBox.Show("Proveedor facturado");

            MostrarImporteAdmin mos = new MostrarImporteAdmin();
            this.Hide();
            mos.Show();

            cn.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Facturar.ElegirFechayProveedor fac = new Facturar.ElegirFechayProveedor();
            this.Hide();
            fac.Show();

        }

        void limpiarCampos()
        {
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();

        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

    }
}
