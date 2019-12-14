namespace FrbaOfertas.ComprarOferta
{
    partial class NumeroDeCompra
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
            this.compranumeroDGV = new System.Windows.Forms.DataGridView();
            this.button5 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.compranumeroDGV)).BeginInit();
            this.SuspendLayout();
            // 
            // compranumeroDGV
            // 
            this.compranumeroDGV.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.compranumeroDGV.Location = new System.Drawing.Point(78, 41);
            this.compranumeroDGV.Name = "compranumeroDGV";
            this.compranumeroDGV.Size = new System.Drawing.Size(132, 65);
            this.compranumeroDGV.TabIndex = 33;
            this.compranumeroDGV.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.compranumeroDGV_CellContentClick);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(102, 112);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(75, 23);
            this.button5.TabIndex = 32;
            this.button5.Text = "OK";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(49, 12);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(187, 23);
            this.button1.TabIndex = 34;
            this.button1.Text = "Visualizar numero de compra";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // NumeroDeCompra
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(289, 147);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.compranumeroDGV);
            this.Controls.Add(this.button5);
            this.Name = "NumeroDeCompra";
            this.Text = "Número de compra/cupon";
            ((System.ComponentModel.ISupportInitialize)(this.compranumeroDGV)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView compranumeroDGV;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button1;
    }
}