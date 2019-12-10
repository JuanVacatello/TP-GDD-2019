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
            adm.ShowDialog();
            if (adm.DialogResult == DialogResult.Yes)
            { }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            login cli = new login();
            cli.ShowDialog();
            if (cli.DialogResult == DialogResult.Yes)
            { }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            loginProv prov = new loginProv();
            prov.ShowDialog();
            if (prov.DialogResult == DialogResult.Yes)
            { }
        }
    }
}
