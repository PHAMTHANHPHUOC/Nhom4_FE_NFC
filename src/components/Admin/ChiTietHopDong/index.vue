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
<style>
.row {
  padding: 20px;
  background-color: #f5f6fa;
  min-height: 100vh;
}

.card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
  border: none !important;
  position: relative;
}

.card::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(to right, #0d6efd, #4e95ff);
  border-radius: 12px 12px 0 0;
}

.card-header {
  background: white;
  border-bottom: 1px solid #edf2f9;
  padding: 1.5rem;
  border-radius: 12px 12px 0 0;
}

.card-header h5 {
  color: #2c3e50;
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0;
}

.btn-success {
  background: #28a745;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-success:hover {
  background: #218838;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
}

.btn-success i {
  margin-right: 8px;
}

.table {
  margin: 0;
  border-color: #edf2f9;
}

.table thead th {
  background: #f8f9fa;
  color: #2c3e50;
  font-weight: 600;
  padding: 1rem;
  border-bottom: 2px solid #dee2e6;
}

.table tbody td,
.table tbody th {
  padding: 1rem;
  color: #495057;
  border-color: #edf2f9;
}

.table tbody tr:hover {
  background-color: #f8f9fa;
  transition: background-color 0.2s ease;
}

.fa-file-contract {
  color: #0d6efd;
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 8px;
  border-radius: 6px;
}

.fa-file-contract:hover {
  color: #0b5ed7;
  background-color: rgba(13, 110, 253, 0.1);
  transform: scale(1.1);
}

/* Modal Styling */
.modal-content {
  border: none;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.modal-header {
  background: linear-gradient(to right, #f8f9fa, #ffffff);
  border-radius: 12px 12px 0 0;
  padding: 1.5rem;
}

.modal-title {
  color: #2c3e50;
  font-weight: 600;
}

.modal-body {
  padding: 1.5rem;
  color: #495057;
  line-height: 1.7;
}

.modal-footer {
  padding: 1rem 1.5rem;
  background: #f8f9fa;
  border-top: 1px solid #edf2f9;
  border-radius: 0 0 12px 12px;
}

.btn-secondary {
  background: #6c757d;
  border: none;
  padding: 8px 20px;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.btn-secondary:hover {
  background: #5a6268;
  transform: translateY(-1px);
}

.btn-close:focus {
  box-shadow: none;
}

/* Custom scrollbar for modal */
.modal-body::-webkit-scrollbar {
  width: 8px;
}

.modal-body::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.modal-body::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 4px;
}

.modal-body::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}
</style>
