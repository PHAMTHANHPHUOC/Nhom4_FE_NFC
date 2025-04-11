<template>
    <div class="container-fluid py-4">
      <!-- Header -->
      <div class="row mb-4">
        <div class="col-12">
          <div class="card bg-primary text-white shadow">
            <div class="card-body p-4">
              <div class="d-flex align-items-center mb-2">
                <i class="fas fa-users-cog fa-2x me-3"></i>
                <h2 class="mb-0 text-white">Quản Lý Hồ Sơ Nhân Sự</h2>
              </div>
              <p class="mb-0">Quản lý thông tin nhân viên và hồ sơ nhân sự của công ty</p>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Controls -->
      <div class="row mb-4">
        <div class="col-md-4 mb-3 mb-md-0">
          <div class="input-group">
            <span class="input-group-text bg-white">
              <i class="fas fa-search text-primary"></i>
            </span>
            <input type="text" class="form-control" placeholder="Tìm kiếm nhân viên..." v-model="searchTerm">
          </div>
        </div>
        <div class="col-md-5 mb-3 mb-md-0">
          <div class="d-flex gap-3">
            <select class="form-select" v-model="filterDepartment">
              <option value="all">Tất cả phòng ban</option>
              <option v-for="dept in departments" :key="dept.id_phong_ban" :value="dept.id_phong_ban">
                {{ dept.ten_phong_ban }}
              </option>
            </select>
            <select class="form-select" v-model="filterStatus">
              <option value="all">Tất cả trạng thái</option>
              <option value="active">Đang làm việc</option>
              <option value="inactive">Đã nghỉ việc</option>
              <option value="probation">Thử việc</option>
            </select>
          </div>
        </div>
        <div class="col-md-3 text-md-end">
          <button class="btn btn-primary" @click="showAddModal">
            <i class="fas fa-plus-circle me-2"></i>Thêm nhân viên
          </button>
        </div>
      </div>
  
      <!-- Stats Cards -->
      <div class="row mb-4">
        <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
          <div class="card shadow-sm h-100">
            <div class="card-body p-3">
              <div class="d-flex align-items-center">
                <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                  <i class="fas fa-users text-primary fa-lg"></i>
                </div>
                <div>
                  <h3 class="mb-0">{{ employees.length }}</h3>
                  <p class="text-muted mb-0">Tổng nhân viên</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
          <div class="card shadow-sm h-100">
            <div class="card-body p-3">
              <div class="d-flex align-items-center">
                <div class="rounded-circle bg-success bg-opacity-10 p-3 me-3">
                  <i class="fas fa-user-check text-success fa-lg"></i>
                </div>
                <div>
                  <h3 class="mb-0">{{ activeEmployees }}</h3>
                  <p class="text-muted mb-0">Đang làm việc</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
          <div class="card shadow-sm h-100">
            <div class="card-body p-3">
              <div class="d-flex align-items-center">
                <div class="rounded-circle bg-warning bg-opacity-10 p-3 me-3">
                  <i class="fas fa-user-clock text-warning fa-lg"></i>
                </div>
                <div>
                  <h3 class="mb-0">{{ probationEmployees }}</h3>
                  <p class="text-muted mb-0">Đang thử việc</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3 col-sm-6">
          <div class="card shadow-sm h-100">
            <div class="card-body p-3">
              <div class="d-flex align-items-center">
                <div class="rounded-circle bg-danger bg-opacity-10 p-3 me-3">
                  <i class="fas fa-user-times text-danger fa-lg"></i>
                </div>
                <div>
                  <h3 class="mb-0">{{ inactiveEmployees }}</h3>
                  <p class="text-muted mb-0">Đã nghỉ việc</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Employee Table -->
      <div class="card shadow-sm mb-4">
        <div class="card-header bg-white py-3">
          <h5 class="mb-0">Danh sách nhân viên</h5>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover mb-0">
              <thead class="table-light">
                <tr>
                  <th>Mã NV</th>
                  <th>Họ và tên</th>
                  <th>Phòng ban</th>
                  <th>Chức danh</th>
                  <th>Ngày vào làm</th>
                  <th>Trạng thái</th>
                  <th class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="employee in filteredEmployees" :key="employee.id_nhan_vien">
                  <td class="fw-bold text-primary">{{ employee.id_nhan_vien }}</td>
                  <td>
                    <div class="d-flex align-items-center">
                      <img :src="employee.avatar || 'https://via.placeholder.com/40?text=User'" 
                           class="rounded-circle me-2" width="40" height="40" alt="Avatar">
                      <span>{{ employee.ho_ten }}</span>
                    </div>
                  </td>
                  <td>{{ employee.phong_ban }}</td>
                  <td>{{ employee.chuc_danh }}</td>
                  <td>{{ formatDate(employee.ngay_vao) }}</td>
                  <td>
                    <span :class="getStatusBadgeClass(employee.trang_thai)">
                      {{ getStatusText(employee.trang_thai) }}
                    </span>
                  </td>
                  <td>
                    <div class="d-flex justify-content-center gap-2">
                      <button class="btn btn-sm btn-outline-primary" @click="viewEmployee(employee)" title="Xem chi tiết">
                        <i class="fas fa-eye"></i>
                      </button>
                      <button class="btn btn-sm btn-outline-info" @click="editEmployee(employee)" title="Chỉnh sửa">
                        <i class="fas fa-edit"></i>
                      </button>
                      <button class="btn btn-sm btn-outline-danger" @click="confirmDelete(employee.id_nhan_vien)" title="Xóa">
                        <i class="fas fa-trash-alt"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr v-if="filteredEmployees.length === 0">
                  <td colspan="7" class="text-center py-4 text-muted">
                    <i class="fas fa-search fa-2x mb-3 d-block"></i>
                    <p>Không tìm thấy nhân viên nào</p>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
  
      <!-- Employee Detail Modal -->
      <div class="modal fade" id="detailModal" tabindex="-1" ref="detailModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content" v-if="selectedEmployee">
            <div class="modal-header bg-primary text-white">
              <h5 class="modal-title">Thông tin chi tiết nhân viên</h5>
              <button type="button" class="btn-close btn-close-white" @click="closeDetailModal"></button>
            </div>
            <div class="modal-body p-4">
              <div class="text-center mb-4">
                <img :src="selectedEmployee.avatar || 'https://via.placeholder.com/120?text=User'" 
                     class="rounded-circle border border-3 border-primary mb-3" width="120" height="120" alt="Avatar">
                <h4>{{ selectedEmployee.ho_ten }}</h4>
                <p class="text-muted mb-2">{{ selectedEmployee.chuc_danh }}</p>
                <span :class="getStatusBadgeClass(selectedEmployee.trang_thai)">
                  {{ getStatusText(selectedEmployee.trang_thai) }}
                </span>
              </div>
              
              <div class="card mb-3">
                <div class="card-header bg-light">
                  <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin cơ bản</h6>
                </div>
                <div class="card-body">
                  <div class="row mb-2">
                    <div class="col-5 text-muted">Mã nhân viên:</div>
                    <div class="col-7 fw-bold">{{ selectedEmployee.id_nhan_vien }}</div>
                  </div>
                  <div class="row mb-2">
                    <div class="col-5 text-muted">Phòng ban:</div>
                    <div class="col-7">{{ selectedEmployee.phong_ban }}</div>
                  </div>
                  <div class="row">
                    <div class="col-5 text-muted">Ngày vào làm:</div>
                    <div class="col-7">{{ formatDate(selectedEmployee.ngay_vao) }}</div>
                  </div>
                </div>
              </div>
              
              <div class="card">
                <div class="card-header bg-light">
                  <h6 class="mb-0"><i class="fas fa-address-card me-2"></i>Thông tin liên hệ</h6>
                </div>
                <div class="card-body">
                  <div class="row mb-2">
                    <div class="col-5 text-muted">Điện thoại:</div>
                    <div class="col-7">{{ selectedEmployee.dien_thoai || 'Chưa cập nhật' }}</div>
                  </div>
                  <div class="row">
                    <div class="col-5 text-muted">Email:</div>
                    <div class="col-7">{{ selectedEmployee.email || 'Chưa cập nhật' }}</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" @click="closeDetailModal">Đóng</button>
              <button type="button" class="btn btn-primary" @click="editFromDetail">
                <i class="fas fa-edit me-2"></i>Chỉnh sửa
              </button>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Employee Form Modal -->
      <div class="modal fade" id="formModal" tabindex="-1" ref="formModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header bg-primary text-white">
              <h5 class="modal-title">{{ isEditing ? 'Cập nhật thông tin nhân viên' : 'Thêm nhân viên mới' }}</h5>
              <button type="button" class="btn-close btn-close-white" @click="closeFormModal"></button>
            </div>
            <div class="modal-body p-4">
              <form @submit.prevent="submitForm">
                <div class="row mb-3">
                  <div class="col-md-6 mb-3 mb-md-0">
                    <label class="form-label">Mã nhân viên</label>
                    <input type="text" class="form-control" v-model="formData.id_nhan_vien" 
                           :disabled="isEditing" placeholder="Tự động tạo nếu để trống">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" v-model="formData.ho_ten" 
                           required placeholder="Nhập họ và tên">
                  </div>
                </div>
                
                <div class="row mb-3">
                  <div class="col-md-6 mb-3 mb-md-0">
                    <label class="form-label">Phòng ban <span class="text-danger">*</span></label>
                    <select class="form-select" v-model="formData.id_phong_ban" required>
                      <option value="" disabled>Chọn phòng ban</option>
                      <option v-for="dept in departments" :key="dept.id_phong_ban" :value="dept.id_phong_ban">
                        {{ dept.ten_phong_ban }}
                      </option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Chức danh <span class="text-danger">*</span></label>
                    <select class="form-select" v-model="formData.id_chuc_danh" required>
                      <option value="" disabled>Chọn chức danh</option>
                      <option v-for="position in positions" :key="position.id_chuc_danh" :value="position.id_chuc_danh">
                        {{ position.ten_chuc_danh }}
                      </option>
                    </select>
                  </div>
                </div>
                
                <div class="row mb-3">
                  <div class="col-md-6 mb-3 mb-md-0">
                    <label class="form-label">Điện thoại</label>
                    <input type="tel" class="form-control" v-model="formData.dien_thoai" 
                           placeholder="Nhập số điện thoại">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" v-model="formData.email" 
                           placeholder="Nhập địa chỉ email">
                  </div>
                </div>
                
                <div class="row mb-3">
                  <div class="col-md-6 mb-3 mb-md-0">
                    <label class="form-label">Ngày vào làm <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" v-model="formData.ngay_vao" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Trạng thái</label>
                    <select class="form-select" v-model="formData.trang_thai">
                      <option value="active">Đang làm việc</option>
                      <option value="inactive">Đã nghỉ việc</option>
                      <option value="probation">Thử việc</option>
                    </select>
                  </div>
                </div>
                
                <div class="mb-4">
                  <label class="form-label">Ảnh đại diện</label>
                  <input type="text" class="form-control" v-model="formData.avatar" 
                         placeholder="Nhập URL ảnh đại diện">
                </div>
                
                <div class="d-flex justify-content-end gap-2">
                  <button type="button" class="btn btn-outline-secondary" @click="closeFormModal">Hủy</button>
                  <button type="submit" class="btn btn-primary">
                    {{ isEditing ? 'Cập nhật' : 'Thêm mới' }}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { Modal } from 'bootstrap';
  
  export default {
    data() {
      return {
        employees: [
          {
            id_nhan_vien: 'NV001', ho_ten: 'Nguyễn Văn A', phong_ban: 'Phòng Kỹ Thuật',
            chuc_danh: 'Kỹ sư phần mềm', ngay_vao: '2020-03-01', trang_thai: 'active',
            dien_thoai: '0912345678', email: 'nguyenvana@example.com',
            avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
            id_phong_ban: 1, id_chuc_danh: 1
          },
          {
            id_nhan_vien: 'NV002', ho_ten: 'Trần Thị B', phong_ban: 'Phòng Nhân Sự',
            chuc_danh: 'Chuyên viên nhân sự', ngay_vao: '2019-06-15', trang_thai: 'active',
            dien_thoai: '0987654321', email: 'tranthib@example.com',
            avatar: 'https://randomuser.me/api/portraits/women/2.jpg',
            id_phong_ban: 2, id_chuc_danh: 2
          },
          {
            id_nhan_vien: 'NV003', ho_ten: 'Lê Văn C', phong_ban: 'Phòng Kế Toán',
            chuc_danh: 'Kế toán viên', ngay_vao: '2021-01-10', trang_thai: 'probation',
            dien_thoai: '0977123456', email: 'levanc@example.com',
            avatar: 'https://randomuser.me/api/portraits/men/3.jpg',
            id_phong_ban: 3, id_chuc_danh: 3
          },
          {
            id_nhan_vien: 'NV004', ho_ten: 'Phạm Thị D', phong_ban: 'Phòng Kỹ Thuật',
            chuc_danh: 'Kỹ sư phần mềm', ngay_vao: '2018-05-20', trang_thai: 'inactive',
            dien_thoai: '0909123456', email: 'phamthid@example.com',
            avatar: 'https://randomuser.me/api/portraits/women/4.jpg',
            id_phong_ban: 1, id_chuc_danh: 1
          }
        ],
        departments: [
          { id_phong_ban: 1, ten_phong_ban: 'Phòng Kỹ Thuật' },
          { id_phong_ban: 2, ten_phong_ban: 'Phòng Nhân Sự' },
          { id_phong_ban: 3, ten_phong_ban: 'Phòng Kế Toán' },
          { id_phong_ban: 4, ten_phong_ban: 'Phòng Kinh Doanh' }
        ],
        positions: [
          { id_chuc_danh: 1, ten_chuc_danh: 'Kỹ sư phần mềm' },
          { id_chuc_danh: 2, ten_chuc_danh: 'Chuyên viên nhân sự' },
          { id_chuc_danh: 3, ten_chuc_danh: 'Kế toán viên' },
          { id_chuc_danh: 4, ten_chuc_danh: 'Nhân viên kinh doanh' },
          { id_chuc_danh: 5, ten_chuc_danh: 'Trưởng phòng' }
        ],
        selectedEmployee: null,
        isEditing: false,
        searchTerm: '',
        filterStatus: 'all',
        filterDepartment: 'all',
        detailModal: null,
        formModal: null,
        formData: {
          id_nhan_vien: '', ho_ten: '', id_phong_ban: '', id_chuc_danh: '',
          ngay_vao: '', trang_thai: 'active', dien_thoai: '', email: '', avatar: ''
        }
      };
    },
    computed: {
      filteredEmployees() {
        let result = [...this.employees];
        
        if (this.filterDepartment !== 'all') {
          const deptId = parseInt(this.filterDepartment);
          result = result.filter(emp => emp.id_phong_ban === deptId);
        }
        
        if (this.filterStatus !== 'all') {
          result = result.filter(emp => emp.trang_thai === this.filterStatus);
        }
        
        if (this.searchTerm.trim() !== '') {
          const searchLower = this.searchTerm.toLowerCase();
          result = result.filter(emp => 
            emp.id_nhan_vien.toLowerCase().includes(searchLower) ||
            emp.ho_ten.toLowerCase().includes(searchLower) ||
            emp.phong_ban.toLowerCase().includes(searchLower) ||
            emp.chuc_danh.toLowerCase().includes(searchLower)
          );
        }
        
        return result;
      },
      activeEmployees() {
        return this.employees.filter(emp => emp.trang_thai === 'active').length;
      },
      inactiveEmployees() {
        return this.employees.filter(emp => emp.trang_thai === 'inactive').length;
      },
      probationEmployees() {
        return this.employees.filter(emp => emp.trang_thai === 'probation').length;
      }
    },
    mounted() {
      this.detailModal = new Modal(this.$refs.detailModal);
      this.formModal = new Modal(this.$refs.formModal);
    },
    methods: {
      getStatusText(status) {
        switch (status) {
          case 'active': return 'Đang làm việc';
          case 'inactive': return 'Đã nghỉ việc';
          case 'probation': return 'Thử việc';
          default: return 'Không xác định';
        }
      },
      getStatusBadgeClass(status) {
        switch (status) {
          case 'active': return 'badge bg-success';
          case 'inactive': return 'badge bg-danger';
          case 'probation': return 'badge bg-warning text-dark';
          default: return 'badge bg-secondary';
        }
      },
      formatDate(dateString) {
        if (!dateString) return 'Chưa cập nhật';
        const date = new Date(dateString);
        return date.toLocaleDateString('vi-VN', {
          day: '2-digit', month: '2-digit', year: 'numeric'
        });
      },
      viewEmployee(employee) {
        this.selectedEmployee = employee;
        this.detailModal.show();
      },
      showAddModal() {
        this.isEditing = false;
        this.resetForm();
        this.formModal.show();
      },
      editEmployee(employee) {
        this.isEditing = true;
        this.formData = { ...employee };
        this.formModal.show();
      },
      editFromDetail() {
        this.editEmployee(this.selectedEmployee);
        this.detailModal.hide();
      },
      confirmDelete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa nhân viên này?')) {
          this.deleteEmployee(id);
        }
      },
      deleteEmployee(id) {
        this.employees = this.employees.filter(emp => emp.id_nhan_vien !== id);
        if (this.selectedEmployee && this.selectedEmployee.id_nhan_vien === id) {
          this.detailModal.hide();
        }
      },
      resetForm() {
        this.formData = {
          id_nhan_vien: '', ho_ten: '', id_phong_ban: '', id_chuc_danh: '',
          ngay_vao: '', trang_thai: 'active', dien_thoai: '', email: '', avatar: ''
        };
      },
      submitForm() {
        const employeeData = { ...this.formData };
        
        const department = this.departments.find(d => d.id_phong_ban === parseInt(employeeData.id_phong_ban));
        const position = this.positions.find(p => p.id_chuc_danh === parseInt(employeeData.id_chuc_danh));
        
        employeeData.phong_ban = department ? department.ten_phong_ban : '';
        employeeData.chuc_danh = position ? position.ten_chuc_danh : '';
        
        if (this.isEditing) {
          const index = this.employees.findIndex(emp => emp.id_nhan_vien === employeeData.id_nhan_vien);
          if (index !== -1) {
            this.employees[index] = employeeData;
            if (this.selectedEmployee && this.selectedEmployee.id_nhan_vien === employeeData.id_nhan_vien) {
              this.selectedEmployee = employeeData;
            }
          }
        } else {
          if (!employeeData.id_nhan_vien) {
            employeeData.id_nhan_vien = `NV${String(this.employees.length + 1).padStart(3, '0')}`;
          }
          this.employees.push(employeeData);
        }
        
        this.formModal.hide();
      },
      closeDetailModal() {
        this.detailModal.hide();
      },
      closeFormModal() {
        this.formModal.hide();
      }
    }
  };
