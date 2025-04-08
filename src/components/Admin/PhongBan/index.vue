<template>
  <div class="quan-ly-phong-ban">
    <div class="card shadow">
      <div class="card-header bg-gradient-primary text-white">
        <h4 class="card-title mb-0"><i class="fas fa-building me-2"></i>Quản lý phòng ban</h4>
        <div class="card-tools">
          <button class="btn btn-light btn-hover-shine" data-bs-toggle="modal" data-bs-target="#createModal">
            <i class="fas fa-plus-circle me-1"></i> Thêm phòng ban
          </button>
        </div>
      </div>

      <!-- Search section -->
      <div class="card-body border-bottom bg-light">
        <div class="row mb-3">
          <div class="col-md-4">
            <div class="form-group">
              <label for="searchName" class="form-label fw-bold text-primary">
                <i class="fas fa-building me-1"></i> Tên phòng ban
              </label>
              <div class="input-group input-group-hover">
                <span class="input-group-text bg-white"><i class="fas fa-search text-primary"></i></span>
                <input type="text" class="form-control border-start-0" id="searchName" v-model="searchTerm"
                  placeholder="Tìm kiếm theo tên..." @keyup.enter="handleSearch">
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <label for="filterStatus" class="form-label fw-bold text-primary">
                <i class="fas fa-toggle-on me-1"></i> Trạng thái
              </label>
              <select class="form-select custom-select" id="filterStatus" v-model="statusFilter">
                <option value="all">Tất cả</option>
                <option :value="1">Hoạt động</option>
                <option :value="0">Không hoạt động</option>
              </select>
            </div>
          </div>
          <div class="col-md-4 d-flex align-items-end">
            <button class="btn btn-primary btn-hover-shine me-2" @click="handleSearch">
              <i class="fas fa-search me-1"></i> Tìm kiếm
            </button>
            <button class="btn btn-outline-secondary btn-hover-shine" @click="resetFilters">
              <i class="fas fa-sync-alt me-1"></i> Đặt lại
            </button>
          </div>
        </div>
      </div>

      <div class="card-body p-3">
        <div class="table-responsive">
          <table class="table table-bordered table-hover table-striped custom-table">
            <thead class="bg-gradient-primary text-white">
              <tr>
                <th class="text-center" width="5%">#</th>
                <th width="25%">Tên phòng ban</th>
                <th width="25%">Trưởng phòng</th>
                <th class="text-center" width="15%">Trạng thái</th>
                <th class="text-center" width="15%">SL nhân viên</th>
                <th class="text-center" width="15%">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(phongBan, key) in danhSachPhongBan" :key="phongBan.id_phong_ban" class="table-row-hover">
                <td class="text-center">
                  <span class="index-badge">{{ key + 1 }}</span>
                </td>
                <td>
                  <div class="d-flex align-items-center">
                    <i class="fas fa-building text-primary me-2"></i>
                    <span class="fw-medium text-dark">{{ phongBan.ten_phong_ban }}</span>
                  </div>
                </td>
                <td>
                  <div class="d-flex align-items-center">
                    <i class="fas fa-user-tie text-info me-2"></i>
                    <span>{{ phongBan.ten_truong_phong || 'Chưa có trưởng phòng' }}</span>
                  </div>
                </td>
                <td class="text-center">
                  <span :class="phongBan.trang_thai ? 'badge-status active' : 'badge-status inactive'">
                    <i :class="phongBan.trang_thai ? 'fas fa-check-circle me-1' : 'fas fa-times-circle me-1'"></i>
                    {{ phongBan.trang_thai ? 'Hoạt động' : 'Không HĐ' }}
                  </span>
                </td>
                <td class="text-center">
                  <div class="employee-count">
                    <i class="fas fa-users me-1 fs-6"></i>
                    <span class="fs-6">{{ phongBan.so_luong_nhan_vien }}</span>
                  </div>
                </td>
                <td class="text-center">
                  <div class="action-buttons">
                    <button class="btn btn-sm btn-primary text-white action-btn" data-bs-toggle="modal"
                      data-bs-target="#detailModal" @click="Object.assign(viewDetail, phongBan)" title="Chi tiết">
                      <i class="fas fa-info-circle"></i>
                    </button>
                    <button class="btn btn-sm btn-info text-white action-btn" data-bs-toggle="modal"
                      data-bs-target="#updateModal" @click="Object.assign(update, phongBan)" title="Sửa">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-danger action-btn" @click="Object.assign(deletePhongBan, phongBan)"
                      data-bs-toggle="modal" data-bs-target="#deleteModal" title="Xóa">
                      <i class="fas fa-trash-alt"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="danhSachPhongBan.length === 0">
                <td colspan="6" class="text-center py-4">
                  <div class="empty-state">
                    <i class="fas fa-folder-open text-secondary fa-3x mb-3"></i>
                    <p class="text-secondary mb-2">Không tìm thấy dữ liệu phù hợp</p>
                    <button class="btn btn-sm btn-outline-primary" @click="resetFilters">
                      <i class="fas fa-sync-alt me-1"></i> Đặt lại bộ lọc
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Modal create-->
    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="createModalLabel">Thêm phòng ban mới</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="form-group mb-3">
              <label for="tenPhongBan" class="form-label fw-bold">Tên phòng ban</label>
              <input type="text" class="form-control" id="tenPhongBan" v-model="create.ten_phong_ban" required>
            </div>
            <div class="form-group mb-3">
              <label for="tenTruongPhong" class="form-label fw-bold">Tên trưởng phòng</label>
              <input type="text" class="form-control" id="tenTruongPhong" v-model="create.ten_truong_phong">
            </div>
            <div class="form-group mb-3">
              <label for="trangThai" class="form-label fw-bold">Trạng thái</label>
              <select class="form-select" id="trangThai" v-model="create.trang_thai">
                <option :value="1">Hoạt động</option>
                <option :value="0">Không hoạt động</option>
              </select>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="button" class="btn btn-primary" v-on:click="createPhongBan" data-bs-dismiss="modal">
              <i class="fas fa-save me-1"></i> Lưu
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal update-->
    <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header bg-info text-white">
            <h5 class="modal-title" id="updateModalLabel">Cập nhật phòng ban</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="form-group mb-3">
              <label for="tenPhongBan" class="form-label fw-bold">Tên phòng ban</label>
              <input type="text" class="form-control" id="tenPhongBan" v-model="update.ten_phong_ban" required>
            </div>
            <div class="form-group mb-3">
              <label for="tenTruongPhong" class="form-label fw-bold">Tên trưởng phòng</label>
              <input type="text" class="form-control" id="tenTruongPhong" v-model="update.ten_truong_phong">
            </div>
            <div class="form-group mb-3">
              <label for="trangThai" class="form-label fw-bold">Trạng thái</label>
              <select class="form-select" id="trangThai" v-model="update.trang_thai">
                <option :value="1">Hoạt động</option>
                <option :value="0">Không hoạt động</option>
              </select>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="button" class="btn btn-info text-white" v-on:click="updatePhongBan" data-bs-dismiss="modal">
              <i class="fas fa-save me-1"></i> Cập nhật
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- modal delete  -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="text-center mb-3">
              <i class="fas fa-exclamation-triangle text-warning fa-3x"></i>
            </div>
            <p class="text-center">Bạn có chắc chắn muốn xóa phòng ban <strong>{{ deletePhongBan.ten_phong_ban
                }}</strong>?</p>
            <p class="text-danger text-center small">Lưu ý: Hành động này không thể hoàn tác.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="button" class="btn btn-danger" @click="deletePhongBanFunc(deletePhongBan.id_phong_ban)"
              data-bs-dismiss="modal">
              <i class="fas fa-trash me-1"></i> Xóa
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- modal detail -->
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="detailModalLabel">Chi tiết phòng ban</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="detail-card">
              <div class="detail-header mb-4">
                <div class="d-flex align-items-center">
                  <div class="detail-icon">
                    <i class="fas fa-building"></i>
                  </div>
                  <div class="ms-3">
                    <h5 class="mb-1">{{ viewDetail.ten_phong_ban }}</h5>
                    <span :class="viewDetail.trang_thai ? 'badge-status active' : 'badge-status inactive'">
                      <i :class="viewDetail.trang_thai ? 'fas fa-check-circle me-1' : 'fas fa-times-circle me-1'"></i>
                      {{ viewDetail.trang_thai ? 'Hoạt động' : 'Không hoạt động' }}
                    </span>
                  </div>
                </div>
              </div>

              <div class="detail-info">
                <div class="detail-item">
                  <div class="detail-label">
                    <i class="fas fa-hashtag text-primary me-2"></i>
                    Mã phòng ban:
                  </div>
                  <div class="detail-value">{{ viewDetail.id_phong_ban }}</div>
                </div>

                <div class="detail-item">
                  <div class="detail-label">
                    <i class="fas fa-user-tie text-info me-2"></i>
                    Trưởng phòng:
                  </div>
                  <div class="detail-value">{{ viewDetail.ten_truong_phong || 'Chưa có trưởng phòng' }}</div>
                </div>

                <div class="detail-item">
                  <div class="detail-label">
                    <i class="fas fa-users text-info me-2"></i>
                    Số lượng nhân viên:
                  </div>
                  <div class="detail-value">
                    <span class="badge bg-info rounded-pill">{{ viewDetail.so_luong_nhan_vien }}</span>
                  </div>
                </div>

                <div class="detail-item" v-if="viewDetail.created_at">
                  <div class="detail-label">
                    <i class="fas fa-calendar-plus text-secondary me-2"></i>
                    Ngày tạo:
                  </div>
                  <div class="detail-value">{{ formatDate(viewDetail.created_at) }}</div>
                </div>

                <div class="detail-item" v-if="viewDetail.updated_at">
                  <div class="detail-label">
                    <i class="fas fa-calendar-alt text-secondary me-2"></i>
                    Cập nhật lần cuối:
                  </div>
                  <div class="detail-value">{{ formatDate(viewDetail.updated_at) }}</div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import baseRequest from "../../../core/baseRequest";
