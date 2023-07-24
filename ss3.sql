create database quanlybanhang;
use quanlybanhang;

create table khachhang (
	MaKH nvarchar(4) primary key,
    TenKH nvarchar(30) not null,
	DiaChi nvarchar(50),
    NgaySinh datetime,
    SoDT nvarchar(15) unique
);

create table nhanvien (
	MaNV nvarchar(4) primary key	,
    HoTen nvarchar(30) not null,
    GioiTinh bit not null,
    DiaChi nvarchar(50) not null,
    NgaySinh datetime not null,
    DienThoai nvarchar(15),
    Email text,
    NoiSinh nvarchar(20) not null,
    NgayVaoLam datetime,
    MaNQL nvarchar(4)
);

create table nhacungcap (
	MaNCC nvarchar(5) primary key,
    TenNCC nvarchar(50) not null,
    DiaChi nvarchar(50) not null,
    DienThoai nvarchar(15) not null,
    Email nvarchar(30) not null,
    Website nvarchar(30)
);

create table loaisp (
	MaLoaiSP nvarchar(5) primary key,
    TenLoaiSP nvarchar(30) not null,
    GhiChu nvarchar(100) not null
);

create table sanpham (
	MaSP nvarchar(4) primary key,
    MaLoaiSP nvarchar(5) not null,
    DonViTinh nvarchar(10) not null,
    foreign key(MaLoaiSP) references loaisp(MaLoaiSP)
);

create table phieunhap (
	SoPN nvarchar(5) primary key,
    MaNV nvarchar(4) not null,
    MaNCC nvarchar(5) not null,
    NgayNhap datetime not null default now(),
    GhiChu nvarchar(100),
    foreign key(MaNV) references nhanvien(MaNV),
    foreign key(MaNCC) references nhacungcap(MaNCC)
);

create table CTPhieuNhap (
	MaSP nvarchar(4) not null,
    SoPN nvarchar(5) not null,
    Soluong smallint not null default 0,
    GiaNhap double not null check(GiaNhap >= 0),
    primary key(MaSP,SoPN),
    foreign key(MaSP) references sanpham(MaSP),
    foreign key(SoPN) references phieunhap(SoPN)
);

create table phieuxuat (
	SoPX nvarchar(5) primary key,
    MaNV nvarchar(4) not null,
    MaKH nvarchar(4) not null,
    NgayBan datetime not null,
    GhiChu text,
    foreign key(MaNV) references nhanvien(MaNV),
    foreign key(MaKH) references khachhang(MaKH)
);

create table CTphieuXuat (
	SoPX nvarchar(5) not null,
    MaSP nvarchar(4) not null,
    SoLluong smallint not null,
    GiaBan double not null,
    primary key(SoPX,MaSP),
    foreign key(SoPX) references phieuxuat(SoPX),
    foreign key(MaSP) references sanpham(MaSP)
);


-- Bài 3: Dùng lệnh INSERT thêm dữ liệu vào các bảng
INSERT INTO nhanvien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
VALUES 
    ('NV01', 'Nguyen Van A', 1, 'Dia Chi A', '1990-01-01', '0123456789', 'email_a@example.com', 'Noi Sinh A', '2021-01-01', NULL),
    ('NV02', 'Tran Thi B', 0, 'Dia Chi B', '1995-02-02', '0987654321', 'email_b@example.com', 'Noi Sinh B', '2021-02-15', 'NV01'),
    ('NV03', 'Le Van C', 1, 'Dia Chi C', '1992-03-03', '0369852147', 'email_c@example.com', 'Noi Sinh C', '2021-03-30', 'NV01');
INSERT INTO nhacungcap (MaNCC, TenNCC, DiaChi, DienThoai, Email, Website)
VALUES 
    ('NCC01', 'Công ty A', 'Địa chỉ A', '0123456789', 'email_a@example.com', 'www.company_a.com'),
    ('NCC02', 'Công ty B', 'Địa chỉ B', '0987654321', 'email_b@example.com', 'www.company_b.com'),
    ('NCC03', 'Công ty C', 'Địa chỉ C', '0369852147', 'email_c@example.com', 'www.company_c.com');
INSERT INTO phieunhap (SoPN, MaNV, MaNCC, NgayNhap, GhiChu)
VALUES 
    ('PN01', 'NV01', 'NCC01', NOW(), 'Phiếu nhập số 1'),
    ('PN02', 'NV02', 'NCC02', NOW(), 'Phiếu nhập số 2');
    
INSERT INTO loaisp (MaLoaiSP, TenLoaiSP, GhiChu)
VALUES 
    ('LSP01', 'Loại sản phẩm 1', 'Ghi chú loại sản phẩm 1'),
    ('LSP02', 'Loại sản phẩm 2', 'Ghi chú loại sản phẩm 2'),
    ('LSP03', 'Loại sản phẩm 3', 'Ghi chú loại sản phẩm 3');
