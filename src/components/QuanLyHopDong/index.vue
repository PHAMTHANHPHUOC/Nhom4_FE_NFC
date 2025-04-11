<template>
  <div class="container-fluid py-4">
    <div class="row">
      <div class="col-12">
        <div class="card mb-4">
          <div class="card-header pb-0">
            <div class="row">
              <div class="col-lg-6">
                <h5 class="mb-0">Quản lý hợp đồng</h5>
              </div>
              <div class="col-lg-6 text-end">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  <i class="fas fa-plus me-2"></i>Thêm hợp đồng
                </button>
              </div>
            </div>
          </div>
          <div class="card-body px-0 pt-0 pb-2">
            <div class="px-4">
              <!-- Bộ lọc -->
              <div class="row mb-4 mt-3">
                <div class="col-md-4 mb-3">
                  <div class="form-group">
                    <label class="form-control-label mb-2">Tìm kiếm</label>
                    <input type="text" class="form-control" v-model="searchQuery"
                      placeholder="Tìm kiếm theo mã hợp đồng, tên nhân viên...">
                  </div>
                </div>
                <div class="col-md-4 mb-3">
                  <div class="form-group">
                    <label class="form-control-label mb-2">Loại hợp đồng</label>
                    <select class="form-select" v-model="filterLoaiHopDong">
                      <option value="">Tất cả loại hợp đồng</option>
                      <option value="Xác định thời hạn">Xác định thời hạn</option>
                      <option value="Không xác định thời hạn">Không xác định thời hạn</option>
                      <option value="Thử việc">Thử việc</option>
                      <option value="Thời vụ">Thời vụ</option>
                    </select>
                  </div>
                </div>
                <div class="col-md-4 mb-3">
                  <div class="form-group">
                    <label class="form-control-label mb-2">Trạng thái</label>
                    <select class="form-select" v-model="filterTrangThai">
                      <option value="">Tất cả trạng thái</option>
                      <option value="Đang hiệu lực">Đang hiệu lực</option>
                      <option value="Sắp hết hạn">Sắp hết hạn</option>
                      <option value="Đã hết hạn">Đã hết hạn</option>
                      <option value="Đã hủy">Đã hủy</option>
                    </select>
                  </div>
                </div>
              </div>

              <!-- Thống kê -->
              <!-- <div class="row mb-4">
                <div class="col-md-3 col-sm-6 mb-3">
                  <div class="card bg-gradient-primary">
                    <div class="card-body p-3">
                      <div class="row">
                        <div class="col-8">
                          <div class="numbers">
                            <p class="text-sm mb-0 text-white font-weight-bold">Tổng hợp đồng</p>
                            <h5 class="font-weight-bolder text-white mb-0">
                              {{ danhSachHopDong.length }}
                            </h5>
                          </div>
                        </div>
                        <div class="col-4 text-end">
                          <div class="icon-shape bg-white shadow text-center border-radius-md">
                            <i class="fas fa-file-contract text-primary opacity-10"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                  <div class="card bg-gradient-success">
                    <div class="card-body p-3">
                      <div class="row">
                        <div class="col-8">
                          <div class="numbers">
                            <p class="text-sm mb-0 text-white font-weight-bold">Đang hiệu lực</p>
                            <h5 class="font-weight-bolder text-white mb-0">
                              {{ countByStatus('Đang hiệu lực') }}
                            </h5>
                          </div>
                        </div>
                        <div class="col-4 text-end">
                          <div class="icon-shape bg-white shadow text-center border-radius-md">
                            <i class="fas fa-check-circle text-success opacity-10"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                  <div class="card bg-gradient-warning">
                    <div class="card-body p-3">
                      <div class="row">
                        <div class="col-8">
                          <div class="numbers">
                            <p class="text-sm mb-0 text-white font-weight-bold">Sắp hết hạn</p>
                            <h5 class="font-weight-bolder text-white mb-0">
                              {{ countByStatus('Sắp hết hạn') }}
                            </h5>
                          </div>
                        </div>
                        <div class="col-4 text-end">
                          <div class="icon-shape bg-white shadow text-center border-radius-md">
                            <i class="fas fa-exclamation-circle text-warning opacity-10"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                  <div class="card bg-gradient-danger">
                    <div class="card-body p-3">
                      <div class="row">
                        <div class="col-8">
                          <div class="numbers">
                            <p class="text-sm mb-0 text-white font-weight-bold">Đã hết hạn</p>
                            <h5 class="font-weight-bolder text-white mb-0">
                              {{ countByStatus('Đã hết hạn') }}
                            </h5>
                          </div>
                        </div>
                        <div class="col-4 text-end">
                          <div class="icon-shape bg-white shadow text-center border-radius-md">
                            <i class="fas fa-times-circle text-danger opacity-10"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div> -->

              <!-- Bảng dữ liệu -->
              <div class="table-responsive">
                <table class="table table-hover align-items text-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Mã HĐ</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nhân viên
                      </th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Loại HĐ</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Thời hạn</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Lương cơ bản
                      </th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Trạng thái
                      </th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 text-center">Thao
                        tác</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(item, index) in danhSachHopDong" :key="item.id_hop_dong">
                      <td>
                        <p class="text-xs font-weight-bold mb-0 ps-3">{{ index + 1 }}</p>
                      </td>
                      <td>
                        <div class="d-flex px-2 py-1 justify-content-center align-items-center">
                          <h6 class="mb-0 text-sm text-center">{{ item.id_nhan_vien }}</h6>
                        </div>
                      </td>
                      <td>
                        <p class="text-xs font-weight-bold mb-0">{{
                          item.loai_hop_dong == 0 ? 'Xác định thời hạn' : item.loai_hop_dong == 1
                            ? 'Không xác định thời hạn' : item.loai_hop_dong == 2 ? 'Thử việc' : item.loai_hop_dong == 3
                              ? 'Thời vụ' : ''
                        }}</p>
                      </td>
                      <td>
                        <p class="text-xs font-weight-bold mb-0">{{ formatDate(item.ngay_bat_dau) }} - {{
                          item.ngay_ket_thuc ? formatDate(item.ngay_ket_thuc) : 'Không xác định' }}</p>
                      </td>
                      <td>
                        <p class="text-xs font-weight-bold mb-0">{{ formatCurrency(item.luong_co_ban) }}</p>
                      </td>
                      <td>
                        <span class="badge badge-sm text-dark" :class="getStatusClass(item.trang_thai)">{{
                          item.trang_thai == 0 ? 'Đang hiệu lực' : item.trang_thai == 1
                            ? 'Sắp hết hạn' : item.trang_thai == 2 ? 'Đã hết hạn' : item.trang_thai == 3 ? 'Đã hủy' : ''
                        }}</span>
                      </td>
                      <td class="align-middle text-center">
                        <button class="btn btn-link text-secondary mb-0" @click="xemChiTiet(item)" title="Xem chi tiết">
                          <i class="fas fa-eye text-xs"></i>
                        </button>
                        <button class="btn btn-link text-secondary mb-0" data-bs-toggle="modal"
                          v-on:click="Object.assign(update_hop_dong, item)" data-bs-target="#exampleModal2"
                          title="Cập nhật">
                          <i class="fas fa-edit text-xs"></i>
                        </button>
                        <button class="btn btn-link text-danger mb-0" data-bs-toggle="modal"
                          data-bs-target="#deleteHopDongModal" @click="Object.assign(delete_hop_dong, item)"
                          title="Hủy hợp đồng" :disabled="item.trang_thai === 'Đã hủy'">
                          <i class="fas fa-trash-alt text-xs"></i>
                        </button>
                      </td>
                    </tr>
                    <!-- <tr v-if="danhSachHopDong.length === 0">
                      <td colspan="7" class="text-center py-4">
                        <div class="d-flex flex-column align-items-center">
                          <i class="fas fa-folder-open fa-3x text-secondary mb-2"></i>
                          <h6 class="text-secondary">Không có dữ liệu hợp đồng</h6>
                        </div>
                      </td>
                    </tr> -->
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Thêm -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-gradient-primary text-white">
            <h5 class="modal-title">
              <i class="fas fa-file-contract me-2"></i>
              Thêm hợp đồng
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form @submit.prevent="submitForm">
            <div class="modal-body">
              <div class="row">
                <div class="col-md-6">

                </div>
                <!-- <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Nhân Viên</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-user"></i></span>
                      <select class="form-select" v-model="formData.id_nhan_vien" :disabled="isViewOnly">
                        <option value="" disabled>Chọn nhân viên</option>
                        <option v-for="nv in danhSachNhanVien" :key="nv.id_nhan_vien" :value="nv.id_nhan_vien">
                          {{ nv.ho_va_ten }}
                        </option>
                      </select>
                    </div>
                  </div>
                </div> -->
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Loại Hợp Đồng</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-file-alt"></i></span>
                      <select class="form-select" v-model="create_hop_dong.loai_hop_dong">
                        <option value="" disabled>Chọn loại hợp đồng</option>
                        <option value="0">Xác định thời hạn</option>
                        <option value="1">Không xác định thời hạn</option>
                        <option value="2">Thử việc</option>
                        <option value="3">Thời vụ</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Lương Cơ Bản</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                      <input type="number" class="form-control" v-model="create_hop_dong.luong_co_ban"
                        placeholder="Nhập lương cơ bản" min="0">
                      <span class="input-group-text">VNĐ</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Ngày Bắt Đầu</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
                      <input type="date" class="form-control" v-model="create_hop_dong.ngay_bat_dau">
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Ngày Kết Thúc</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar-times"></i></span>
                      <input type="date" class="form-control" v-model="create_hop_dong.ngay_ket_thuc">
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-12">
                  <div class="form-group mb-3">
                    <label>Trạng Thái</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                      <select class="form-select" v-model="create_hop_dong.trang_thai" :disabled="isViewOnly">
                        <option value="" disabled>Chọn trạng thái</option>
                        <option value="0">Đang hiệu lực</option>
                        <option value="1">Sắp hết hạn</option>
                        <option value="2">Đã hết hạn</option>
                        <option value="3">Đã hủy</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Đóng
              </button>
              <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" v-on:click="createHopDong">
                <i class="fas fa-save me-2"></i>Lưu
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- Modal Xem Chi Tiết  -->

    <!-- Modal Sửa  -->
    <div class="modal fade" id="exampleModal2" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-gradient-primary text-white">
            <h5 class="modal-title">
              <i class="fas fa-file-contract me-2"></i>
              Cập nhật hợp đồng
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form @submit.prevent="submitForm">
            <div class="modal-body">
              <div class="row">
                <div class="col-md-6">

                </div>
                <!-- <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Nhân Viên</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-user"></i></span>
                      <select class="form-select" v-model="formData.id_nhan_vien" :disabled="isViewOnly">
                        <option value="" disabled>Chọn nhân viên</option>
                        <option v-for="nv in danhSachNhanVien" :key="nv.id_nhan_vien" :value="nv.id_nhan_vien">
                          {{ nv.ho_va_ten }}
                        </option>
                      </select>
                    </div>
                  </div>
                </div> -->
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Loại Hợp Đồng</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-file-alt"></i></span>
                      <select class="form-select" v-model="update_hop_dong.loai_hop_dong">
                        <option value="" disabled>Chọn loại hợp đồng</option>
                        <option value="0">Xác định thời hạn</option>
                        <option value="1">Không xác định thời hạn</option>
                        <option value="2">Thử việc</option>
                        <option value="3">Thời vụ</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Lương Cơ Bản</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                      <input type="number" class="form-control" v-model="update_hop_dong.luong_co_ban"
                        placeholder="Nhập lương cơ bản" min="0">
                      <span class="input-group-text">VNĐ</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Ngày Bắt Đầu</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
                      <input type="date" class="form-control" v-model="update_hop_dong.ngay_bat_dau">
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label>Ngày Kết Thúc</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-calendar-times"></i></span>
                      <input type="date" class="form-control" v-model="update_hop_dong.ngay_ket_thuc">
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-12">
                  <div class="form-group mb-3">
                    <label>Trạng Thái</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                      <select class="form-select" v-model="update_hop_dong.trang_thai" :disabled="isViewOnly">
                        <option value="" disabled>Chọn trạng thái</option>
                        <option value="0">Đang hiệu lực</option>
                        <option value="1">Sắp hết hạn</option>
                        <option value="2">Đã hết hạn</option>
                        <option value="3">Đã hủy</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Đóng
              </button>
              <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" v-on:click="updateHopDong">
                <i class="fas fa-save me-2"></i>Cập nhật
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- Modal Xóa  -->
    <div class="modal fade" id="deleteHopDongModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-gradient-danger text-white">
            <h5 class="modal-title">
              <i class="fas fa-trash-alt me-2"></i>
              Xác nhận hủy hợp đồng
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body py-4">
            <div class="text-center mb-4">
              <div class="icon-box mb-3">
                <i class="fas fa-exclamation-triangle fa-4x text-warning"></i>
              </div>
              <h4>Bạn có chắc chắn muốn hủy hợp đồng này?</h4>
              <p class="text-muted">Hành động này sẽ chuyển trạng thái hợp đồng sang "Đã hủy" và không thể hoàn tác.</p>
            </div>

            <div class="card border mb-3">
              <div class="card-body p-3">
                <div class="row">
                  <div class="col-md-6"></div>
                  <p class="text-sm mb-0">Mã hợp đồng:</p>
                  <h5 class="font-weight-bolder mb-0">{{ delete_hop_dong.id }}</h5>
                </div>
              </div>
            </div>


          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
              <i class="fas fa-times me-2"></i>Hủy bỏ
            </button>
            <button type="button" class="btn btn-danger" data-bs-dismiss="modal" @click="deleteHopDong">
              <i class="fas fa-trash-alt me-2"></i>Xác nhận hủy
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Modal } from 'bootstrap'
import axios from 'axios'
import baseRequest from "../../../core/baseRequest";
import { createToaster } from "@meforma/vue-toaster";
const toaster = createToaster({ position: "top-right" });

