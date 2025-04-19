<template>
  <div class="row">
    <div class="col-lg-12">
      <div class="card">
        <div
          class="card-header d-flex justify-content-between align-items-center mt-2"
        >
          <h6><b>DANH SÁCH KPI NHÂN VIÊN</b></h6>
          <div>
            <button
              @click="xuatExcel()"
              type="button"
              class="btn btn-success me-2"
            >
              <i class="fa-regular fa-file-excel"></i> Xuất Excel
            </button>
            <button
              type="button"
              class="btn btn-primary"
              data-bs-toggle="modal"
              data-bs-target="#themMoiModal"
            >
              Thêm Mới
            </button>
          </div>
        </div>
        <div class="card-body table-responsive">
          <div class="input-group mt-3 w-100">
            <input
              type="text"
              v-model="search.noi_dung"
              class="form-control search-control border border-1 border-secondary"
              placeholder="Search..."
            />
            <span
              class="position-absolute top-50 search-show translate-middle-y"
              style="left: 15px"
              ><i class="bx bx-search"></i
            ></span>
            <button
              class="btn btn-outline-secondary"
              type="button"
              id="button-addon2"
              v-on:click="TimKiemKpiNhanVien()"
            >
              Tìm Kiếm
            </button>
          </div>
          <table class="table table-bordered table-hover mt-2">
            <thead>
              <tr>
                <th class="text-center">#</th>
                <th class="text-center">Nhân Viên</th>
                <th class="text-center">Tên KPI</th>
                <th class="text-center">Điểm Được Chấm</th>
                <th class="text-center">Người Đánh Giá</th>
                <th class="text-center">Ngày Đánh Giá</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <template
                v-for="(value, index) in list_kpi_nhan_vien"
                :key="index"
              >
                <tr>
                  <th class="align-middle text-center">{{ index + 1 }}</th>
                  <td class="align-middle">{{ value.ho_va_ten }}</td>
                  <td class="align-middle">{{ value.ten_tieu_chi }}</td>
                  <td class="align-middle text-center">
                    {{ value.diem_duoc_cham }}
                  </td>
                  <td class="align-middle">
                    {{ value.ten_nhan_vien_danh_gia }}
                  </td>
                  <td class="align-middle text-center">
                    {{ value.ngay_danh_gia }}
                  </td>
                  <td class="align-middle text-center">
                    <button
                      class="btn btn-info me-2"
                      data-bs-toggle="modal"
                      v-on:click="Object.assign(update, value)"
                      data-bs-target="#chamDiemModal"
                    >
                      Chấm Điểm
                    </button>
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
    <div
      class="modal fade"
      id="themMoiModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              Thêm Mới KPI
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
              <label class="form-label">Chọn Nhân Viên</label>
              <select v-model="create.id_nhan_vien" class="form-control mt-1">
                <template v-for="(value, index) in list_nhan_vien" :key="index">
                  <option v-bind:value="value.id">{{ value.ho_va_ten }}</option>
                </template>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Chọn KPI</label>
              <select v-model="create.id_tieu_chi" class="form-control mt-1">
                <template
                  v-for="(value, index) in list_tieu_chi_kpi"
                  :key="index"
                >
                  <option v-bind:value="value.id">
                    {{ value.ten_tieu_chi }}
                  </option>
                </template>
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
              class="btn btn-primary"
              data-bs-dismiss="modal"
              v-on:click="themMoi()"
            >
              Thêm Mới
            </button>
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
            <h1 class="modal-title fs-5" id="exampleModalLabel">Xóa KPI</h1>
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
                    Bạn chắc chắc xóa kpi <b>{{ del.ten_tieu_chi }}</b> của
                    <b>{{ del.ho_va_ten }}</b> này chứ !!!
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
              v-on:click="xoaDiemKpiNhanVien()"
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
              Cập nhật KPI
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
              <label class="form-label">Chọn Nhân Viên</label>
              <select v-model="update.id_nhan_vien" class="form-control mt-1">
                <template v-for="(value, index) in list_nhan_vien" :key="index">
                  <option v-bind:value="value.id">{{ value.ho_va_ten }}</option>
                </template>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Chọn KPI</label>
              <select v-model="update.id_tieu_chi" class="form-control mt-1">
                <template
                  v-for="(value, index) in list_tieu_chi_kpi"
                  :key="index"
                >
                  <option v-bind:value="value.id">
                    {{ value.ten_tieu_chi }}
                  </option>
                </template>
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
              v-on:click="upDateKpiNhanVien()"
            >
              Cập nhật
            </button>
          </div>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="chamDiemModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              Chấm Điểm KPI
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <div class="row mt-2">
              <div class="col-lg-12">
                <label class="form-label fw-bold">Cho Điểm KPI</label>
                <input
                  v-model="update.diem_duoc_cham"
                  type="number"
                  class="form-control"
                />
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
              class="btn btn-primary"
              data-bs-dismiss="modal"
              v-on:click="chamDiemKpiNhanVien()"
            >
              Chấm Điểm
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
      list_nhan_vien: [],
      list_tieu_chi_kpi: [],
      list_kpi_nhan_vien: [],
      create: {},
      update: {},
      del: {},
      search: {},
    };
  },
  mounted() {
    this.loadDataNhanVien();
    this.loadDataKpi();
    this.loadDataKpiNhanVien();
  },
  methods: {
    xuatExcel() {
      axios
        .get("http://127.0.0.1:8000/api/admin/kpi-nhan-vien/xuat-excel", {
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
          link.setAttribute("download", "kpi_nhan_vien.xlsx");
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
    loadDataKpi() {
      axios
        .get("http://127.0.0.1:8000/api/admin/tieu-chi-kpi/data-open", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_tieu_chi_kpi = res.data.data;
        });
    },
    loadDataKpiNhanVien() {
      axios
        .get("http://127.0.0.1:8000/api/admin/kpi-nhan-vien/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_kpi_nhan_vien = res.data.data;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },
    themMoi() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/kpi-nhan-vien/create",
          this.create,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataKpiNhanVien();
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
    upDateKpiNhanVien() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/kpi-nhan-vien/update",
          this.update,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataKpiNhanVien();
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
    chamDiemKpiNhanVien() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/kpi-nhan-vien/cham-diem",
          this.update,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataKpiNhanVien();
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
    xoaDiemKpiNhanVien() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/kpi-nhan-vien/delete",
          this.del,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadDataKpiNhanVien();
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
    TimKiemKpiNhanVien() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/kpi-nhan-vien/tim-kiem",
          this.search,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          this.list_kpi_nhan_vien = res.data.data;
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

.card-header h6 {
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

.search-control {
  padding-left: 2.5rem;
}

.search-show {
  color: #6c2bd9;
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

.btn-info {
  color: #17a2b8;
  background-color: transparent;
  border: 2px solid #17a2b8;
}

.btn-info:hover {
  color: #fff;
  background-color: #17a2b8;
  border-color: #17a2b8;
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

.text-nowrap {
  white-space: nowrap !important;
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

.mt-3 {
  margin-top: 1rem !important;
}

.mb-1 {
  margin-bottom: 0.25rem !important;
}

.mb-2 {
  margin-bottom: 0.5rem !important;
}

.mb-3 {
  margin-bottom: 1rem !important;
}
</style>
