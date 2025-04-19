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
