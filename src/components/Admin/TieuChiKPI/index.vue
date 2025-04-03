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
                  <i class="fas fa-chart-line me-2"></i>Quản Lý Tiêu Chí KPI
                </h2>
                <p class="text-white opacity-8 mb-0">
                  Thiết lập và theo dõi các chỉ số đánh giá hiệu suất nhân viên
                </p>
              </div>
              <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <button class="btn btn-light btn-lg shadow-sm" @click="showAddModal">
                  <i class="fas fa-plus-circle me-2"></i>Thêm Tiêu Chí
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
                placeholder="Tìm kiếm theo mã, tên hoặc mô tả..."
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
              <div class="icon-shape bg-gradient-success text-white rounded-circle shadow p-3">
                <i class="fas fa-chart-bar"></i>
              </div>
              <div class="ms-3">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Tổng Tiêu Chí</p>
                <h3 class="font-weight-bolder mb-0">{{ danhSachTieuChi.length }}</h3>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Table Section -->
    <div class="card border-0 shadow mb-4">
      <div class="card-header bg-white p-4 border-0">
        <h5 class="mb-0 font-weight-bold">Danh Sách Tiêu Chí KPI</h5>
      </div>
      <div class="card-body px-0 pt-0 pb-2">
        <div class="table-responsive p-0">
          <table class="table align-items-center mb-0">
            <thead>
              <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-4">Mã Tiêu Chí</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Tên Tiêu Chí</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Mô Tả</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Trọng Số</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Đơn Vị & Mục Tiêu</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Trạng Thái</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in filteredItems" :key="item.id" :class="index % 2 === 0 ? 'bg-light' : ''">
                <td class="ps-4">
                  <span class="badge badge-sm bg-gradient-info">{{ item.maTieuChi }}</span>
                </td>
                <td>
                  <h6 class="mb-0 text-sm">{{ item.tenTieuChi }}</h6>
                </td>
                <td>
                  <p class="text-xs text-secondary mb-0">{{ item.moTa }}</p>
                </td>
                <td style="min-width: 200px">
                  <div class="d-flex align-items-center">
                    <span class="me-2 text-sm">{{ item.trongSo }}%</span>
                    <div class="w-100">
                      <div class="progress" style="height: 6px">
                        <div 
                          class="progress-bar" 
                          :class="getProgressClass(item.trongSo)"
                          :style="{ width: item.trongSo + '%' }"
                          role="progressbar"
                          :aria-valuenow="item.trongSo"
                          aria-valuemin="0"
                          aria-valuemax="100"
                        ></div>
                      </div>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="d-flex flex-column">
                    <h6 class="mb-0 text-sm">{{ item.donViDo }}</h6>
                    <p class="text-xs text-secondary mb-0">Mục tiêu: {{ item.mucTieu }}</p>
                  </div>
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
                    <button class="btn btn-link text-warning px-2 mb-0" @click="suaTieuChi(item)" title="Sửa">
                      <i class="fas fa-pencil-alt"></i>
                    </button>
                    <button class="btn btn-link text-danger px-2 mb-0" @click="xoaTieuChi(item.id)" title="Xóa">
                      <i class="far fa-trash-alt"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredItems.length === 0">
                <td colspan="7" class="text-center py-4">
                  <div class="d-flex flex-column align-items-center">
                    <i class="fas fa-search fa-3x text-secondary mb-3"></i>
                    <h5 class="text-secondary">Không tìm thấy tiêu chí nào</h5>
                    <p class="text-xs text-secondary">Thử tìm kiếm với từ khóa khác hoặc thêm tiêu chí mới</p>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Modal Form -->
    <div class="modal fade" id="tieuChiModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
          <div class="modal-header bg-gradient-primary text-white">
            <h5 class="modal-title">
              <i class="fas fa-edit me-2"></i>
              {{ isEditing ? 'Cập Nhật Tiêu Chí' : 'Thêm Tiêu Chí Mới' }}
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form @submit.prevent="submitForm">
            <div class="modal-body p-4">
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Mã Tiêu Chí</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.maTieuChi" 
                        :readonly="isEditing"
                        required
                        placeholder="Nhập mã tiêu chí"
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Tên Tiêu Chí</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-tag"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.tenTieuChi" 
                        required
                        placeholder="Nhập tên tiêu chí"
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="form-group mb-3">
                <label class="form-control-label">Mô Tả</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                  <textarea 
                    class="form-control" 
                    v-model="formData.moTa" 
                    rows="3"
                    placeholder="Nhập mô tả chi tiết về tiêu chí"
                  ></textarea>
                </div>
              </div>

              <div class="row">
                <div class="col-md-4">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Trọng Số (%)</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-percentage"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.trongSo" 
                        min="0" 
                        max="100" 
                        required
                        placeholder="0-100"
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Đơn Vị Đo</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-ruler"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.donViDo" 
                        required
                        placeholder="VD: %, VNĐ, giờ"
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Mục Tiêu</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-bullseye"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.mucTieu" 
                        required
                        placeholder="Giá trị mục tiêu"
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label class="form-control-label">Trạng Thái</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-toggle-on"></i></span>
                  <select class="form-select" v-model="formData.trangThai" required>
                    <option value="Hoạt động">Hoạt động</option>
                    <option value="Tạm ngưng">Tạm ngưng</option>
                    <option value="Đã xóa">Đã xóa</option>
                  </select>
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
// import { Modal } from 'bootstrap'
// import axios from '@/plugins/axios'

