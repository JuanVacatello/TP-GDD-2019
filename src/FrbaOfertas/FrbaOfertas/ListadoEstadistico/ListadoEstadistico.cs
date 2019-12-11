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

namespace FrbaOfertas.ListadoEstadistico
{
    public partial class ListadoEstadistico : Form
    {
        public ListadoEstadistico()
        {
            InitializeComponent();
            cargarDatosListado();
            cargarDatosSemestre();
        }

        public void cargarDatosListado()
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.seleccionarListado", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["listado_descripcion"] = "Seleccione un listado";
            dt.Rows.InsertAt(fila, 0);

            comboBox1.ValueMember = "listado_descripcion";
            comboBox1.DisplayMember = "listado_descripcion";
            comboBox1.DataSource = dt;

        }

        public void cargarDatosSemestre()
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            cn.Open();
            SqlCommand query = new SqlCommand("LIL_MIX.seleccionarSemestre", cn);
            query.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cn.Close();

            DataRow fila = dt.NewRow();
            fila["semestre_id"] = "Seleccione un semestre";
            dt.Rows.InsertAt(fila, 0);

            comboBox2.ValueMember = "semestre_id";
            comboBox2.DisplayMember = "semestre_id";
            comboBox2.DataSource = dt;

        }

        private void confeccionarListado(string listado_descripcion, string semestre_id)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            SqlCommand query = new SqlCommand("LIL_MIX.crearListadoEstadistico", cn);
            query.CommandType = CommandType.StoredProcedure;
            query.Parameters.Add(new SqlParameter("@semestre", Convert.ToInt32(semestre_id)));
            query.Parameters.Add(new SqlParameter("@listado", listado_descripcion));
            query.Parameters.Add(new SqlParameter("@anio", Convert.ToInt32(this.txtAnio.Text)));

            cn.Open();
            query.ExecuteNonQuery();
            cn.Close();
        }

        private void btnVolver_Click(object sender, EventArgs e)
        {
            FuncionalidadesRol.FuncionalidadesAdmin cre = new FuncionalidadesRol.FuncionalidadesAdmin();
            this.Hide();
            cre.Show();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void btnSeleccionar_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedValue.ToString() != null)
            {
                if (comboBox2.SelectedValue.ToString() != null)
                {
                    string listado_descripcion = comboBox1.SelectedValue.ToString();
                    string semestre_id = comboBox2.SelectedValue.ToString();
                    confeccionarListado(listado_descripcion, semestre_id);
                }
            }
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
