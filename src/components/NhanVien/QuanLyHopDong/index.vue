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
              <div class="table-responsive p-4 shadow-sm rounded-lg bg-white">
                <div class="d-flex justify-content-between align-items-center mb-4">
                  <h6 class="text-dark mb-0 font-weight-bold">
                    <i class="fas fa-list-ul me-2"></i>Danh sách hợp đồng
                  </h6>
                </div>
                <table class="table custom-table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase">Mã HĐ</th>
                      <th class="text-uppercase">Nhân viên</th>
                      <th class="text-uppercase">Loại HĐ</th>
                      <th class="text-uppercase">Thời hạn</th>
                      <th class="text-uppercase">Lương cơ bản</th>
                      <th class="text-uppercase">Trạng thái</th>
                      <th class="text-uppercase text-center">Thao tác</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(item, index) in danhSachHopDong" :key="item.id_hop_dong">
                      <td>
                        <div class="d-flex align-items-center">
                          <div class="icon-circle bg-light-primary me-3">
                            <i class="fas fa-file-contract text-primary"></i>
                          </div>
                          <span class="text-sm font-weight-bold">#{{ index + 1 }}</span>
                        </div>
                      </td>
                      <td>
                        <div class="d-flex align-items-center">
                          <div class="avatar avatar-xs me-2 bg-gradient-primary rounded-circle">
                            <span class="text-white text-xs">{{ item.id_nhan_vien }}</span>
                          </div>
                          <h6 class="mb-0 text-sm">{{ item.id_nhan_vien }}</h6>
                        </div>
                      </td>
                      <td>
                        <span class="contract-type">
                          {{
                            item.loai_hop_dong == 0 ? 'Xác định thời hạn' : item.loai_hop_dong == 1
                              ? 'Không xác định thời hạn' : item.loai_hop_dong == 2 ? 'Thử việc' : item.loai_hop_dong == 3
                                ? 'Thời vụ' : ''
                          }}
                        </span>
                      </td>
                      <td>
                        <div class="d-flex align-items-center">
                          <i class="fas fa-calendar-alt text-info me-2"></i>
                          <span class="text-sm">{{ formatDate(item.ngay_bat_dau) }} - {{
                            item.ngay_ket_thuc ? formatDate(item.ngay_ket_thuc) : 'Không xác định' }}</span>
                        </div>
                      </td>
                      <td>
                        <div class="d-flex align-items-center">
                          <i class="fas fa-money-bill-wave text-success me-2"></i>
                          <span class="text-sm font-weight-bold">{{ formatCurrency(item.luong_co_ban) }}</span>
                        </div>
                      </td>
                      <td>
                        <span class="badge" :class="{
                          'badge-success': item.trang_thai == 0,
                          'badge-warning': item.trang_thai == 1,
                          'badge-danger': item.trang_thai == 2,
                          'badge-secondary': item.trang_thai == 3
                        }">
                          <i class="fas" :class="{
                            'fa-check-circle': item.trang_thai == 0,
                            'fa-exclamation-circle': item.trang_thai == 1,
                            'fa-times-circle': item.trang_thai == 2,
                            'fa-ban': item.trang_thai == 3
                          }"></i>
                          {{
                            item.trang_thai == 0 ? 'Đang hiệu lực' : item.trang_thai == 1
                              ? 'Sắp hết hạn' : item.trang_thai == 2 ? 'Đã hết hạn' : item.trang_thai == 3 ? 'Đã hủy' : ''
                          }}
                        </span>
                      </td>
                      <td class="align-middle text-center">
                        <div class="action-buttons">
                          <button class="btn btn-link action-btn" data-bs-toggle="modal"
                            v-on:click="Object.assign(update_hop_dong, item)" data-bs-target="#exampleModal2"
                            title="Cập nhật">
                            <i class="fas fa-edit"></i>
                          </button>
                          <button class="btn btn-link action-btn text-danger" data-bs-toggle="modal"
                            data-bs-target="#deleteHopDongModal" @click="Object.assign(delete_hop_dong, item)"
                            title="Hủy hợp đồng" :disabled="item.trang_thai === 'Đã hủy'">
                            <i class="fas fa-trash-alt"></i>
                          </button>
                        </div>
                      </td>
                    </tr>
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
          <div class="modal-header">
            <div class="modal-title-wrapper">
              <div class="modal-icon bg-gradient-primary">
                <i class="fas fa-file-contract text-white"></i>
              </div>
              <h5 class="modal-title">
                Thêm hợp đồng mới
              </h5>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form @submit.prevent="submitForm">
            <div class="modal-body">
              <div class="form-section mb-4">
                <h6 class="form-section-title">
                  <i class="fas fa-info-circle me-2"></i>Thông tin hợp đồng
                </h6>
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Loại Hợp Đồng</label>
                      <div class="input-group input-group-dynamic">
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
                      <label class="form-control-label">Lương Cơ Bản</label>
                      <div class="input-group input-group-dynamic">
                        <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                        <input type="number" class="form-control" v-model="create_hop_dong.luong_co_ban"
                          placeholder="Nhập lương cơ bản" min="0">
                        <span class="input-group-text currency-suffix">VNĐ</span>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Ngày Bắt Đầu</label>
                      <div class="input-group input-group-dynamic">
                        <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
                        <input type="date" class="form-control" v-model="create_hop_dong.ngay_bat_dau">
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Ngày Kết Thúc</label>
                      <div class="input-group input-group-dynamic">
                        <span class="input-group-text"><i class="fas fa-calendar-times"></i></span>
                        <input type="date" class="form-control" v-model="create_hop_dong.ngay_ket_thuc">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Trạng Thái</label>
                      <div class="input-group input-group-dynamic">
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
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Hủy
              </button>
              <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" v-on:click="createHopDong">
                <i class="fas fa-save me-2"></i>Lưu hợp đồng
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Modal Cập Nhật  -->
    <div class="modal fade" id="exampleModal2" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <div class="modal-title-wrapper">
              <div class="modal-icon bg-gradient-warning">
                <i class="fas fa-edit text-white"></i>
              </div>
              <h5 class="modal-title">
                Cập nhật hợp đồng
              </h5>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form @submit.prevent="submitForm">
            <div class="modal-body">
              <div class="form-section mb-4">
                <h6 class="form-section-title">
                  <i class="fas fa-info-circle me-2"></i>Thông tin hợp đồng
                </h6>
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Loại Hợp Đồng</label>
                      <div class="input-group input-group-dynamic">
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
                      <label class="form-control-label">Lương Cơ Bản</label>
                      <div class="input-group input-group-dynamic">
                        <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                        <input type="number" class="form-control" v-model="update_hop_dong.luong_co_ban"
                          placeholder="Nhập lương cơ bản" min="0">
                        <span class="input-group-text currency-suffix">VNĐ</span>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Ngày Bắt Đầu</label>
                      <div class="input-group input-group-dynamic">
                        <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
                        <input type="date" class="form-control" v-model="update_hop_dong.ngay_bat_dau">
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Ngày Kết Thúc</label>
                      <div class="input-group input-group-dynamic">
                        <span class="input-group-text"><i class="fas fa-calendar-times"></i></span>
                        <input type="date" class="form-control" v-model="update_hop_dong.ngay_ket_thuc">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <div class="form-group mb-3">
                      <label class="form-control-label">Trạng Thái</label>
                      <div class="input-group input-group-dynamic">
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
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>Hủy
              </button>
              <button type="submit" class="btn btn-warning" data-bs-dismiss="modal" v-on:click="updateHopDong">
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
          <div class="modal-header border-0">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body pt-0 pb-4">
            <div class="text-center mb-4">
              <div class="icon-box-danger mb-4">
                <i class="fas fa-exclamation-triangle fa-4x text-danger"></i>
              </div>
              <h4 class="modal-title fw-bold">Bạn có chắc chắn muốn hủy?</h4>
              <p class="text-muted mt-3">Hành động này sẽ chuyển trạng thái hợp đồng sang "Đã hủy" và không thể hoàn
                tác.</p>
            </div>

            <div class="contract-info-card mb-4">
              <div class="contract-info-header">
                <i class="fas fa-file-contract me-2"></i>
                Thông tin hợp đồng
              </div>
              <div class="contract-info-body">
                <div class="info-item">
                  <span class="info-label">Mã hợp đồng:</span>
                  <span class="info-value">#{{ delete_hop_dong.id }}</span>
                </div>
                <div class="info-item" v-if="delete_hop_dong.id_nhan_vien">
                  <span class="info-label">Nhân viên:</span>
                  <span class="info-value">{{ delete_hop_dong.id_nhan_vien }}</span>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
              <i class="fas fa-arrow-left me-2"></i>Quay lại
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
  box-shadow: 0 10px 20px rgba(50, 50, 93, 0.15), 0 5px 15px rgba(0, 0, 0, 0.1);
  border-radius: 1rem;
  border: none;
  transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 25px rgba(50, 50, 93, 0.2), 0 10px 20px rgba(0, 0, 0, 0.15);
}

