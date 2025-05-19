<template>
  <div class="row">
    <div class="col-lg-12">
      <div class="card">
        <div class="card-body">
          <ul class="nav nav-tabs nav-primary" role="tablist">
            <li class="nav-item" role="presentation">
              <a
                class="nav-link active"
                data-bs-toggle="tab"
                href="#primaryhome"
                role="tab"
                aria-selected="true"
              >
                <div class="d-flex align-items-center">
                  <div class="tab-icon">
                    <i class="fa-solid fa-user font-18 me-1"></i>
                  </div>
                  <div class="tab-title">Profile</div>
                </div>
              </a>
            </li>
            <li class="nav-item" role="presentation">
              <a
                class="nav-link"
                data-bs-toggle="tab"
                href="#primarycontact"
                role="tab"
                aria-selected="false"
                tabindex="-1"
              >
                <div class="d-flex align-items-center">
                  <div class="tab-icon">
                    <i class="fa-solid fa-lock font-18 me-1"></i>
                  </div>
                  <div class="tab-title">Đổi mật khẩu</div>
                </div>
              </a>
            </li>
          </ul>
          <div class="tab-content py-3">
            <div
              class="tab-pane fade show active"
              id="primaryhome"
              role="tabpanel"
            >
              <div class="row">
                <div class="col-lg-4 d-flex">
                  <div class="card flex-fill">
                    <div class="card-body">
                      <div
                        class="d-flex flex-column align-items-center text-center"
                      >
                        <img
                          src="../../../assets/images/avatars/avatar-16.png"
                          style="width: 140px; height: 140px"
                          alt="Admin"
                          class="rounded-circle p-1 bg-primary"
                        />
                        <div class="mt-3">
                          <h4>{{ profile.ho_va_ten }}</h4>
                          <p class="text-secondary mb-1">
                            {{ chuc_vu.ten_chuc_vu }}
                          </p>
                          <p class="text-muted font-size-sm">
                            {{ profile.dia_chi }}
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-8 d-flex">
                  <div class="card flex-fill">
                    <div class="card-body">
                      <div class="row mb-3">
                        <div class="col-lg-3">
                          <h6 class="mb-0">Họ và Tên</h6>
                        </div>
                        <div class="col-lg-9 text-secondary">
                          <input
                            v-model="profile.ho_va_ten"
                            type="text"
                            class="form-control"
                            placeholder="Nhập họ và tên"
                          />
                        </div>
                      </div>
                      <div class="row mb-3">
                        <div class="col-lg-3">
                          <h6 class="mb-0">Email</h6>
                        </div>
                        <div class="col-lg-9 text-secondary">
                          <input
                            v-model="profile.email"
                            type="text"
                            class="form-control"
                            placeholder="Nhập email"
                          />
                        </div>
                      </div>
                      <div class="row mb-3">
                        <div class="col-lg-3">
                          <h6 class="mb-0">Số Điện Thoại</h6>
                        </div>
                        <div class="col-lg-9 text-secondary">
                          <input
                            v-model="profile.so_dien_thoai"
                            type="text"
                            class="form-control"
                            placeholder="Nhập số điện thoại"
                          />
                        </div>
                      </div>
                      <div class="row mb-3">
                        <div class="col-lg-3">
                          <h6 class="mb-0">Địa Chỉ</h6>
                        </div>
                        <div class="col-lg-9 text-secondary">
                          <input
                            v-model="profile.dia_chi"
                            type="text"
                            class="form-control"
                            placeholder="Nhập số điện thoại"
                          />
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-lg-3"></div>
                        <div class="col-lg-9 text-secondary">
                          <button
                            v-on:click="updateProfile()"
                            type="button"
                            class="btn btn-primary px-4"
                          >
                            Lưu
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="tab-pane fade" id="primarycontact" role="tabpanel">
              <div class="col">
                <h4>Thay đổi mật khẩu</h4>
              </div>
              <div class="col">Quản lý mật khẩu để bảo mật tài khoản</div>
              <hr />
              <div class="row mb-2">
                <div class="col-lg-2">
                  <label for="">Mật khẩu cũ</label>
                </div>
                <div class="col-lg-3">
                  <input
                    v-model="update_password.old_password"
                    type="password"
                    placeholder="Nhập mật khẩu cũ"
                    class="form-control"
                  />
                </div>
              </div>

              <div class="row mb-2">
                <div class="col-lg-2">
                  <label for="">Mật khẩu mới</label>
                </div>
                <div class="col-lg-3">
                  <input
                    v-model="update_password.password"
                    type="password"
                    placeholder="Nhập mật khẩu mới"
                    class="form-control"
                  />
                </div>
              </div>
              <div class="row mb-2">
                <div class="col-lg-2">
                  <label for="">Nhập lại Mật khẩu mới </label>
                </div>
                <div class="col-lg-3">
                  <input
                    v-model="update_password.re_password"
                    type="password"
                    placeholder="Nhập lại mật khẩu mới"
                    class="form-control"
                  />
                </div>
              </div>
              <button v-on:click="updateMatKhau()" class="btn btn-primary">
                Lưu
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      profile: {},
      update_password: {},
      chuc_vu: {},
    };
  },

  mounted() {
    this.getProfile();
    this.loadChucVu();
  },
  methods: {
    loadChucVu() {
      axios
        .get("http://127.0.0.1:8000/api/admin/chuc-vu/data-profile", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          // Lấy phần tử đầu tiên từ mảng data
          if (res.data.data && res.data.data.length > 0) {
            this.chuc_vu = res.data.data[0];
          } else {
            this.chuc_vu = { ten_chuc_vu: "" }; // Mặc định nếu không có dữ liệu
          }
        });
    },
    getProfile() {
      axios
        .get("http://localhost:8000/api/admin/thong-tin", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          this.profile = res.data.data;
        });
    },
    updateProfile() {
      axios
        .post(
          "http://localhost:8000/api/admin/update-thong-tin",
          this.profile,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            this.getProfile();
          } else {
            this.$toast.error(res.data.message);
          }
        });
    },
    updateMatKhau() {
      axios
        .post(
          "http://localhost:8000/api/admin/update-mat-khau",
          this.update_password,
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);

            this.getProfile();
            this.update_password = {};
          } else {
            this.$toast.error(res.data.message);
          }
        })
        .catch((res) => {
          const errors = Object.values(res.response.data.errors);
          errors.forEach((v) => {
            this.$toast.error(v[0]);
          });
        });
    },
  },
};
</script>
<style scoped>
.card {
  border: none;
  box-shadow: 0 2px 15px rgba(108, 43, 217, 0.1);
  border-radius: 10px;
  margin-bottom: 1.5rem;
}

