<template>
  <div class="row">
    <!-- Search Section -->
    <div class="col-lg-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-lg-3">
              <label class="form-label fw-bold">Từ ngày</label>
              <input
                v-model="searchData.ngay_bat_dau"
                type="date"
                class="form-control"
              />
            </div>
            <div class="col-lg-3">
              <label class="form-label fw-bold">Đến ngày</label>
              <input
                v-model="searchData.ngay_ket_thuc"
                type="date"
                class="form-control"
              />
            </div>

            <div class="col-lg-3">
              <label class="form-label fw-bold">Loại vắng</label>
              <select v-model="searchData.id_loai_vang" class="form-select">
                <option value="">Tất cả</option>
                <option
                  v-for="lv in loaiVangList"
                  :key="lv.id_loai_vang"
                  :value="lv.id_loai_vang"
                >
                  {{ lv.ten_loai_vang }}
                </option>
              </select>
            </div>
          </div>
          <div class="row mt-3">
            <div class="col-lg-3">
              <label class="form-label fw-bold">Trạng thái</label>
              <select v-model="searchData.tinh_trang" class="form-select">
                <option value="">Tất cả</option>
                <option value="0">Chờ phê duyệt</option>
                <option value="1">Đã phê duyệt</option>
                <option value="2">Từ chối</option>
              </select>
            </div>
            <div class="col-lg-3 d-flex align-items-end">
              <button @click="searchNghiPhep" class="btn btn-primary w-100">
                <i class="fas fa-search me-2"></i> Tìm kiếm
              </button>
            </div>
            <div class="col-lg-3 d-flex align-items-end">
              <button
                class="btn btn-success w-100"
                data-bs-toggle="modal"
                data-bs-target="#createModal"
              >
                <i class="fas fa-plus me-2"></i> Thêm mới
              </button>
            </div>
            <div class="col-lg-3 d-flex align-items-end">
              <button @click="exportToExcel" class="btn btn-secondary w-100">
                <i class="fas fa-file-excel me-2"></i> Xuất Excel
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Data Table Section -->
    <div class="col-lg-12 mt-3">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">Danh sách đăng ký vắng/công tác</h5>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th class="text-center">#</th>
                  <th class="text-center">Nhân viên</th>
                  <th class="text-center">Loại vắng</th>
                  <th class="text-center">Ngày bắt đầu</th>
                  <th class="text-center">Ngày kết thúc</th>
                  <th class="text-center">Số ngày</th>
                  <th class="text-center">Lý do</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Người phê duyệt</th>
                  <th class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <template v-if="isLoading">
                  <tr>
                    <td colspan="10" class="text-center">
                      Đang tải dữ liệu...
                    </td>
                  </tr>
                </template>
                <template v-else-if="dangKyVangList.length === 0">
                  <tr>
                    <td colspan="10" class="text-center">Không có dữ liệu</td>
                  </tr>
                </template>
                <template
                  v-else
                  v-for="(item, index) in dangKyVangList"
                  :key="item.id_dang_ky"
                >
                  <tr>
                    <td class="text-center">{{ index + 1 }}</td>
                    <td>{{ item.ho_va_ten }}</td>
                    <td>{{ item.ten_loai_vang }}</td>
                    <td class="text-center">{{ item.ngay_bat_dau }}</td>
                    <td class="text-center">{{ item.ngay_ket_thuc }}</td>
                    <td class="text-center">{{ item.so_ngay_vang }}</td>
                    <td>{{ item.ly_do }}</td>
                    <td class="text-center">
                      <span
                        :class="{
                          'badge bg-warning': item.tinh_trang === 0,
                          'badge bg-success': item.tinh_trang === 1,
                          'badge bg-danger': item.tinh_trang === 2,
                        }"
                      >
                        {{
                          item.tinh_trang == 0
                            ? "Chờ phê duyệt"
                            : item.tinh_trang == 1
                            ? "Đã phê duyệt"
                            : "Từ chối"
                        }}
                      </span>
                    </td>
                    <td>
                      {{
                        item.nguoi_phe_diet === null
                          ? "chưa phê duyệt"
                          : item.nguoi_phe_diet
                      }}
                    </td>
                    <td class="text-center">
                      <button
                        class="btn btn-primary btn-sm me-1"
                        data-bs-toggle="modal"
                        data-bs-target="#editModal"
                        @click="Object.assign(editItem, item)"
                      >
                        <i class="fas fa-edit"></i>
                      </button>
                      <button
                        class="btn btn-danger btn-sm me-1"
                        data-bs-toggle="modal"
                        data-bs-target="#deleteModal"
                        @click="Object.assign(deleteItem, item)"
                      >
                        <i class="fas fa-trash"></i>
                      </button>
                    </td>
                  </tr>
                </template>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- Create Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Thêm đăng ký vắng/công tác</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">Loại vắng</label>
                <select
                  v-model="formData.id_loai_vang"
                  class="form-select"
                  required
                >
                  <option value="">-- Chọn loại vắng --</option>
                  <option
                    v-for="lv in loaiVangList"
                    :key="lv.id_loai_vang"
                    :value="lv.id"
                  >
                    {{ lv.ten_loai_vang }}
                  </option>
                </select>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">Ngày bắt đầu</label>
                <input
                  v-model="formData.ngay_bat_dau"
                  type="date"
                  class="form-control"
                  required
                />
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">Ngày kết thúc</label>
                <input
                  v-model="formData.ngay_ket_thuc"
                  type="date"
                  class="form-control"
                  required
                />
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label">Lý do</label>
              <textarea
                v-model="formData.ly_do"
                class="form-control"
                rows="3"
                required
              ></textarea>
            </div>
            <div class="mb-3">
              <label class="form-label">Ghi chú</label>
              <textarea
                v-model="formData.ghi_chu"
                class="form-control"
                rows="2"
              ></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Đóng
            </button>
            <button
              type="button"
              class="btn btn-primary"
              @click="createDangKyVang"
              data-bs-dismiss="modal"
            >
              Lưu
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Cập nhật đăng ký vắng/công tác</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">Loại vắng</label>
                <select
                  v-model="editItem.id_loai_vang"
                  class="form-select"
                  required
                >
                  <option value="">-- Chọn loại vắng --</option>
                  <option
                    v-for="lv in loaiVangList"
                    :key="lv.id"
                    :value="lv.id"
                  >
                    {{ lv.ten_loai_vang }}
                  </option>
                </select>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">Ngày bắt đầu</label>
                <input
                  v-model="editItem.ngay_bat_dau"
                  type="date"
                  class="form-control"
                  required
                />
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">Ngày kết thúc</label>
                <input
                  v-model="editItem.ngay_ket_thuc"
                  type="date"
                  class="form-control"
                  required
                />
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label">Lý do</label>
              <textarea
                v-model="editItem.ly_do"
                class="form-control"
                rows="3"
                required
              ></textarea>
            </div>
            <div class="mb-3">
              <label class="form-label">Ghi chú</label>
              <textarea
                v-model="editItem.ghi_chu"
                class="form-control"
                rows="2"
              ></textarea>
            </div>

            <div
              class="mb-3"
              v-if="editItem.trang_thai === 1 || editItem.trang_thai === 2"
            >
              <label class="form-label">Người phê duyệt</label>
              <input
                v-model="editItem.nguoi_phe_duyet"
                type="text"
                class="form-control"
              />
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Đóng
            </button>
            <button
              type="button"
              class="btn btn-primary"
              @click="update"
              data-bs-dismiss="modal"
            >
              Lưu
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Modal -->
    <div
      class="modal fade"
      id="deleteModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              Xóa Chấm Công
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <div
              class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2"
            >
              <div class="d-flex align-items-center">
                <div class="font-35 text-white">
                  <i class="bx bxs-message-square-x"></i>
                </div>
                <div class="ms-1">
                  <h6 class="mb-1 text-white">
                    Bạn chắc chắc xóa đăng kí văng của nhân viên
                    <b>{{ deleteItem.ho_va_ten }}</b>
                    chứ !!!
                  </h6>
                  <div class="text-white text-nowrap">
                    <b>LƯU Ý !!!</b> Điều này không thể khôi phục khi ấn xác
                    nhận
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Đóng
            </button>
            <button
              type="button"
              class="btn btn-danger"
              data-bs-dismiss="modal"
              v-on:click="xoaDangKyVang(deleteItem.id)"
            >
              Xác nhận
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  name: "BaoCaoVangDiCongTac",
  data() {
    return {
      // Data
      dangKyVangList: [],
      loaiVangList: [],
      nhanVienList: [],

      // Form data
      formData: {
        id_nhan_vien: "",
        id_loai_vang: "",
        ngay_bat_dau: "",
        ngay_ket_thuc: "",
        ly_do: "",
        ghi_chu: "",
      },

      // Search data
      searchData: {
        ngay_bat_dau: "",
        ngay_ket_thuc: "",
        id_nhan_vien: "",
        id_loai_vang: "",
        tinh_trang: "",
      },

      // Edit and delete data
      editItem: {},
      deleteItem: {},
      changeStatus: {},
      changeStatus2: {},
      // Loading state
      isLoading: false,
    };
  },

  mounted() {
    this.fetchNhanVien();
    this.fetchLoaiVang();
    this.fetchDangkyVang();
  },

  methods: {
    fetchNhanVien() {
      axios
        .get("http://localhost:8000/api/admin/nhan-vien/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.nhanVienList = res.data.data;
        });
    },
    fetchLoaiVang() {
      axios
        .get("http://localhost:8000/api/admin/get-loai-vang", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.loaiVangList = res.data.loaiVang;
        });
    },
    createDangKyVang() {
      axios
        .post(
          "http://localhost:8000/api/admin/them-bao-cao-vang-di-cong-tac",
          this.formData,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.status === 201) {
            this.$toast.success(res.data.message);
            this.fetchDangkyVang();
            this.formData = {};
          }
        })
        .catch((res) => {
          const errorList = res.response.data.errors;
          for (const key in errorList) {
            this.$toast.error(errorList[key][0]);
          }
        });
    },
    fetchDangkyVang() {
      axios
        .get("http://localhost:8000/api/admin/get-bao-cao-vang", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.dangKyVangList = res.data.nghiPhep;
        });
    },

    update() {
      axios
        .put(
          "http://localhost:8000/api/admin/sua-bao-cao-vang",
          this.editItem,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.fetchDangkyVang();
          }
        })
        .catch((res) => {
          const errorList = res.response.data.errors;
          for (const key in errorList) {
            this.$toast.error(errorList[key][0]);
          }
        });
    },
    xoaDangKyVang(id) {
      axios
        .delete("http://localhost:8000/api/admin/xoa-bao-cao-vang/" + id, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.fetchDangkyVang();
          }
        });
    },
    searchNghiPhep() {
      axios
        .get("http://localhost:8000/api/admin/get-bao-cao-vang", {
          params: this.searchData,
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.dangKyVangList = res.data.nghiPhep;
        });
    },
    changeAccecpt() {
      axios
        .post(
          "http://localhost:8000/api/admin/trang-thai-chap-nhan",
          this.changeStatus,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.fetchDangkyVang();
          }
        });
    },
    changeReject() {
      axios
        .post(
          "http://localhost:8000/api/admin/trang-thai-tu-choi",
          this.changeStatus2,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.fetchDangkyVang();
          }
        });
    },
  },
};
</script>
<style scoped>
.card {
  border: none !important;
  box-shadow: 0 2px 15px rgba(108, 43, 217, 0.1);
  border-radius: 10px;
  margin-bottom: 1.5rem;
}

