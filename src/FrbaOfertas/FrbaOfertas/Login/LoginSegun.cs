using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas.Login
{
    public partial class LoginSegun : Form
    {
        public LoginSegun()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            loginAdm adm = new loginAdm();
            this.Hide(); 
            adm.Show();
              
        }

        private void button2_Click(object sender, EventArgs e)
        {
            login cli = new login();
            this.Hide();
            cli.Show();
            
        }

        private void button3_Click(object sender, EventArgs e)
        {
            loginProv prov = new loginProv();
            this.Hide();
            prov.Show();
        }

        private void LoginSegun_Load(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
