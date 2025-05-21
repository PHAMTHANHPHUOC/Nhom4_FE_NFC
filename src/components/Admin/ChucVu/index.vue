<template>
  <div class="row" id="app">
    <div class="col-md-3">
      <div class="card">
        <div class="card-header mt-2">
          <h5><b> Thêm Mới Chức Vụ </b></h5>
        </div>
        <div class="card-body">
          <label class="form-lable">Tên Chức Vụ</label>
          <input
            v-model="create_chuc_vu.ten_chuc_vu"
            class="form-control mt-1"
            type="text"
          />
          <label class="form-lable">Chức Vụ Cha</label>
          <input
            v-model="create_chuc_vu.id_chuc_vu_cha"
            class="form-control mt-1"
            type="text"
          />
          <label class="form-lable mt-2"> Tình Trạng</label>
          <select v-model="create_chuc_vu.tinh_trang" class="form-control">
            <option value="1">Hiển Thị</option>
            <option value="0">Tạm Dừng</option>
          </select>
        </div>
        <div class="card-footer text-end">
          <button @click="createChucVu()" class="btn btn-primary">
            Thêm Mới Chức Vụ
          </button>
        </div>
      </div>
    </div>
    <div class="col-md-9">
      <div class="card">
        <div
          class="card-header mt-2 d-flex justify-content-between align-items-center"
        >
          <h5><b>Danh Sách Chức Vụ</b></h5>
          <div class="row">
            <div class="col-lg-">
              <button
                class="btn btn-success me-2"
                data-bs-toggle="modal"
                data-bs-target="#treeChucVuModal"
              >
                <i class="fa-solid fa-folder-tree text-success"></i> Cây Chức Vụ
              </button>
              <button @click="xuatExcel()" class="btn btn-success">
                <i class="fa-regular fa-file-excel"></i> Xuất Excel
              </button>
            </div>
          </div>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th class="text-center align-middle text-nowrap">#</th>
                  <th class="text-center align-middle text-nowrap">
                    Tên Chức Vụ
                  </th>
                  <th class="text-center align-middle text-nowrap">
                    Chức vụ cha
                  </th>
                  <th class="text-center align-middle text-nowrap">
                    Tình Trạng
                  </th>
                  <th class="text-center align-middle text-nowrap">Action</th>
                </tr>
              </thead>
              <tbody>
                <template v-for="(v, k) in list_chuc_vu" :key="k">
                  <tr>
                    <th class="text-center align-middle text-nowrap">
                      {{ k + 1 }}
                    </th>
                    <td class="align-middle text-nowrap">
                      {{ v.ten_chuc_vu }}
                    </td>
                    <td class="align-middle text-nowrap">
                      {{ v.id_chuc_vu_cha }}
                    </td>
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
                    <td class="text-center align-middle text-nowrap">
                      <button
                        class="btn btn-warning me-2"
                        data-bs-toggle="modal"
                        data-bs-target="#phanQuyenModal"
                        v-on:click="loadChucNang(v)"
                      >
                        Phân Quyền
                      </button>
                      <button
                        class="btn btn-info me-2"
                        data-bs-toggle="modal"
                        v-on:click="Object.assign(edit_chuc_vu, v)"
                        data-bs-target="#editModal"
                      >
                        Cập Nhật
                      </button>
                      <button
                        class="btn btn-danger"
                        data-bs-toggle="modal"
                        v-on:click="Object.assign(delete_chuc_vu, v)"
                        data-bs-target="#deleteModal"
                      >
                        Xóa Bỏ
                      </button>
                    </td>
                  </tr>
                </template>
              </tbody>
            </table>
          </div>
        </div>

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
                <h5 class="modal-title" id="exampleModalLabel">Xóa Chức Vụ</h5>
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
                        Bạn chắc chắc xóa chức vụ
                        <b>{{ delete_chuc_vu.ten_chuc_vu }}</b> này chứ !!!
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
                  @click="xoaChucVu()"
                  type="button"
                  class="btn btn-danger"
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
          id="treeChucVuModal"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog modal-xl">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Cây Chức Vụ</h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">
                <div id="tree" ref="tree"></div>
              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal"
                >
                  Đóng
                </button>
              </div>
            </div>
          </div>
        </div>

        <div
          class="modal fade"
          id="editModal"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">
                  Chỉnh Sửa Chức Vụ
                </h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">
                <label class="form-lable">Tên Chức Vụ</label>
                <input
                  v-model="edit_chuc_vu.ten_chuc_vu"
                  class="form-control mt-1"
                  type="text"
                />
                <label class="form-lable">Chức Vụ Cha</label>
                <input
                  v-model="edit_chuc_vu.id_chuc_vu_cha"
                  class="form-control mt-1"
                  type="text"
                />
                <label class="form-lable mt-2"> Tình Trạng</label>
                <select v-model="edit_chuc_vu.tinh_trang" class="form-control">
                  <option value="1">Hiển Thị</option>
                  <option value="0">Tạm Dừng</option>
                </select>
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
                  @click="capNhatChucVu()"
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
      </div>
    </div>
  </div>
  <div
    class="modal fade"
    id="phanQuyenModal"
    tabindex="-1"
    aria-labelledby="exampleModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">
            Phân Quyền Cho Nhân Viên {{ phan_quyen_nhan_vien.ho_va_ten }}
          </h1>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <table class="table table-bordered table-hover">
            <thead>
              <tr>
                <th class="align-middle text-center">#</th>
                <th class="align-middle text-center">Tên Chức Năng</th>
                <th class="align-middle text-center">Trạng Thái</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(v, k) in list_chuc_nang" :key="k">
                <tr>
                  <th class="text-center align-middle">
                    {{ k + 1 }}
                  </th>
                  <td class="align-middle">
                    {{ v.ten_chuc_nang }}
                  </td>
                  <td class="text-center align-middle">
                    <button
                      v-if="v.is_phan_quyen == 1"
                      v-on:click="removeQuyen(v)"
                      class="btn btn-primary"
                    >
                      Đã Phân Quyền
                    </button>
                    <button
                      v-else
                      v-on:click="setQuyen(v)"
                      class="btn btn-danger"
                    >
                      Chưa Phân Quyền
                    </button>
                  </td>
                </tr>
              </template>
            </tbody>
          </table>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal"
          >
            Đóng
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import OrgChart from "@balkangraph/orgchart.js";
export default {
  data() {
    return {
      create_chuc_vu: {},
      edit_chuc_vu: {},
      delete_chuc_vu: {},
      list_chuc_vu: [],
      phan_quyen_nhan_vien: {},
      list_chuc_nang: [],
      nodes: [],
    };
  },
  mounted() {
    this.loadChucVu();
  },
  methods: {
    mytree: function(domEl, x) {
      this.chart = new OrgChart(domEl, {
        nodes: x,
        nodeBinding: {
          field_0: "name",
          img_0: "img",
        },
      });
    },
    loadChucNang(value) {
      this.phan_quyen_nhan_vien = value;
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/chuc-nang/data",
          this.phan_quyen_nhan_vien,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          this.list_chuc_nang = res.data.data;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },
    removeQuyen(value) {
      value.id_nhan_vien = this.phan_quyen_nhan_vien.id;
      axios
        .post("http://127.0.0.1:8000/api/admin/phan-quyen/delete", value, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadChucNang(this.phan_quyen_nhan_vien);
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
    setQuyen(value) {
      value.id_nhan_vien = this.phan_quyen_nhan_vien.id;
      axios
        .post("http://127.0.0.1:8000/api/admin/phan-quyen/create", value, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadChucNang(this.phan_quyen_nhan_vien);
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
    xuatExcel() {
      axios
        .get("http://127.0.0.1:8000/api/admin/chuc-vu/xuat-excel", {
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
          link.setAttribute("download", "chuc_vu.xlsx");
          document.body.appendChild(link);
          link.click();
        });
    },
    loadChucVu() {
      axios
        .get("http://127.0.0.1:8000/api/admin/chuc-vu/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_chuc_vu = res.data.data;
          this.list_chuc_vu.forEach((value, index) => {
            var item = {
              id: value.id,
              pid: value.id_chuc_vu_cha ?? null,
              name: value.ten_chuc_vu,
              title: value.ten_chuc_vu,
            };
            this.nodes.push(item);
          });
          this.mytree(this.$refs.tree, this.nodes);
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },
    createChucVu() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/chuc-vu/create",
          this.create_chuc_vu,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadChucVu();
            this.create_chuc_vu = {};
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
    capNhatChucVu() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/chuc-vu/update",
          this.edit_chuc_vu,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadChucVu();
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
    xoaChucVu() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/chuc-vu/delete",
          this.delete_chuc_vu,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadChucVu();
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
        .post("http://127.0.0.1:8000/api/admin/chuc-vu/change-status", value, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadChucVu();
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

.card-footer {
  background-color: #f8f5ff;
  border-top: 1px solid rgba(108, 43, 217, 0.1);
  padding: 1rem 1.5rem;
}

.form-lable {
  color: #333;
  font-weight: 600;
  display: block;
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

.w-100 {
  width: 100% !important;
}

.text-nowrap {
  white-space: nowrap !important;
}
</style>
