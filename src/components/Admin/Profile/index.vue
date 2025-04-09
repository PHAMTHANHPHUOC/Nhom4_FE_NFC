<template>
  <div class="profile-container">
    <div class="card">
      <div class="card-body">
        <ul class="nav nav-tabs nav-primary" role="tablist">
          <li class="nav-item" role="presentation">
            <a class="nav-link active" data-bs-toggle="tab" href="#profile" role="tab">
              <i class="fas fa-user me-2"></i>Thông Tin Cá Nhân
            </a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" data-bs-toggle="tab" href="#security" role="tab">
              <i class="fas fa-shield-alt me-2"></i>Bảo Mật
            </a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" data-bs-toggle="tab" href="#reports" role="tab">
              <i class="fas fa-chart-bar me-2"></i>Báo Cáo
            </a>
          </li>
        </ul>

        <div class="tab-content py-4">
          <!-- Profile Tab -->
          <div class="tab-pane fade show active" id="profile" role="tabpanel">
            <div class="row">
              <div class="col-lg-4">
                <div class="card profile-card">
                  <div class="card-body text-center">
                    <div class="position-relative d-inline-block">
                      <img
                        src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnO0uhwiK1yDASJ6SkO3SLFNU3dtIb4NMiBA&s"
                        alt="Quản trị viên" class="rounded-circle p-1 bg-primary" width="110" />
                      <button class="btn btn-sm btn-primary avatar-edit-btn">
                        <i class="fas fa-camera"></i>
                      </button>
                    </div>
                    <h4 class="mt-3">{{ profile.ho_va_ten }}</h4>
                    <p class="text-muted">{{ profile.email }}</p>
                    <div class="profile-stats">
                      <div class="row text-center">
                        <div class="col">
                          <h6>Ngày Công</h6>
                          <p>22/26</p>
                        </div>
                        <div class="col">
                          <h6>Dự Án</h6>
                          <p>5</p>
                        </div>
                        <div class="col">
                          <h6>KPI</h6>
                          <p>90%</p>
                        </div>
                      </div>
                    </div>
                    <hr />
                    <div class="social-links">
                      <a href="#" class="btn btn-outline-primary btn-sm">
                        <i class="fab fa-facebook-f"></i>
                      </a>
                      <a href="#" class="btn btn-outline-info btn-sm">
                        <i class="fab fa-twitter"></i>
                      </a>
                      <a href="#" class="btn btn-outline-danger btn-sm">
                        <i class="fab fa-instagram"></i>
                      </a>
                      <a href="#" class="btn btn-outline-dark btn-sm">
                        <i class="fab fa-github"></i>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-8">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title mb-4">Thông Tin Cá Nhân</h5>
                    <form @submit.prevent="updateProfile">
                      <div class="row mb-3">
                        <div class="col-md-6">
                          <label class="form-label">Họ và Tên</label>
                          <input type="text" class="form-control" />
                        </div>
                        <div class="col-md-6">
                          <label class="form-label">Email</label>
                          <input type="email" class="form-control" />
                        </div>
                      </div>
                      <div class="row mb-3">
                        <div class="col-md-6">
                          <label class="form-label">Số Điện Thoại</label>
                          <input type="tel" class="form-control" />
                        </div>
                        <div class="col-md-6">
                          <label class="form-label">Ngày Sinh</label>
                          <input type="date" class="form-control" />
                        </div>
                      </div>
                      <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Lưu Thay Đổi
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Security Tab -->
          <!-- <div class="tab-pane fade" id="security" role="tabpanel">
            <div class="row justify-content-center">
              <div class="col-md-8">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title mb-4">Đổi Mật Khẩu</h5>
                    <form @submit.prevent="changePassword">
                      <div class="mb-3">
                        <label class="form-label">Mật Khẩu Hiện Tại</label>
                        <div class="input-group">
                          <input
                            :type="showPassword ? 'text' : 'password'"
                            class="form-control"
                            v-model="passwordForm.current"
                          />
                          <button
                            type="button"
                            class="btn btn-outline-secondary"
                            @click="showPassword = !showPassword"
                          >
                            <i
                              :class="
                                showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'
                              "
                            ></i>
                          </button>
                        </div>
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Mật Khẩu Mới</label>
                        <input
                          type="password"
                          class="form-control"
                          v-model="passwordForm.new"
                        />
                      </div>
                      <div class="mb-4">
                        <label class="form-label">Xác Nhận Mật Khẩu Mới</label>
                        <input
                          type="password"
                          class="form-control"
                          v-model="passwordForm.confirm"
                        />
                      </div>
                      <button type="submit" class="btn btn-primary">
                        <i class="fas fa-key me-2"></i>Đổi Mật Khẩu
                      </button>
                      <button
                        type="button"
                        class="btn btn-link"
                        @click="forgotPassword"
                      >
                        Quên mật khẩu?
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div> -->

          <!-- Reports Tab -->
          <!-- <div class="tab-pane fade" id="reports" role="tabpanel">
            <div class="row">
              <div class="col-md-6 col-lg-3 mb-4">
                <div class="card bg-primary text-white">
                  <div class="card-body">
                    <h6>Tổng Ngày Công</h6>
                    <h3>22/26</h3>
                    <div class="progress mt-2" style="height: 5px">
                      <div
                        class="progress-bar bg-white"
                        style="width: 85%"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-6 col-lg-3 mb-4">
                <div class="card bg-success text-white">
                  <div class="card-body">
                    <h6>KPI Đạt Được</h6>
                    <h3>90%</h3>
                    <div class="progress mt-2" style="height: 5px">
                      <div
                        class="progress-bar bg-white"
                        style="width: 90%"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-6 col-lg-3 mb-4">
                <div class="card bg-warning text-white">
                  <div class="card-body">
                    <h6>Dự Án Tham Gia</h6>
                    <h3>5</h3>
                    <div class="progress mt-2" style="height: 5px">
                      <div
                        class="progress-bar bg-white"
                        style="width: 75%"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-6 col-lg-3 mb-4">
                <div class="card bg-info text-white">
                  <div class="card-body">
                    <h6>Đánh Giá</h6>
                    <h3>A+</h3>
                    <div class="progress mt-2" style="height: 5px">
                      <div
                        class="progress-bar bg-white"
                        style="width: 95%"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

           
            <div class="card mb-4">
              <div class="card-body">
                <h5 class="card-title">Biểu Đồ Hiệu Suất</h5>
                <canvas id="performanceChart" height="100"></canvas>
              </div>
            </div>
          </div> -->
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { createToaster } from "@meforma/vue-toaster";
import baseRequest from "../../../core/baseRequest";
const toaster = createToaster({ position: "top-right" });

