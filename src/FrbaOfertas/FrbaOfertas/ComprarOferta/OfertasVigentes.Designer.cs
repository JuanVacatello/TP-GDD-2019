namespace FrbaOfertas.ComprarOferta
{
    partial class OfertasVigentes
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
            this.components = new System.ComponentModel.Container();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.codigoDeOfertaDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.descripcionDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.precioDeListaDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.precioDeOfertaDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.stockDisponibleDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Seleccionar = new System.Windows.Forms.DataGridViewButtonColumn();
            this.ofertasVigentesHastaDiaActualBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.gD2C2019DataSet = new FrbaOfertas.GD2C2019DataSet();
            this.ofertasVigentesHastaDiaActualTableAdapter = new FrbaOfertas.GD2C2019DataSetTableAdapters.ofertasVigentesHastaDiaActualTableAdapter();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ofertasVigentesHastaDiaActualBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gD2C2019DataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(501, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(117, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "OFERTAS VIGENTES:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(475, 412);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(143, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Cantidad que desea comprar";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(495, 438);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(100, 20);
            this.textBox1.TabIndex = 4;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(413, 485);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(113, 23);
            this.button2.TabIndex = 5;
            this.button2.Text = "Atrás";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(556, 485);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(113, 23);
            this.button3.TabIndex = 6;
            this.button3.Text = "Comprar oferta";
            this.button3.UseVisualStyleBackColor = true;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.codigoDeOfertaDataGridViewTextBoxColumn,
            this.descripcionDataGridViewTextBoxColumn,
            this.precioDeListaDataGridViewTextBoxColumn,
            this.precioDeOfertaDataGridViewTextBoxColumn,
            this.stockDisponibleDataGridViewTextBoxColumn,
            this.cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn,
            this.Seleccionar});
            this.dataGridView1.DataSource = this.ofertasVigentesHastaDiaActualBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(49, 53);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(944, 338);
            this.dataGridView1.TabIndex = 7;
            // 
            // codigoDeOfertaDataGridViewTextBoxColumn
            // 
            this.codigoDeOfertaDataGridViewTextBoxColumn.DataPropertyName = "Codigo de oferta";
            this.codigoDeOfertaDataGridViewTextBoxColumn.HeaderText = "Codigo de oferta";
            this.codigoDeOfertaDataGridViewTextBoxColumn.Name = "codigoDeOfertaDataGridViewTextBoxColumn";
            // 
            // descripcionDataGridViewTextBoxColumn
            // 
            this.descripcionDataGridViewTextBoxColumn.DataPropertyName = "Descripcion";
            this.descripcionDataGridViewTextBoxColumn.HeaderText = "Descripcion";
            this.descripcionDataGridViewTextBoxColumn.Name = "descripcionDataGridViewTextBoxColumn";
            this.descripcionDataGridViewTextBoxColumn.Width = 300;
            // 
            // precioDeListaDataGridViewTextBoxColumn
            // 
            this.precioDeListaDataGridViewTextBoxColumn.DataPropertyName = "Precio de lista";
            this.precioDeListaDataGridViewTextBoxColumn.HeaderText = "Precio de lista";
            this.precioDeListaDataGridViewTextBoxColumn.Name = "precioDeListaDataGridViewTextBoxColumn";
            // 
            // precioDeOfertaDataGridViewTextBoxColumn
            // 
            this.precioDeOfertaDataGridViewTextBoxColumn.DataPropertyName = "Precio de oferta";
            this.precioDeOfertaDataGridViewTextBoxColumn.HeaderText = "Precio de oferta";
            this.precioDeOfertaDataGridViewTextBoxColumn.Name = "precioDeOfertaDataGridViewTextBoxColumn";
            // 
            // stockDisponibleDataGridViewTextBoxColumn
            // 
            this.stockDisponibleDataGridViewTextBoxColumn.DataPropertyName = "Stock disponible";
            this.stockDisponibleDataGridViewTextBoxColumn.HeaderText = "Stock disponible";
            this.stockDisponibleDataGridViewTextBoxColumn.Name = "stockDisponibleDataGridViewTextBoxColumn";
            // 
            // cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn
            // 
            this.cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn.DataPropertyName = "Cantidad máxima que puede comprar cada cliente";
            this.cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn.HeaderText = "Cantidad máxima que puede comprar cada cliente";
            this.cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn.Name = "cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn";
            // 
            // Seleccionar
            // 
            this.Seleccionar.HeaderText = "Seleccionar";
            this.Seleccionar.Name = "Seleccionar";
            // 
            // ofertasVigentesHastaDiaActualBindingSource
            // 
            this.ofertasVigentesHastaDiaActualBindingSource.DataMember = "ofertasVigentesHastaDiaActual";
            this.ofertasVigentesHastaDiaActualBindingSource.DataSource = this.gD2C2019DataSet;
            // 
            // gD2C2019DataSet
            // 
            this.gD2C2019DataSet.DataSetName = "GD2C2019DataSet";
            this.gD2C2019DataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // ofertasVigentesHastaDiaActualTableAdapter
            // 
            this.ofertasVigentesHastaDiaActualTableAdapter.ClearBeforeFill = true;
            // 
            // OfertasVigentes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1023, 538);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "OfertasVigentes";
            this.Text = "Ofertas vigentes";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ofertasVigentesHastaDiaActualBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gD2C2019DataSet)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource ofertasVigentesHastaDiaActualBindingSource;
        private GD2C2019DataSet gD2C2019DataSet;
        private GD2C2019DataSetTableAdapters.ofertasVigentesHastaDiaActualTableAdapter ofertasVigentesHastaDiaActualTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn codigoDeOfertaDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn descripcionDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn precioDeListaDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn precioDeOfertaDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn stockDisponibleDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn cantidadMáximaQuePuedeComprarCadaClienteDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewButtonColumn Seleccionar;
    }
}