<template>
  <div class="register-container">
    <h2 class="text-center mb-4">Đăng Ký Nhân Viên</h2>
    <form @submit.prevent="submitForm">
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="ho_va_ten" class="form-label">Họ và tên</label>
          <input
            type="text"
            class="form-control"
            id="ho_va_ten"
            v-model="formData.ho_va_ten"
          />
        </div>
        <div class="col-md-6 mb-3">
          <label for="ngay_sinh" class="form-label">Ngày sinh</label>
          <input
            type="date"
            class="form-control"
            id="ngay_sinh"
            v-model="formData.ngay_sinh"
          />
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label">Giới tính</label>
          <div class="d-flex">
            <div class="form-check me-3">
              <input
                class="form-check-input"
                type="radio"
                id="gioi_tinh_nam"
                name="gioi_tinh"
                :value="true"
                v-model="formData.gioi_tinh"
              />
              <label class="form-check-label" for="gioi_tinh_nam">Nam</label>
            </div>
            <div class="form-check">
              <input
                class="form-check-input"
                type="radio"
                id="gioi_tinh_nu"
                name="gioi_tinh"
                :value="false"
                v-model="formData.gioi_tinh"
              />
              <label class="form-check-label" for="gioi_tinh_nu">Nữ</label>
            </div>
          </div>
        </div>
        <div class="col-md-6 mb-3">
          <label for="so_dien_thoai" class="form-label">Số điện thoại</label>
          <input
            type="tel"
            class="form-control"
            id="so_dien_thoai"
            v-model="formData.so_dien_thoai"
          />
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="email" class="form-label">Email</label>
          <input
            type="email"
            class="form-control"
            id="email"
            v-model="formData.email"
          />
        </div>
        <div class="col-md-6 mb-3">
          <label for="password" class="form-label">Mật khẩu</label>
          <input
            type="password"
            class="form-control"
            id="password"
            v-model="formData.password"
          />
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="ngay_tuyen_dung" class="form-label"
            >Ngày tuyển dụng</label
          >
          <input
            type="date"
            class="form-control"
            id="ngay_tuyen_dung"
            v-model="formData.ngay_tuyen_dung"
          />
        </div>
        <div class="col-md-6 mb-3">
          <label for="ma_vai_tro" class="form-label">Vai trò</label>
          <select
            class="form-select"
            id="ma_vai_tro"
            v-model="formData.id_vai_tro"
          >
            <option value="" disabled>Chọn vai trò</option>
            <option v-for="role in roles" :key="role.id" :value="role.id">
              {{ role.ten_vai_tro }}
            </option>
          </select>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="ma_phong_ban" class="form-label">Phòng ban</label>
          <select
            class="form-select"
            id="ma_phong_ban"
            v-model="formData.id_phong_ban"
          >
            <option value="" disabled>Chọn phòng ban</option>
            <option v-for="dept in departments" :key="dept.id" :value="dept.id">
              {{ dept.ten_phong_ban }}
            </option>
          </select>
        </div>
        <div class="col-md-6 mb-3">
          <label for="ma_chuc_danh" class="form-label">Chức danh</label>
          <select
            class="form-select"
            id="ma_chuc_danh"
            v-model="formData.id_chuc_danh"
          >
            <option value="" disabled>Chọn chức danh</option>
            <option
              v-for="position in positions"
              :key="position.id"
              :value="position.id"
            >
              {{ position.ten_chuc_danh }}
            </option>
          </select>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="loai_hop_dong" class="form-label">Loại hợp đồng</label>
          <select
            class="form-select"
            id="loai_hop_dong"
            v-model="formData.loai_hop_dong"
          >
            <option value="" disabled>Chọn loại hợp đồng</option>
            <option value="Toàn thời gian">Toàn thời gian</option>
            <option value="Bán thời gian">Bán thời gian</option>
            <option value="Thời vụ">Thời vụ</option>
            <option value="Thực tập">Thực tập</option>
          </select>
        </div>
        <div class="col-md-6 mb-3">
          <label class="form-label">Trạng thái</label>
          <div class="form-check form-switch">
            <input
              class="form-check-input"
              type="checkbox"
              id="trang_thai"
              v-model="formData.trang_thai"
            />
            <label class="form-check-label" for="trang_thai">
              {{ formData.trang_thai ? "Hoạt động" : "Không hoạt động" }}
            </label>
          </div>
        </div>
      </div>

      <div class="mb-3">
        <div class="form-check">
          <input
            class="form-check-input"
            type="checkbox"
            id="is_master"
            v-model="formData.is_master"
          />
          <label class="form-check-label" for="is_master"> Quản lý </label>
        </div>
      </div>

      <div class="d-grid gap-2 d-md-flex justify-content-md-end">
        <button
          type="button"
          class="btn btn-secondary me-md-2"
          @click="resetForm"
        >
          Hủy
        </button>
        <button type="submit" class="btn btn-primary" :disabled="isSubmitting">
          {{ isSubmitting ? "Đang xử lý..." : "Đăng ký" }}
        </button>
      </div>
    </form>

    <!-- Alert for success/error messages -->
    <div
      v-if="alertMessage"
      :class="`alert alert-${alertType} mt-3`"
      role="alert"
    >
      {{ alertMessage }}
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "DangKiNhanVien",
  data() {
    return {
      formData: {
        ma_vai_tro: 1,
        ho_va_ten: "",
        ngay_sinh: "",
        gioi_tinh: true,
        so_dien_thoai: "",
        email: "",
        password: "",
        ngay_tuyen_dung: "",
        ma_phong_ban: 1,
        ma_chuc_danh: 1,
        trang_thai: true,
        loai_hop_dong: "Toàn thời gian",
        is_master: true,
      },
      roles: [],
      departments: [],
      positions: [],
      isSubmitting: false,
      alertMessage: "",
      alertType: "success",
    };
  },
  created() {
    this.fetchRoles();
    this.fetchDepartments();
    this.fetchPositions();
  },
  methods: {
    async fetchRoles() {
      try {
        // Replace with your actual API endpoint
        const response = await axios.get("/api/roles");
        this.roles = response.data;
      } catch (error) {
        console.error("Error fetching roles:", error);
        // For testing, add some dummy data
        this.roles = [
          { id: 1, ten_vai_tro: "Admin" },
          { id: 2, ten_vai_tro: "Nhân viên" },
          { id: 3, ten_vai_tro: "Quản lý" },
        ];
      }
    },
    async fetchDepartments() {
      try {
        // Replace with your actual API endpoint
        const response = await axios.get("/api/departments");
        this.departments = response.data;
      } catch (error) {
        console.error("Error fetching departments:", error);
        // For testing, add some dummy data
        this.departments = [
          { id: 1, ten_phong_ban: "Phòng Nhân sự" },
          { id: 2, ten_phong_ban: "Phòng Kỹ thuật" },
          { id: 3, ten_phong_ban: "Phòng Kinh doanh" },
        ];
      }
    },
    async fetchPositions() {
      try {
        // Replace with your actual API endpoint
        const response = await axios.get("/api/positions");
        this.positions = response.data;
      } catch (error) {
        console.error("Error fetching positions:", error);
        // For testing, add some dummy data
        this.positions = [
          { id: 1, ten_chuc_danh: "Trưởng phòng" },
          { id: 2, ten_chuc_danh: "Nhân viên" },
          { id: 3, ten_chuc_danh: "Kỹ sư" },
        ];
      }
    },
    async submitForm() {
      this.isSubmitting = true;
      this.alertMessage = "";

      try {
        // Updated API endpoint to match your test endpoint
        const response = await axios.post(
          "http://127.0.0.1:8000/api/dang-ky-nhan-vien",
          this.formData
        );

        this.alertType = "success";
        this.alertMessage = "Đăng ký nhân viên thành công!";
        this.resetForm();

        console.log("Registration successful:", response.data);
      } catch (error) {
        this.alertType = "danger";
        this.alertMessage =
          error.response?.data?.message ||
          "Đã xảy ra lỗi khi đăng ký nhân viên.";
        console.error("Registration error:", error);
      } finally {
        this.isSubmitting = false;
      }
    },
    resetForm() {
      this.formData = {
        ma_vai_tro: 1,
        ho_va_ten: "",
        ngay_sinh: "",
        gioi_tinh: true,
        so_dien_thoai: "",
        email: "",
        password: "",
        ngay_tuyen_dung: "",
        ma_phong_ban: 1,
        ma_chuc_danh: 1,
        trang_thai: true,
        loai_hop_dong: "Toàn thời gian",
        is_master: true,
      };
    },
  },
};
</script>

<style scoped>
.register-container {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f8f9fa;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
  color: #343a40;
  margin-bottom: 20px;
}

.form-label {
  font-weight: 500;
}

.btn-primary {
  background-color: #007bff;
  border-color: #007bff;
}

.btn-primary:hover {
  background-color: #0069d9;
  border-color: #0062cc;
}

.btn-secondary {
  background-color: #6c757d;
  border-color: #6c757d;
}

.btn-secondary:hover {
  background-color: #5a6268;
  border-color: #545b62;
}
</style>