export default {
  data() {
    return {
      id: this.$route.params.id,
      profile: {},
      token: localStorage.getItem("chia_khoa"),
    };
  },
  mounted() {
    this.loadProfile();
  },
  methods: {
    loadProfile() {
      baseRequest
        .get(`khach-hang/thong-tin/${this.id}`)
        .then((response) => {
          this.profile = response.data.data;
        })
        .catch((error) => {
          console.error("Error loading profile:", error);
        });
    }
  },
};
</script>

<style scoped>
.profile-avatar {
  width: 150px;
  height: 150px;
  object-fit: cover;
  border: 4px solid #fff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.avatar-edit-btn {
  position: absolute;
  bottom: 0;
  right: 0;
  border-radius: 50%;
  padding: 8px;
}

.profile-card {
  border: none;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

.social-links {
  display: flex;
  justify-content: center;
  gap: 10px;
}

.profile-stats {
  padding: 20px 0;
}

.nav-tabs .nav-link {
  color: #6c757d;
  font-weight: 500;
}

.nav-tabs .nav-link.active {
  color: #0d6efd;
  font-weight: 600;
}

.card {
  border: none;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
  border-radius: 10px;
}

.progress {
  border-radius: 10px;
}

.btn-outline-secondary:hover {
  background-color: #f8f9fa;
  color: #6c757d;
}
</style>
