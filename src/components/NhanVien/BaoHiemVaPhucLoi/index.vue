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
                  <i class="fas fa-shield-alt me-2"></i>Bảo Hiểm & Phúc Lợi
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
                placeholder="Tìm kiếm theo tên nhân viên hoặc loại bảo hiểm..."
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
                <i class="fas fa-user-shield"></i>
              </div>
              <div class="ms-3">
                <p class="text-sm mb-0 text-capitalize font-weight-bold">Tổng Bảo Hiểm</p>
                <h3 class="font-weight-bolder mb-0">{{ danhSachBaoHiem.length }}</h3>
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
            <label class="form-label mb-1 text-sm">Loại bảo hiểm</label>
            <select class="form-select" v-model="filterLoaiBaoHiem">
              <option value="">Tất cả</option>
              <option value="BHXH">Bảo hiểm xã hội</option>
              <option value="BHYT">Bảo hiểm y tế</option>
              <option value="BHTN">Bảo hiểm thất nghiệp</option>
              <option value="BHSK">Bảo hiểm sức khỏe</option>
            </select>
          </div>
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Trạng thái</label>
            <select class="form-select" v-model="filterTrangThai">
              <option value="">Tất cả</option>
              <option value="Đang áp dụng">Đang áp dụng</option>
              <option value="Hết hạn">Hết hạn</option>
              <option value="Sắp hết hạn">Sắp hết hạn</option>
            </select>
          </div>
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Phòng ban</label>
            <select class="form-select" v-model="filterPhongBan">
              <option value="">Tất cả</option>
              <option v-for="pb in danhSachPhongBan" :key="pb.maPhongBan" :value="pb.maPhongBan">
                {{ pb.tenPhongBan }}
              </option>
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
 
    <!-- Stats Cards -->
    <div class="row mb-4">
      <div class="col-md-3 mb-4 mb-md-0">
        <div class="card border-0 shadow-sm">
          <div class="card-body p-3">
            <div class="row">
              <div class="col-8">
                <div class="numbers">
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">BHXH</p>
                  <h5 class="font-weight-bolder mb-0 text-primary">
                    {{ countByType('BHXH') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-primary text-white rounded shadow p-3">
                  <i class="fas fa-id-card"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <div class="card border-0 shadow-sm">
          <div class="card-body p-3">
            <div class="row">
              <div class="col-8">
                <div class="numbers">
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">BHYT</p>
                  <h5 class="font-weight-bolder mb-0 text-success">
                    {{ countByType('BHYT') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-success text-white rounded shadow p-3">
                  <i class="fas fa-heartbeat"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <div class="card border-0 shadow-sm">
          <div class="card-body p-3">
            <div class="row">
              <div class="col-8">
                <div class="numbers">
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">BHTN</p>
                  <h5 class="font-weight-bolder mb-0 text-warning">
                    {{ countByType('BHTN') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-warning text-white rounded shadow p-3">
                  <i class="fas fa-briefcase"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card border-0 shadow-sm">
          <div class="card-body p-3">
            <div class="row">
              <div class="col-8">
                <div class="numbers">
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">BHSK</p>
                  <h5 class="font-weight-bolder mb-0 text-info">
                    {{ countByType('BHSK') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-info text-white rounded shadow p-3">
                  <i class="fas fa-medkit"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Table Section -->
    <div class="card border-0 shadow mb-4">
      <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
        <h5 class="mb-0 font-weight-bold">Danh Sách Bảo Hiểm & Phúc Lợi</h5>
        <div class="d-flex align-items-center">
          <span class="badge bg-primary rounded-pill me-2">{{ filteredItems.length }}</span>
          <span class="text-sm text-muted">bảo hiểm</span>
        </div>
      </div>
      <div class="card-body px-0 pt-0 pb-2">
        <div class="table-responsive p-0">
          <table class="table align-items-center mb-0">
            <thead>
              <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-4">STT</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nhân Viên</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Loại Bảo Hiểm</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Mã Số</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thời Hạn</th>
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
                    <h6 class="mb-0 text-sm">{{ getLoaiBaoHiemText(item.loaiBaoHiem) }}</h6>
                    <p class="text-xs text-secondary mb-0">{{ item.noiDangKy }}</p>
                  </div>
                </td>
                <td>
                  <p class="text-sm font-weight-bold mb-0">{{ item.maSoBaoHiem }}</p>
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
                    :class="getStatusClass(item.trangThai)"
                  >
                    {{ item.trangThai }}
                  </span>
                </td>
                <td>
                  <div class="d-flex">
                    <button class="btn btn-link text-info px-2 mb-0 action-btn" @click="xemChiTiet(item)" title="Xem chi tiết">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-link text-primary px-2 mb-0 action-btn" @click="capNhatBaoHiem(item)" title="Cập nhật">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-link text-danger px-2 mb-0 action-btn" @click="xoaBaoHiem(item.id)" title="Xóa">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredItems.length === 0">
                <td colspan="7" class="text-center py-5">
                  <div class="d-flex flex-column align-items-center">
                    <i class="fas fa-folder-open fa-3x text-secondary mb-3"></i>
                    <h5 class="text-secondary">Không tìm thấy thông tin bảo hiểm nào</h5>
                    <p class="text-xs text-secondary">Thử thay đổi bộ lọc hoặc thêm bảo hiểm mới</p>
                    <button class="btn btn-sm btn-primary mt-3" @click="showAddModal">
                      <i class="fas fa-plus-circle me-2"></i>Thêm bảo hiểm mới
                    </button>
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
              <i class="fas fa-shield-alt me-2"></i>
              {{ isEditing ? 'Chi Tiết Bảo Hiểm' : 'Thêm Bảo Hiểm Mới' }}
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
                      <span class="input-group-text"><i class="fas fa-shield-alt"></i></span>
                      <select class="form-select" v-model="formData.loaiBaoHiem" required>
                        <option value="" disabled>Chọn loại bảo hiểm</option>
                        <option value="BHXH">Bảo hiểm xã hội</option>
                        <option value="BHYT">Bảo hiểm y tế</option>
                        <option value="BHTN">Bảo hiểm thất nghiệp</option>
                        <option value="BHSK">Bảo hiểm sức khỏe</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Mã Số Bảo Hiểm</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.maSoBaoHiem" 
                        placeholder="Nhập mã số bảo hiểm"
                        required
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Nơi Đăng Ký</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-building"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.noiDangKy" 
                        placeholder="Nhập nơi đăng ký"
                        required
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
                      <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
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
                      <span class="input-group-text"><i class="fas fa-calendar-times"></i></span>
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
                    <label class="form-control-label">Mức Đóng (VNĐ/tháng)</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.mucDong" 
                        placeholder="Nhập mức đóng"
                        required
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Tỷ Lệ Hưởng (%)</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-percentage"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.tyLeHuong" 
                        placeholder="Nhập tỷ lệ hưởng"
                        min="0"
                        max="100"
                        required
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
                    <option value="Đang áp dụng">Đang áp dụng</option>
                    <option value="Hết hạn">Hết hạn</option>
                    <option value="Sắp hết hạn">Sắp hết hạn</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Đóng
              </button>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-2"></i>{{ isEditing ? 'Cập Nhật' : 'Lưu Bảo Hiểm' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Modal } from 'bootstrap'

export default {
  name: 'BaoHiemVaPhucLoi',
  data() {
    return {
      searchQuery: '',
      filterLoaiBaoHiem: '',
      filterTrangThai: '',
      filterPhongBan: '',
      danhSachBaoHiem: [
        {
          id: 1,
          maNhanVien: 'NV001',
          tenNhanVien: 'Nguyễn Văn A',
          avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
          loaiBaoHiem: 'BHXH',
          maSoBaoHiem: '0123456789',
          noiDangKy: 'BHXH TP. Hồ Chí Minh',
          ngayHieuLuc: '2023-01-01',
          ngayHetHan: '2023-12-31',
          mucDong: 500000,
          tyLeHuong: 80,
          trangThai: 'Đang áp dụng',
          ghiChu: 'Đóng đầy đủ hàng tháng',
          maPhongBan: 'PB001'
        },
        {
          id: 2,
          maNhanVien: 'NV001',
          tenNhanVien: 'Nguyễn Văn A',
          avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
          loaiBaoHiem: 'BHYT',
          maSoBaoHiem: 'YT0123456789',
          noiDangKy: 'BHYT TP. Hồ Chí Minh',
          ngayHieuLuc: '2023-01-01',
          ngayHetHan: '2023-12-31',
          mucDong: 300000,
          tyLeHuong: 100,
          trangThai: 'Đang áp dụng',
          ghiChu: 'Thẻ BHYT mới',
          maPhongBan: 'PB001'
        },
        {
          id: 3,
          maNhanVien: 'NV002',
          tenNhanVien: 'Trần Thị B',
          avatar: 'https://randomuser.me/api/portraits/women/2.jpg',
          loaiBaoHiem: 'BHXH',
          maSoBaoHiem: '9876543210',
          noiDangKy: 'BHXH TP. Hồ Chí Minh',
          ngayHieuLuc: '2023-02-01',
          ngayHetHan: '2023-08-15',
          mucDong: 450000,
          tyLeHuong: 80,
          trangThai: 'Sắp hết hạn',
          ghiChu: 'Cần gia hạn',
          maPhongBan: 'PB002'
        },
        {
          id: 4,
          maNhanVien: 'NV003',
          tenNhanVien: 'Lê Văn C',
          avatar: 'https://randomuser.me/api/portraits/men/3.jpg',
          loaiBaoHiem: 'BHTN',
          maSoBaoHiem: 'TN0123456789',
          noiDangKy: 'BHXH TP. Hồ Chí Minh',
          ngayHieuLuc: '2022-06-01',
          ngayHetHan: '2023-06-01',
          mucDong: 200000,
          tyLeHuong: 60,
          trangThai: 'Hết hạn',
          ghiChu: 'Cần gia hạn gấp',
          maPhongBan: 'PB003'
        },
        {
          id: 5,
          maNhanVien: 'NV004',
          tenNhanVien: 'Phạm Thị D',
          avatar: 'https://randomuser.me/api/portraits/women/4.jpg',
          loaiBaoHiem: 'BHSK',
          maSoBaoHiem: 'SK0123456789',
          noiDangKy: 'Bảo hiểm Bảo Việt',
          ngayHieuLuc: '2023-03-15',
          ngayHetHan: '2024-03-15',
          mucDong: 800000,
          tyLeHuong: 90,
          trangThai: 'Đang áp dụng',
          ghiChu: 'Bảo hiểm sức khỏe cao cấp',
          maPhongBan: 'PB002'
        },
        {
          id: 6,
          maNhanVien: 'NV005',
          tenNhanVien: 'Hoàng Văn E',
          avatar: 'https://randomuser.me/api/portraits/men/5.jpg',
          loaiBaoHiem: 'BHYT',
          maSoBaoHiem: 'YT9876543210',
          noiDangKy: 'BHYT TP. Hồ Chí Minh',
          ngayHieuLuc: '2023-01-01',
          ngayHetHan: '2023-07-30',
          mucDong: 300000,
          tyLeHuong: 100,
          trangThai: 'Sắp hết hạn',
          ghiChu: 'Cần gia hạn',
          maPhongBan: 'PB001'
        }
      ],
      danhSachNhanVien: [
        { maNhanVien: 'NV001', tenNhanVien: 'Nguyễn Văn A'},
        { maNhanVien: 'NV002', tenNhanVien: 'Trần Thị B' },
        { maNhanVien: 'NV003', tenNhanVien: 'Lê Văn C' },
        { maNhanVien: 'NV004', tenNhanVien: 'Phạm Thị D' },
        { maNhanVien: 'NV005', tenNhanVien: 'Hoàng Văn E' }
      ],
      danhSachPhongBan: [
        { maPhongBan: 'PB001', tenPhongBan: 'Phòng Nhân sự' },
        { maPhongBan: 'PB002', tenPhongBan: 'Phòng Kế toán' },
        { maPhongBan: 'PB003', tenPhongBan: 'Phòng Kỹ thuật' },
        { maPhongBan: 'PB004', tenPhongBan: 'Phòng Kinh doanh' }
      ],
      formData: {
        maNhanVien: '',
        loaiBaoHiem: '',
        maSoBaoHiem: '',
        noiDangKy: '',
        ngayHieuLuc: '',
        ngayHetHan: '',
        mucDong: 0,
        tyLeHuong: 0,
        trangThai: 'Đang áp dụng',
        ghiChu: ''
      },
      isEditing: false,
      modalInstance: null,
      selectedFile: null
    }
  },
  computed: {
    filteredItems() {
      let result = [...this.danhSachBaoHiem]
      
      // Tìm kiếm
      if (this.searchQuery) {
        const query = this.searchQuery.toLowerCase()
        result = result.filter(item => {
          return item.tenNhanVien.toLowerCase().includes(query) ||
                 item.maSoBaoHiem.toLowerCase().includes(query) ||
                 this.getLoaiBaoHiemText(item.loaiBaoHiem).toLowerCase().includes(query)
        })
      }
      
      // Lọc theo loại bảo hiểm
      if (this.filterLoaiBaoHiem) {
        result = result.filter(item => item.loaiBaoHiem === this.filterLoaiBaoHiem)
      }
      
      // Lọc theo trạng thái
      if (this.filterTrangThai) {
        result = result.filter(item => item.trangThai === this.filterTrangThai)
      }
      
      // Lọc theo phòng ban
      if (this.filterPhongBan) {
        result = result.filter(item => item.maPhongBan === this.filterPhongBan)
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
        case 'Đang áp dụng': return 'bg-gradient-success'
        case 'Sắp hết hạn': return 'bg-gradient-warning'
        case 'Hết hạn': return 'bg-gradient-danger'
        default: return 'bg-gradient-secondary'
      }
    },
    getLoaiBaoHiemText(code) {
      switch (code) {
        case 'BHXH': return 'Bảo hiểm xã hội'
        case 'BHYT': return 'Bảo hiểm y tế'
        case 'BHTN': return 'Bảo hiểm thất nghiệp'
        case 'BHSK': return 'Bảo hiểm sức khỏe'
        default: return code
      }
    },
    calculateDaysLeft(endDateStr) {
      const today = new Date()
      const endDate = new Date(endDateStr)
      
      // Đặt giờ về 0 để so sánh chỉ ngày
      today.setHours(0, 0, 0, 0)
      endDate.setHours(0, 0, 0, 0)
      
      const diffTime = endDate - today
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
      
      if (diffDays < 0) {
        return 'Đã hết hạn ' + Math.abs(diffDays) + ' ngày'
      } else if (diffDays === 0) {
        return 'Hết hạn hôm nay'
      } else if (diffDays <= 30) {
        return 'Còn ' + diffDays + ' ngày'
      } else {
        return 'Còn ' + Math.floor(diffDays / 30) + ' tháng ' + (diffDays % 30) + ' ngày'
      }
    },
    countByType(type) {
      return this.danhSachBaoHiem.filter(item => item.loaiBaoHiem === type).length
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
        maSoBaoHiem: '',
        noiDangKy: '',
        ngayHieuLuc: '',
        ngayHetHan: '',
        mucDong: 0,
        tyLeHuong: 0,
        trangThai: 'Đang áp dụng',
        ghiChu: ''
      }
      this.selectedFile = null
    },
    handleFileUpload(event) {
      this.selectedFile = event.target.files[0]
    },
    validateDateRange() {
      if (this.formData.ngayHieuLuc && this.formData.ngayHetHan) {
        const startDate = new Date(this.formData.ngayHieuLuc)
        const endDate = new Date(this.formData.ngayHetHan)
        
        if (startDate > endDate) {
          alert('Ngày hiệu lực không thể sau ngày hết hạn!')
          this.formData.ngayHetHan = this.formData.ngayHieuLuc
          return false
        }
      }
      return true
    },
    submitForm() {
      try {
        // Kiểm tra ngày
        if (!this.validateDateRange()) {
          return
        }
        
        // Lấy thông tin nhân viên
        const nhanVien = this.danhSachNhanVien.find(nv => nv.maNhanVien === this.formData.maNhanVien)
        
        if (!nhanVien) {
          alert('Không tìm thấy thông tin nhân viên!')
          return
        }
        
        // Kiểm tra trùng mã số bảo hiểm
        if (!this.isEditing) {
          const existingBaoHiem = this.danhSachBaoHiem.find(
            bh => bh.loaiBaoHiem === this.formData.loaiBaoHiem && 
                 bh.maSoBaoHiem === this.formData.maSoBaoHiem
          )
          
          if (existingBaoHiem) {
            alert('Mã số bảo hiểm này đã tồn tại trong hệ thống!')
            return
          }
        }
        
        if (this.isEditing) {
          // Cập nhật bảo hiểm
          const index = this.danhSachBaoHiem.findIndex(item => item.id === this.formData.id)
          if (index !== -1) {
            this.danhSachBaoHiem[index] = { ...this.formData }
            this.showNotification('Đã cập nhật thông tin bảo hiểm thành công!', 'success')
          }
        } else {
          // Tạo bảo hiểm mới
          const newId = Math.max(...this.danhSachBaoHiem.map(item => item.id), 0) + 1
          const maPhongBan = this.danhSachBaoHiem.find(
            bh => bh.maNhanVien === this.formData.maNhanVien
          )?.maPhongBan || 'PB001'
          
          this.danhSachBaoHiem.push({
            id: newId,
            maNhanVien: this.formData.maNhanVien,
            tenNhanVien: nhanVien.tenNhanVien,
            avatar: `https://randomuser.me/api/portraits/${Math.random() > 0.5 ? 'men' : 'women'}/${newId}.jpg`,
            loaiBaoHiem: this.formData.loaiBaoHiem,
            maSoBaoHiem: this.formData.maSoBaoHiem,
            noiDangKy: this.formData.noiDangKy,
            ngayHieuLuc: this.formData.ngayHieuLuc,
            ngayHetHan: this.formData.ngayHetHan,
            mucDong: this.formData.mucDong,
            tyLeHuong: this.formData.tyLeHuong,
            trangThai: 'Đang áp dụng',
            ghiChu: this.formData.ghiChu,
            maPhongBan: maPhongBan
          })
          
          this.showNotification('Đã thêm bảo hiểm mới thành công!', 'success')
        }
        
        this.modalInstance.hide()
      } catch (error) {
        console.error('Lỗi khi lưu:', error)
        this.showNotification('Có lỗi xảy ra khi lưu thông tin bảo hiểm!', 'danger')
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
    capNhatBaoHiem(item) {
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
          this.showNotification('Đã xóa bảo hiểm thành công!', 'success')
        }
      }
    },
    applyFilters() {
      // Đã xử lý trong computed property
      this.showNotification('Đã áp dụng bộ lọc!', 'info')
    },
    showNotification(message, type = 'info') {
      // Giả lập hiển thị thông báo
      const alertClass = type === 'success' ? 'alert-success' : 
                         type === 'danger' ? 'alert-danger' : 
                         type === 'warning' ? 'alert-warning' : 'alert-info'
      
      const alertDiv = document.createElement('div')
      alertDiv.className = `alert ${alertClass} position-fixed top-0 end-0 m-3`
      alertDiv.style.zIndex = '9999'
      alertDiv.style.minWidth = '300px'
      alertDiv.style.boxShadow = '0 0.5rem 1rem rgba(0, 0, 0, 0.15)'
      alertDiv.innerHTML = message
      
      document.body.appendChild(alertDiv)
      
      setTimeout(() => {
        alertDiv.style.opacity = '0'
        alertDiv.style.transition = 'opacity 0.5s'
        setTimeout(() => {
          document.body.removeChild(alertDiv)
        }, 500)
      }, 3000)
    },
    checkExpiringInsurance() {
      // Kiểm tra các bảo hiểm sắp hết hạn (trong vòng 30 ngày)
      const today = new Date()
      today.setHours(0, 0, 0, 0)
      
      this.danhSachBaoHiem.forEach(item => {
        const endDate = new Date(item.ngayHetHan)
        endDate.setHours(0, 0, 0, 0)
        
        const diffTime = endDate - today
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
        
        if (diffDays < 0 && item.trangThai !== 'Hết hạn') {
          // Đã hết hạn
          item.trangThai = 'Hết hạn'
        } else if (diffDays >= 0 && diffDays <= 30 && item.trangThai !== 'Sắp hết hạn') {
          // Sắp hết hạn (còn dưới 30 ngày)
          item.trangThai = 'Sắp hết hạn'
        }
      })
    }
  },
  mounted() {
    // Khởi tạo Bootstrap Modal
    this.modalInstance = new Modal(document.getElementById('baoHiemModal'))
    
    // Kiểm tra bảo hiểm sắp hết hạn
    this.checkExpiringInsurance()
  },
  beforeUnmount() {
    // Dọn dẹp modal nếu cần
    if (this.modalInstance) {
      this.modalInstance.dispose()
    }
  },
  watch: {
    'formData.ngayHieuLuc'() {
      this.validateDateRange()
    },
    'formData.ngayHetHan'() {
      this.validateDateRange()
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

.avatar-sm {
  width: 36px;
  height: 36px;
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
  transition: all 0.3s ease;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
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

.action-btn {
  transition: all 0.3s ease;
}

.action-btn:hover {
  transform: scale(1.2);
}

.text-truncate {
  max-width: 200px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* Animation for table rows */
tr {
  transition: all 0.3s ease;
}

tr:hover {
  background-color: rgba(94, 114, 228, 0.05) !important;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
  background: #555;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .icon-shape {
    width: 40px;
    height: 40px;
  }
  
  .card-body {
    padding: 1rem;
  }
  
  .table > :not(caption) > * > * {
    padding: 0.75rem 0.5rem;
  }
}
</style>