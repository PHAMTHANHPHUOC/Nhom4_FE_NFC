<template>
  <div class="container-fluid py-4">
    <!-- Header Section -->
    <div class="row mb-4">
      <div class="col-12">
        <div class="card bg-gradient-primary border-0 shadow">
          <div class="card-body p-4">
            <div class="row align-items-center">
              <div class="col-lg-8">
                <h2 class="text-white mb-1 font-weight-bold">
                  <i class="fas fa-calendar-times me-2"></i>Báo Cáo Vắng
                </h2>
                <p class="text-white opacity-8 mb-0">
                  Quản lý và theo dõi thông tin vắng mặt của nhân viên
                </p>
              </div>
              <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <button class="btn btn-light btn-lg shadow-sm" @click="showAddModal">
                  <i class="fas fa-plus-circle me-2"></i>Thêm Báo Cáo
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Search & Stats Section -->
    <div class="row mb-4">
      <div class="col-lg-8 mb-4 mb-lg-0">
        <div class="card border-0 shadow-sm h-100">
          <div class="card-body">
            <div class="input-group input-group-lg">
              <span class="input-group-text bg-white border-end-0">
                <i class="fas fa-search text-primary"></i>
              </span>
              <input 
                type="text" 
                class="form-control border-start-0 ps-0" 
                placeholder="Tìm kiếm theo tên nhân viên hoặc lý do..."
                v-model="searchQuery"
              >
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-4">
        <div class="card border-0 shadow-sm h-100">
          <div class="card-body">
            <div class="d-flex align-items-center">
              <div class="icon-shape bg-gradient-danger text-white rounded-circle shadow p-3">
                <i class="fas fa-user-clock"></i>
              </div>
              <div class="ms-3">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Tổng Báo Cáo</p>
                <h3 class="font-weight-bolder mb-0">{{ danhSachBaoCao.length }}</h3>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Filter Section -->
    <div class="card border-0 shadow-sm mb-4">
      <div class="card-body p-3">
        <div class="row align-items-center">
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Từ ngày</label>
            <input type="date" class="form-control" v-model="filterStartDate">
          </div>
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Đến ngày</label>
            <input type="date" class="form-control" v-model="filterEndDate">
          </div>
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Trạng thái</label>
            <select class="form-select" v-model="filterStatus">
              <option value="">Tất cả</option>
              <option value="Chờ duyệt">Chờ duyệt</option>
              <option value="Đã duyệt">Đã duyệt</option>
              <option value="Từ chối">Từ chối</option>
            </select>
          </div>
          <div class="col-md-3 d-flex align-items-end">
            <button class="btn btn-primary w-100" @click="applyFilters">
              <i class="fas fa-filter me-2"></i>Lọc
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Table Section -->
    <div class="card border-0 shadow mb-4">
      <div class="card-header bg-white p-4 border-0">
        <h5 class="mb-0 font-weight-bold">Danh Sách Báo Cáo Vắng</h5>
      </div>
      <div class="card-body px-0 pt-0 pb-2">
        <div class="table-responsive p-0">
          <table class="table align-items-center mb-0">
            <thead>
              <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-4">STT</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nhân Viên</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thời Gian</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Lý Do</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Trạng Thái</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in filteredItems" :key="item.id" :class="index % 2 === 0 ? 'bg-light' : ''">
                <td class="ps-4">
                  <span class="text-secondary text-sm">{{ index + 1 }}</span>
                </td>
                <td>
                  <div class="d-flex px-2 py-1">
                    <div>
                      <img :src="item.avatar || 'https://via.placeholder.com/40'" class="avatar avatar-sm me-3" alt="user image">
                    </div>
                    <div class="d-flex flex-column justify-content-center">
                      <h6 class="mb-0 text-sm">{{ item.tenNhanVien }}</h6>
                      <p class="text-xs text-secondary mb-0">{{ item.maNhanVien }}</p>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="d-flex flex-column">
                    <h6 class="mb-0 text-sm">{{ formatDate(item.ngayBatDau) }} - {{ formatDate(item.ngayKetThuc) }}</h6>
                    <p class="text-xs text-secondary mb-0">{{ item.soNgayNghi }} ngày</p>
                  </div>
                </td>
                <td>
                  <p class="text-sm mb-0">{{ item.lyDo }}</p>
                </td>
                <td>
                  <span 
                    class="badge badge-sm" 
                    :class="getStatusClass(item.trangThai)"
                  >
                    {{ item.trangThai }}
                  </span>
                </td>
                <td>
                  <div class="d-flex">
                    <button class="btn btn-link text-info px-2 mb-0" @click="xemChiTiet(item)" title="Xem chi tiết">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button v-if="item.trangThai === 'Chờ duyệt'" class="btn btn-link text-success px-2 mb-0" @click="duyetBaoCao(item.id)" title="Duyệt">
                      <i class="fas fa-check"></i>
                    </button>
                    <button v-if="item.trangThai === 'Chờ duyệt'" class="btn btn-link text-danger px-2 mb-0" @click="tuChoiBaoCao(item.id)" title="Từ chối">
                      <i class="fas fa-times"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredItems.length === 0">
                <td colspan="6" class="text-center py-4">
                  <div class="d-flex flex-column align-items-center">
                    <i class="fas fa-folder-open fa-3x text-secondary mb-3"></i>
                    <h5 class="text-secondary">Không tìm thấy báo cáo nào</h5>
                    <p class="text-xs text-secondary">Thử thay đổi bộ lọc hoặc thêm báo cáo mới</p>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Modal Form -->
    <div class="modal fade" id="baoCaoModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
          <div class="modal-header bg-gradient-primary text-white">
            <h5 class="modal-title">
              <i class="fas fa-edit me-2"></i>
              {{ isEditing ? 'Chi Tiết Báo Cáo Vắng' : 'Thêm Báo Cáo Vắng' }}
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form @submit.prevent="submitForm">
            <div class="modal-body p-4">
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Nhân Viên</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-user"></i></span>
                      <select 
                        class="form-select" 
                        v-model="formData.maNhanVien" 
                        :disabled="isEditing"
                        required
                      >
                        <option value="" disabled>Chọn nhân viên</option>
                        <option v-for="nv in danhSachNhanVien" :key="nv.maNhanVien" :value="nv.maNhanVien">
                          {{ nv.tenNhanVien }}
                        </option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Loại Nghỉ</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-tag"></i></span>
                      <select class="form-select" v-model="formData.loaiNghi" required>
                        <option value="" disabled>Chọn loại nghỉ</option>
                        <option value="Nghỉ phép">Nghỉ phép</option>
                        <option value="Nghỉ ốm">Nghỉ ốm</option>
                        <option value="Nghỉ không lương">Nghỉ không lương</option>
                        <option value="Nghỉ đặc biệt">Nghỉ đặc biệt</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Ngày Bắt Đầu</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                      <input 
                        type="date" 
                        class="form-control" 
                        v-model="formData.ngayBatDau" 
                        required
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Ngày Kết Thúc</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                      <input 
                        type="date" 
                        class="form-control" 
                        v-model="formData.ngayKetThuc" 
                        required
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="form-group mb-3">
                <label class="form-control-label">Lý Do</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                  <textarea 
                    class="form-control" 
                    v-model="formData.lyDo" 
                    rows="3"
                    placeholder="Nhập lý do chi tiết"
                    required
                  ></textarea>
                </div>
              </div>

              <div class="form-group mb-3">
                <label class="form-control-label">Tệp Đính Kèm</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-paperclip"></i></span>
                  <input 
                    type="file" 
                    class="form-control" 
                    @change="handleFileUpload"
                  >
                </div>
                <small class="text-muted">Đính kèm giấy tờ liên quan (nếu có)</small>
              </div>

              <div v-if="isEditing" class="form-group">
                <label class="form-control-label">Trạng Thái</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-toggle-on"></i></span>
                  <select class="form-select" v-model="formData.trangThai" required>
                    <option value="Chờ duyệt">Chờ duyệt</option>
                    <option value="Đã duyệt">Đã duyệt</option>
                    <option value="Từ chối">Từ chối</option>
                  </select>
                </div>
              </div>

              <div v-if="isEditing && formData.ghiChu" class="form-group mt-3">
                <label class="form-control-label">Ghi Chú</label>
                <div class="alert alert-info p-3">
                  {{ formData.ghiChu }}
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Đóng
              </button>
              <button v-if="!isEditing" type="submit" class="btn btn-primary">
                <i class="fas fa-save me-2"></i>Gửi Báo Cáo
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
//import { Modal } from 'bootstrap'

