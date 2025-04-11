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
                  <i class="fas fa-chart-line me-2"></i>Tiêu Chí KPI
                </h2>
                <p class="text-white opacity-8 mb-0">
                  Quản lý và theo dõi các tiêu chí đánh giá hiệu suất nhân viên
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
                placeholder="Tìm kiếm theo tên tiêu chí hoặc phòng ban..."
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
                <i class="fas fa-tasks"></i>
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

    <!-- Filter Section -->
    <div class="card border-0 shadow-sm mb-4">
      <div class="card-body p-3">
        <div class="row align-items-center">
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Loại tiêu chí</label>
            <select class="form-select" v-model="filterLoaiTieuChi">
              <option value="">Tất cả</option>
              <option value="Định lượng">Định lượng</option>
              <option value="Định tính">Định tính</option>
              <option value="Hỗn hợp">Hỗn hợp</option>
            </select>
          </div>
          <div class="col-md-3 mb-3 mb-md-0">
            <label class="form-label mb-1 text-sm">Trạng thái</label>
            <select class="form-select" v-model="filterTrangThai">
              <option value="">Tất cả</option>
              <option value="Đang áp dụng">Đang áp dụng</option>
              <option value="Tạm ngưng">Tạm ngưng</option>
              <option value="Đã hết hạn">Đã hết hạn</option>
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
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">Định lượng</p>
                  <h5 class="font-weight-bolder mb-0 text-primary">
                    {{ countByType('Định lượng') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-primary text-white rounded shadow p-3">
                  <i class="fas fa-calculator"></i>
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
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">Định tính</p>
                  <h5 class="font-weight-bolder mb-0 text-success">
                    {{ countByType('Định tính') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-success text-white rounded shadow p-3">
                  <i class="fas fa-star"></i>
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
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">Hỗn hợp</p>
                  <h5 class="font-weight-bolder mb-0 text-warning">
                    {{ countByType('Hỗn hợp') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-warning text-white rounded shadow p-3">
                  <i class="fas fa-balance-scale"></i>
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
                  <p class="text-sm mb-0 text-capitalize font-weight-bold">Đang áp dụng</p>
                  <h5 class="font-weight-bolder mb-0 text-info">
                    {{ countByStatus('Đang áp dụng') }}
                  </h5>
                </div>
              </div>
              <div class="col-4 text-end">
                <div class="icon-shape bg-gradient-info text-white rounded shadow p-3">
                  <i class="fas fa-check-circle"></i>
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
        <h5 class="mb-0 font-weight-bold">Danh Sách Tiêu Chí KPI</h5>
        <div class="d-flex align-items-center">
          <span class="badge bg-primary rounded-pill me-2">{{ filteredItems.length }}</span>
          <span class="text-sm text-muted">tiêu chí</span>
        </div>
      </div>
      <div class="card-body px-0 pt-0 pb-2">
        <div class="table-responsive p-0">
          <table class="table align-items-center mb-0">
            <thead>
              <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-4">STT</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Tên Tiêu Chí</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Loại</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Phòng Ban</th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Trọng Số</th>
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
                    <div class="d-flex flex-column justify-content-center">
                      <h6 class="mb-0 text-sm">{{ item.tenTieuChi }}</h6>
                      <p class="text-xs text-secondary mb-0">Mã: {{ item.maTieuChi }}</p>
                    </div>
                  </div>
                </td>
                <td>
                  <div class="d-flex flex-column">
                    <h6 class="mb-0 text-sm">{{ item.loaiTieuChi }}</h6>
                    <p class="text-xs text-secondary mb-0">{{ item.donViDo }}</p>
                  </div>
                </td>
                <td>
                  <p class="text-sm font-weight-bold mb-0">{{ getPhongBanName(item.maPhongBan) }}</p>
                </td>
                <td>
                  <div class="d-flex align-items-center">
                    <span class="me-2 text-sm font-weight-bold">{{ item.trongSo }}%</span>
                    <div>
                      <div class="progress" style="width: 100px">
                        <div class="progress-bar bg-gradient-info" role="progressbar" 
                          :style="`width: ${item.trongSo}%`" 
                          :aria-valuenow="item.trongSo" 
                          aria-valuemin="0" 
                          aria-valuemax="100">
                        </div>
                      </div>
                    </div>
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
                    <button class="btn btn-link text-primary px-2 mb-0 action-btn" @click="capNhatTieuChi(item)" title="Cập nhật">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-link text-danger px-2 mb-0 action-btn" @click="xoaTieuChi(item.id)" title="Xóa">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredItems.length === 0">
                <td colspan="7" class="text-center py-5">
                  <div class="d-flex flex-column align-items-center">
                    <i class="fas fa-folder-open fa-3x text-secondary mb-3"></i>
                    <h5 class="text-secondary">Không tìm thấy tiêu chí KPI nào</h5>
                    <p class="text-xs text-secondary">Thử thay đổi bộ lọc hoặc thêm tiêu chí mới</p>
                    <button class="btn btn-sm btn-primary mt-3" @click="showAddModal">
                      <i class="fas fa-plus-circle me-2"></i>Thêm tiêu chí mới
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
    <div class="modal fade" id="tieuChiModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
          <div class="modal-header bg-gradient-primary text-white">
            <h5 class="modal-title">
              <i class="fas fa-chart-line me-2"></i>
              {{ isEditing ? 'Chi Tiết Tiêu Chí KPI' : 'Thêm Tiêu Chí KPI Mới' }}
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
                        placeholder="Nhập mã tiêu chí"
                        :disabled="isEditing"
                        required
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
                        placeholder="Nhập tên tiêu chí"
                        required
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Loại Tiêu Chí</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-list-ul"></i></span>
                      <select class="form-select" v-model="formData.loaiTieuChi" required>
                        <option value="" disabled>Chọn loại tiêu chí</option>
                        <option value="Định lượng">Định lượng</option>
                        <option value="Định tính">Định tính</option>
                        <option value="Hỗn hợp">Hỗn hợp</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Phòng Ban</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-building"></i></span>
                      <select class="form-select" v-model="formData.maPhongBan" required>
                        <option value="" disabled>Chọn phòng ban</option>
                        <option v-for="pb in danhSachPhongBan" :key="pb.maPhongBan" :value="pb.maPhongBan">
                          {{ pb.tenPhongBan }}
                        </option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Đơn Vị Đo</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-ruler"></i></span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="formData.donViDo" 
                        placeholder="VD: %, số lượng, điểm..."
                        required
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Trọng Số (%)</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-percentage"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.trongSo" 
                        placeholder="Nhập trọng số"
                        min="0"
                        max="100"
                        required
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Mục Tiêu Tối Thiểu</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-arrow-down"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.mucTieuToiThieu" 
                        placeholder="Nhập mục tiêu tối thiểu"
                        required
                      >
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Mục Tiêu Tối Đa</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-arrow-up"></i></span>
                      <input 
                        type="number" 
                        class="form-control" 
                        v-model="formData.mucTieuToiDa" 
                        placeholder="Nhập mục tiêu tối đa"
                        required
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label class="form-control-label">Ngày Bắt Đầu</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
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
                      <span class="input-group-text"><i class="fas fa-calendar-times"></i></span>
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
                <label class="form-control-label">Mô Tả Chi Tiết</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                  <textarea 
                    class="form-control" 
                    v-model="formData.moTa" 
                    rows="3"
                    placeholder="Nhập mô tả chi tiết về tiêu chí"
                    required
                  ></textarea>
                </div>
              </div>

              <div class="form-group mb-3">
                <label class="form-control-label">Cách Tính Điểm</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-calculator"></i></span>
                  <textarea 
                    class="form-control" 
                    v-model="formData.cachTinhDiem" 
                    rows="3"
                    placeholder="Mô tả cách tính điểm cho tiêu chí này"
                    required
                  ></textarea>
                </div>
              </div>

              <div v-if="isEditing" class="form-group">
                <label class="form-control-label">Trạng Thái</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-toggle-on"></i></span>
                  <select class="form-select" v-model="formData.trangThai" required>
                    <option value="Đang áp dụng">Đang áp dụng</option>
                    <option value="Tạm ngưng">Tạm ngưng</option>
                    <option value="Đã hết hạn">Đã hết hạn</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Đóng
              </button>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-2"></i>{{ isEditing ? 'Cập Nhật' : 'Lưu Tiêu Chí' }}
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
  name: 'TieuChiKPI',
  data() {
    return {
      searchQuery: '',
      filterLoaiTieuChi: '',
      filterTrangThai: '',
      filterPhongBan: '',
      danhSachTieuChi: [
        {
          id: 1,
          maTieuChi: 'KPI001',
          tenTieuChi: 'Doanh số bán hàng',
          loaiTieuChi: 'Định lượng',
          maPhongBan: 'PB004',
          donViDo: 'Triệu đồng',
          trongSo: 30,
          mucTieuToiThieu: 100,
          mucTieuToiDa: 200,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Tổng doanh số bán hàng đạt được trong tháng',
          cachTinhDiem: 'Doanh số đạt 100 triệu: 70 điểm, mỗi 10 triệu tăng thêm: +3 điểm, tối đa 100 điểm',
          trangThai: 'Đang áp dụng'
        },
        {
          id: 2,
          maTieuChi: 'KPI002',
          tenTieuChi: 'Tỷ lệ chuyển đổi khách hàng',
          loaiTieuChi: 'Định lượng',
          maPhongBan: 'PB004',
          donViDo: '%',
          trongSo: 20,
          mucTieuToiThieu: 15,
          mucTieuToiDa: 30,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Tỷ lệ khách hàng tiềm năng chuyển đổi thành khách hàng thực tế',
          cachTinhDiem: 'Tỷ lệ đạt 15%: 70 điểm, mỗi 1% tăng thêm: +2 điểm, tối đa 100 điểm',
          trangThai: 'Đang áp dụng'
        },
        {
          id: 3,
          maTieuChi: 'KPI003',
          tenTieuChi: 'Chất lượng code',
          loaiTieuChi: 'Định tính',
          maPhongBan: 'PB003',
          donViDo: 'Điểm',
          trongSo: 25,
          mucTieuToiThieu: 7,
          mucTieuToiDa: 10,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Đánh giá chất lượng code dựa trên các tiêu chí: rõ ràng, dễ bảo trì, hiệu suất, tuân thủ quy chuẩn',
          cachTinhDiem: 'Đánh giá theo thang điểm 10, điểm đạt được x 10 = số điểm KPI',
          trangThai: 'Đang áp dụng'
        },
        {
          id: 4,
          maTieuChi: 'KPI004',
          tenTieuChi: 'Số lượng bug',
          loaiTieuChi: 'Định lượng',
          maPhongBan: 'PB003',
          donViDo: 'Lỗi',
          trongSo: 15,
          mucTieuToiThieu: 0,
          mucTieuToiDa: 5,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Số lượng lỗi được phát hiện sau khi triển khai sản phẩm',
          cachTinhDiem: '0 lỗi: 100 điểm, 1-2 lỗi: 90 điểm, 3-5 lỗi: 80 điểm, 6-10 lỗi: 60 điểm, >10 lỗi: 0 điểm',
          trangThai: 'Đang áp dụng'
        },
        {
          id: 5,
          maTieuChi: 'KPI005',
          tenTieuChi: 'Tuân thủ quy trình',
          loaiTieuChi: 'Định tính',
          maPhongBan: 'PB001',
          donViDo: 'Điểm',
          trongSo: 15,
          mucTieuToiThieu: 8,
          mucTieuToiDa: 10,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Đánh giá mức độ tuân thủ quy trình làm việc của công ty',
          cachTinhDiem: 'Đánh giá theo thang điểm 10, điểm đạt được x 10 = số điểm KPI',
          trangThai: 'Đang áp dụng'
        },
        {
          id: 6,
          maTieuChi: 'KPI006',
          tenTieuChi: 'Sáng kiến cải tiến',
          loaiTieuChi: 'Hỗn hợp',
          maPhongBan: 'PB003',
          donViDo: 'Sáng kiến',
          trongSo: 10,
          mucTieuToiThieu: 1,
          mucTieuToiDa: 5,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Số lượng và chất lượng sáng kiến cải tiến quy trình làm việc',
          cachTinhDiem: '1 sáng kiến: 70 điểm, mỗi sáng kiến thêm: +10 điểm, chất lượng sáng kiến: +0-20 điểm',
          trangThai: 'Đang áp dụng'
        },
        {
          id: 7,
          maTieuChi: 'KPI007',
          tenTieuChi: 'Đào tạo nhân viên mới',
          loaiTieuChi: 'Hỗn hợp',
          maPhongBan: 'PB001',
          donViDo: 'Nhân viên',
          trongSo: 10,
          mucTieuToiThieu: 1,
          mucTieuToiDa: 3,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-06-30',
          moTa: 'Số lượng nhân viên mới được đào tạo và chất lượng đào tạo',
          cachTinhDiem: '1 nhân viên: 80 điểm, mỗi nhân viên thêm: +10 điểm, đánh giá chất lượng: +0-10 điểm',
          trangThai: 'Tạm ngưng'
        },
        {
          id: 8,
          maTieuChi: 'KPI008',
          tenTieuChi: 'Tiết kiệm chi phí',
          loaiTieuChi: 'Định lượng',
          maPhongBan: 'PB002',
          donViDo: '%',
          trongSo: 20,
          mucTieuToiThieu: 5,
          mucTieuToiDa: 15,
          ngayBatDau: '2023-01-01',
          ngayKetThuc: '2023-12-31',
          moTa: 'Phần trăm tiết kiệm chi phí so với ngân sách được phê duyệt',
          cachTinhDiem: 'Tiết kiệm 5%: 70 điểm, mỗi 1% tiết kiệm thêm: +3 điểm, tối đa 100 điểm',
          trangThai: 'Đang áp dụng'
        }
      ],
      danhSachPhongBan: [
        { maPhongBan: 'PB001', tenPhongBan: 'Phòng Nhân sự' },
        { maPhongBan: 'PB002', tenPhongBan: 'Phòng Kế toán' },
        { maPhongBan: 'PB003', tenPhongBan: 'Phòng Kỹ thuật' },
        { maPhongBan: 'PB004', tenPhongBan: 'Phòng Kinh doanh' }
      ],
      formData: {
        maTieuChi: '',
        tenTieuChi: '',
        loaiTieuChi: '',
        maPhongBan: '',
        donViDo: '',
        trongSo: 0,
        mucTieuToiThieu: 0,
        mucTieuToiDa: 0,
        ngayBatDau: '',
        ngayKetThuc: '',
        moTa: '',
        cachTinhDiem: '',
        trangThai: 'Đang áp dụng'
      },
      isEditing: false,
      modalInstance: null
    }
  },
  computed: {
    filteredItems() {
      let result = [...this.danhSachTieuChi]
      
      // Tìm kiếm
      if (this.searchQuery) {
        const query = this.searchQuery.toLowerCase()
        result = result.filter(item => {
          return item.tenTieuChi.toLowerCase().includes(query) ||
                 item.maTieuChi.toLowerCase().includes(query) ||
                 this.getPhongBanName(item.maPhongBan).toLowerCase().includes(query)
        })
      }
      
      // Lọc theo loại tiêu chí
      if (this.filterLoaiTieuChi) {
        result = result.filter(item => item.loaiTieuChi === this.filterLoaiTieuChi)
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
    getPhongBanName(maPhongBan) {
      const phongBan = this.danhSachPhongBan.find(pb => pb.maPhongBan === maPhongBan)
      return phongBan ? phongBan.tenPhongBan : maPhongBan
    },
    getStatusClass(status) {
      switch (status) {
        case 'Đang áp dụng': return 'bg-gradient-success'
        case 'Tạm ngưng': return 'bg-gradient-warning'
        case 'Đã hết hạn': return 'bg-gradient-danger'
        default: return 'bg-gradient-secondary'
      }
    },
    countByType(type) {
      return this.danhSachTieuChi.filter(item => item.loaiTieuChi === type).length
    },
    countByStatus(status) {
      return this.danhSachTieuChi.filter(item => item.trangThai === status).length
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
        loaiTieuChi: '',
        maPhongBan: '',
        donViDo: '',
        trongSo: 0,
        mucTieuToiThieu: 0,
        mucTieuToiDa: 0,
        ngayBatDau: '',
        ngayKetThuc: '',
        moTa: '',
        cachTinhDiem: '',
        trangThai: 'Đang áp dụng'
      }
    },
    validateDateRange() {
      if (this.formData.ngayBatDau && this.formData.ngayKetThuc) {
        const startDate = new Date(this.formData.ngayBatDau)
        const endDate = new Date(this.formData.ngayKetThuc)
        
        if (startDate > endDate) {
          alert('Ngày bắt đầu không thể sau ngày kết thúc!')
          this.formData.ngayKetThuc = this.formData.ngayBatDau
          return false
        }
      }
      return true
    },
    validateTargetRange() {
      if (this.formData.mucTieuToiThieu > this.formData.mucTieuToiDa) {
        alert('Mục tiêu tối thiểu không thể lớn hơn mục tiêu tối đa!')
        this.formData.mucTieuToiDa = this.formData.mucTieuToiThieu
        return false
      }
      return true
    },
    submitForm() {
      try {
        // Kiểm tra ngày
        if (!this.validateDateRange()) {
          return
        }
        
        // Kiểm tra mục tiêu
        if (!this.validateTargetRange()) {
          return
        }
        
        // Kiểm tra trọng số
        if (this.formData.trongSo < 0 || this.formData.trongSo > 100) {
          alert('Trọng số phải nằm trong khoảng từ 0 đến 100!')
          return
        }
        
        // Kiểm tra trùng mã tiêu chí
        if (!this.isEditing) {
          const existingTieuChi = this.danhSachTieuChi.find(
            tc => tc.maTieuChi === this.formData.maTieuChi
          )
          
          if (existingTieuChi) {
            alert('Mã tiêu chí này đã tồn tại trong hệ thống!')
            return
          }
        }
        
        if (this.isEditing) {
          // Cập nhật tiêu chí
          const index = this.danhSachTieuChi.findIndex(item => item.id === this.formData.id)
          if (index !== -1) {
            this.danhSachTieuChi[index] = { ...this.formData }
            this.showNotification('Đã cập nhật tiêu chí KPI thành công!', 'success')
          }
        } else {
          // Tạo tiêu chí mới
          const newId = Math.max(...this.danhSachTieuChi.map(item => item.id), 0) + 1
          
          this.danhSachTieuChi.push({
            id: newId,
            maTieuChi: this.formData.maTieuChi,
            tenTieuChi: this.formData.tenTieuChi,
            loaiTieuChi: this.formData.loaiTieuChi,
            maPhongBan: this.formData.maPhongBan,
            donViDo: this.formData.donViDo,
            trongSo: this.formData.trongSo,
            mucTieuToiThieu: this.formData.mucTieuToiThieu,
            mucTieuToiDa: this.formData.mucTieuToiDa,
            ngayBatDau: this.formData.ngayBatDau,
            ngayKetThuc: this.formData.ngayKetThuc,
            moTa: this.formData.moTa,
            cachTinhDiem: this.formData.cachTinhDiem,
            trangThai: 'Đang áp dụng'
          })
          
          this.showNotification('Đã thêm tiêu chí KPI mới thành công!', 'success')
        }
        
        this.modalInstance.hide()
      } catch (error) {
        console.error('Lỗi khi lưu:', error)
        this.showNotification('Có lỗi xảy ra khi lưu tiêu chí KPI!', 'danger')
      }
    },
    xemChiTiet(item) {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('tieuChiModal'))
      }
      this.isEditing = true
      this.formData = { ...item }
      this.modalInstance.show()
    },
    capNhatTieuChi(item) {
      if (!this.modalInstance) {
        this.modalInstance = new Modal(document.getElementById('tieuChiModal'))
      }
      this.isEditing = true
      this.formData = { ...item }
      this.modalInstance.show()
    },
    xoaTieuChi(id) {
      if (confirm('Bạn có chắc chắn muốn xóa tiêu chí KPI này?')) {
        const index = this.danhSachTieuChi.findIndex(item => item.id === id)
        if (index !== -1) {
          this.danhSachTieuChi.splice(index, 1)
          this.showNotification('Đã xóa tiêu chí KPI thành công!', 'success')
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
    checkExpiringKPIs() {
      // Kiểm tra các tiêu chí sắp hết hạn
      const today = new Date()
      today.setHours(0, 0, 0, 0)
      
      this.danhSachTieuChi.forEach(item => {
        const endDate = new Date(item.ngayKetThuc)
        endDate.setHours(0, 0, 0, 0)
        
        if (endDate < today && item.trangThai !== 'Đã hết hạn') {
          // Đã hết hạn
          item.trangThai = 'Đã hết hạn'
        }
      })
    }
  },
  mounted() {
    // Khởi tạo Bootstrap Modal
    this.modalInstance = new Modal(document.getElementById('tieuChiModal'))
    
    // Kiểm tra tiêu chí hết hạn
    this.checkExpiringKPIs()
  },
  beforeUnmount() {
    // Dọn dẹp modal nếu cần
    if (this.modalInstance) {
      this.modalInstance.dispose()
    }
  },
  watch: {
    'formData.ngayBatDau'() {
      this.validateDateRange()
    },
    'formData.ngayKetThuc'() {
      this.validateDateRange()
    },
    'formData.mucTieuToiThieu'() {
      this.validateTargetRange()
    },
    'formData.mucTieuToiDa'() {
      this.validateTargetRange()
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