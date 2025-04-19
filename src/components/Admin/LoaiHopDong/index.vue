<template>
  <div class="row" id="app">
    <div class="col-md-3">
      <div class="card">
        <div class="card-header mt-2">
          <h5><b> Thêm Mới Loại Hợp Đồng </b></h5>
        </div>
        <div class="card-body">
          <label class="form-lable">Tên Hợp Đồng</label>
          <input
            v-model="create_loai_hop_dong.ten_hop_dong"
            class="form-control mt-1"
            type="text"
          />
          <label class="form-lable mt-2">Nội Dung</label>
          <!-- <textarea v-model="create_loai_hop_dong.noi_dung" class="form-control" cols="30"
                        rows="10"></textarea> -->
          <ckeditor
            v-model="create_loai_hop_dong.noi_dung"
            :editor="editor"
            :config="editorConfig"
          />
          <label class="form-lable mt-2"> Tình Trạng</label>
          <select
            v-model="create_loai_hop_dong.tinh_trang"
            class="form-control"
          >
            <option value="1">Hiển Thị</option>
            <option value="0">Tạm Dừng</option>
          </select>
        </div>
        <div class="card-footer text-end">
          <button @click="createLoaiHopDong()" class="btn btn-primary">
            Thêm Mới Hợp Đồng
          </button>
        </div>
      </div>
    </div>
    <div class="col-md-9">
      <div class="card">
        <div
          class="card-header mt-2 d-flex justify-content-between align-items-center"
        >
          <h5><b>Danh Sách Loại Hợp Đồng</b></h5>
          <button
            @click="xuatExcel()"
            type="button"
            class="btn btn-success me-2"
          >
            <i class="fa-regular fa-file-excel"></i> Xuất Excel
          </button>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th class="text-center align-middle text-nowrap">#</th>
                  <th class="text-center align-middle text-nowrap">
                    Tên Hợp Đồng
                  </th>
                  <th class="text-center align-middle text-nowrap">Nội Dung</th>
                  <th class="text-center align-middle text-nowrap">
                    Tình Trạng
                  </th>
                  <th class="text-center align-middle text-nowrap">Action</th>
                </tr>
              </thead>
              <tbody>
                <template v-for="(v, k) in list_loai_hop_dong" :key="k">
                  <tr>
                    <th class="text-center align-middle text-nowrap">
                      {{ k + 1 }}
                    </th>
                    <td class="align-middle text-nowrap">
                      {{ v.ten_hop_dong }}
                    </td>
                    <td
                      class="align-middle text-nowrap text-center"
                      data-bs-toggle="modal"
                      data-bs-target="#noi_dung"
                    >
                      <i
                        v-on:click="noi_dung_hop_dong = v.noi_dung"
                        class="fa-solid fa-file-contract fa-xl"
                      ></i>
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
                        class="btn btn-info me-2"
                        data-bs-toggle="modal"
                        v-on:click="Object.assign(edit_loai_hop_dong, v)"
                        data-bs-target="#editModal"
                      >
                        Cập Nhật
                      </button>
                      <button
                        class="btn btn-danger"
                        data-bs-toggle="modal"
                        v-on:click="Object.assign(delete_loai_hop_dong, v)"
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
                <h5 class="modal-title" id="exampleModalLabel">
                  Xóa Loại Hợp Đồng
                </h5>
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
                        Bạn chắc chắc xóa Loại Hợp Đồng
                        <b>{{ delete_loai_hop_dong.ten_hop_dong }}</b> này chứ
                        !!!
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
                  @click="xoaLoaiHopDong()"
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
          id="editModal"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">
                  Chỉnh Sửa Loại Hợp Đồng
                </h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">
                <label class="form-lable">Tên Hợp Đồng</label>
                <input
                  v-model="edit_loai_hop_dong.ten_hop_dong"
                  class="form-control mt-1"
                  type="text"
                />
                <label class="form-lable mt-2">Nội Dung</label>
                <!-- <textarea v-model="edit_loai_hop_dong.noi_dung" class="form-control" cols="30"
                                    rows="10"></textarea> -->
                <ckeditor
                  v-model="edit_loai_hop_dong.noi_dung"
                  :editor="editor"
                  :config="editorConfig"
                />
                <label class="form-lable mt-2"> Tình Trạng</label>
                <select
                  v-model="edit_loai_hop_dong.tinh_trang"
                  class="form-control"
                >
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
                  @click="capNhatLoaiHopDong()"
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
          id="noi_dung"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">
                  Nội Dung Hợp Đồng
                </h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">
                <span v-html="noi_dung_hop_dong"></span>
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
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import {
  ClassicEditor,
  Bold,
  Essentials,
  Italic,
  Mention,
  Paragraph,
  Undo,
  Heading,
  BlockQuote,
  Font,
  Link,
  List,
  Alignment,
} from "ckeditor5";
import { Ckeditor } from "@ckeditor/ckeditor5-vue";
import "ckeditor5/ckeditor5.css";
export default {
  components: {
    Ckeditor,
  },
  data() {
    return {
      create_loai_hop_dong: {},
      edit_loai_hop_dong: {},
      delete_loai_hop_dong: {},
      list_loai_hop_dong: [],
      noi_dung_hop_dong: "",
      editor: ClassicEditor,
      editorConfig: {
        plugins: [
          Bold,
          Essentials,
          Italic,
          Mention,
          Paragraph,
          Undo,
          Heading,
          BlockQuote,
          Font,
          Link,
          List,
          Alignment,
        ],
        toolbar: [
          "heading",
          "|",
          "undo",
          "redo",
          "|",
          "bold",
          "italic",
          "fontSize",
          "fontFamily",
          "fontColor",
          "|",
          "link",
          "bulletedList",
          "numberedList",
          "blockQuote",
          "|",
          "Alignment",
        ],
      },
    };
  },
  mounted() {
    this.loadLoaiHopDong();
  },
  methods: {
    xuatExcel() {
      axios
        .get("http://127.0.0.1:8000/api/admin/loai-hop-dong/xuat-excel", {
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
          link.setAttribute("download", "loai_hop_dong.xlsx");
          document.body.appendChild(link);
          link.click();
        });
    },
    loadLoaiHopDong() {
      axios
        .get("http://127.0.0.1:8000/api/admin/loai-hop-dong/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_loai_hop_dong = res.data.data;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
        });
    },
    createLoaiHopDong() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/loai-hop-dong/create",
          this.create_loai_hop_dong,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadLoaiHopDong();
            this.create_loai_hop_dong = {};
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
    capNhatLoaiHopDong() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/loai-hop-dong/update",
          this.edit_loai_hop_dong,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadLoaiHopDong();
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
    xoaLoaiHopDong() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/loai-hop-dong/delete",
          this.delete_loai_hop_dong,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.loadLoaiHopDong();
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
          "http://127.0.0.1:8000/api/admin/loai-hop-dong/change-status",
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
            this.loadLoaiHopDong();
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

/* CKEditor customization */
:deep(.ck-editor__editable) {
  min-height: 200px;
  border-color: #e2d9f3 !important;
}

:deep(.ck.ck-editor__main > .ck-editor__editable) {
  background-color: #fff;
}

:deep(.ck.ck-toolbar) {
  border-color: #e2d9f3 !important;
  background: #f8f5ff !important;
}

:deep(.ck.ck-button) {
  color: #333;
}

:deep(.ck.ck-button:hover) {
  background-color: #e2d9f3 !important;
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

.mb-1 {
  margin-bottom: 0.25rem !important;
}

.mb-2 {
  margin-bottom: 0.5rem !important;
}
</style>