INSERT INTO sanpham (MaSP, MaLoaiSP, DonViTinh)
VALUES 
    ('SP01', 'LSP01', 'Cái'),
    ('SP02', 'LSP01', 'Cái'),
    ('SP03', 'LSP02', 'Hộp'),
    ('SP04', 'LSP03', 'Chai');
INSERT INTO CTPhieuNhap (MaSP, SoPN, Soluong, GiaNhap)
VALUES 
    ('SP01', 'PN01', 10, 100),
    ('SP02', 'PN01', 5, 200),
    ('SP03', 'PN02', 8, 150),
    ('SP04', 'PN02', 12, 180);
    
INSERT INTO khachhang (MaKH, TenKH, DiaChi, NgaySinh, SoDT)
VALUES 
    ('KH01', 'Nguyen Van A', 'Dia Chi A', '1990-01-01', '0123456789'),
    ('KH02', 'Tran Thi B', 'Dia Chi B', '1995-02-02', '0987654321'),
    ('KH03', 'Le Van C', 'Dia Chi C', '1992-03-03', '0369852147');

INSERT INTO phieuxuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES 
    ('PX01', 'NV03', 'KH01', NOW(), 'Phiếu xuất số 1'),
    ('PX02', 'NV02', 'KH02', NOW(), 'Phiếu xuất số 2');
    
INSERT INTO CTphieuXuat (SoPX, MaSP, SoLluong, GiaBan)
VALUES 
    ('PX01', 'SP01', 5, 120),
    ('PX01', 'SP02', 10, 150),
    ('PX01', 'SP03', 8, 180),
    ('PX02', 'SP02', 15, 160),
    ('PX02', 'SP03', 12, 190);
    
-- them 1 nhan vien  moi
INSERT INTO nhanvien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
VALUES ('NV04', 'Nguyen Thi D', 0, 'Dia Chi D', '1994-04-04', '0123456789', NULL, 'Noi Sinh D', '2021-04-01', NULL);

-- Bài 4: Dùng lệnh UPDATE cập nhật dữ liệu các bảng
UPDATE khachhang
set SoDT = '0123456987'
where MaKH = 'KH01';
-- Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
delete from nhanvien where MaNV = 'NV04';
    
-- Bài 6: Dùng lệnh SELECT lấy dữ liệu từ các bảng
-- 1.
select MaNV, HoTen,
       case 
         when GioiTinh = 1 then 'Nam'
		 else 'Nu'
       end as GioiTinh,
       NgaySinh,
       DiaChi,
       DienThoai,
       Year(now()) - year(NgaySinh) as tuoi
       from nhanvien 
order by tuoi;

-- 2.

select 
pn.SoPN as sophieunhap,
pn.MaNV as manhanvien,
pn.MaNCC as mancc,
pn.NgayNhap as ngaynhaphang,
pn.ghichu as ghichu
from phieunhap pn
join nhanvien nv on pn.MaNV = nv.MaNV
join nhacungcap ncc on pn.MaNCC = ncc.MaNCC
where month(pn.NgayNhap) = 7 and year(pn.NgayNhap) = 2023
;
-- 3.
SELECT *
FROM sanpham
WHERE DonViTinh = 'chai';

-- 4.
select *  from CTphieunhap ct join sanpham sp on ct.MaSP = sp.MaSp;

-- 5.
SELECT 
    ncc.MaNCC,
    ncc.TenNCC,
    ncc.DiaChi,
    ncc.DienThoai,
    ncc.Email,
    pn.SoPN AS SoPhieuNhap,
    pn.NgayNhap AS NgayNhapHang
FROM nhacungcap ncc
JOIN phieunhap pn ON ncc.MaNCC = pn.MaNCC
WHERE MONTH(pn.NgayNhap) = MONTH(NOW()) AND YEAR(pn.NgayNhap) = YEAR(NOW())
ORDER BY pn.NgayNhap;

-- 6.
SELECT 
    px.SoPX AS SoPhieuXuat,
    nv.HoTen AS NhanVienBanHang,
    px.NgayBan AS NgayBan,
    sp.MaSP,
    sp.MaLoaiSp,
    sp.DonViTinh,
    ctx.SoLluong,
    ctx.GiaBan,
    ctx.SoLluong * ctx.GiaBan AS DoanhThu
FROM phieuxuat px
JOIN nhanvien nv ON px.MaNV = nv.MaNV
JOIN ctphieuxuat ctx ON px.SoPX = ctx.SoPX
JOIN sanpham sp ON ctx.MaSP = sp.MaSP
WHERE MONTH(px.NgayBan) <= 7 AND YEAR(px.NgayBan) = 2023;

-- 7.
select * from khachhang kh where month(kh.NgaySinh) =3;










