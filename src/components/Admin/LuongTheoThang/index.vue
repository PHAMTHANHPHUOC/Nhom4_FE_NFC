<template>
  <div class="row">
    <div class="col-lg-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-lg-2">
              <label class="form-label fw-bold">Năm</label>
              <input
                v-model="tinh_luong.year"
                type="number"
                class="text-center form-control"
              />
            </div>
            <div class="col-lg-2 d-flex align-items-end">
              <button v-on:click="tinhLuong()" class="btn btn-primary w-100">
                Tìm Kiếm
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-12">
      <div class="card">
        <div
          class="card-header d-flex justify-content-between align-items-center mt-2"
        >
          <h5 class="fw-bold">Bảng Lương</h5>
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
                <tr class="align-middle">
                  <th class="text-center">#</th>
                  <th class="text-center">Tên Nhân Viên</th>
                  <th class="text-center">Tháng 01</th>
                  <th class="text-center">Tháng 02</th>
                  <th class="text-center">Tháng 03</th>
                  <th class="text-center">Tháng 04</th>
                  <th class="text-center">Tháng 05</th>
                  <th class="text-center">Tháng 06</th>
                  <th class="text-center">Tháng 07</th>
                  <th class="text-center">Tháng 08</th>
                  <th class="text-center">Tháng 09</th>
                  <th class="text-center">Tháng 10</th>
                  <th class="text-center">Tháng 11</th>
                  <th class="text-center">Tháng 12</th>
                </tr>
              </thead>
              <tbody>
                <template v-for="(value, index) in list" :key="index">
                  <tr class="align-middle">
                    <th class="text-center">{{ index + 1 }}</th>
                    <th class="text-center">{{ value.ho_va_ten }}</th>
                    <td class="text-center">{{ value.thang_1 }}</td>
                    <td class="text-center">{{ value.thang_2 }}</td>
                    <td class="text-center">{{ value.thang_3 }}</td>
                    <td class="text-center">{{ value.thang_4 }}</td>
                    <td class="text-center">{{ value.thang_5 }}</td>
                    <td class="text-center">{{ value.thang_6 }}</td>
                    <td class="text-center">{{ value.thang_7 }}</td>
                    <td class="text-center">{{ value.thang_8 }}</td>
                    <td class="text-center">{{ value.thang_9 }}</td>
                    <td class="text-center">{{ value.thang_10 }}</td>
                    <td class="text-center">{{ value.thang_11 }}</td>
                    <td class="text-center">{{ value.thang_12 }}</td>
                  </tr>
                </template>
              </tbody>
            </table>
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
      tinh_luong: {},
      list: [],
    };
  },
  methods: {
    xuatExcel() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/luong-theo-thang/xuat-excel",
          {},
          {
            responseType: "blob",
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status == false) {
            this.$toast.error(res.data.message);
          }
          const url = window.URL.createObjectURL(new Blob([res.data]));
          const link = document.createElement("a");
          link.href = url;
          link.setAttribute("download", "luong_theo_thang.xlsx");
          document.body.appendChild(link);
          link.click();
        });
    },
    tinhLuong() {
      axios
        .post("http://127.0.0.1:8000/api/admin/tinh-luong-4", this.tinh_luong, {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list = res.data.data;
          if (res.data.status == 0) {
            this.$toast.error(res.data.message);
          }
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

input[type="number"].form-control {
  background-color: #fff;
  cursor: pointer;
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

.table-responsive {
  border-radius: 8px;
  overflow: auto;
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
  white-space: nowrap;
}

.table tbody td,
.table tbody th {
  color: #333;
  padding: 1rem;
  border-color: #e2d9f3;
  vertical-align: middle;
  white-space: nowrap;
}

.table-hover tbody tr:hover {
  background-color: #f8f5ff;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
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

.mt-2 {
  margin-top: 0.5rem !important;
}

/* Excel icon styling */
.fa-file-excel {
  margin-right: 0.5rem;
}
</style>
