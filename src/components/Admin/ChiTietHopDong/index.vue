<template>
  <div class="row">
    <div class="col-lg-12">
      <div class="card border-top border-0 border-4 border-primary">
        <div
          class="card-header d-flex justify-content-between align-items-center"
        >
          <h5>Hợp Đồng Nhân Viên</h5>
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
              <tr class="align-middle text-center">
                <th class="align-middle">#</th>
                <th class="align-middle">Tên Nhân Viên</th>
                <th class="align-middle">Loại Hợp Đồng</th>
                <th class="align-middle">Nội Dung</th>
                <th class="align-middle">Ngày Bắt Đầu</th>
                <th class="align-middle">Ngày Kết Thúc</th>
                <th class="align-middle">Ngày Ký</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(v, k) in list_chi_tiet_hop_dong" :key="k">
                <tr class="align-middle">
                  <th class="align-middle text-center">{{ k + 1 }}</th>
                  <td class="align-middle">{{ v.ho_va_ten }}</td>
                  <td class="align-middle">{{ v.ten_hop_dong }}</td>
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
                  <td class="align-middle text-center">{{ v.ngay_bat_dau }}</td>
                  <td class="align-middle text-center">
                    {{ v.ngay_ket_thuc }}
                  </td>
                  <td class="align-middle text-center">{{ v.ngay_ky }}</td>
                </tr>
              </template>
            </tbody>
          </table>
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
          <h5 class="modal-title" id="exampleModalLabel">Nội Dung Hợp Đồng</h5>
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
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      list_chi_tiet_hop_dong: [],
      noi_dung_hop_dong: "",
    };
  },
  mounted() {
    this.loadChiTietHopDong();
  },
  methods: {
    xuatExcel() {
      axios
        .get("http://127.0.0.1:8000/api/admin/chi-tiet-hop-dong/xuat-excel", {
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
          link.setAttribute("download", "chi_tiet_hop_dong.xlsx");
          document.body.appendChild(link);
          link.click();
        });
    },
    loadChiTietHopDong() {
      axios
        .get("http://127.0.0.1:8000/api/admin/chi-tiet-hop-dong/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_chi_tiet_hop_dong = res.data.data;
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

.card.border-top {
  border-top: 4px solid #6c2bd9 !important;
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

.btn {
  padding: 0.6rem 1.2rem;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s ease;
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

/* File icon styling */
.fa-file-contract {
  color: #6c2bd9;
  cursor: pointer;
  transition: all 0.3s ease;
}

.fa-file-contract:hover {
  color: #5a23b5;
  transform: scale(1.1);
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
</style>
