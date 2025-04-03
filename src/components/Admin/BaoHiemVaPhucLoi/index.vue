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
                  <i class="fas fa-shield-alt me-2"></i>Bảo Hiểm và Phúc Lợi
                </h2>
                <p class="text-white opacity-8 mb-0">
                  Quản lý thông tin bảo hiểm và phúc lợi của nhân viên
                </p>
              </div>
              <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <button class="btn btn-light btn-lg shadow-sm" @click="showAddModal">
                  <i class="fas fa-plus-circle me-2"></i>Thêm Bảo Hiểm
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
                placeholder="Tìm kiếm theo mã nhân viên hoặc số bảo hiểm..."
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
              <div class="icon-shape bg-gradient-info text-white rounded-circle shadow p-3">
                <i class="fas fa-id-card"></i>
              </div>
              <div class="ms-3">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Tổng Bảo Hiểm</p>
                <h3 class="font-weight-bolder mb-0">{{ filteredItems.length }}</h3>
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
          <div class="col-md-4 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Loại bảo hiểm</label>
            <select class="form-select" v-model="filterType">
              <option value="">Tất cả</option>
              <option value="BHXH">Bảo hiểm xã hội</option>
              <option value="BHYT">Bảo hiểm y tế</option>
              <option value="BHTN">Bảo hiểm thất nghiệp</option>
            </select>
          </div>
          <div class="col-md-4 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Trạng thái</label>
            <select class="form-select" v-model="filterStatus">
              <option value="">Tất cả</option>
              <option value="active">Còn hiệu lực</option>
              <option value="expired">Hết hạn</option>
            </select>
          </div>
          <div class="col-md-4 d-flex align-items-end">
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
        <h5 class="mb-0 font-weight-bold">Danh Sách Bảo Hiểm và Phúc Lợi</h5>
      </div>
      <div class="card-body px-0 pt-0 pb-2">
        <div class="table-responsive p-0">
          <table class="table align-items-center mb-0">
            <thead>
              <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-4">Mã NV</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nhân Viên</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Loại BH</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Số BH</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thời Hạn</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Trạng Thái</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in filteredItems" :key="item.id" :class="index % 2 === 0 ? 'bg-light' : ''">
                <td class="ps-4">
                  <span class="badge badge-sm bg-gradient-info">{{ item.maNhanVien }}</span>
                </td>
                <td>
                  <div class="d-flex px-2 py-1">
                    <div>
                      <img :src="item.avatar || 'https://via.placeholder.com/40'" class="avatar avatar-sm me-3" alt="user image">
                    </div>
                    <div class="d-flex flex-column justify-content-center">
                      <h6 class="mb-0 text-sm">{{ item.tenNhanVien }}</h6>
                      <p class="text-xs text-secondary mb-0">{{ item.phongBan }}</p>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="badge badge-sm" :class="getTypeClass(item.loaiBaoHiem)">
                    {{ getLoaiBaoHiemText(item.loaiBaoHiem) }}
                  </span>
                </td>
                <td>
                  <p class="text-sm mb-0 font-weight-bold">{{ item.soBaoHiem }}</p>
                </td>
                <td>
                  <div class="d-flex flex-column">
                    <h6 class="mb-0 text-sm">{{ formatDate(item.ngayHieuLuc) }} - {{ formatDate(item.ngayHetHan) }}</h6>
                    <p class="text-xs text-secondary mb-0">{{ calculateDaysLeft(item.ngayHetHan) }}</p>
                  </div>
                </td>
                <td>
                  <span 
                    class="badge badge-sm" 
                    :class="getStatusClass(item.ngayHetHan)"
                  >
                    {{ getStatusText(item.ngayHetHan) }}
                  </span>
                </td>
                <td>
                  <div class="d-flex">
                    <button class="btn btn-link text-warning px-2 mb-0" @click="suaBaoHiem(item)" title="Sửa">
                      <i class="fas fa-pencil-alt"></i>
                    </button>
                    <button class="btn btn-link text-danger px-2 mb-0" @click="xoaBaoHiem(item.id)" title="Xóa">
                      <i class="far fa-trash-alt"></i>
                    </button>
                    <button class="btn btn-link text-info px-2 mb-0" @click="xemChiTiet(item)" title="Xem chi tiết">
                      <i class="fas fa-eye"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredItems.length === 0">
                <td colspan="7" class="text-center py-4">
                  <div class="d-flex flex-column align-items-center">
                    <i class="fas fa-folder-open fa-3x text-secondary mb-3"></i>
                    <h5 class="text-secondary">Không tìm thấy dữ liệu bảo hiểm nào</h5>
                    <p class="text-xs text-secondary">Thử thay đổi bộ lọc hoặc thêm bảo hiểm mới</p>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Modal Form -->
    <div class="modal fade" id="baoHiemModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
          <div class="modal-header bg-gradient-primary text-white">
            <h5 class="modal-title">
              <i class="fas fa-edit me-2"></i>
              {{ isEditing ? 'Cập Nhật Bảo Hiểm' : 'Thêm Bảo Hiểm Mới' }}
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
                    <label class="form-control-label">Loại Bảo Hiểm</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-tag"></i></span>
                      <select class="form-select" v-model="formData.loaiBaoHiem" required>
                        <option value="" disabled>Chọn loại bảo hiểm</option>
                        <option value="BHXH">Bảo hiểm xã hội</option>
                        <option value="BHYT">Bảo hiểm y tế</option>
                        <option value="BHTN">Bảo hiểm thất nghiệp</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Số Bảo Hiểm</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.soBaoHiem" 
                        required
                        placeholder="Nhập số bảo hiểm"
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Nơi Cấp</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-building"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.noiCap" 
                        placeholder="Nhập nơi cấp"
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Ngày Hiệu Lực</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                      <input 
                        type="date" 
                        class="form-control" 
                        v-model="formData.ngayHieuLuc" 
                        required
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Ngày Hết Hạn</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                      <input 
                        type="date" 
                        class="form-control" 
                        v-model="formData.ngayHetHan" 
                        required
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Mức Đóng (VNĐ)</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-money-bill"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.mucDong" 
                        placeholder="Nhập mức đóng"
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Tỷ Lệ Đóng (%)</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-percentage"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.tyLeDong" 
                        placeholder="Nhập tỷ lệ đóng"
                        min="0"
                        max="100"
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="form-group mb-3">
                <label class="form-control-label">Ghi Chú</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                  <textarea 
                    class="form-control" 
                    v-model="formData.ghiChu" 
                    rows="3"
                    placeholder="Nhập ghi chú (nếu có)"
                  ></textarea>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Hủy
              </button>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-2"></i>{{ isEditing ? 'Cập Nhật' : 'Thêm Mới' }}
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
  name: 'BaoHiemVaPhucLoi',
  data() {
    return {
      searchQuery: '',
      filterType: '',
      filterStatus: '',
      danhSachBaoHiem: [
        {
          id: 1,
          maNhanVien: 'NV001',
          tenNhanVien: 'Nguyễn Văn A',
          phongBan: 'Phòng Kỹ Thuật',
          avatar: 'https://via.placeholder.com/40',
          loaiBaoHiem: 'BHXH',
          soBaoHiem: '0123456789',
          noiCap: 'Bảo hiểm xã hội TP.HCM',
          ngayHieuLuc: '2023-01-01',
          ngayHetHan: '2024-01-01',
          mucDong: 500000,
          tyLeDong: 8,
          ghiChu: 'Bảo hiểm xã hội bắt buộc'
        },
        {
          id: 2,
          maNhanVien: 'NV001',
          tenNhanVien: 'Nguyễn Văn A',
          phongBan: 'Phòng Kỹ Thuật',
          avatar: 'https://via.placeholder.com/40',
          loaiBaoHiem: 'BHYT',
          soBaoHiem: 'YT0123456789',
          noiCap: 'Bảo hiểm y tế TP.HCM',
          ngayHieuLuc: '2023-01-01',
          ngayHetHan: '2023-12-31',
          mucDong: 300000,
          tyLeDong: 4.5,
          ghiChu: 'Bảo hiểm y tế bắt buộc'
        },
        {
          id: 3,
          maNhanVien: 'NV002',
          tenNhanVien: 'Trần Thị B',
          phongBan: 'Phòng Nhân Sự',
          avatar: 'https://via.placeholder.com/40',
          loaiBaoHiem: 'BHXH',
          soBaoHiem: '0123456790',
          noiCap: 'Bảo hiểm xã hội TP.HCM',
          ngayHieuLuc: '2023-02-01',
          ngayHetHan: '2023-08-15',
          mucDong: 450000,
          tyLeDong: 8,
          ghiChu: 'Bảo hiểm xã hội bắt buộc'
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
        loaiBaoHiem: '',
        soBaoHiem: '',
        noiCap: '',
        ngayHieuLuc: '',
        ngayHetHan: '',
        mucDong: '',
        tyLeDong: '',
        ghiChu: ''
      },
      isEditing: false,
      modalInstance: null
    }
  },
  computed: {
    filteredItems() {
      let result = [...this.danhSachBaoHiem]
      
      // Tìm kiếm
      if (this.searchQuery) {
        const query = this.searchQuery.toLowerCase()
        result = result.filter(item => {
          return item.maNhanVien.toLowerCase().includes(query) ||
                 item.tenNhanVien.toLowerCase().includes(query) ||
                 item.soBaoHiem.toLowerCase().includes(query)
        })
      }
      
      // Lọc theo loại bảo hiểm
      if (this.filterType) {
        result = result.filter(item => item.loaiBaoHiem === this.filterType)
      }
      
      // Lọc theo trạng thái
      if (this.filterStatus) {
        const today = new Date()
        
        switch (this.filterStatus) {
          case 'active':
            result = result.filter(item => new Date(item.ngayHetHan) > today)
            break
          case 'expired':
            result = result.filter(item => new Date(item.ngayHetHan) < today)
            break
        }
      }
      
      return result
    }
  },
  methods: {
    formatDate(dateString) {
      if (!dateString) return ''
      const options = { day: '2-digit', month: '2-digit', year: 'numeric' }
      return new Date(dateString).toLocaleDateString('vi-VN', options)
    },
    getLoaiBaoHiemText(loai) {
      switch (loai) {
        case 'BHXH': return 'Bảo hiểm xã hội'
        case 'BHYT': return 'Bảo hiểm y tế'
        case 'BHTN': return 'Bảo hiểm thất nghiệp'
        default: return loai
      }
    },
    getTypeClass(type) {
      switch (type) {
        case 'BHXH': return 'bg-gradient-primary'
        case 'BHYT': return 'bg-gradient-success'
        case 'BHTN': return 'bg-gradient-warning'
        default: return 'bg-gradient-secondary'
      }
    },
    getStatusClass(expiryDate) {
      const today = new Date()
      const expiry = new Date(expiryDate)
      
      if (expiry < today) {
        return 'bg-gradient-danger'
      } else {
        return 'bg-gradient-success'
      }
    },
    getStatusText(expiryDate) {
      const today = new Date()
      const expiry = new Date(expiryDate)
      
      if (expiry < today) {
        return 'Hết hạn'
      } else {
        return 'Còn hiệu lực'
      }
    },
    calculateDaysLeft(expiryDate) {
      const today = new Date()
      const expiry = new Date(expiryDate)
      const diffTime = expiry - today
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
      
      if (diffDays < 0) {
        return `Đã hết hạn ${Math.abs(diffDays)} ngày`
      } else if (diffDays === 0) {
        return 'Hết hạn hôm nay'
      } else {
        return `Còn ${diffDays} ngày`
      }
    },
    showAddModal() {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('baoHiemModal'))
      }
      this.isEditing = false
      this.resetForm()
      this.modalInstance.show()
    },
    resetForm() {
      this.formData = {
        maNhanVien: '',
        loaiBaoHiem: '',
        soBaoHiem: '',
        noiCap: '',
        ngayHieuLuc: '',
        ngayHetHan: '',
        mucDong: '',
        tyLeDong: '',
        ghiChu: ''
      }
    },
    submitForm() {
      try {
        if (this.isEditing) {
          // Cập nhật bảo hiểm
          const index = this.danhSachBaoHiem.findIndex(item => item.id === this.formData.id)
          if (index !== -1) {
            // Lấy thông tin nhân viên
            const nhanVien = this.danhSachNhanVien.find(nv => nv.maNhanVien === this.formData.maNhanVien)
            
            // Cập nhật thông tin
            this.danhSachBaoHiem[index] = {
              ...this.formData,
              tenNhanVien: nhanVien.tenNhanVien
            }
          }
        } else {
          // Thêm mới bảo hiểm
          const newId = Math.max(...this.danhSachBaoHiem.map(item => item.id), 0) + 1
          
          // Lấy thông tin nhân viên
          const nhanVien = this.danhSachNhanVien.find(nv => nv.maNhanVien === this.formData.maNhanVien)
          
          // Thêm bảo hiểm mới
          this.danhSachBaoHiem.push({
            id: newId,
            maNhanVien: this.formData.maNhanVien,
            tenNhanVien: nhanVien.tenNhanVien,
            phongBan: 'Chưa cập nhật',
            avatar: 'https://via.placeholder.com/40',
            loaiBaoHiem: this.formData.loaiBaoHiem,
            soBaoHiem: this.formData.soBaoHiem,
            noiCap: this.formData.noiCap,
            ngayHieuLuc: this.formData.ngayHieuLuc,
            ngayHetHan: this.formData.ngayHetHan,
            mucDong: this.formData.mucDong,
            tyLeDong: this.formData.tyLeDong,
            ghiChu: this.formData.ghiChu
          })
        }
        
        this.modalInstance.hide()
        // Thêm thông báo thành công
      } catch (error) {
        console.error('Lỗi khi lưu:', error)
      }
    },
    suaBaoHiem(item) {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('baoHiemModal'))
      }
      this.isEditing = true
      this.formData = { ...item }
      this.modalInstance.show()
    },
    xoaBaoHiem(id) {
      if (confirm('Bạn có chắc chắn muốn xóa bảo hiểm này?')) {
        const index = this.danhSachBaoHiem.findIndex(item => item.id === id)
        if (index !== -1) {
          this.danhSachBaoHiem.splice(index, 1)
        }
      }
    },
    xemChiTiet(item) {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('baoHiemModal'))
      }
      this.isEditing = true
      this.formData = { ...item }
      this.modalInstance.show()
    },
    applyFilters() {
      // Đã xử lý trong computed property
    }
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

.card {
  border-radius: 15px;
  overflow: hidden;
}

.badge {
  padding: 0.5em 0.75em;
  border-radius: 6px;
}
</style>