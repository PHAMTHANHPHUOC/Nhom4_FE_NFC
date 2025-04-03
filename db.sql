CREATE TABLE DangKyVang (
    id_dangkyvang INT PRIMARY KEY,
    id_nhan_vien INT,
    loai_vang VARCHAR(50),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    ly_do TEXT,
    trang_thai VARCHAR(20),
    nguoi_phe_duyet INT,
    ghi_chu TEXT
);

CREATE TABLE LoaiVang (
    id_loai_vang INT PRIMARY KEY,
    ten_loai_vang VARCHAR(50),
    diem_thu_kpi INT,
    yeu_cau_phe_duyet BOOLEAN,
    ghi_chu TEXT
);

CREATE TABLE BangLuong (
    id_bang_luong INT PRIMARY KEY,
    id_nhan_vien INT,
    thang INT,
    luong_co_ban DECIMAL(15, 2),
    luong_lam_them DECIMAL(15, 2),
    thuong DECIMAL(15, 2),
    khau_tru DECIMAL(15, 2),
    tong_luong DECIMAL(15, 2)
);

CREATE TABLE BangCong (
    id_bang_cong INT PRIMARY KEY,
    id_nhan_vien INT,
    ngay_cham_cong DATE,
    gio_vao TIME,
    gio_ra TIME,
    tong_gio_lam DECIMAL(5, 2),
    gio_lam_them DECIMAL(5, 2),
    ghi_chu TEXT
);

CREATE TABLE BaoHiem (
    id_bao_hiem INT PRIMARY KEY,
    id_nhan_vien INT,
    loai_bao_hiem VARCHAR(50),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    trang_thai VARCHAR(20),
    ghi_chu TEXT
);

CREATE TABLE PhanQuyen (
    id_phan_quyen INT PRIMARY KEY,
    ten_quyen VARCHAR(50),
    trang_thai VARCHAR(20)
);

CREATE TABLE BangThietBiNFC (
    id_thiet_bi INT PRIMARY KEY,
    ten_thiet_bi VARCHAR(50),
    vi_tri_dat VARCHAR(100),
    dia_chi_mac VARCHAR(50),
    trang_thai VARCHAR(20),
    thong_tin_dang_bao_cuoi TEXT,
    ngay_bao_cuoi DATE,
    ghi_chu TEXT
);

CREATE TABLE VaiTro (
    id_vai_tro INT PRIMARY KEY,
    ten_vai_tro VARCHAR(50),
    mo_ta TEXT,
    ghi_chu TEXT
);

CREATE TABLE ChucDanh (
    id_chuc_danh INT PRIMARY KEY,
    ten_chuc_danh VARCHAR(50),
    ban_luong DECIMAL(15, 2),
    trang_thai VARCHAR(20)
);

CREATE TABLE PhongBan (
    id_phong_ban INT PRIMARY KEY,
   