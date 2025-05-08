-- Table: NhanVien
CREATE TABLE NhanVien (
    id_nhan_vien INT PRIMARY KEY,
    id_vat_tro INT,
    ho_va_ten VARCHAR(100),
    ngay_sinh DATE,
    gioi_tinh VARCHAR(10),
    so_dien_thoai VARCHAR(15),
    email VARCHAR(100),
    mat_khau VARCHAR(100),
    ngay_tuyen_dung DATE,
    id_phong_ban INT,
    id_chuc_danh INT,
    trang_thai VARCHAR(20),
    loai_hop_dong VARCHAR(50),
    is_master BOOLEAN,
    FOREIGN KEY (id_vat_tro) REFERENCES VaiTro(id_vat_tro),
    FOREIGN KEY (id_phong_ban) REFERENCES PhongBan(id_phong_ban),
    FOREIGN KEY (id_chuc_danh) REFERENCES BangChucDanh(id_chuc_danh)
);

-- Table: VaiTro
CREATE TABLE VaiTro (
    id_vat_tro INT PRIMARY KEY,
    ten_vai_tro VARCHAR(50),
    mo_ta TEXT,
    phan_quyen TEXT
);

-- Table: PhongBan
CREATE TABLE PhongBan (
    id_phong_ban INT PRIMARY KEY,
    trang_thai VARCHAR(20),
    ten_truong_phong VARCHAR(100),
    ten_phong_ban VARCHAR(50)
);

-- Table: BangChucDanh
CREATE TABLE BangChucDanh (
    id_chuc_danh INT PRIMARY KEY,
    ten_chuc_danh VARCHAR(50),
    ban_luong DECIMAL(15,2),
    trang_thai VARCHAR(20)
);

-- Table: DangKyVang
CREATE TABLE DangKyVang (
    id_dang_ky INT PRIMARY KEY,
    id_nhan_vien INT,
    id_loai_vang INT,
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    so_ngay_vang INT,
    ly_do TEXT,
    trang_thai VARCHAR(20),
    nguoi_phe_duyet VARCHAR(100),
    ngay_phe_duyet DATE,
    ghi_chu TEXT,
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien),
    FOREIGN KEY (id_loai_vang) REFERENCES LoaiVang(id_loai_vang)
);

-- Table: LoaiVang
CREATE TABLE LoaiVang (
    id_loai_vang INT PRIMARY KEY,
    ten_loai_vang VARCHAR(50),
    diem_tru_boi INT,
    yeu_cau_phe_duyet BOOLEAN
);

-- Table: HopDong
CREATE TABLE HopDong (
    id_hop_dong INT PRIMARY KEY,
    id_nhan_vien INT,
    loai_hop_dong VARCHAR(50),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    luong_co_ban DECIMAL(15,2),
    trang_thai VARCHAR(20),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: BaoHiem
CREATE TABLE BaoHiem (
    id_bao_hiem INT PRIMARY KEY,
    id_nhan_vien INT,
    loai_bao_hiem VARCHAR(50),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    trang_thai VARCHAR(20),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: BangLuong
CREATE TABLE BangLuong (
    id_bang_luong INT PRIMARY KEY,
    id_nhan_vien INT,
    thoi_gian VARCHAR(20),
    luong_co_ban DECIMAL(15,2),
    phu_cap DECIMAL(15,2),
    thuong DECIMAL(15,2),
    phat DECIMAL(15,2),
    trang_thai VARCHAR(20),
    tong_luong DECIMAL(15,2),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: BangCaLam
CREATE TABLE BangCaLam (
    id_ca_lam INT PRIMARY KEY,
    ten_ca_lam VARCHAR(50),
    gio_bat_dau TIME,
    gio_ket_thuc TIME,
    id_phong_ban INT,
    trang_thai VARCHAR(20),
    la_ca_linh_hoat BOOLEAN,
    thoi_gian_cho_phep INT,
    FOREIGN KEY (id_phong_ban) REFERENCES PhongBan(id_phong_ban)
);

-- Table: BangChamCong
CREATE TABLE BangChamCong (
    id_cham_cong INT PRIMARY KEY,
    id_ca_lam INT,
    id_nhan_vien INT,
    ngay_cham_cong DATE,
    gio_vao TIME,
    gio_ra TIME,
    tong_gio_lam DECIMAL(5,2),
    trang_thai VARCHAR(20),
    gio_lam_them DECIMAL(5,2),
    FOREIGN KEY (id_ca_lam) REFERENCES BangCaLam(id_ca_lam),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: BangThietBiNFC
CREATE TABLE BangThietBiNFC (
    id_thiet_bi INT PRIMARY KEY,
    ten_thiet_bi VARCHAR(100),
    vi_tri_dat VARCHAR(100),
    dia_chi_ip VARCHAR(20),
    dia_chi_mac VARCHAR(20),
    trang_thai VARCHAR(20),
    thoi_gian_dong_bo_cuoi DATETIME,
    ngay_lap_dat DATE
);

-- Table: BangTheNFC
CREATE TABLE BangTheNFC (
    id_the INT PRIMARY KEY,
    id_nhan_vien INT,
    trang_thai_the VARCHAR(20),
    ngay_cap DATE,
    lan_su_dung_cuoi DATETIME,
    ngay_kich_hoat DATE,
    ngay_vo_hieu_hoa DATE,
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: BangTieuChiKPI
CREATE TABLE BangTieuChiKPI (
    id_kpi INT PRIMARY KEY,
    id_nhan_vien INT,
    ten_kpi VARCHAR(100),
    so_ta VARCHAR(255),
    don_vi_tinh VARCHAR(50),
    muc_tieu DECIMAL(15,2),
    ket_qua_dat_duoc DECIMAL(15,2),
    ty_le_hoan_thanh DECIMAL(5,2),
    thoi_gian_danh_gia DATE,
    id_nguoi_danh_gia INT,
    ghi_chu TEXT,
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien),
    FOREIGN KEY (id_nguoi_danh_gia) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: TangCa
CREATE TABLE TangCa (
    id_tang_ca INT PRIMARY KEY,
    id_nhan_vien INT,
    ngay_yeu_cau DATE,
    ngay_tang_ca DATE,
    thoi_gian_bat_dau TIME,
    thoi_gian_ket_thuc TIME,
    so_gio DECIMAL(5,2),
    trang_thai VARCHAR(20),
    muc_dich TEXT,
    nguoi_kiem_duyet VARCHAR(100),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: ChiTietTangCa
CREATE TABLE ChiTietTangCa (
    id_tang_ca INT,
    id_nhan_vien INT,
    trang_thai VARCHAR(20),
    nguoi_kiem_duyet VARCHAR(100),
    id_tang_ca_main INT,
    PRIMARY KEY (id_tang_ca, id_nhan_vien),
    FOREIGN KEY (id_tang_ca) REFERENCES TangCa(id_tang_ca),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id_nhan_vien)
);

-- Table: ChiTietPhanQuyen
CREATE TABLE ChiTietPhanQuyen (
    id_phan_quyen INT PRIMARY KEY,
    id_quyen INT,
    id_chuc_danh INT,
    FOREIGN KEY (id_chuc_danh) REFERENCES BangChucDanh(id_chuc_danh)
);

-- Table: PhanQuyen
CREATE TABLE PhanQuyen (
    id_phan_quyen INT PRIMARY KEY,
    ten_quyen VARCHAR(50),
    trang_thai VARCHAR(20)
);