</script>
  
  <style>
  /* Base Styles */
  .employee-management {
    font-family: 'Roboto', sans-serif;
    background-color: #f5f7fa;
    min-height: 100vh;
    padding: 20px;
    color: #333;
  }

  /* Header Section */
  .header-section {
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 24px;
    color: white;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .header-title {
    display: flex;
    align-items: center;
    margin-bottom: 8px;
  }

  .header-title i {
    font-size: 24px;
    margin-right: 16px;
  }

  .header-title h1 {
    font-size: 24px;
    font-weight: 600;
    margin: 0;
  }

  .header-description {
    font-size: 14px;
    opacity: 0.9;
    margin: 0;
  }

  /* Search and Filter Section */
  .search-filter-section {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 24px;
    flex-wrap: wrap;
    gap: 16px;
  }

  .search-box {
    position: relative;
    flex: 1;
    min-width: 250px;
    max-width: 400px;
  }

  .search-box i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #6366f1;
  }

  .search-box input {
    width: 100%;
    padding: 12px 12px 12px 40px;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    font-size: 14px;
    background-color: white;
    transition: all 0.3s;
  }

  .search-box input:focus {
    outline: none;
    border-color: #6366f1;
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
  }

  .filter-options {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
  }

  .filter-item {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .filter-item label {
    font-size: 14px;
    color: #4b5563;
    white-space: nowrap;
  }

  .filter-item select {
    padding: 10px 12px;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    font-size: 14px;
    background-color: white;
    min-width: 120px;
  }

  .add-employee-btn {
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    color: white;
    border: none;
    border-radius: 8px;
    padding: 12px 20px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    transition: all 0.3s;
    white-space: nowrap;
  }

  .add-employee-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }

  /* Stats Section */
  .stats-section {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 24px;
  }

  .stat-card {
    background-color: white;
    border-radius: 12px;
    padding: 20px;
    display: flex;
    align-items: center;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    transition: all 0.3s;
  }

  .stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  }

  .stat-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    background-color: rgba(99, 102, 241, 0.1);
    color: #6366f1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    margin-right: 15px;
  }

  .stat-icon.active {
    background-color: rgba(16, 185, 129, 0.1);
    color: #10b981;
  }

  .stat-icon.probation {
    background-color: rgba(245, 158, 11, 0.1);
    color: #f59e0b;
  }

  .stat-icon.inactive {
    background-color: rgba(239, 68, 68, 0.1);
    color: #ef4444;
  }

  .stat-info h3 {
    font-size: 24px;
    font-weight: 600;
    margin: 0 0 5px;
  }

  .stat-info p {
    font-size: 14px;
    color: #6b7280;
    margin: 0;
  }

  /* Employee Table Section */
  .employee-table-section {
    background-color: white;
    border-radius: 12px;
    padding: 24px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    overflow: hidden;
  }

  .section-title {
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 20px;
    color: #1f2937;
  }

  .table-container {
    overflow-x: auto;
  }

  .employee-table {
    width: 100%;
    border-collapse: collapse;
  }

  .employee-table th {
    background-color: #f9fafb;
    padding: 12px 16px;
    text-align: left;
    font-size: 14px;
    font-weight: 600;
    color: #4b5563;
    border-bottom: 1px solid #e5e7eb;
  }

  .employee-table td {
    padding: 16px;
    border-bottom: 1px solid #e5e7eb;
    font-size: 14px;
    color: #1f2937;
  }

  .employee-table tr:hover {
    background-color: #f9fafb;
  }

  .employee-id {
    font-weight: 600;
    color: #6366f1;
  }

  .employee-name {
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .employee-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    border: 2px solid #e5e7eb;
  }

  .employee-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    display: inline-block;
  }

  .status-badge.active {
    background-color: #d1fae5;
    color: #065f46;
  }

  .status-badge.inactive {
    background-color: #fee2e2;
    color: #991b1b;
  }

  .status-badge.probation {
    background-color: #fef3c7;
    color: #92400e;
  }

  .action-buttons {
    display: flex;
    gap: 8px;
  }

  .btn-view, .btn-edit, .btn-delete {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: none;
    cursor: pointer;
    transition: all 0.2s;
  }

  .btn-view {
    background-color: #e0e7ff;
    color: #4f46e5;
  }

  .btn-edit {
    background-color: #e0f2fe;
    color: #0284c7;
  }

  .btn-delete {
    background-color: #fee2e2;
    color: #dc2626;
  }

  .btn-view:hover, .btn-edit:hover, .btn-delete:hover {
    transform: translateY(-2px);
  }

  /* Modal Styles */
  .modal-backdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .modal-container {
    background-color: white;
    border-radius: 12px;
    width: 90%;
    max-width: 600px;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  }

  .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #e9ecef;
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    color: white;
    border-radius: 12px 12px 0 0;
  }

  .modal-header h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 600;
  }

  .close-btn {
    background: transparent;
    border: none;
    color: white;
    font-size: 18px;
    cursor: pointer;
  }

  .modal-body {
    padding: 20px;
  }
  </style>