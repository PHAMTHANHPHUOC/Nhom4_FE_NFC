<template>
  <div class="row">
    <div class="col-lg-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-lg-3">
              <label class="form-label fw-bold">Chọn Nhân Viên</label>
              <select v-model="create.id_nhan_vien" class="form-control mt-1">
                <template v-for="(value, index) in list_nhan_vien" :key="index">
                  <option v-bind:value="value.id">{{ value.ho_va_ten }}</option>
                </template>
              </select>
            </div>
            <div class="col-lg-3">
              <label class="form-label fw-bold">Chọn Ngày</label>
              <input
                v-model="create.ngay_lam_viec"
                type="date"
                class="form-control"
              />
            </div>
            <div class="col-lg-3">
              <label class="form-label fw-bold">Chọn Ca</label>
              <select v-model="create.ca_lam" class="form-control">
                <option value="1">Ca Sáng</option>
                <option value="2">Ca Chiều</option>
                <option value="3">Ca Tối</option>
              </select>
            </div>
            <div class="col-lg-3 d-flex align-items-end">
              <button class="btn btn-primary w-100" v-on:click="themMoi()">
                Chấm Công
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-12">
      <div class="row">
        <div class="col-lg-12">
          <div class="card">
            <div
              class="card-header d-flex justify-content-between align-items-center"
            >
              <h5 class="mt-1"><b>Bảng Chấm Công</b></h5>
              <button
                @click="xuatExcel()"
                type="button"
                class="btn btn-success me-2"
              >
                <i class="fa-regular fa-file-excel"></i> Xuất Excel
              </button>
            </div>
            <div class="card-body">
              <table class="table table-bordered table-hover mt-2">
                <thead>
                  <tr>
                    <th class="text-center">#</th>
                    <th class="text-center">Nhân Viên</th>
                    <th class="text-center">Phòng Ban</th>
                    <th class="text-center">Ngày Chấm Công</th>
                    <th class="text-center">Ca Làm</th>
                    <th class="text-center">Action</th>
                  </tr>
                </thead>
                <tbody>
                  <template
                    v-for="(value, index) in list_cham_cong"
                    :key="index"
                  >
                    <tr>
                      <th class="align-middle text-center">{{ index + 1 }}</th>
                      <td class="align-middle">{{ value.ho_va_ten }}</td>
                      <td class="align-middle">{{ value.ten_phong_ban }}</td>
                      <td class="align-middle text-center">
                        {{ value.ngay_lam_viec }}
                      </td>
                      <td class="align-middle text-center">
                        {{
                          value.ca_lam == 1
                            ? "Ca Sáng"
                            : value.ca_lam == 2
                            ? "Ca Chiều"
                            : "Ca Tối"
                        }}
                      </td>
                      <td class="align-middle text-center">
                        <button
                          class="btn btn-primary me-2"
                          data-bs-toggle="modal"
                          v-on:click="Object.assign(update, value)"
                          data-bs-target="#capnhatDM"
                        >
                          Cập nhật
                        </button>
                        <button
                          class="btn btn-danger"
                          data-bs-toggle="modal"
                          v-on:click="Object.assign(del, value)"
                          data-bs-target="#delModal"
                        >
                          Xóa
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
    </div>
    <div
      class="modal fade"
      id="delModal"
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
                    Bạn chắc chắc xóa bảng chấm công của
                    <b>{{ del.ho_va_ten }}</b>
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
              v-on:click="xoaChamCong()"
            >
              Xác nhận
            </button>
          </div>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="capnhatDM"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              Cập nhật Chấm Công
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label fw-bold">Chọn Nhân Viên</label>
              <select v-model="update.id_nhan_vien" class="form-control mt-1">
                <template v-for="(value, index) in list_nhan_vien" :key="index">
                  <option v-bind:value="value.id">{{ value.ho_va_ten }}</option>
                </template>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label fw-bold">Chọn Ngày</label>
              <input
                v-model="update.ngay_lam_viec"
                type="date"
                class="form-control"
              />
            </div>
            <div class="mb-3">
              <label class="form-label fw-bold">Chọn Ca</label>
              <select v-model="update.ca_lam" class="form-control">
                <option value="1">Ca Sáng</option>
                <option value="2">Ca Chiều</option>
                <option value="3">Ca Tối</option>
              </select>
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
              data-bs-dismiss="modal"
              v-on:click="updateChamCong()"
            >
              Cập nhật
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
  data() {
    return {
      list_cham_cong: [],
      list_nhan_vien: [],
      create: {},
      update: {},
      del: {},
    };
  },
  mounted() {
    this.loadDataNhanVien();
    this.loadDataChamCong();
  },
  methods: {
    xuatExcel() {
      axios
        .get("http://127.0.0.1:8000/api/admin/cham-cong/xuat-excel", {
          responseType: "blob",
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status == false) {
            this.$toast.error(res.data.message);
          }
          const url = window.URL.createObjectURL(new Blob([res.data]));
          const link = document.createElement("a");
          link.href = url;
          link.setAttribute("download", "cham_cong.xlsx");
          document.body.appendChild(link);
          link.click();
        });
    },
    loadDataNhanVien() {
      axios
        .get("http://127.0.0.1:8000/api/admin/nhan-vien/data-open", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_nhan_vien = res.data.data;
        });
    },
    loadDataChamCong() {
      axios
        .get("http://127.0.0.1:8000/api/admin/cham-cong/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_cham_cong = res.data.data;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },

    themMoi() {
      axios
        .post("http://127.0.0.1:8000/api/admin/cham-cong/create", this.create, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataChamCong();
            this.create = {};
          } else {
            this.$toast.error(res.data.message);
          }
        })
        .catch((res) => {
          const errors = Object.values(res.response.data.errors);
          errors.forEach((v) => {
            this.$toast.error(v[0]);
          });
        });
    },
    updateChamCong() {
      axios
        .post("http://127.0.0.1:8000/api/admin/cham-cong/update", this.update, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataChamCong();
          } else {
            this.$toast.error(res.data.message);
          }
        })
        .catch((res) => {
          const errors = Object.values(res.response.data.errors);
          errors.forEach((v) => {
            this.$toast.error(v[0]);
          });
        });
    },
    xoaChamCong() {
      axios
        .post("http://127.0.0.1:8000/api/admin/cham-cong/delete", this.del, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataChamCong();
          } else {
            this.$toast.error(res.data.message);
          }
        })
        .catch((res) => {
          const errors = Object.values(res.response.data.errors);
          errors.forEach((v) => {
            this.$toast.error(v[0]);
          });
        });
    },
  },
};
</script>
<style scoped>
.card {
  border: none;
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

.form-label {
  color: #333;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.form-control {
  border: 1px solid #e2d9f3;
  border-radius: 8px;
  padding: 0.6rem 1rem;
  transition: all 0.3s ease;
}

.form-control:focus {
  border-color: #6c2bd9;
  box-shadow: 0 0 0 0.2rem rgba(108, 43, 217, 0.15);
}

select.form-control {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M0 2l4 4 4-4z' fill='%236c2bd9'/%3E%3C/svg%3E");
  background-position: right 1rem center;
  background-repeat: no-repeat;
  padding-right: 2.5rem;
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

.modal-content {
  border: none;
  border-radius: 15px;
  box-shadow: 0 5px 20px rgba(108, 43, 217, 0.15);
}

.modal-header {
  background-color: #f8f5ff;
  border-bottom: 1px solid #e2d9f3;
  padding: 1.5rem;
}

.modal-title {
  color: #333;
  font-weight: 600;
}

.modal-body {
  padding: 1.5rem;
}

.modal-footer {
  border-top: 1px solid #e2d9f3;
  padding: 1.5rem;
}

.alert-danger {
  background-color: #fff1f2;
  border-color: #fecdd3;
}

.alert-danger .text-white {
  color: #fff !important;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #f8f5ff;
}

::-webkit-scrollbar-thumb {
  background: #6c2bd9;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #5a23b5;
}

.w-100 {
  width: 100% !important;
}

.fw-bold {
  font-weight: 600 !important;
}

.text-center {
  text-align: center !important;
}

.align-middle {
  vertical-align: middle !important;
}

.me-2 {
  margin-right: 0.5rem !important;
}

.mt-1 {
  margin-top: 0.25rem !important;
}

.mt-2 {
  margin-top: 0.5rem !important;
}

.mb-3 {
  margin-bottom: 1rem !important;
}
</style>