import { createToaster } from "@meforma/vue-toaster";
const toaster = createToaster({ position: "top-right" });
export default {
  name: 'QuanLyPhongBan',
  data() {
    return {
      danhSachPhongBan: [],
      isEditing: false,
      create: {
        ten_phong_ban: '',
        ten_truong_phong: '',
        trang_thai: 1
      },
      update: {
        id_phong_ban: null,
        ten_phong_ban: '',
        ten_truong_phong: '',
        trang_thai: 1
      },
      viewDetail: {},
      deletePhongBan: {},
      searchTerm: '',
      statusFilter: 'all'
    };
  },
  mounted() {
    this.fetchPhongBan();
  },
  methods: {
    createPhongBan() {
      baseRequest.post("create-phong-ban", this.create)
        .then(response => {
          if (response.data.status === 201) {
            toaster.success("Thêm phòng ban thành công");
            this.fetchPhongBan();
          }
        })
    },
    updatePhongBan() {
      baseRequest.put("update-phong-ban", this.update)
        .then(response => {
          if (response.data.status === 200) {
            toaster.success("Cập nhật phòng ban thành công");
            this.fetchPhongBan();
          }
        })
    },

    deletePhongBanFunc(id) {
      baseRequest.delete(`delete-phong-ban/${id}`)
        .then(response => {
          if (response.data.status === 200) {
            toaster.success("Xóa phòng ban thành công");
            this.fetchPhongBan();
          }
        })
    },
    fetchPhongBan() {
      // Build query parameters for search
      const params = {};
      if (this.searchTerm) {
        params.ten_phong_ban = this.searchTerm;
      }
      if (this.statusFilter !== 'all') {
        params.trang_thai = this.statusFilter;
      }

      axios.get('http://localhost:8000/api/get-phong-ban', { params })
        .then(response => {
          if (response.data.status === 200) {
            this.danhSachPhongBan = response.data.data;
          }
        })
        .catch(error => {
          console.error('Lỗi khi lấy dữ liệu phòng ban:', error);
        });
    },

    // Update the search method to trigger API call
    handleSearch() {
      this.fetchPhongBan();
    },

    resetFilters() {
      this.searchTerm = '';
      this.statusFilter = 'all';
      this.fetchPhongBan(); // Fetch all data after reset
    },
    formatDate(dateString) {
      if (!dateString) return '';
      const options = {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      };
      return new Date(dateString).toLocaleDateString('vi-VN', options);
    },
  }
};
</script>