export default {
  name: 'BaoCaoVang',
  data() {
    return {
      searchQuery: '',
      filterStartDate: '',
      filterEndDate: '',
      filterStatus: '',
      danhSachBaoCao: [
        {
          id: 1,
          maNhanVien: 'NV001',
          tenNhanVien: 'Nguyễn Văn A',
          avatar: 'https://via.placeholder.com/40',
          ngayBatDau: '2023-06-10',
          ngayKetThuc: '2023-06-12',
          soNgayNghi: 3,
          lyDo: 'Bị ốm, cần nghỉ ngơi',
          loaiNghi: 'Nghỉ ốm',
          trangThai: 'Đã duyệt',
          ghiChu: 'Đã xác nhận với bộ phận y tế'
        },
        {
          id: 2,
          maNhanVien: 'NV002',
          tenNhanVien: 'Trần Thị B',
          avatar: 'https://via.placeholder.com/40',
          ngayBatDau: '2023-06-15',
          ngayKetThuc: '2023-06-15',
          soNgayNghi: 1,
          lyDo: 'Có việc gia đình đột xuất',
          loaiNghi: 'Nghỉ phép',
          trangThai: 'Chờ duyệt',
          ghiChu: ''
        },
        {
          id: 3,
          maNhanVien: 'NV003',
          tenNhanVien: 'Lê Văn C',
          avatar: 'https://via.placeholder.com/40',
          ngayBatDau: '2023-06-20',
          ngayKetThuc: '2023-06-25',
          soNgayNghi: 6,
          lyDo: 'Đi du lịch cùng gia đình',
          loaiNghi: 'Nghỉ phép',
          trangThai: 'Từ chối',
          ghiChu: 'Thời gian nghỉ quá dài, cần sắp xếp lại'
        }
      ],
      danhSachNhanVien: [
        { maNhanVien: 'NV001', tenNhanVien: 'Nguyễn Văn A' },
        { maNhanVien: 'NV002', tenNhanVien: 'Trần Thị B' },
        { maNhanVien: 'NV003', tenNhanVien: 'Lê Văn C' },
        { maNhanVien: 'NV004', tenNhanVien: 'Phạm Thị D' },
        { maNhanVien: 'NV005', tenNhanVien: 'Hoàng Văn E' }
      ],
      formData: {
        maNhanVien: '',
        ngayBatDau: '',
        ngayKetThuc: '',
        lyDo: '',
        loaiNghi: '',
        trangThai: 'Chờ duyệt',
        ghiChu: ''
      },
      isEditing: false,
      modalInstance: null,
      selectedFile: null
    }
  },
  computed: {
    filteredItems() {
      let result = [...this.danhSachBaoCao]
      
      // Tìm kiếm
      if (this.searchQuery) {
        const query = this.searchQuery.toLowerCase()
        result = result.filter(item => {
          return item.tenNhanVien.toLowerCase().includes(query) ||
                 item.lyDo.toLowerCase().includes(query)
        })
      }
      
      // Lọc theo trạng thái
      if (this.filterStatus) {
        result = result.filter(item => item.trangThai === this.filterStatus)
      }
      
      // Lọc theo ngày bắt đầu
      if (this.filterStartDate) {
        result = result.filter(item => new Date(item.ngayBatDau) >= new Date(this.filterStartDate))
      }
      
      // Lọc theo ngày kết thúc
      if (this.filterEndDate) {
        result = result.filter(item => new Date(item.ngayKetThuc) <= new Date(this.filterEndDate))
      }
      
      return result
    }
  },
  methods: {
    formatDate(dateString) {
      const options = { day: '2-digit', month: '2-digit', year: 'numeric' }
      return new Date(dateString).toLocaleDateString('vi-VN', options)
    },
    getStatusClass(status) {
      switch (status) {
        case 'Đã duyệt': return 'bg-gradient-success'
        case 'Chờ duyệt': return 'bg-gradient-warning'
        case 'Từ chối': return 'bg-gradient-danger'
        default: return 'bg-gradient-secondary'
      }
    },
    showAddModal() {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('baoCaoModal'))
      }
      this.isEditing = false
      this.resetForm()
      this.modalInstance.show()
    },
    resetForm() {
      this.formData = {
        maNhanVien: '',
        ngayBatDau: '',
        ngayKetThuc: '',
        lyDo: '',
        loaiNghi: '',
        trangThai: 'Chờ duyệt',
        ghiChu: ''
      }
      this.selectedFile = null
    },
    handleFileUpload(event) {
      this.selectedFile = event.target.files[0]
    },
    submitForm() {
      try {
        // Tính số ngày nghỉ
        const startDate = new Date(this.formData.ngayBatDau)
        const endDate = new Date(this.formData.ngayKetThuc)
        const diffTime = Math.abs(endDate - startDate)
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1
        
        // Lấy thông tin nhân viên
        const nhanVien = this.danhSachNhanVien.find(nv => nv.maNhanVien === this.formData.maNhanVien)
        
        // Tạo báo cáo mới
        const newId = Math.max(...this.danhSachBaoCao.map(item => item.id), 0) + 1
        this.danhSachBaoCao.push({
          id: newId,
          maNhanVien: this.formData.maNhanVien,
          tenNhanVien: nhanVien.tenNhanVien,
          avatar: 'https://via.placeholder.com/40',
          ngayBatDau: this.formData.ngayBatDau,
          ngayKetThuc: this.formData.ngayKetThuc,
          soNgayNghi: diffDays,
          lyDo: this.formData.lyDo,
          loaiNghi: this.formData.loaiNghi,
          trangThai: 'Chờ duyệt',
          ghiChu: ''
        })
        
        this.modalInstance.hide()
        // Thêm thông báo thành công
      } catch (error) {
        console.error('Lỗi khi lưu:', error)
      }
    },
    xemChiTiet(item) {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('baoCaoModal'))
      }
      this.isEditing = true
      this.formData = { ...item }
      this.modalInstance.show()
    },
    duyetBaoCao(id) {
      if (confirm('Bạn có chắc chắn muốn duyệt báo cáo này?')) {
        const index = this.danhSachBaoCao.findIndex(item => item.id === id)
        if (index !== -1) {
          this.danhSachBaoCao[index].trangThai = 'Đã duyệt'
          this.danhSachBaoCao[index].ghiChu = 'Đã duyệt ngày ' + new Date().toLocaleDateString('vi-VN')
        }
      }
    },
    tuChoiBaoCao(id) {
      const lyDo = prompt('Nhập lý do từ chối:')
      if (lyDo) {
        const index = this.danhSachBaoCao.findIndex(item => item.id === id)
        if (index !== -1) {
          this.danhSachBaoCao[index].trangThai = 'Từ chối'
          this.danhSachBaoCao[index].ghiChu = 'Từ chối: ' + lyDo
        }
      }
    },
    applyFilters() {
      // Đã xử lý trong computed property
    }
  },
  mounted() {
    // Khởi tạo dữ liệu nếu cần
  }
}
</script>