.card-header {
  background-color: #f8f5ff;
  border-bottom: 1px solid rgba(108, 43, 217, 0.1);
  padding: 1rem 1.5rem;
}

.card-header h5 {
  color: #333;
  font-size: 1.1rem;
  margin: 0;
}

.card-body {
  padding: 1.5rem;
}

.card-footer {
  background-color: #f8f5ff;
  border-top: 1px solid rgba(108, 43, 217, 0.1);
  padding: 1rem 1.5rem;
}

label {
  color: #333;
  font-weight: 600;
}

.form-control,
.form-select {
  border: 1px solid #e2d9f3;
  border-radius: 8px;
  padding: 0.6rem 1rem;
  transition: all 0.3s ease;
}

.form-control:focus,
.form-select:focus {
  border-color: #6c2bd9;
  box-shadow: 0 0 0 0.2rem rgba(108, 43, 217, 0.15);
}

.btn {
  padding: 0.6rem 1.2rem;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-primary {
  color: #6c2bd9;
  background-color: transparent;
  border: 2px solid #6c2bd9;
}

.btn-primary:hover {
  color: #fff;
  background-color: #6c2bd9;
  border-color: #6c2bd9;
}

.btn-success {
  color: #28a745;
  background-color: transparent;
  border: 2px solid #28a745;
}

.btn-success:hover {
  color: #fff;
  background-color: #28a745;
  border-color: #28a745;
}

.btn-danger {
  color: #dc3545;
  background-color: transparent;
  border: 2px solid #dc3545;
}

.btn-danger:hover {
  color: #fff;
  background-color: #dc3545;
  border-color: #dc3545;
}

.btn-secondary {
  color: #6c757d;
  background-color: transparent;
  border: 2px solid #6c757d;
}

.btn-secondary:hover {
  color: #fff;
  background-color: #6c757d;
  border-color: #6c757d;
}

.table {
  margin-bottom: 0;
}

.table thead th {
  background-color: #f8f5ff;
  color: #333;
  font-weight: 600;
  border-bottom: 2px solid #e2d9f3;
  padding: 1rem;
}

.table tbody td,
.table tbody th {
  color: #333;
  padding: 1rem;
  border-color: #e2d9f3;
  vertical-align: middle;
}

.table-hover tbody tr:hover {
  background-color: #f8f5ff;
}

.badge {
  padding: 0.5em 0.8em;
  font-weight: 500;
  border-radius: 6px;
}
</style>
