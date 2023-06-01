using Npgsql;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PostgreProductProject
{
    public partial class FrmProduct : Form
    {
        public FrmProduct()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost;port=5432;Database=dbproducts;user ID=postgres;password=12345");
        private void BtnList_Click(object sender, EventArgs e)
        {
            string query = "select * from products";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connection);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from categories ",connection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            comboBox1.DisplayMember = "categoryname";
            comboBox1.ValueMember = "categoryid";
            comboBox1.DataSource = dt;
            connection.Close();
         
        }

        private void BtnAdd_Click(object sender, EventArgs e)
        {
            TxtProductName.Text = comboBox1.SelectedValue.ToString();

        }
    }
}