<style scoped>
.bg-gradient-primary {
  background: linear-gradient(145deg, #5e72e4 0%, #825ee4 100%);
}

.bg-gradient-success {
  background: linear-gradient(145deg, #2dce89 0%, #2dcecc 100%);
}

.bg-gradient-warning {
  background: linear-gradient(145deg, #fb6340 0%, #fbb140 100%);
}

.bg-gradient-danger {
  background: linear-gradient(145deg, #f5365c 0%, #f56036 100%);
}

.bg-gradient-info {
  background: linear-gradient(145deg, #11cdef 0%, #1171ef 100%);
}

.icon-shape {
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.progress {
  overflow: visible;
  height: 6px;
  border-radius: 6px;
}

.form-control:focus, .form-select:focus {
  border-color: #5e72e4;
  box-shadow: 0 0 0 0.2rem rgba(94, 114, 228, 0.25);
}

.card {
  border-radius: 15px;
  overflow: hidden;
}

.modal-content {
  border-radius: 15px;
  overflow: hidden;
}

.badge {
  padding: 0.5em 0.75em;
  border-radius: 6px;
}

.table > :not(caption) > * > * {
  padding: 1rem 1rem;
  vertical-align: middle;
}

.form-control-label {
  margin-bottom: 0.5rem;
  font-weight: 600;
  font-size: 0.875rem;
}

.input-group-text {
  background-color: #f8f9fa;
}

.btn-outline-secondary:hover {
  background-color: #6c757d;
  color: white;
}

.btn-primary {
  background: linear-gradient(145deg, #5e72e4 0%, #825ee4 100%);
  border: none;
}

.btn-primary:hover {
  background: linear-gradient(145deg, #4e62d4 0%, #724ed4 100%);
}

.opacity-8 {
  opacity: 0.8;
}
</style>