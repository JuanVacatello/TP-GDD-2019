﻿namespace FrbaOfertas.FuncionalidadesRol
{
    partial class CambiarContraCli
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
            this.txtContraActual = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txtContraNueva = new System.Windows.Forms.TextBox();
            this.Atrás = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // txtContraActual
            // 
            this.txtContraActual.Location = new System.Drawing.Point(12, 27);
            this.txtContraActual.Name = "txtContraActual";
            this.txtContraActual.Size = new System.Drawing.Size(208, 20);
            this.txtContraActual.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(9, 11);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(147, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Ingrese su contraseña actual:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(9, 69);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(145, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Ingrese la nueva contraseña:";
            // 
            // txtContraNueva
            // 
            this.txtContraNueva.Location = new System.Drawing.Point(12, 85);
            this.txtContraNueva.Name = "txtContraNueva";
            this.txtContraNueva.Size = new System.Drawing.Size(208, 20);
            this.txtContraNueva.TabIndex = 5;
            // 
            // Atrás
            // 
            this.Atrás.Location = new System.Drawing.Point(12, 123);
            this.Atrás.Name = "Atrás";
            this.Atrás.Size = new System.Drawing.Size(75, 23);
            this.Atrás.TabIndex = 6;
            this.Atrás.Text = "Atrás";
            this.Atrás.UseVisualStyleBackColor = true;
            this.Atrás.Click += new System.EventHandler(this.Atrás_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(93, 123);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(127, 23);
            this.button1.TabIndex = 7;
            this.button1.Text = "Cambiar contraseña";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // CambiarContraCli
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(230, 160);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.Atrás);
            this.Controls.Add(this.txtContraNueva);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtContraActual);
            this.Name = "CambiarContraCli";
            this.Text = "CambiarContraCli";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtContraActual;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtContraNueva;
        private System.Windows.Forms.Button Atrás;
        private System.Windows.Forms.Button button1;
    }
}