export default {
  name: 'QuanLyHopDong',
  data() {
    return {
      searchQuery: '',
      filterLoaiHopDong: '',
      filterTrangThai: '',
      isEditing: false,
      isViewOnly: false,
      selectedId: null,
      modalInstance: null,
      formData: {
        id_hop_dong: '',
        id_nhan_vien: '',
        loai_hop_dong: '',
        ngay_bat_dau: '',
        ngay_ket_thuc: '',
        luong_co_ban: 0,
        trang_thai: 'Đang hiệu lực'
      },
      create_hop_dong: {
        id_nhan_vien: '',
        loai_hop_dong: '',
        ngay_bat_dau: '',
        ngay_ket_thuc: '',
        luong_co_ban: 0,
        trang_thai: 0

      },
      update_hop_dong: {

      },
      delete_hop_dong: {

      },
      danhSachHopDong: [],
      danhSachNhanVien: []
    }
  },
  // computed: {
  //   filteredItems() {
  //     let result = [...this.danhSachHopDong]

  //     if (this.searchQuery) {
  //       const searchLower = this.searchQuery.toLowerCase()
  //       result = result.filter(item =>
  //         item.id_hop_dong.toString().includes(searchLower) ||
  //         item.ten_nhan_vien.toLowerCase().includes(searchLower)
  //       )
  //     }

  //     if (this.filterLoaiHopDong) {
  //       result = result.filter(item => item.loai_hop_dong === this.filterLoaiHopDong)
  //     }

  //     if (this.filterTrangThai) {
  //       result = result.filter(item => item.trang_thai === this.filterTrangThai)
  //     }

  //     return result
  //   }
  // },
  methods: {
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.toLocaleDateString('vi-VN')
    },

    formatCurrency(value) {
      if (!value) return '0 VNĐ'
      return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value)
    },

    getStatusClass(status) {
      switch (status) {
        case 'Đang hiệu lực': return 'bg-gradient-success'
        case 'Sắp hết hạn': return 'bg-gradient-warning'
        case 'Đã hết hạn': return 'bg-gradient-danger'
        case 'Đã hủy': return 'bg-gradient-secondary'
        default: return 'bg-gradient-info'
      }
    },

    countByStatus(status) {
      return this.danhSachHopDong.filter(item => item.trang_thai === status).length
    },


    loadHopDong() {
      baseRequest.get('get-quan-ly-hop-dong').then(response => {
        this.danhSachHopDong = response.data.data
        console.log(this.danhSachHopDong)
      })
    },
    createHopDong() {
      baseRequest
        .post('them-quan-ly-hop-dong', this.create_hop_dong)
        .then(response => {
          if (response.status === 201) {
            toaster.success(response.data.message)
            this.loadHopDong()
          } else {
            toaster.error("Thêm hợp đồng thất bại")
          }
        })
    },
    updateHopDong() {
      baseRequest.put('cap-nhat-quan-ly-hop-dong', this.update_hop_dong).then(response => {
        if (response.status === 200) {
          toaster.success(response.data.message)
          this.loadHopDong()
        } else {
          toaster.error("Cập nhật hợp đồng thất bại")
        }
      })
    },
    deleteHopDong() {
      baseRequest.delete(`xoa-quan-ly-hop-dong/${this.delete_hop_dong.id}`).then(response => {
        if (response.status === 200) {
          toaster.success(response.data.message)
          this.loadHopDong()
        } else {
          toaster.error("Xóa hợp đồng thất bại")
        }
      })
    }
  },
  mounted() {
    this.loadHopDong()
  }
}
</script>

