USE [QLBanSanGo]
GO
/****** Object:  Table [dbo].[tChiTietHoaDonBan]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tChiTietHoaDonBan](
	[SoHDB] [nvarchar](20) NOT NULL,
	[MaHang] [nvarchar](20) NOT NULL,
	[SoLuong] [int] NULL,
	[GiamGia] [int] NULL,
	[ThanhTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHDB] ASC,
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tDMHangHoa]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDMHangHoa](
	[MaHang] [nvarchar](20) NOT NULL,
	[TenHangHoa] [nvarchar](100) NOT NULL,
	[MaLoaiGo] [nvarchar](20) NOT NULL,
	[MaKichThuoc] [nvarchar](20) NOT NULL,
	[MaDacDiem] [nvarchar](20) NOT NULL,
	[MaCongDung] [nvarchar](20) NOT NULL,
	[MaMau] [nvarchar](20) NOT NULL,
	[MaNuocSX] [nvarchar](20) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGiaNhap] [money] NOT NULL,
	[DonGiaBan] [money] NULL,
	[ThoiGianBaoHanh] [int] NULL,
	[Anh] [nvarchar](max) NULL,
	[GhiChu] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tHoaDonBan]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tHoaDonBan](
	[SoHDB] [nvarchar](20) NOT NULL,
	[MaNV] [nvarchar](20) NOT NULL,
	[NgayBan] [datetime] NULL,
	[MaKhach] [nvarchar](20) NOT NULL,
	[TongTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tKhachHang]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tKhachHang](
	[MaKhach] [nvarchar](20) NOT NULL,
	[TenKhach] [nvarchar](100) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DienThoai] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Report1]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Report1](@maKhach NVARCHAR(20)) RETURNS TABLE AS
RETURN
	SELECT DISTINCT TOP(2) WITH TIES tKhachHang.MaKhach, TenKhach, tDMHangHoa.MaHang, TenHangHoa, SUM(tChiTietHoaDonBan.SoLuong) AS Soluong
	FROM tKhachHang
		JOIN tHoaDonBan ON tHoaDonBan.MaKhach = tKhachHang.MaKhach
		JOIN tChiTietHoaDonBan ON tChiTietHoaDonBan.SoHDB = tHoaDonBan.SoHDB
		JOIN tDMHangHoa ON tDMHangHoa.MaHang = tChiTietHoaDonBan.MaHang
	WHERE tKhachHang.MaKhach = @maKhach
	GROUP BY tKhachHang.MaKhach, TenKhach, tDMHangHoa.MaHang, TenHangHoa
	ORDER BY SoLuong DESC
GO
/****** Object:  Table [dbo].[tChiTietHoaDonNhap]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tChiTietHoaDonNhap](
	[SoHDN] [nvarchar](20) NOT NULL,
	[MaHang] [nvarchar](20) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [money] NOT NULL,
	[GiamGia] [int] NULL,
	[ThanhTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHDN] ASC,
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tHoaDonNhap]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tHoaDonNhap](
	[SoHDN] [nvarchar](20) NOT NULL,
	[MaNV] [nvarchar](20) NOT NULL,
	[NgayNhap] [datetime] NULL,
	[MaNCC] [nvarchar](20) NOT NULL,
	[TongTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Report2]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Report2](@thang INT) RETURNS TABLE AS
RETURN
	SELECT tHoaDonNhap.SoHDN, SUM(SoLuong * DonGia) AS TongTienNhap, NgayNhap
	FROM tChiTietHoaDonNhap JOIN tHoaDonNhap ON tChiTietHoaDonNhap.SoHDN = tHoaDonNhap.SoHDN
	WHERE MONTH(NgayNhap) = @thang
	GROUP BY tHoaDonNhap.SoHDN, NgayNhap
GO
/****** Object:  UserDefinedFunction [dbo].[Report3]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Report3](@nam INT) RETURNS TABLE AS
RETURN
	SELECT TOP(5) WITH TIES tHoaDonBan.SoHDB, MaNV, NgayBan, MaKhach, SUM(tChiTietHoaDonBan.SoLuong * tDMHangHoa.DonGiaBan) AS DoanhThu
	FROM tChiTietHoaDonBan
		JOIN tHoaDonBan ON tChiTietHoaDonBan.SoHDB = tHoaDonBan.SoHDB
		JOIN tDMHangHoa ON tChiTietHoaDonBan.MaHang = tDMHangHoa.MaHang
	WHERE YEAR(NgayBan) = @nam
	GROUP BY tHoaDonBan.SoHDB, MaNV, NgayBan, MaKhach
	ORDER BY DoanhThu DESC
GO
/****** Object:  Table [dbo].[tNhanVien]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tNhanVien](
	[MaNV] [nvarchar](20) NOT NULL,
	[TenNV] [nvarchar](100) NOT NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[NgaySinh] [date] NULL,
	[DienThoai] [nvarchar](15) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[MaCV] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Report4]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Report4](@thang INT) RETURNS TABLE AS
RETURN
	SELECT TOP(2) WITH TIES tNhanVien.MaNV, TenNV, SUM(tChiTietHoaDonBan.SoLuong * tDMHangHoa.DonGiaBan) AS DoanhThu, NgayBan
	FROM tChiTietHoaDonBan
		JOIN tHoaDonBan ON tChiTietHoaDonBan.SoHDB = tHoaDonBan.SoHDB
		JOIN tNhanVien ON tHoaDonBan.MaNV = tNhanVien.MaNV
		JOIN tDMHangHoa ON tChiTietHoaDonBan.MaHang = tDMHangHoa.MaHang
	WHERE MONTH(NgayBan) = @thang
	GROUP BY tNhanVien.MaNV, TenNV, NgayBan
	ORDER BY DoanhThu DESC
GO
/****** Object:  Table [dbo].[tCongDung]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCongDung](
	[MaCongDung] [nvarchar](20) NOT NULL,
	[TenCongDung] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCongDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tDacDiem]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDacDiem](
	[MaDacDiem] [nvarchar](20) NOT NULL,
	[TenDacDiem] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDacDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tKichThuoc]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tKichThuoc](
	[MaKichThuoc] [nvarchar](20) NOT NULL,
	[TenKichThuoc] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKichThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tLoaiGo]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tLoaiGo](
	[MaLoaiGo] [nvarchar](20) NOT NULL,
	[TenLoaiGo] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiGo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tMauSac]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tMauSac](
	[MaMau] [nvarchar](20) NOT NULL,
	[TenMau] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tNuocSanXuat]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tNuocSanXuat](
	[MaNuocSX] [nvarchar](20) NOT NULL,
	[TenNuocSX] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNuocSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_DMHangHoa]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[View_DMHangHoa] AS
SELECT MaHang, TenHangHoa, TenLoaiGo, TenKichThuoc, TenDacDiem, TenCongDung, TenMau, TenNuocSX, SoLuong, DonGiaNhap, DonGiaBan, ThoiGianBaoHanh, Anh, GhiChu
FROM tDMHangHoa
	JOIN tLoaiGo ON tDMHangHoa.MaLoaiGo = tLoaiGo.MaLoaiGo
	JOIN tKichThuoc ON tDMHangHoa.MaKichThuoc = tKichThuoc.MaKichThuoc
	JOIN tDacDiem ON tDMHangHoa.MaDacDiem =  tDacDiem.MaDacDiem
	JOIN tCongDung ON tDMHangHoa.MaCongDung = tCongDung.MaCongDung
	JOIN tMauSac ON tDMHangHoa.MaMau = tMauSac.MaMau
	JOIN tNuocSanXuat ON tDMHangHoa.MaNuocSX = tNuocSanXuat.MaNuocSX
GO
/****** Object:  View [dbo].[View_HoaDonBan]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[View_HoaDonBan] AS
SELECT SoHDB, TenNV, NgayBan, TenKhach, TongTien
FROM tHoaDonBan
	JOIN tNhanVien ON tHoaDonBan.MaNV = tNhanVien.MaNV
	JOIN tKhachHang ON tHoaDonBan.MaKhach = tKhachHang.MaKhach
GO
/****** Object:  Table [dbo].[tNhaCungCap]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tNhaCungCap](
	[MaNCC] [nvarchar](20) NOT NULL,
	[TenNCC] [nvarchar](100) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DienThoai] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_HoaDonNhap]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[View_HoaDonNhap] AS
SELECT SoHDN, TenNV, NgayNhap, TenNCC, TongTien
FROM tHoaDonNhap
	JOIN tNhanVien ON tHoaDonNhap.MaNV = tNhanVien.MaNV
	JOIN tNhaCungCap ON tHoaDonNhap.MaNCC = tNhaCungCap.MaNCC
GO
/****** Object:  Table [dbo].[tCongViec]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCongViec](
	[MaCV] [nvarchar](20) NOT NULL,
	[TenCV] [nvarchar](100) NOT NULL,
	[MucLuong] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_NhanVien]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[View_NhanVien] AS
SELECT MaNV, TenNV, GioiTinh, NgaySinh, DienThoai, DiaChi, TenCV
FROM tNhanVien JOIN tCongViec ON tNhanVien.MaCV = tCongViec.MaCV
GO
/****** Object:  Table [dbo].[tLogin]    Script Date: 20/11/2022 19:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tLogin](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tLogin] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tCongDung] ([MaCongDung], [TenCongDung]) VALUES (N'CD001', N'Lát sàn')
INSERT [dbo].[tCongDung] ([MaCongDung], [TenCongDung]) VALUES (N'CD002', N'Ốp tường')
INSERT [dbo].[tCongDung] ([MaCongDung], [TenCongDung]) VALUES (N'CD003', N'Ốp trần')
GO
INSERT [dbo].[tCongViec] ([MaCV], [TenCV], [MucLuong]) VALUES (N'CS', N'Chăm sóc khách hàng', 12000000.0000)
INSERT [dbo].[tCongViec] ([MaCV], [TenCV], [MucLuong]) VALUES (N'HT', N'Vận hành hệ thống', 20000000.0000)
INSERT [dbo].[tCongViec] ([MaCV], [TenCV], [MucLuong]) VALUES (N'KT', N'Kế toán', 12500000.0000)
INSERT [dbo].[tCongViec] ([MaCV], [TenCV], [MucLuong]) VALUES (N'QL', N'Quản lí', 25000000.0000)
INSERT [dbo].[tCongViec] ([MaCV], [TenCV], [MucLuong]) VALUES (N'TN', N'Thu ngân', 10000000.0000)
GO
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB001', N'MH001', 50, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB001', N'MH002', 60, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB001', N'MH003', 60, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB002', N'MH004', 90, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB002', N'MH005', 30, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB003', N'MH006', 35, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB003', N'MH007', 70, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB003', N'MH008', 110, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB004', N'MH009', 20, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB004', N'MH010', 55, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB004', N'MH011', 90, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB005', N'MH012', 64, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB005', N'MH013', 30, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB005', N'MH014', 140, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB006', N'MH015', 130, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB006', N'MH016', 10, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB006', N'MH017', 55, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB006', N'MH018', 40, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB007', N'MH019', 100, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB007', N'MH020', 40, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB008', N'MH001', 85, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB008', N'MH006', 30, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB008', N'MH007', 20, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB009', N'MH003', 50, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB009', N'MH006', 10, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB009', N'MH009', 60, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB010', N'MH007', 30, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB010', N'MH011', 78, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB010', N'MH013', 60, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB011', N'MH004', 20, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB011', N'MH008', 100, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB011', N'MH011', 50, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB012', N'MH005', 30, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB012', N'MH009', 40, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB012', N'MH012', 50, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB013', N'MH002', 30, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB014', N'MH003', 50, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB015', N'MH004', 20, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB016', N'MH006', 20, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB017', N'MH015', 90, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB018', N'MH012', 200, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB019', N'MH002', 120, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB019', N'MH009', 250, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB020', N'MH014', 250, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonBan] ([SoHDB], [MaHang], [SoLuong], [GiamGia], [ThanhTien]) VALUES (N'HDB020', N'MH015', 550, NULL, NULL)
GO
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN001', N'MH001', 2000, 359100.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN001', N'MH002', 2000, 359100.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN001', N'MH003', 5000, 445500.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN001', N'MH004', 2500, 369000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN002', N'MH005', 5400, 585000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN002', N'MH006', 4500, 387000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN002', N'MH007', 800, 504000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN002', N'MH008', 1200, 432000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN003', N'MH009', 1100, 360000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN003', N'MH010', 1800, 220500.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN003', N'MH011', 950, 387000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN003', N'MH012', 2400, 184500.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN004', N'MH013', 1250, 432000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN004', N'MH014', 2800, 432000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN004', N'MH015', 1700, 468000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN004', N'MH016', 3100, 162000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN005', N'MH017', 2300, 207000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN005', N'MH018', 950, 621000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN005', N'MH019', 1600, 180000.0000, NULL, NULL)
INSERT [dbo].[tChiTietHoaDonNhap] ([SoHDN], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HDN005', N'MH020', 3200, 250000.0000, NULL, NULL)
GO
INSERT [dbo].[tDacDiem] ([MaDacDiem], [TenDacDiem]) VALUES (N'DD001', N'Chống cháy')
INSERT [dbo].[tDacDiem] ([MaDacDiem], [TenDacDiem]) VALUES (N'DD002', N'Chống xước')
INSERT [dbo].[tDacDiem] ([MaDacDiem], [TenDacDiem]) VALUES (N'DD003', N'Chống nước')
INSERT [dbo].[tDacDiem] ([MaDacDiem], [TenDacDiem]) VALUES (N'DD004', N'Chịu lực tốt')
GO
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH001', N'Hamilton HM801 ', N'LG001', N'KT003', N'DD002', N'CD001', N'MS001', N'QG086', 6500, 359100.0000, 399000.0000, 10, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH002', N'Lamton AquaGuard AG1210', N'LG003', N'KT006', N'DD001', N'CD001', N'MS004', N'QG084', 9000, 445500.0000, 495000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH003', N'Hillman Ambition H1041', N'LG004', N'KT001', N'DD003', N'CD001', N'MS004', N'QG060', 4100, 459000.0000, 510000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH004', N'Dongwha NT008', N'LG002', N'KT002', N'DD004', N'CD001', N'MS001', N'QG082', 5000, 369000.0000, 410000.0000, 20, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH005', N'Vinasan OT1255', N'LG005', N'KT008', N'DD002', N'CD002', N'MS003', N'QG084', 8200, 585000.0000, 650000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH006', N'Artfloor Urban AU007 Paris', N'LG006', N'KT004', N'DD001', N'CD001', N'MS002', N'QG090', 8000, 387000.0000, 430000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH007', N'Versailles Sahara S177017 ', N'LG001', N'KT001', N'DD002', N'CD001', N'MS005', N'QG034', 1100, 504000.0000, 560000.0000, 20, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH008', N'Floorpan Orange FP964 Andiroba', N'LG007', N'KT005', N'DD003', N'CD001', N'MS003', N'QG007', 3600, 432000.0000, 480000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH009', N'Dongwha KO1205', N'LG002', N'KT006', N'DD004', N'CD001', N'MS002', N'QG082', 2900, 360000.0000, 400000.0000, 10, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH010', N'Kronotex Dynamic KT4568', N'LG003', N'KT008', N'DD003', N'CD002', N'MS006', N'QG049', 5000, 220500.0000, 254000.0000, 10, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH011', N'Artfloor Urban AU007', N'LG004', N'KT002', N'DD001', N'CD001', N'MS002', N'QG090', 1900, 387000.0000, 430000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH012', N'ShopHouse SH150', N'LG005', N'KT008', N'DD002', N'CD003', N'MS001', N'QG084', 8500, 184500.0000, 205000.0000, 8, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH013', N'Floorpan Red FP33', N'LG001', N'KT001', N'DD003', N'CD001', N'MS002', N'QG007', 5500, 432000.0000, 480000.0000, 10, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH014', N'Floorpan Orange FP951', N'LG002', N'KT002', N'DD004', N'CD001', N'MS003', N'QG007', 4600, 432000.0000, 480000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH015', N'Syncro S177253', N'LG003', N'KT004', N'DD002', N'CD001', N'MS006', N'QG034', 5300, 468000.0000, 520000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH016', N'Thailife TL813', N'LG006', N'KT006', N'DD001', N'CD001', N'MS005', N'QG066', 6000, 162000.0000, 180000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH017', N'Vanachai VF10711', N'LG007', N'KT007', N'DD003', N'CD001', N'MS002', N'QG066', 6100, 207000.0000, 230000.0000, 15, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH018', N'KronoSwiss D3784', N'LG004', N'KT001', N'DD001', N'CD001', N'MS004', N'QG041', 2000, 621000.0000, 690000.0000, 25, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH019', N'Smartwood SW4890', N'LG001', N'KT008', N'DD002', N'CD003', N'MS003', N'QG066', 6600, 180000.0000, 200000.0000, 10, NULL, NULL)
INSERT [dbo].[tDMHangHoa] ([MaHang], [TenHangHoa], [MaLoaiGo], [MaKichThuoc], [MaDacDiem], [MaCongDung], [MaMau], [MaNuocSX], [SoLuong], [DonGiaNhap], [DonGiaBan], [ThoiGianBaoHanh], [Anh], [GhiChu]) VALUES (N'MH020', N'Robina RB1248', N'LG002', N'KT005', N'DD004', N'CD001', N'MS004', N'QG060', 7000, 250000.0000, 265000.0000, 10, NULL, NULL)
GO
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB001', N'NV001', CAST(N'2019-08-11' AS Date), N'KH001', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB002', N'NV002', CAST(N'2019-08-13' AS Date), N'KH002', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB003', N'NV003', CAST(N'2019-11-25' AS Date), N'KH003', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB004', N'NV004', CAST(N'2019-12-20' AS Date), N'KH004', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB005', N'NV005', CAST(N'2020-02-14' AS Date), N'KH005', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB006', N'NV006', CAST(N'2020-02-14' AS Date), N'KH006', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB007', N'NV007', CAST(N'2020-03-10' AS Date), N'KH007', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB008', N'NV008', CAST(N'2020-03-21' AS Date), N'KH008', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB009', N'NV009', CAST(N'2020-03-26' AS Date), N'KH009', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB010', N'NV010', CAST(N'2020-04-02' AS Date), N'KH010', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB011', N'NV001', CAST(N'2021-07-11' AS Date), N'KH011', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB012', N'NV002', CAST(N'2021-08-20' AS Date), N'KH012', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB013', N'NV003', CAST(N'2021-08-12' AS Date), N'KH013', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB014', N'NV004', CAST(N'2021-09-12' AS Date), N'KH014', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB015', N'NV005', CAST(N'2021-09-22' AS Date), N'KH015', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB016', N'NV006', CAST(N'2021-09-28' AS Date), N'KH016', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB017', N'NV007', CAST(N'2021-11-12' AS Date), N'KH017', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB018', N'NV008', CAST(N'2021-11-22' AS Date), N'KH018', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB019', N'NV009', CAST(N'2022-01-12' AS Date), N'KH019', NULL)
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HDB020', N'NV010', CAST(N'2022-02-20' AS Date), N'KH020', NULL)
GO
INSERT [dbo].[tHoaDonNhap] ([SoHDN], [MaNV], [NgayNhap], [MaNCC], [TongTien]) VALUES (N'HDN001', N'NV002', CAST(N'2021-06-13' AS Date), N'NCC001', NULL)
INSERT [dbo].[tHoaDonNhap] ([SoHDN], [MaNV], [NgayNhap], [MaNCC], [TongTien]) VALUES (N'HDN002', N'NV001', CAST(N'2021-06-28' AS Date), N'NCC003', NULL)
INSERT [dbo].[tHoaDonNhap] ([SoHDN], [MaNV], [NgayNhap], [MaNCC], [TongTien]) VALUES (N'HDN003', N'NV004', CAST(N'2021-06-01' AS Date), N'NCC002', NULL)
INSERT [dbo].[tHoaDonNhap] ([SoHDN], [MaNV], [NgayNhap], [MaNCC], [TongTien]) VALUES (N'HDN004', N'NV005', CAST(N'2021-09-05' AS Date), N'NCC004', NULL)
INSERT [dbo].[tHoaDonNhap] ([SoHDN], [MaNV], [NgayNhap], [MaNCC], [TongTien]) VALUES (N'HDN005', N'NV003', CAST(N'2021-09-10' AS Date), N'NCC005', NULL)
GO
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT001', N'1220mm x 197mm x 8mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT002', N'1222mm x 197mm x 8mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT003', N'1218mm x 198mm x 8mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT004', N'1218mm x 198mm x 12mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT005', N'803mm x 127mm x 8mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT006', N'1200mm x 122mm x 12mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT007', N'1200mm x 195mm x 8mm')
INSERT [dbo].[tKichThuoc] ([MaKichThuoc], [TenKichThuoc]) VALUES (N'KT008', N'808mm x 90mm x 8mm')
GO
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH001', N'Nguyễn Thị Hải', N'Hà Nội', N'0923872389')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH002', N'Nguyễn Quang Chính', N'Hà Nội', N'0965231644')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH003', N'Trần Văn Quang', N'Thái Bình', N'0862316409')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH004', N'Phạm Văn Cường', N'Hà Nội', N'0832346484')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH005', N'Trần Thị Thu Hoài', N'Nam Định', N'0962114326')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH006', N'Mai Tuyết Linh', N'Bắc Ninh', N'0322316430')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH007', N'Trần Thu Yến', N'Đà Nẵng', N'0866623643')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH008', N'Hoàng Quốc Quân', N'Hà Nam', N'0842316420')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH009', N'Khuất Duy Hoàng', N'Phú Thọ', N'0822363804')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH010', N'Nguyễn Thị Sim', N'Hà Nam', N'0962317443')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH011', N'Nguyễn Lê Ánh Hồng', N'TP. Hồ Chí Minh', N'0972346420')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH012', N'Hoàng Anh Bắc', N'Nam Định', N'0832313415')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH013', N'Nguyễn Hồng Nhung', N'Thái Bình', N'0862431632')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH014', N'Nguyễn Văn Cự', N'Hải Phòng', N'0862336420')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH015', N'Lương Thành Lai', N'Hà Nội', N'0823163832')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH016', N'Trần Thị Minh Ánh', N'Hà Nam', N'0862416284')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH017', N'Phạm Thị Mai Ánh', N'Quảng Ninh', N'0962416480')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH018', N'Lê Ngọc Anh', N'Bắc Ninh', N'0364313430')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH019', N'Nguyễn Đức Cảnh', N'Phú Thọ', N'0962364322')
INSERT [dbo].[tKhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai]) VALUES (N'KH020', N'Nguyễn Quang Long', N'Hà Nội', N'0862314440')
GO
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG001', N'Gỗ sồi')
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG002', N'Gỗ giáng hương')
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG003', N'Gỗ tràm bông vàng')
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG004', N'Gỗ chiu liu')
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG005', N'Gỗ teak')
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG006', N'Gỗ căm xe')
INSERT [dbo].[tLoaiGo] ([MaLoaiGo], [TenLoaiGo]) VALUES (N'LG007', N'Gỗ lim')
GO
INSERT [dbo].[tLogin] ([Username], [Password]) VALUES (N'admin', N'admin')
INSERT [dbo].[tLogin] ([Username], [Password]) VALUES (N'user666', N'123')
GO
INSERT [dbo].[tMauSac] ([MaMau], [TenMau]) VALUES (N'MS001', N'Màu xám')
INSERT [dbo].[tMauSac] ([MaMau], [TenMau]) VALUES (N'MS002', N'Màu đỏ')
INSERT [dbo].[tMauSac] ([MaMau], [TenMau]) VALUES (N'MS003', N'Màu vàng')
INSERT [dbo].[tMauSac] ([MaMau], [TenMau]) VALUES (N'MS004', N'Màu nâu')
INSERT [dbo].[tMauSac] ([MaMau], [TenMau]) VALUES (N'MS005', N'Màu đen')
INSERT [dbo].[tMauSac] ([MaMau], [TenMau]) VALUES (N'MS006', N'Màu trắng')
GO
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG007', N'Nga')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG034', N'Tây Ban Nha')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG041', N'Thuỵ Sĩ')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG044', N'Anh')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG049', N'Đức')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG060', N'Malaysia')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG066', N'Thái Lan')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG082', N'Hàn Quốc')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG084', N'Việt Nam')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG086', N'Trung Quốc')
INSERT [dbo].[tNuocSanXuat] ([MaNuocSX], [TenNuocSX]) VALUES (N'QG090', N'Thổ Nhĩ Kì')
GO
INSERT [dbo].[tNhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC001', N'Công ty Sàn Gỗ Uyên Minh', N'TP. Hồ Chí Minh', N'0909071257')
INSERT [dbo].[tNhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC002', N'Công ty Cổ phần Sàn Đẹp', N'Hà Nội', N'0918421902')
INSERT [dbo].[tNhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC003', N'Công ty TNHH INOVAR', N'Hà Nội', N'0982986917')
INSERT [dbo].[tNhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC004', N'Công ty TNHH Thương mại và Xây dựng Trần Gia Phát', N'Hải Phòng', N'0934561577')
INSERT [dbo].[tNhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC005', N'Công ty TNHH Kiến Hưng', N'Bắc Ninh', N'0979450369')
GO
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV001', N'Lê Văn Cường', N'Nam', CAST(N'1999-01-14' AS Date), N'0928548266', N'Hà Nội', N'TN')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV002', N'Trần Thu Hạ', N'Nữ', CAST(N'1997-04-11' AS Date), N'0828649271', N'Nam Định', N'KT')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV003', N'Nguyễn Văn Hưng', N'Nam', CAST(N'1998-08-23' AS Date), N'0934648287', N'TP. Hồ Chí Minh', N'KT')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV004', N'Lại Văn Sáng', N'Nam', CAST(N'1996-12-25' AS Date), N'0978638273', N'Đà Nẵng', N'HT')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV005', N'Nguyễn Vân Anh', N'Nữ', CAST(N'1991-02-03' AS Date), N'0988248291', N'Hà Nội', N'KT')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV006', N'Phạm Quang Khải', N'Nam', CAST(N'1994-07-07' AS Date), N'0938658217', N'Thái Bình', N'QL')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV007', N'Nguyễn Hải Anh', N'Nữ', CAST(N'1990-02-23' AS Date), N'0928648277', N'Hà Nội', N'TN')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV008', N'Trần Văn Chính', N'Nam', CAST(N'1992-05-09' AS Date), N'0828842247', N'Phú Thọ', N'HT')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV009', N'Lê Bạch Yến', N'Nữ', CAST(N'1996-04-21' AS Date), N'0828548272', N'Hải Phòng', N'CS')
INSERT [dbo].[tNhanVien] ([MaNV], [TenNV], [GioiTinh], [NgaySinh], [DienThoai], [DiaChi], [MaCV]) VALUES (N'NV010', N'Trần Thanh Nga', N'Nữ', CAST(N'1995-10-20' AS Date), N'0921658290', N'Quảng Ninh', N'CS')
GO
ALTER TABLE [dbo].[tChiTietHoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaHang])
REFERENCES [dbo].[tDMHangHoa] ([MaHang])
GO
ALTER TABLE [dbo].[tChiTietHoaDonBan]  WITH CHECK ADD FOREIGN KEY([SoHDB])
REFERENCES [dbo].[tHoaDonBan] ([SoHDB])
GO
ALTER TABLE [dbo].[tChiTietHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaHang])
REFERENCES [dbo].[tDMHangHoa] ([MaHang])
GO
ALTER TABLE [dbo].[tChiTietHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([SoHDN])
REFERENCES [dbo].[tHoaDonNhap] ([SoHDN])
GO
ALTER TABLE [dbo].[tDMHangHoa]  WITH CHECK ADD FOREIGN KEY([MaCongDung])
REFERENCES [dbo].[tCongDung] ([MaCongDung])
GO
ALTER TABLE [dbo].[tDMHangHoa]  WITH CHECK ADD FOREIGN KEY([MaDacDiem])
REFERENCES [dbo].[tDacDiem] ([MaDacDiem])
GO
ALTER TABLE [dbo].[tDMHangHoa]  WITH CHECK ADD FOREIGN KEY([MaKichThuoc])
REFERENCES [dbo].[tKichThuoc] ([MaKichThuoc])
GO
ALTER TABLE [dbo].[tDMHangHoa]  WITH CHECK ADD FOREIGN KEY([MaLoaiGo])
REFERENCES [dbo].[tLoaiGo] ([MaLoaiGo])
GO
ALTER TABLE [dbo].[tDMHangHoa]  WITH CHECK ADD FOREIGN KEY([MaMau])
REFERENCES [dbo].[tMauSac] ([MaMau])
GO
ALTER TABLE [dbo].[tDMHangHoa]  WITH CHECK ADD FOREIGN KEY([MaNuocSX])
REFERENCES [dbo].[tNuocSanXuat] ([MaNuocSX])
GO
ALTER TABLE [dbo].[tHoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaKhach])
REFERENCES [dbo].[tKhachHang] ([MaKhach])
GO
ALTER TABLE [dbo].[tHoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[tNhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[tHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[tNhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[tHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[tNhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[tNhanVien]  WITH CHECK ADD FOREIGN KEY([MaCV])
REFERENCES [dbo].[tCongViec] ([MaCV])
GO
