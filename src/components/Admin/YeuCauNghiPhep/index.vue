<template>
  <div class="container-fluid py-4">
    <!-- Header with title and add button -->
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h6 class="mb-0"><b>QUẢN LÝ YÊU CẦU NGHỈ PHÉP</b></h6>
        <div>
          <button class="btn btn-success me-2">
            <i class="fa-regular fa-file-excel"></i>Xuất Excel
          </button>
          <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#themMoiModal">
            <i class="fas fa-plus"></i>Tạo yêu cầu mới
          </button>
        </div>
      </div>

      <!-- Table of leave requests -->
      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>ID</th>
                <th>Nhân viên</th>
                <th>Loại nghỉ phép</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Số ngày</th>
                <th>Lý do</th>
                <th>Trạng thái</th>
                <th>Người phê duyệt</th>
                <th>Ngày phê duyệt</th>
                <th>Ghi chú</th>
                <th class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(v, k) in list_yeu_cau_nghi_phep" :key="k">
                <tr>
                  <td>{{ v.id_nhan_vien }}</td>
                  <td>{{ v.ho_va_ten }}</td>
                  <td>{{ v.ten_loai_vang }}</td>
                  <td>{{ v.ngay_bat_dau }}</td>
                  <td>{{ v.ngay_ket_thuc }}</td>
                  <td>{{ v.so_ngay_vang }}</td>
                  <td>{{ v.ly_do }}</td>
                  <td>
                    <button v-if="v.tinh_trang === 0" class="btn btn-sm btn-outline-warning rounded-pill px-3">
                      Chưa phê duyệt
                    </button>
                    <button v-else class="btn btn-sm btn-outline-success rounded-pill px-3">
                      <i class="fas fa-check-circle me-1"></i>Đã phê duyệt
                    </button>
                  </td>
                  <td>{{ v.nguoi_phe_duyet }}</td>
                  <td>{{ v.ngay_phe_duyet }}</td>
                  <td>{{ v.ghi_chu }}</td>
                  <td class="text-center">

                    <button class="btn btn-sm btn-secondary me-1" title="Sửa">
                      <i class="fas fa-edit" data-bs-toggle="modal" data-bs-target="#updateModal"
                        @click="Object.assign(update, v)"></i>
                    </button>
                    <button class="btn btn-sm btn-danger" title="Xóa" data-bs-toggle="modal"
                      data-bs-target="#deleteModal" @click="Object.assign(del, v)">
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
  <!-- Modal Create -->
  <div class="modal modal-lg fade" id="themMoiModal" tabindex="-1" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">YÊU CẦU NGHỈ PHÉP</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="id_nhan_vien" class="form-label">Mã nhân viên</label>
              <select v-model="create.id_nhan_vien" class="form-control mt-1">
                <template v-for="(v, k) in nhanVienList" :key="k">
                  <option v-bind:value="v.id">{{ v.ho_va_ten }}</option>
                </template>
              </select>
            </div>

            <div class="col-md-6">
              <label for="id_loai_vang" class="form-label">Loại nghỉ phép</label>
              <select v-model="create.id_loai_vang" class="form-select" id="id_loai_vang">
                <option disabled>Chọn loại nghỉ phép</option>
                <template v-for="(v, k) in loaiVangList" :key="k">
                  <option :value="v.id" selected>{{ v.ten_loai_vang }} </option>
                </template>
              </select>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label for="ngay_bat_dau" class="form-label">Ngày bắt đầu</label>
              <input v-model="create.ngay_bat_dau" type="date" class="form-control" id="ngay_bat_dau">
            </div>

            <div class="col-md-6">
              <label for="ngay_ket_thuc" class="form-label">Ngày kết thúc</label>
              <input v-model="create.ngay_ket_thuc" type="date" class="form-control" id="ngay_ket_thuc">
            </div>
          </div>

          <div class="mb-3">
            <label for="ly_do" class="form-label">Lý do</label>
            <textarea v-model="create.ly_do" class="form-control" id="ly_do" rows="3"></textarea>
          </div>

          <div class="mb-3">
            <label for="ghi_chu" class="form-label">Ghi chú</label>
            <textarea v-model="create.ghi_chu" class="form-control" id="ghi_chu" rows="3"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" @:click="creareYeuCauVang" data-bs-dismiss="modal">Thêm
            Mới</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal Update -->
  <div class="modal modal-lg fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">CẬP NHẬT NGHỈ PHÉP</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="id_nhan_vien" class="form-label">Mã nhân viên</label>
              <select v-model="update.id_nhan_vien" class="form-control mt-1">
                <template v-for="(v, k) in nhanVienList" :key="k">
                  <option v-bind:value="v.id">{{ v.ho_va_ten }}</option>
                </template>
              </select>
            </div>

            <div class="col-md-6">
              <label for="id_loai_vang" class="form-label">Loại nghỉ phép</label>
              <select v-model="update.id_loai_vang" class="form-select" id="id_loai_vang">
                <option disabled>Chọn loại nghỉ phép</option>
                <template v-for="(v, k) in loaiVangList" :key="k">
                  <option :value="v.id" selected>{{ v.ten_loai_vang }} </option>
                </template>
              </select>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label for="ngay_bat_dau" class="form-label">Ngày bắt đầu</label>
              <input v-model="update.ngay_bat_dau" type="date" class="form-control" id="ngay_bat_dau">
            </div>

            <div class="col-md-6">
              <label for="ngay_ket_thuc" class="form-label">Ngày kết thúc</label>
              <input v-model="update.ngay_ket_thuc" type="date" class="form-control" id="ngay_ket_thuc">
            </div>
          </div>

          <div class="mb-3">
            <label for="ly_do" class="form-label">Lý do</label>
            <textarea v-model="update.ly_do" class="form-control" id="ly_do" rows="3"></textarea>
          </div>
          <div class="mb-3">
            <label for="ghi_chu" class="form-label">Ghi chú</label>
            <textarea v-model="update.ghi_chu" class="form-control" id="ghi_chu" rows="3"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" @:click="updateYeuCauVang" data-bs-dismiss="modal">Cập
            Nhật</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Delete Modal -->
  <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">
            Xóa Yêu Cầu Nghỉ Phép
          </h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
            <div class="d-flex align-items-center">
              <div class="font-35 text-white">
                <i class="bx bxs-message-square-x"></i>
              </div>
              <div class="ms-1">
                <h6 class="mb-1 text-white">
                  Bạn chắc chắc xóa yêu cầu nghỉ phép của nhân viên
                  <b>{{ del.ho_va_ten }}</b>
                  chứ !!
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
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Đóng
          </button>
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal" v-on:click="xoaYeuCauVang(del.id)">
            Xác nhận
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
      list_yeu_cau_nghi_phep: [],
      create: {
        id_nhan_vien: '',
        id_loai_vang: '',
        ngay_bat_dau: '',
        ngay_ket_thuc: '',
        ly_do: '',
        ghi_chu: ''
      },
      update: {

      },
      del: {},
      loaiVangList: [],
      nhanVienList: [],
    };
  },
  mounted() {
    this.loadDataYeuCauNghiPhep();
    this.fetchLoaiVang();
    this.fetchNhanVien();
  },
  methods: {
    loadDataYeuCauNghiPhep() {
      axios
        .get("http://127.0.0.1:8000/api/admin/nghi-phep/data", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.list_yeu_cau_nghi_phep = res.data.data;
        });
    },
    fetchNhanVien() {
      axios.get('http://localhost:8000/api/admin/nhan-vien/data', {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
        }
      })
        .then((res) => {
          this.nhanVienList = res.data.data;
        })
    },
    fetchLoaiVang() {
      axios.get('http://localhost:8000/api/admin/get-loai-vang', {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
        }
      }).then((res) => {
        this.loaiVangList = res.data.loaiVang

      })
    },
    creareYeuCauVang() {
      axios.post('http://127.0.0.1:8000/api/admin/nghi-phep/create', this.create, {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
        }
      })
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.loadDataYeuCauNghiPhep();
          }
        })
    },
    updateYeuCauVang() {
      axios.post('http://127.0.0.1:8000/api/admin/nghi-phep/update', this.update, {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
        }
      })
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.loadDataYeuCauNghiPhep();
          }
        })
    },
    xoaYeuCauVang(id) {
      axios.delete('http://localhost:8000/api/admin/nghi-phep/delete/' + id, {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
        }
      })
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success(res.data.message);
            this.loadDataYeuCauNghiPhep();
          }
        })
    },
  }
}
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

label {
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

.modal-example {
  display: block;
  position: static;
  margin-top: 2rem;
  margin-bottom: 2rem;
  pointer-events: none;
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

.badge {
  padding: 0.5em 0.8em;
  border-radius: 6px;
  font-weight: 500;
}

.bg-warning {
  background-color: #fff3cd !important;
  color: #856404 !important;
}

.bg-success {
  background-color: #d4edda !important;
  color: #155724 !important;
}

.bg-danger {
  background-color: #f8d7da !important;
  color: #721c24 !important;
}

.bg-secondary {
  background-color: #e2e3e5 !important;
  color: #383d41 !important;
}

.btn-sm {
  padding: 0.4rem 0.6rem;
  font-size: 0.875rem;
}
</style>
