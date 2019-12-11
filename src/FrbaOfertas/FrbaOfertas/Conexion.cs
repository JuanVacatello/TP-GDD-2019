using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas
{
    class Conexion
    {
        public static SqlConnection ObtenerConexion()
        {
            try
            {
                SqlConnection conectar = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ToString());
                conectar.Open();
                return conectar;
            }
            catch (Exception)
            {
                throw new Exception("Error en la conexion");
            }
        }

        public static SqlConnection CerrarConexion()
        {
            SqlConnection conectar = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ToString());
            conectar.Close();
            return conectar;
        }
    }
}