.card-header {
  background-color: #fff;
  padding: 1.5rem 1.5rem 1rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.card-header h5 {
  font-weight: 700;
  color: #344767;
  letter-spacing: -0.025rem;
}

.icon-shape {
  width: 56px;
  height: 56px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 0.75rem;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.table {
  border-collapse: separate;
  border-spacing: 0 8px;
  margin-top: -8px;
}

.table th {
  font-size: 0.65rem;
  font-weight: 700;
  padding: 1rem 1.5rem;
  text-transform: uppercase;
  letter-spacing: 0.05rem;
  background-color: #f8f9fa;
  color: #8898aa;
  border: none;
}

.table td {
  padding: 1rem 1.5rem;
  vertical-align: middle;
  background-color: white;
  border-top: 1px solid #f0f0f0;
  border-bottom: 1px solid #f0f0f0;
}

.table tr td:first-child {
  border-left: 1px solid #f0f0f0;
  border-top-left-radius: 0.5rem;
  border-bottom-left-radius: 0.5rem;
}

.table tr td:last-child {
  border-right: 1px solid #f0f0f0;
  border-top-right-radius: 0.5rem;
  border-bottom-right-radius: 0.5rem;
}

.badge {
  padding: 0.55em 0.9em;
  font-weight: 600;
  text-transform: uppercase;
  font-size: 0.65rem;
  border-radius: 0.5rem;
  letter-spacing: 0.05rem;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.form-control,
.form-select {
  border-radius: 0.5rem;
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  border: 1px solid #e9ecef;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  transition: all 0.2s ease;
}

.form-control:focus,
.form-select:focus {
  border-color: #5e72e4;
  box-shadow: 0 0 0 3px rgba(94, 114, 228, 0.15);
}

.input-group-text {
  border-radius: 0.5rem 0 0 0.5rem;
  padding: 0.75rem 1rem;
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  color: #8898aa;
}

.modal-content {
  border-radius: 1rem;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
}

.modal-header {
  padding: 1.25rem 1.5rem;
}

.modal-body {
  padding: 1.5rem;
}

.modal-footer {
  padding: 1rem 1.5rem;
  background-color: #f8f9fa;
}

.btn {
  box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
  border-radius: 0.5rem;
  padding: 0.6rem 1.2rem;
  font-weight: 600;
  transition: all 0.2s ease;
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
}

.btn-success {
  background: linear-gradient(310deg, #2dce89, #2dcecc);
  border: none;
}

.btn-primary {
  background: linear-gradient(310deg, #5e72e4, #825ee4);
  border: none;
}

.btn-danger {
  background: linear-gradient(310deg, #f5365c, #f56036);
  border: none;
}

.btn-outline-secondary {
  border: 1px solid #cbd3da;
  color: #6c757d;
}

.btn-link {
  padding: 0.5rem;
  border-radius: 0.5rem;
  transition: all 0.2s;
}

.btn-link:hover {
  background-color: rgba(0, 0, 0, 0.05);
  transform: translateY(0);
}

.bg-gradient-success {
  background: linear-gradient(310deg, #2dce89, #2dcecc) !important;
}

.bg-gradient-warning {
  background: linear-gradient(310deg, #fb6340, #fbb140) !important;
}

.bg-gradient-danger {
  background: linear-gradient(310deg, #f5365c, #f56036) !important;
}

.bg-gradient-secondary {
  background: linear-gradient(310deg, #8898aa, #888aaa) !important;
}

.bg-gradient-primary {
  background: linear-gradient(310deg, #5e72e4, #825ee4) !important;
}

.text-xs {
  font-size: 0.75rem !important;
  letter-spacing: 0.025rem;
}

.text-sm {
  font-size: 0.875rem !important;
  letter-spacing: 0.025rem;
}

/* Status badges */
.badge-success {
  background-color: rgba(45, 206, 137, 0.1);
  color: #2dce89 !important;
  border: 1px solid rgba(45, 206, 137, 0.2);
}

.badge-warning {
  background-color: rgba(251, 99, 64, 0.1);
  color: #fb6340 !important;
  border: 1px solid rgba(251, 99, 64, 0.2);
}

.badge-danger {
  background-color: rgba(245, 54, 92, 0.1);
  color: #f5365c !important;
  border: 1px solid rgba(245, 54, 92, 0.2);
}

.badge-secondary {
  background-color: rgba(136, 152, 170, 0.1);
  color: #8898aa !important;
  border: 1px solid rgba(136, 152, 170, 0.2);
}

.icon-box {
  width: 80px;
  height: 80px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: rgba(251, 99, 64, 0.1);
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .icon-shape {
    width: 44px;
    height: 44px;
  }

  .table-responsive {
    border-radius: 0.75rem;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
  }

  .card-header {
    padding: 1.25rem 1.25rem 0.75rem;
  }

  .table th,
  .table td {
    padding: 0.75rem 1rem;
  }
}

/* Thêm style mới cho bảng */
.custom-table {
  border-collapse: separate;
  border-spacing: 0 12px;
  margin-top: -12px;
}

.custom-table th {
  background-color: transparent;
  border: none;
  color: #8898aa;
  font-size: 0.7rem;
  padding: 0.75rem 1.5rem;
  letter-spacing: 0.05em;
  font-weight: 700;
}

.custom-table tbody tr {
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
  transition: all 0.2s;
  border-radius: 0.5rem;
}

.custom-table tbody tr:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.custom-table td {
  background-color: white;
  padding: 1rem 1.5rem;
  border: none;
  vertical-align: middle;
}

.custom-table tr td:first-child {
  border-top-left-radius: 0.5rem;
  border-bottom-left-radius: 0.5rem;
}

.custom-table tr td:last-child {
  border-top-right-radius: 0.5rem;
  border-bottom-right-radius: 0.5rem;
}

.contract-type {
  font-size: 0.8rem;
  font-weight: 600;
}

.icon-circle {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.bg-light-primary {
  background-color: rgba(94, 114, 228, 0.1);
}

.action-buttons {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
}

.action-btn {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 0.5rem;
  padding: 0;
  transition: all 0.2s;
}

.action-btn:hover {
  background-color: #f8f9fa;
}

.search-bar {
  max-width: 300px;
}

/* Avatar */
.avatar {
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Modal customization */
.modal-title-wrapper {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.modal-icon {
  width: 42px;
  height: 42px;
  border-radius: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.form-section-title {
  font-weight: 600;
  color: #344767;
  margin-bottom: 1.25rem;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.form-control-label {
  font-size: 0.875rem;
  font-weight: 600;
  color: #344767;
  margin-bottom: 0.5rem;
}

.input-group-dynamic {
  transition: all 0.2s ease;
}

.input-group-dynamic:focus-within {
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
}

.currency-suffix {
  border-radius: 0 0.5rem 0.5rem 0;
  background-color: #f8f9fa;
}

/* Contract info card in delete modal */
.contract-info-card {
  border-radius: 0.75rem;
  overflow: hidden;
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.contract-info-header {
  background-color: #f8f9fa;
  padding: 0.75rem 1rem;
  font-weight: 600;
  font-size: 0.875rem;
  color: #344767;
}

.contract-info-body {
  padding: 1rem;
}

.info-item {
  display: flex;
  margin-bottom: 0.5rem;
}

.info-label {
  font-size: 0.875rem;
  color: #8898aa;
  width: 120px;
}

.info-value {
  font-size: 0.875rem;
  font-weight: 600;
  color: #344767;
}

.icon-box-danger {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  background-color: rgba(245, 54, 92, 0.1);
}
</style>