<style scoped>
.card {
  box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08);
  border-radius: 0.75rem;
}

.icon-shape {
  width: 48px;
  height: 48px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 0.75rem;
}

.table th {
  font-size: 0.65rem;
  font-weight: 600;
  padding: 1rem;
}

.table td {
  padding: 0.75rem 1rem;
  vertical-align: middle;
}

.badge {
  padding: 0.55em 0.9em;
  font-weight: 600;
  text-transform: uppercase;
  font-size: 0.65rem;
  border-radius: 0.5rem;
}

.form-control,
.form-select {
  border-radius: 0.5rem;
  padding: 0.6rem 1rem;
  font-size: 0.875rem;
  border: 1px solid #dee2e6;
}

.input-group-text {
  border-radius: 0.5rem 0 0 0.5rem;
  padding: 0.6rem 1rem;
  background-color: #f8f9fa;
  border: 1px solid #dee2e6;
}

.modal-content {
  border-radius: 0.75rem;
  overflow: hidden;
}

.bg-gradient-success {
  background: linear-gradient(87deg, #2dce89 0, #2dcecc 100%) !important;
}

.bg-gradient-warning {
  background: linear-gradient(87deg, #fb6340 0, #fbb140 100%) !important;
}

.bg-gradient-danger {
  background: linear-gradient(87deg, #f5365c 0, #f56036 100%) !important;
}

.bg-gradient-secondary {
  background: linear-gradient(87deg, #8898aa 0, #888aaa 100%) !important;
}

.bg-gradient-primary {
  background: linear-gradient(87deg, #5e72e4 0, #825ee4 100%) !important;
}

.text-xs {
  font-size: 0.75rem !important;
}

.text-sm {
  font-size: 0.875rem !important;
}

@media (max-width: 768px) {
  .icon-shape {
    width: 40px;
    height: 40px;
  }

  .table-responsive {
    border-radius: 0.5rem;
  }
}
</style>