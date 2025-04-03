<template>
  <div class="container mt-4">
    <h2 class="mb-4">Quản Lý Thưởng Phạt</h2>

    <!-- Form thêm/sửa thưởng phạt -->
    <div class="card mb-4">
      <div
        class="card-header d-flex justify-content-between align-items-center"
      >
        <h5 class="card-title mb-0">
          {{ isEditing ? "Cập Nhật" : "Thêm Mới" }} Thưởng Phạt
        </h5>
        <button class="btn btn-primary" @click="toggleForm">
          {{ showForm ? "Đóng" : "Thêm mới" }}
        </button>
      </div>

      <div class="card-body" v-if="showForm">
        <form @submit.prevent="handleSubmit">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Nhân Viên</label>
              <select
                class="form-select"
                v-model="formData.ma_nhan_vien"
                required
              >
                <option value="">-- Chọn nhân viên --</option>
                <option
                  v-for="nv in danhSachNhanVien"
                  :key="nv.ma_nhan_vien"
                  :value="nv.ma_nhan_vien"
                >
                  {{ nv.ho_ten }} - {{ nv.ma_nhan_vien }}
                </option>
              </select>
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">Loại</label>
              <div class="d-flex">
                <div class="form-check me-4">
                  <input
                    class="form-check-input"
                    type="radio"
                    v-model="formData.loai"
                    :value="1"
                    id="loaiThuong"
                  />
                  <label class="form-check-label" for="loaiThuong"
                    >Thưởng</label
                  >
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="radio"
                    v-model="formData.loai"
                    :value="0"
                    id="loaiPhat"
                  />
                  <label class="form-check-label" for="loaiPhat">Phạt</label>
                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-8 mb-3">
              <label class="form-label">Tiêu Đề</label>
              <input
                type="text"
                class="form-control"
                v-model="formData.tieu_de"
                required
                placeholder="VD: Thưởng vượt KPI Q1, Phạt đi muộn..."
              />
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Giá Trị</label>
              <div class="input-group">
                <input
                  type="number"
                  class="form-control"
                  v-model="formData.gia_tri"
                  required
                />
                <span class="input-group-text">VNĐ</span>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Ngày Áp Dụng</label>
              <input
                type="date"
                class="form-control"
                v-model="formData.ngay_ap_dung"
                required
              />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Trạng Thái</label>
              <select class="form-select" v-model="formData.trang_thai">
                <option value="de_xuat">Đề xuất</option>
                <option value="duyet">Duyệt</option>
                <option value="tu_choi">Từ chối</option>
              </select>
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label">Lý Do</label>
            <textarea
              class="form-control"
              v-model="formData.ly_do"
              rows="3"
              required
            ></textarea>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Người Tạo</label>
              <input
                type="text"
                class="form-control"
                v-model="formData.nguoi_tao"
                required
              />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Người Duyệt</label>
              <input
                type="text"
                class="form-control"
                v-model="formData.nguoi_duyet"
              />
            </div>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Ngày Duyệt</label>
              <input
                type="date"
                class="form-control"
                v-model="formData.ngay_duyet"
                :disabled="formData.trang_thai !== 'duyet'"
              />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Ghi Chú</label>
              <textarea
                class="form-control"
                v-model="formData.ghi_chu"
                rows="2"
              ></textarea>
            </div>
          </div>

          <div class="mt-3">
            <button type="submit" class="btn btn-success">
              {{ isEditing ? "Cập nhật" : "Thêm mới" }}
            </button>
            <button
              type="button"
              class="btn btn-secondary ms-2"
              @click="resetForm"
            >
              Làm mới
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Bảng danh sách -->
    <div class="card">
      <div class="card-header">
        <div class="row align-items-center">
          <div class="col">
            <h5 class="card-title mb-0">Danh Sách Thưởng Phạt</h5>
          </div>
          <div class="col-auto">
            <div class="input-group">
              <input
                type="text"
                class="form-control"
                v-model="searchTerm"
                placeholder="Tìm kiếm..."
              />
              <button class="btn btn-outline-secondary" type="button">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>Mã TP</th>
                <th>Nhân Viên</th>
                <th>Loại</th>
                <th>Tiêu Đề</th>
                <th>Giá Trị</th>
                <th>Ngày Áp Dụng</th>
                <th>Trạng Thái</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in filteredItems" :key="item.ma_thuong_phat">
                <td>{{ item.ma_thuong_phat }}</td>
                <td>{{ item.ten_nhan_vien }}</td>
                <td>
                  <span
                    :class="
                      item.loai === 1 ? 'badge bg-success' : 'badge bg-danger'
                    "
                  >
                    {{ item.loai === 1 ? "Thưởng" : "Phạt" }}
                  </span>
                </td>
                <td>{{ item.tieu_de }}</td>
                <td>{{ formatCurrency(item.gia_tri) }}</td>
                <td>{{ formatDate(item.ngay_ap_dung) }}</td>
                <td>
                  <span :class="getTrangThaiClass(item.trang_thai)">
                    {{ getTrangThaiText(item.trang_thai) }}
                  </span>
                </td>
                <td>
                  <button
                    class="btn btn-sm btn-info me-1"
                    @click="editItem(item)"
                  >
                    <i class="fas fa-edit"></i>
                  </button>
                  <button
                    class="btn btn-sm btn-danger"
                    @click="deleteItem(item.ma_thuong_phat)"
                  >
                    <i class="fas fa-trash"></i>
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
  name: "QuanLyThuongPhat",
  data() {
    return {
      showForm: false,
      isEditing: false,
      searchTerm: "",
      formData: {
        ma_thuong_phat: null,
        ma_nhan_vien: "",
        loai: 1,
        tieu_de: "",
        ly_do: "",
        gia_tri: "",
        ngay_ap_dung: "",
        nguoi_tao: "",
        nguoi_duyet: "",
        ngay_duyet: "",
        trang_thai: "de_xuat",
        ghi_chu: "",
      },
      danhSachThuongPhat: [],
      danhSachNhanVien: [],
    };
  },
  computed: {
    filteredItems() {
      const search = this.searchTerm.toLowerCase();
      return this.danhSachThuongPhat.filter(
        (item) =>
          item.tieu_de.toLowerCase().includes(search) ||
          item.ma_thuong_phat.toString().includes(search) ||
          item.ten_nhan_vien.toLowerCase().includes(search)
      );
    },
  },
  methods: {
    async loadDanhSach() {
      try {
        const response = await this.axios.get("/api/thuong-phat");
        this.danhSachThuongPhat = response.data;
      } catch (error) {
        console.error("Lỗi khi tải danh sách:", error);
      }
    },

    async loadNhanVien() {
      try {
        const response = await this.axios.get("/api/nhan-vien");
        this.danhSachNhanVien = response.data;
      } catch (error) {
        console.error("Lỗi khi tải danh sách nhân viên:", error);
      }
    },

    toggleForm() {
      this.showForm = !this.showForm;
      if (!this.showForm) {
        this.resetForm();
      }
    },

    async handleSubmit() {
      try {
        if (this.isEditing) {
          await this.axios.put(
            `/api/thuong-phat/${this.formData.ma_thuong_phat}`,
            this.formData
          );
        } else {
          await this.axios.post("/api/thuong-phat", this.formData);
        }
        this.loadDanhSach();
        this.resetForm();
        this.showForm = false;
        alert(this.isEditing ? "Cập nhật thành công!" : "Thêm mới thành công!");
      } catch (error) {
        console.error("Lỗi khi lưu:", error);
        alert("Có lỗi xảy ra!");
      }
    },

    editItem(item) {
      this.isEditing = true;
      this.formData = { ...item };
      this.showForm = true;
    },

    async deleteItem(id) {
      if (confirm("Bạn có chắc muốn xóa?")) {
        try {
          await this.axios.delete(`/api/thuong-phat/${id}`);
          this.loadDanhSach();
          alert("Xóa thành công!");
        } catch (error) {
          console.error("Lỗi khi xóa:", error);
          alert("Có lỗi xảy ra!");
        }
      }
    },

    resetForm() {
      this.isEditing = false;
      this.formData = {
        ma_thuong_phat: null,
        ma_nhan_vien: "",
        loai: 1,
        tieu_de: "",
        ly_do: "",
        gia_tri: "",
        ngay_ap_dung: "",
        nguoi_tao: "",
        nguoi_duyet: "",
        ngay_duyet: "",
        trang_thai: "de_xuat",
        ghi_chu: "",
      };
    },

    formatCurrency(value) {
      return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(value);
    },

    formatDate(date) {
      return new Date(date).toLocaleDateString("vi-VN");
    },

    getTrangThaiText(trangThai) {
      const map = {
        de_xuat: "Đề xuất",
        duyet: "Đã duyệt",
        tu_choi: "Từ chối",
      };
      return map[trangThai] || trangThai;
    },

    getTrangThaiClass(trangThai) {
      const map = {
        de_xuat: "badge bg-warning",
        duyet: "badge bg-success",
        tu_choi: "badge bg-danger",
      };
      return map[trangThai] || "";
    },
  },
  mounted() {
    this.loadDanhSach();
    this.loadNhanVien();
  },
};
</script>

<style scoped>
.card {
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.badge {
  padding: 6px 10px;
  font-size: 0.875rem;
}

.table th {
  background-color: #f8f9fa;
  white-space: nowrap;
}

.btn-sm {
  padding: 0.25rem 0.5rem;
}

.input-group {
  width: 250px;
}
</style>