.card-body {
  padding: 1.5rem;
}

/* Nav tabs styling */
.nav-tabs {
  border-bottom: 2px solid #e2d9f3;
}

.nav-tabs .nav-link {
  color: #6c757d;
  border: none;
  padding: 1rem 1.5rem;
  transition: all 0.3s ease;
}

.nav-tabs .nav-link:hover {
  border: none;
  color: #6c2bd9;
}

.nav-tabs .nav-link.active {
  color: #6c2bd9;
  background: transparent;
  border-bottom: 2px solid #6c2bd9;
}

.tab-icon {
  color: #6c2bd9;
}

/* Form controls */
.form-control {
  border: 1px solid #e2d9f3;
  border-radius: 8px;
  padding: 0.6rem 1rem;
  transition: all 0.3s ease;
}

.form-control:focus {
  border-color: #6c2bd9;
  box-shadow: 0 0 0 0.2rem rgba(108, 43, 217, 0.15);
}

/* Profile image */
.rounded-circle {
  border: 2px solid #6c2bd9 !important;
}

.bg-primary {
  background-color: #f8f5ff !important;
}

/* Text styles */
h4 {
  color: #333;
  font-weight: 600;
}

h6 {
  color: #333;
  font-weight: 600;
}

.text-secondary {
  color: #6c757d !important;
}

.text-muted {
  color: #6c757d !important;
}

/* Buttons */
.btn {
  padding: 0.6rem 1.2rem;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.btn-primary {
  color: #6c2bd9;
  background-color: transparent;
  border: 2px solid #6c2bd9;
}

.btn-primary:hover {
  color: #fff;
  background-color: #6c2bd9;
  border-color: #6c2bd9;
}

/* Icons */
.font-18 {
  font-size: 18px;
}

/* Divider */
hr {
  border-color: #e2d9f3;
  opacity: 0.5;
}

/* Utility classes */
.mb-0 {
  margin-bottom: 0 !important;
}

.mb-1 {
  margin-bottom: 0.25rem !important;
}

.mb-2 {
  margin-bottom: 0.5rem !important;
}

.mb-3 {
  margin-bottom: 1rem !important;
}

.mt-3 {
  margin-top: 1rem !important;
}

.me-1 {
  margin-right: 0.25rem !important;
}

.px-4 {
  padding-left: 1.5rem !important;
  padding-right: 1.5rem !important;
}

.py-3 {
  padding-top: 1rem !important;
  padding-bottom: 1rem !important;
}

.p-1 {
  padding: 0.25rem !important;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #f8f5ff;
}

::-webkit-scrollbar-thumb {
  background: #6c2bd9;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #5a23b5;
}
</style>
