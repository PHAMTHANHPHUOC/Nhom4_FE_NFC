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