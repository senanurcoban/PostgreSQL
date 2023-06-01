using Npgsql;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
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
           // TxtProductName.Text = comboBox1.SelectedValue.ToString();
            connection.Open();
            NpgsqlCommand command=new NpgsqlCommand("insert into products (productid,productname,stock,purchaseprice,saleprice,image,category)" +
                " values (@p1,@p2,@p3,@p4,@p5,@p6,@p7)" ,connection);
            command.Parameters.AddWithValue("@p1",int.Parse(TxtProductid.Text));
            command.Parameters.AddWithValue("@p2",TxtProductName.Text);
            command.Parameters.AddWithValue("@p3",int.Parse(numericUpDown1.Value.ToString()));
            command.Parameters.AddWithValue("@p4",double.Parse(TxtPurchaseprice.Text));
            command.Parameters.AddWithValue("@p5",double.Parse(TxtSaleprice.Text));
            command.Parameters.AddWithValue("@p6",Txtİmage.Text);
            command.Parameters.AddWithValue("@p7",comboBox1.SelectedValue.ToString());
            command.ExecuteNonQuery();
            connection.Close();
            MessageBox.Show("Product registration was successful.", "Information",MessageBoxButtons.OK,MessageBoxIcon.Information);
        }

        private void BtnDelete_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command2 = new NpgsqlCommand("delete from products where productid=@p1", connection);
            command2.Parameters.AddWithValue("@p1", int.Parse(TxtProductid.Text));
            command2.ExecuteNonQuery();
            connection.Close();
            MessageBox.Show("The product deletion was successful.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Stop);


        }

        private void BtnUpdate_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command3 = new NpgsqlCommand("update products set productname=@p1,stock=@p2,purchaseprice=@p3 where productid=@p4", connection);
            command3.Parameters.AddWithValue("@p1", TxtProductName.Text);
            command3.Parameters.AddWithValue("@p2", int.Parse(numericUpDown1.Value.ToString()));
            command3.Parameters.AddWithValue("@p3", double.Parse(TxtPurchaseprice.Text));
            command3.Parameters.AddWithValue("@p4", int.Parse(TxtProductid.Text));
            command3.ExecuteNonQuery();
            connection.Close();
            MessageBox.Show("The product update was successful.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void BtnView_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command4 = new NpgsqlCommand("select * from productlist", connection);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(command4);
            DataSet dt = new DataSet();
            da.Fill(dt);
            dataGridView1.DataSource = dt.Tables[0];
            connection.Close();

        }
    }
}
