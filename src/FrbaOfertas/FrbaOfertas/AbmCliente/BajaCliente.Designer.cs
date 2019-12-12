namespace FrbaOfertas.AbmCliente
{
    partial class BajaCliente
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.txtNombreFiltro = new System.Windows.Forms.TextBox();
            this.txtApellidoFiltro = new System.Windows.Forms.TextBox();
            this.txtMailFiltro = new System.Windows.Forms.TextBox();
            this.txtDniFiltro = new System.Windows.Forms.TextBox();
            this.dgvBajaCliente = new System.Windows.Forms.DataGridView();
            this.button2 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvBajaCliente)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(35, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(93, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Filtre su busqueda";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(584, 274);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 4;
            this.button1.Text = "Atras";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(35, 51);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(44, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Nombre";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(165, 51);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(44, 13);
            this.label3.TabIndex = 8;
            this.label3.Text = "Apellido";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(297, 51);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(26, 13);
            this.label4.TabIndex = 9;
            this.label4.Text = "Mail";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(421, 51);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(26, 13);
            this.label5.TabIndex = 10;
            this.label5.Text = "DNI";
            // 
            // txtNombreFiltro
            // 
            this.txtNombreFiltro.Location = new System.Drawing.Point(38, 77);
            this.txtNombreFiltro.Name = "txtNombreFiltro";
            this.txtNombreFiltro.Size = new System.Drawing.Size(100, 20);
            this.txtNombreFiltro.TabIndex = 11;
            // 
            // txtApellidoFiltro
            // 
            this.txtApellidoFiltro.Location = new System.Drawing.Point(168, 77);
            this.txtApellidoFiltro.Name = "txtApellidoFiltro";
            this.txtApellidoFiltro.Size = new System.Drawing.Size(100, 20);
            this.txtApellidoFiltro.TabIndex = 12;
            // 
            // txtMailFiltro
            // 
            this.txtMailFiltro.Location = new System.Drawing.Point(300, 77);
            this.txtMailFiltro.Name = "txtMailFiltro";
            this.txtMailFiltro.Size = new System.Drawing.Size(100, 20);
            this.txtMailFiltro.TabIndex = 13;
            // 
            // txtDniFiltro
            // 
            this.txtDniFiltro.Location = new System.Drawing.Point(424, 77);
            this.txtDniFiltro.Name = "txtDniFiltro";
            this.txtDniFiltro.Size = new System.Drawing.Size(100, 20);
            this.txtDniFiltro.TabIndex = 14;
            // 
            // dgvBajaCliente
            // 
            this.dgvBajaCliente.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvBajaCliente.Location = new System.Drawing.Point(28, 103);
            this.dgvBajaCliente.Name = "dgvBajaCliente";
            this.dgvBajaCliente.Size = new System.Drawing.Size(631, 150);
            this.dgvBajaCliente.TabIndex = 15;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(541, 74);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(118, 23);
            this.button2.TabIndex = 16;
            this.button2.Text = "Filtrar";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // BajaCliente
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(682, 309);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.dgvBajaCliente);
            this.Controls.Add(this.txtDniFiltro);
            this.Controls.Add(this.txtMailFiltro);
            this.Controls.Add(this.txtApellidoFiltro);
            this.Controls.Add(this.txtNombreFiltro);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.button1);
            this.Name = "BajaCliente";
            this.Text = "Baja Cliente";
            ((System.ComponentModel.ISupportInitialize)(this.dgvBajaCliente)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtNombreFiltro;
        private System.Windows.Forms.TextBox txtApellidoFiltro;
        private System.Windows.Forms.TextBox txtMailFiltro;
        private System.Windows.Forms.TextBox txtDniFiltro;
        private System.Windows.Forms.DataGridView dgvBajaCliente;
        private System.Windows.Forms.Button button2;

    }
}