using Npgsql;
using System;
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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost;port=5432;Database=dbproducts;user ID=postgres;password=12345");
        private void button1_Click(object sender, EventArgs e)
        {
            string query = "select * from categories";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connection);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command1 = new NpgsqlCommand("insert into categories(categoryid,categoryname) values (@p1,@p2)", connection);
            command1.Parameters.AddWithValue("@p1",int .Parse( TxtCategoryid.Text));
            command1.Parameters.AddWithValue("@p2", TxtCategoryName.Text);
            command1.ExecuteNonQuery();            // değişiklikler veri tabanına yansıtılır.
            connection.Close();
            MessageBox.Show("Adding category was successful.");
        }

        private void button4_Click(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {

        }
    }
}