export default {
  name: 'TieuChiKPI',
  data() {
    return {
      searchQuery: '',
      danhSachTieuChi: [
        {
          id: 1,
          maTieuChi: 'KPI001',
          tenTieuChi: 'Doanh số bán hàng',
          moTa: 'Chỉ tiêu doanh số bán hàng tháng',
          trongSo: 30,
          donViDo: 'Triệu VNĐ',
          mucTieu: '100',
          trangThai: 'Hoạt động'
        },
        {
          id: 2,
          maTieuChi: 'KPI002',
          tenTieuChi: 'Tỷ lệ chuyển đổi khách hàng',
          moTa: 'Tỷ lệ khách hàng tiềm năng chuyển thành khách hàng thực tế',
          trongSo: 20,
          donViDo: '%',
          mucTieu: '15',
          trangThai: 'Hoạt động'
        },
        {
          id: 3,
          maTieuChi: 'KPI003',
          tenTieuChi: 'Số lượng khách hàng mới',
          moTa: 'Số lượng khách hàng mới được thu hút trong tháng',
          trongSo: 25,
          donViDo: 'Khách hàng',
          mucTieu: '50',
          trangThai: 'Tạm ngưng'
        }
      ],
      formData: {
        maTieuChi: '',
        tenTieuChi: '',
        moTa: '',
        trongSo: 0,
        donViDo: '',
        mucTieu: '',
        trangThai: 'Hoạt động'
      },
      isEditing: false,
      modalInstance: null
    }
  },
  computed: {
    filteredItems() {
      const query = this.searchQuery.toLowerCase()
      return this.danhSachTieuChi.filter(item => {
        return item.maTieuChi.toLowerCase().includes(query) ||
               item.tenTieuChi.toLowerCase().includes(query) ||
               item.moTa.toLowerCase().includes(query)
      })
    }
  },
  methods: {
    async loadDanhSachTieuChi() {
      try {
        // Uncomment khi có API thực tế
        // const response = await axios.get('/tieu-chi-kpi')
        // this.danhSachTieuChi = response.data
      } catch (error) {
        console.error('Lỗi khi tải danh sách:', error)
      }
    },
    getProgressClass(value) {
      if (value < 30) return 'bg-gradient-danger'
      if (value < 70) return 'bg-gradient-warning'
      return 'bg-gradient-success'
    },
    getStatusClass(status) {
      switch (status) {
        case 'Hoạt động': return 'bg-gradient-success'
        case 'Tạm ngưng': return 'bg-gradient-warning'
        case 'Đã xóa': return 'bg-gradient-danger'
        default: return 'bg-gradient-secondary'
      }
    },
    showAddModal() {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('tieuChiModal'))
      }
      this.isEditing = false
      this.resetForm()
      this.modalInstance.show()
    },
    resetForm() {
      this.formData = {
        maTieuChi: '',
        tenTieuChi: '',
        moTa: '',
        trongSo: 0,
        donViDo: '',
        mucTieu: '',
        trangThai: 'Hoạt động'
      }
    },
    async submitForm() {
      try {
        if (this.isEditing) {
          // Uncomment khi có API thực tế
          // await axios.put(`/tieu-chi-kpi/${this.formData.id}`, this.formData)
          
          // Mô phỏng cập nhật
          const index = this.danhSachTieuChi.findIndex(item => item.id === this.formData.id)
          if (index !== -1) {
            this.danhSachTieuChi[index] = { ...this.formData }
          }
        } else {
          // Uncomment khi có API thực tế
          // const response = await axios.post('/tieu-chi-kpi', this.formData)
          
          // Mô phỏng thêm mới
          const newId = Math.max(...this.danhSachTieuChi.map(item => item.id), 0) + 1
          this.danhSachTieuChi.push({
            ...this.formData,
            id: newId
          })
        }
        this.modalInstance.hide()
        // Thêm thông báo thành công
      } catch (error) {
        console.error('Lỗi khi lưu:', error)
      }
    },
    async suaTieuChi(item) {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('tieuChiModal'))
      }
      this.isEditing = true
      this.formData = { ...item }
      this.modalInstance.show()
    },
    async xoaTieuChi(id) {
      if (confirm('Bạn có chắc chắn muốn xóa tiêu chí này?')) {
        try {
          // Uncomment khi có API thực tế
          // await axios.delete(`/tieu-chi-kpi/${id}`)
          
          // Mô phỏng xóa
          this.danhSachTieuChi = this.danhSachTieuChi.filter(item => item.id !== id)
          // Thêm thông báo thành công
        } catch (error) {
          console.error('Lỗi khi xóa:', error)
        }
      }
    }
  },
  mounted() {
    this.loadDanhSachTieuChi()
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