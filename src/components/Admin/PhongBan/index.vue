<template>
  <div class="row">
    <div class="col-lg-4">
      <div class="card border-top border-0 border-4 border-primary">
        <div class="card-header">
          <h5>Thêm Mới Phòng Ban</h5>
        </div>
        <div class="card-body">
          <div class="">
            <div class="mb-3">
              <label class="mb-2">Tên Phòng Ban</label>
              <input
                v-model="create_phong_ban.ten_phong_ban"
                type="text"
                class="form-control"
                placeholder=""
              />
            </div>
            <div class="mb-3">
              <label class="mb-2"> Phòng Ban Cha</label>
              <select
                v-model="create_phong_ban.id_phong_ban_cha"
                class="form-select"
              >
                <option
                  v-for="lv in list_phong_ban"
                  :key="lv.id"
                  :value="lv.id"
                >
                  {{ lv.ten_phong_ban }}
                </option>
              </select>
            </div>

            <div class="mb-3">
              <label class="mb-2">Tình Trạng</label>
              <select
                v-model="create_phong_ban.tinh_trang"
                class="form-select"
                aria-label="Default select example"
              >
                <option value="1">Hiển Thị</option>
                <option value="0">Tạm tắt</option>
              </select>
            </div>
          </div>
        </div>
        <div class="card-footer text-end">
          <button
            @click="createPhongBan()"
            type="button"
            class="btn btn-primary"
          >
            Thêm Mới
          </button>
        </div>
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card border-top border-0 border-4 border-primary">
        <div
          class="card-header d-flex justify-content-between align-items-center"
        >
          <h5>Danh Sách Phòng Ban</h5>
          <button
            @click="xuatExcel()"
            type="button"
            class="btn btn-success me-2"
          >
            <i class="fa-regular fa-file-excel"></i> Xuất Excel
          </button>
        </div>
        <div class="card-body">
          <table class="table table-bordered">
            <thead>
              <tr class="text-center">
                <th class="align-middle">#</th>
                <th class="align-middle">Tên Phòng Ban</th>
                <th class="align-middle">Phòng Ban Cha</th>
                <th class="align-middle">Tình Trạng</th>
                <th class="align-middle">Action</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(v, k) in list_phong_ban" :key="k">
                <tr class="align-middle text-center">
                  <th class="align-middle">{{ k + 1 }}</th>
                  <td class="align-middle">{{ v.ten_phong_ban }}</td>
                  <td class="align-middle">{{ v.id_phong_ban_cha }}</td>
                  <!-- <td class="align-middle">{{ v.id_truong_phong }}</td> -->
                  <td class="align-middle text-nowrap text-center">
                    <template v-if="v.tinh_trang == 1">
                      <button
                        v-on:click="changeStatus(v)"
                        class="btn btn-success w-100"
                      >
                        Hiển Thị
                      </button>
                    </template>
                    <template v-else>
                      <button
                        v-on:click="changeStatus(v)"
                        class="btn btn-danger w-100"
                      >
                        Tạm Tắt
                      </button>
                    </template>
                  </td>
                  <td class="align-middle">
                    <button
                      type="button"
                      class="btn btn-primary me-2"
                      data-bs-toggle="modal"
                      v-on:click="Object.assign(edit_phong_ban, v)"
                      data-bs-target="#edit"
                    >
                      Cập Nhật
                    </button>
                    <button
                      type="button"
                      data-bs-toggle="modal"
                      data-bs-target="#xoa"
                      v-on:click="Object.assign(delete_phong_ban, v)"
                      class="btn btn-danger"
                    >
                      Xóa
                    </button>
                  </td>
                </tr>
              </template>
            </tbody>
          </table>
        </div>
        <div
          class="modal fade"
          id="edit"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">
                  Cập Nhật Phòng Ban
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
                  <label class="mb-2">Tên Phòng Ban</label>
                  <input
                    v-model="edit_phong_ban.ten_phong_ban"
                    type="text"
                    class="form-control"
                    placeholder=""
                  />
                </div>
                <div class="mb-3">
                  <label class="mb-2"> Phòng Ban Cha</label>
                  <select
                    v-model="create_phong_ban.id_phong_ban_cha"
                    class="form-select"
                  >
                    <option
                      v-for="lv in list_phong_ban"
                      :key="lv.id"
                      :value="lv.id"
                    >
                      {{ lv.ten_phong_ban }}
                    </option>
                  </select>
                </div>
                <div class="mb-3">
                  <label class="mb-2">Trưởng Phòng</label>
                  <input
                    v-model="edit_phong_ban.id_truong_phong"
                    type="number"
                    class="form-control"
                    placeholder=""
                  />
                </div>
                <div class="mb-3">
                  <label class="mb-2">Tình Trạng</label>
                  <select
                    v-model="edit_phong_ban.tinh_trang"
                    class="form-select"
                    aria-label="Default select example"
                  >
                    <option value="1">Hiển Thị</option>
                    <option value="0">Tạm tắt</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal"
                >
                  Close
                </button>
                <button
                  @click="capNhatPhongBan()"
                  type="button"
                  class="btn btn-primary"
                  data-bs-dismiss="modal"
                >
                  Xác Nhận
                </button>
              </div>
            </div>
          </div>
        </div>

        <div
          class="modal fade"
          id="xoa"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">
                  Xóa Phòng Ban
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
                        Bạn chắc chắc xóa phòng ban
                        <b>{{ delete_phong_ban.ten_phong_ban }}</b> này chứ !!!
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
                  Close
                </button>
                <button
                  @click="xoaPhongBan()"
                  type="button"
                  class="btn btn-danger"
                  data-bs-dismiss="modal"
                >
                  Xóa
                </button>
              </div>
            </div>
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
      create_phong_ban: {},
      edit_phong_ban: {},
      delete_phong_ban: {},
      list_phong_ban: [],
    };
  },
  mounted() {
    this.loadPhongBan();
  },
  methods: {
    xuatExcel() {
      axios
        .get("http://127.0.0.1:8000/api/admin/phong-ban/xuat-excel", {
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
          link.setAttribute("download", "phong_ban.xlsx");
          document.body.appendChild(link);
          link.click();
        });
    },
    loadPhongBan() {
      axios
        .get("http://127.0.0.1:8000/api/admin/phong-ban/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_phong_ban = res.data.data;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },
    createPhongBan() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/phong-ban/create",
          this.create_phong_ban,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadPhongBan();
            this.create_phong_ban = {};
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
    capNhatPhongBan() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/phong-ban/update",
          this.edit_phong_ban,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadPhongBan();
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
    xoaPhongBan() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/phong-ban/delete",
          this.delete_phong_ban,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadPhongBan();
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
    changeStatus(value) {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/phong-ban/change-status",
          value,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadPhongBan();
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
  color: #be123c !important;
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

/* Remove default border-top from Bootstrap */
.border-top {
  border-top: none !important;
}

.border-4 {
  border: none !important;
}

.border-primary {
  border: none !important;
}

.w-100 {
  width: 100% !important;
}

.text-nowrap {
  white-space: nowrap !important;
}
</style>
