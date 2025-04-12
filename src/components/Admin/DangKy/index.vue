<template>
  <div class="register-container">
    <h2 class="text-center mb-4">Đăng Ký Nhân Viên</h2>
    <form @submit.prevent="dangKy">
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
import baseRequest from "../../../core/baseRequest";
import { createToaster } from "@meforma/vue-toaster";
const toaster = createToaster({ position: "top-right" });
export default {
  name: "DangKiNhanVien",
  data() {
    return {
      formData: {
        id_vai_tro: 1,
        ho_va_ten: "",
        ngay_sinh: "",
        gioi_tinh: true,
        so_dien_thoai: "",
        email: "",
        password: "",
        ngay_tuyen_dung: "",
        id_phong_ban: 1,
        id_chuc_danh: 1,
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
  mounted() {},
  methods: {
    dangKy() {
      baseRequest.post("dang-ky-nhan-vien", this.formData).then((res) => {
        toaster.success(res.data.message);
        this.$router.push("/quan-ly/dang-nhap");
      });
    },
    resetForm() {
      this.formData = {
        id_vai_tro: null,
        ho_va_ten: "",
        ngay_sinh: "",
        gioi_tinh: true,
        so_dien_thoai: "",
        email: "",
        password: "",
        ngay_tuyen_dung: "",
        id_phong_ban: null,
        id_chuc_danh: null,
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
