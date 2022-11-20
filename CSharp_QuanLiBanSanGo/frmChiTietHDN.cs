﻿using CSharp_QuanLiBanSanGo.Class;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CSharp_QuanLiBanSanGo
{
    public partial class frmChiTietHDN : Form
    {
        DBconfig dtBase = new DBconfig();
        string soHDN;
        string queryLoad;

        public frmChiTietHDN()
        {
            InitializeComponent();
        }

        public frmChiTietHDN(string soHDN, string query)
        {
            InitializeComponent();
            this.soHDN = soHDN;
            this.queryLoad = query;
        }

        private bool checkValidation()
        {
            if (cboMatHang.Text.Trim() == "")
            {
                MessageBox.Show("Hãy chọn mặt hàng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                cboMatHang.Focus();

                return false;
            }

            if (txtSoLuong.Text.Trim() == "")
            {
                MessageBox.Show("Hãy nhập số lượng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                txtSoLuong.Focus();

                return false;
            }

            if (txtDonGia.Text.Trim() == "")
            {
                MessageBox.Show("Hãy nhập đơn giá", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                txtDonGia.Focus();

                return false;
            }

            if(txtGiamGia.Text.Trim() == "")
            {
                MessageBox.Show("Hãy nhập giảm giá", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                txtGiamGia.Focus();

                return false;
            }    

            return true;
        }

        private void refreshInput()
        {
            cboMatHang.Text = "";
            txtSoLuong.Text = "";
            txtDonGia.Text = "";
            txtGiamGia.Text = "";
            txtThanhTien.Text = "";

            btnSua.Enabled = false;
            btnXoa.Enabled = false;
        }

        private void load_MatHang()
        {
            cboMatHang.DataSource = dtBase.getTable("SELECT * FROM tDMHangHoa");
            cboMatHang.ValueMember = "MaHang";
            cboMatHang.DisplayMember = "TenHangHoa";
        }

        private void txtSoLuong_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void txtDonGia_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void txtGiamGia_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void frmChiTietHDN_Load(object sender, EventArgs e)
        {
            this.Text += soHDN;
            lblSoHDN.Text = soHDN;

            DataTable dtChiTietHDB = dtBase.getTable(queryLoad);
            dgvChiTietHDN.DataSource = dtChiTietHDB;

            dgvChiTietHDN.Columns[0].HeaderText = "Số hoá đơn nhập";
            dgvChiTietHDN.Columns[1].HeaderText = "Tên mặt hàng";
            dgvChiTietHDN.Columns[2].HeaderText = "Số lượng";
            dgvChiTietHDN.Columns[3].HeaderText = "Đơn giá";
            dgvChiTietHDN.Columns[4].HeaderText = "Giảm giá";
            dgvChiTietHDN.Columns[5].HeaderText = "Thành tiền";

            btnSua.Enabled = false;
            btnXoa.Enabled = false;

            load_MatHang();

            refreshInput();
        }

        private void dgvChiTietHDN_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            cboMatHang.Text = dgvChiTietHDN.CurrentRow.Cells[1].Value.ToString();
            txtSoLuong.Text = dgvChiTietHDN.CurrentRow.Cells[2].Value.ToString();
            txtDonGia.Text = dgvChiTietHDN.CurrentRow.Cells[3].Value.ToString();
            txtGiamGia.Text = dgvChiTietHDN.CurrentRow.Cells[4].Value.ToString();
            txtThanhTien.Text = dgvChiTietHDN.CurrentRow.Cells[5].Value.ToString();

            string[] arrDonGia = dgvChiTietHDN.CurrentRow.Cells[3].Value.ToString().Split(',');
            txtDonGia.Text = arrDonGia[0];

            string[] arrGiamGia = dgvChiTietHDN.CurrentRow.Cells[4].Value.ToString().Split(',');
            txtGiamGia.Text = arrGiamGia[0];

            cboMatHang.Enabled = false;
            btnThem.Enabled = false;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
        }

        private void btnLamMoi_Click(object sender, EventArgs e)
        {
            refreshInput();

            btnThem.Enabled = true;
            cboMatHang.Enabled = true;

            dgvChiTietHDN.DataSource = dtBase.getTable(queryLoad);
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            if (checkValidation())
            {
                DataTable dtChiTietHDB = dtBase.getTable($"SELECT * FROM tCHiTietHoaDonNhap WHERE SoHDN = N'{lblSoHDN.Text}' AND MaHang ='{cboMatHang.SelectedValue}'");

                if (dtChiTietHDB.Rows.Count > 0)
                {
                    MessageBox.Show("Mặt hàng này đã có, hãy chọn mặt hàng khác", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    cboMatHang.Focus();
                }
                else
                {
                    if (MessageBox.Show("Bạn có muốn thêm mặt hàng này vào danh sách không?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                    {
                        try
                        {
                            dtBase.getExcute($"INSERT INTO tChiTietHoaDonNhap(SoHDN, MaHang, SoLuong, DonGia, GiamGia) VALUES(N'{lblSoHDN.Text}', N'{cboMatHang.SelectedValue}', N'{txtSoLuong.Text}', N'{txtDonGia.Text}', N'{txtGiamGia.Text}')");
                            MessageBox.Show("Bạn đã thêm thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

                            dgvChiTietHDN.DataSource = dtBase.getTable(queryLoad);

                            refreshInput();
                        }    
                        catch(Exception ex)
                        {
                            MessageBox.Show(ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                }
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            if (checkValidation())
            {
                if (MessageBox.Show("Bạn có sửa thông tin này không?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Information) == DialogResult.Yes)
                {
                    try
                    {
                        dtBase.getExcute($"UPDATE tChiTietHoaDonNhap SET SoLuong = {txtSoLuong.Text} WHERE SoHDN = N'{lblSoHDN.Text}' AND MaHang = N'{cboMatHang.SelectedValue}'");
                        dtBase.getExcute($"UPDATE tChiTietHoaDonNhap SET DonGia = {txtDonGia.Text} WHERE SoHDN = N'{lblSoHDN.Text}' AND MaHang = N'{cboMatHang.SelectedValue}'");
                        dtBase.getExcute($"UPDATE tChiTietHoaDonNhap SET GiamGia = {txtGiamGia.Text} WHERE SoHDN = N'{lblSoHDN.Text}' AND MaHang = N'{cboMatHang.SelectedValue}'");

                        MessageBox.Show("Bạn đã sửa thông tin thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        dgvChiTietHDN.DataSource = dtBase.getTable(queryLoad);
                        refreshInput();
                    }    
                    catch(Exception ex)
                    {
                        MessageBox.Show(ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Bạn có muốn xóa mặt hàng có mã là: " + cboMatHang.SelectedValue.ToString() + " không?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                try
                {
                    dtBase.getExcute($"DELETE tChiTietHoaDonNhap WHERE SoHDN ='{lblSoHDN.Text}' AND MaHang = N'{cboMatHang.SelectedValue}'");
                    dgvChiTietHDN.DataSource = dtBase.getTable(queryLoad);
                    MessageBox.Show("Bạn đã xoá thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    refreshInput();
                }    
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void btnExcel_Click(object sender, EventArgs e)
        {

        }

        private void btnDong_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}