<style scoped>
.quan-ly-phong-ban {
  padding: 20px;
}

.card {
  border-radius: 12px;
  overflow: hidden;
  border: none;
  transition: all 0.3s ease;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05) !important;
}

.card:hover {
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1) !important;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
}

.bg-gradient-primary {
  background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
}

.table th,
.table td {
  vertical-align: middle;
  padding: 8px;
  font-size: 0.85rem;
}

.custom-table {
  border-radius: 8px;
  overflow: hidden;
  border-collapse: separate;
  border-spacing: 0;
  border: 1px solid #e3e6f0;
  font-size: 0.85rem;
  max-width: 100%;
  margin-bottom: 0;
}

.custom-table thead th {
  border-bottom: none;
  font-weight: 600;
  text-transform: uppercase;
  font-size: 0.75rem;
  letter-spacing: 0.5px;
  padding: 8px;
}

.table-row-hover {
  transition: all 0.2s ease;
}

.table-row-hover:hover {
  background-color: rgba(78, 115, 223, 0.05) !important;
  transform: translateY(-1px);
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.index-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background-color: rgba(78, 115, 223, 0.1);
  color: #4e73df;
  font-size: 0.75rem;
  font-weight: 600;
}

.badge-status.active {
  background-color: rgba(40, 167, 69, 0.15);
  color: #28a745;
  font-weight: 600;
}

.badge-status.inactive {
  background-color: rgba(220, 53, 69, 0.15);
  color: #dc3545;
  font-weight: 600;
}

.employee-count {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(54, 185, 204, 0.15);
  color: #36b9cc;
  padding: 3px 8px;
  border-radius: 4px;
  font-weight: 500;
  font-size: 0.75rem;
}

.empty-state {
  padding: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.action-buttons {
  display: flex;
  justify-content: center;
  gap: 5px;
}

.action-btn {
  border-radius: 4px;
  width: 28px;
  height: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  padding: 0;
}

.action-btn i {
  font-size: 0.75rem;
}

.action-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.badge-status {
  padding: 4px 8px;
  border-radius: 50px;
  font-weight: 500;
  font-size: 0.75rem;
  display: inline-flex;
  align-items: center;
}

.badge {
  font-size: 0.75rem;
}

.detail-card {
  background-color: #fff;
  border-radius: 8px;
}

.detail-header {
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}

.detail-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background-color: rgba(78, 115, 223, 0.1);
  color: #4e73df;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
}

.detail-info {
  margin-top: 15px;
}

.detail-item {
  display: flex;
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px dashed #eee;
}

.detail-label {
  width: 40%;
  color: #6c757d;
  font-weight: 500;
}

.detail-value {
  width: 60%;
  font-weight: 400;
}
</style>