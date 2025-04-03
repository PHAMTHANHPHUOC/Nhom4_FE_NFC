<template>
  <div class="container mt-4">
    <h2 class="mb-4">Quản Lý Nghỉ Phép</h2>

    <!-- Form đăng ký nghỉ phép -->
    <div class="card mb-4">
      <div class="card-header">
        <h5 class="card-title mb-0">Đơn Xin Nghỉ Phép</h5>
      </div>
      <div class="card-body">
        <form @submit.prevent="submitForm">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Mã Nhân Viên</label>
              <input
                type="text"
                class="form-control"
                v-model="formData.id_nhan_vien"
                required
              />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Loại Nghỉ Phép</label>
              <select
                class="form-select"
                v-model="formData.id_loai_vang"
                required
              >
                <option value="">Chọn loại nghỉ phép</option>
                <option
                  v-for="loai in danhSachLoaiVang"
                  :key="loai.id_loai_vang"
                  :value="loai.id_loai_vang"
                >
                  {{ loai.ten_loai_vang }}
                </option>
              </select>
            </div>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Ngày Bắt Đầu</label>
              <input
                type="date"
                class="form-control"
                v-model="formData.ngay_bat_dau"
                required
              />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Ngày Kết Thúc</label>
              <input
                type="date"
                class="form-control"
                v-model="formData.ngay_ket_thuc"
                required
              />
            </div>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Số Ngày Nghỉ</label>
              <input
                type="number"
                class="form-control"
                v-model="formData.so_ngay_vang"
                required
              />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Lý Do</label>
              <input
                type="text"
                class="form-control"
                v-model="formData.ly_do"
                required
              />
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label">Ghi Chú</label>
            <textarea
              class="form-control"
              v-model="formData.ghi_chu"
              rows="3"
            ></textarea>
          </div>

          <button type="submit" class="btn btn-primary">Gửi Đơn</button>
        </form>
      </div>
    </div>

    <!-- Bảng danh sách đơn nghỉ phép -->
    <div class="card">
      <div class="card-header">
        <h5 class="card-title mb-0">Danh Sách Đơn Nghỉ Phép</h5>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>ID</th>
                <th>Mã NV</th>
                <th>Loại Nghỉ</th>
                <th>Ngày Bắt Đầu</th>
                <th>Ngày Kết Thúc</th>
                <th>Số Ngày</th>
                <th>Trạng Thái</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="don in danhSachDon" :key="don.id_dang_ky">
                <td>{{ don.id_dang_ky }}</td>
                <td>{{ don.id_nhan_vien }}</td>
                <td>{{ don.ten_loai_vang }}</td>
                <td>{{ formatDate(don.ngay_bat_dau) }}</td>
                <td>{{ formatDate(don.ngay_ket_thuc) }}</td>
                <td>{{ don.so_ngay_vang }}</td>
                <td>
                  <span :class="getTrangThaiClass(don.trang_thai)">
                    {{ getTrangThaiText(don.trang_thai) }}
                  </span>
                </td>
                <td>
                  <button class="btn btn-sm btn-info me-2" @click="suaDon(don)">
                    Sửa
                  </button>
                  <button
                    class="btn btn-sm btn-danger"
                    @click="xoaDon(don.id_dang_ky)"
                  >
                    Xóa
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "QuanLyNghiPhep",
  data() {
    return {
      formData: {
        id_nhan_vien: "",
        id_loai_vang: "",
        ngay_bat_dau: "",
        ngay_ket_thuc: "",
        so_ngay_vang: "",
        ly_do: "",
        ghi_chu: "",
        trang_thai: "pending",
      },
      danhSachDon: [],
      danhSachLoaiVang: [],
    };
  },
  methods: {
    async loadDanhSachDon() {
      try {
        // Gọi API lấy danh sách đơn
        const response = await this.axios.get("/api/dang-ky-vang");
        this.danhSachDon = response.data;
      } catch (error) {
        console.error("Lỗi khi tải danh sách đơn:", error);
      }
    },

    async loadLoaiVang() {
      try {
        // Gọi API lấy danh sách loại vắng
        const response = await this.axios.get("/api/loai-vang");
        this.danhSachLoaiVang = response.data;
      } catch (error) {
        console.error("Lỗi khi tải loại vắng:", error);
      }
    },

    async submitForm() {
      try {
        await this.axios.post("/api/dang-ky-vang", this.formData);
        this.loadDanhSachDon();
        this.resetForm();
        alert("Đăng ký nghỉ phép thành công!");
      } catch (error) {
        console.error("Lỗi khi gửi đơn:", error);
        alert("Có lỗi xảy ra khi gửi đơn!");
      }
    },

    async xoaDon(id) {
      if (confirm("Bạn có chắc muốn xóa đơn này?")) {
        try {
          await this.axios.delete(`/api/dang-ky-vang/${id}`);
          this.loadDanhSachDon();
          alert("Xóa đơn thành công!");
        } catch (error) {
          console.error("Lỗi khi xóa đơn:", error);
          alert("Có lỗi xảy ra khi xóa đơn!");
        }
      }
    },

    formatDate(date) {
      return new Date(date).toLocaleDateString("vi-VN");
    },

    getTrangThaiText(trangThai) {
      const trangThaiMap = {
        pending: "Chờ duyệt",
        approved: "Đã duyệt",
        rejected: "Từ chối",
      };
      return trangThaiMap[trangThai] || trangThai;
    },

    getTrangThaiClass(trangThai) {
      const classMap = {
        pending: "badge bg-warning",
        approved: "badge bg-success",
        rejected: "badge bg-danger",
      };
      return classMap[trangThai] || "";
    },

    resetForm() {
      this.formData = {
        id_nhan_vien: "",
        id_loai_vang: "",
        ngay_bat_dau: "",
        ngay_ket_thuc: "",
        so_ngay_vang: "",
        ly_do: "",
        ghi_chu: "",
        trang_thai: "pending",
      };
    },
  },
  mounted() {
    this.loadDanhSachDon();
    this.loadLoaiVang();
  },
};
</script>

<style scoped>
.card {
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.badge {
  padding: 8px 12px;
  font-size: 0.9em;
}

.table th {
  background-color: #f8f9fa;
}

.btn-sm {
  padding: 0.25rem 0.5rem;
  font-size: 0.875rem;
}
</style>
