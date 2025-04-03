<template>
  <div class="login-container">
    <div class="card">
      <div class="card-header text-center">
        <h3>Đăng Nhập</h3>
      </div>
      <div class="card-body">
        <form @submit.prevent="handleLogin">
          <div class="mb-4">
            <label class="form-label">Email</label>
            <input
              type="email"
              class="form-control"
              v-model="khach_hang.email"
              placeholder="Nhập email của bạn"
              required
            />
          </div>

          <div class="mb-4">
            <label class="form-label">Mật Khẩu</label>
            <div class="input-group">
              <input
                :type="showPassword ? 'text' : 'password'"
                class="form-control"
                v-model="khach_hang.password"
                placeholder="Nhập mật khẩu"
                required
              />
              <button
                class="btn btn-outline-secondary"
                type="button"
                @click="togglePassword"
              >
                <i
                  :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"
                ></i>
              </button>
            </div>
          </div>

          <div class="mb-4 form-check">
            <input
              type="checkbox"
              class="form-check-input"
              id="remember"
              v-model="rememberMe"
            />
            <label class="form-check-label" for="remember"
              >Ghi nhớ đăng nhập</label
            >
          </div>

          <div class="d-grid">
            <button
              v-on:click="actionDangNhap()"
              type="submit"
              class="btn btn-primary"
            >
              <i class="fas fa-sign-in-alt me-2"></i>
              Đăng Nhập
            </button>
          </div>

          <div class="text-center mt-4">
            <p class="mb-0">
              <a href="#" class="text-decoration-none">Quên mật khẩu?</a>
            </p>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import baseRequest from "../../../core/baseRequest";
import { createToaster } from "@meforma/vue-toaster";
const toaster = createToaster({ position: "top-right" });
export default {
  data() {
    return {
      khach_hang: {},
    };
  },
  mounted() {},
  methods: {
    actionDangNhap() {
      baseRequest.post("dang-nhap", this.khach_hang).then((res) => {
        if (res.data.status == 1) {
          console.log(res.data.chia_khoa);
          toaster.success(res.data.message);
          localStorage.setItem("chia_khoa", res.data.chia_khoa);
          this.khach_hang = {};
          this.$router.push("/");
        } else if (res.data.status == 2) {
          toaster.warning(res.data.message);
        } else {
          toaster.error(res.data.message);
        }
      });
    },
  },
};
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f8f9fa;
  padding: 1rem;
}

.card {
  width: 100%;
  max-width: 400px;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
  border: none;
  border-radius: 10px;
}

.card-header {
  background: #fff;
  border-bottom: 2px solid #f0f0f0;
  padding: 1.5rem;
  border-radius: 10px 10px 0 0;
}

.card-header h3 {
  margin: 0;
  color: #2c3e50;
  font-weight: 600;
}

.card-body {
  padding: 2rem;
}

.form-label {
  font-weight: 500;
  color: #2c3e50;
}

.form-control {
  padding: 0.75rem 1rem;
  border-radius: 5px;
}

.form-control:focus {
  box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
}

.btn {
  padding: 0.75rem 1rem;
  font-weight: 500;
}

.btn-primary {
  background-color: #3498db;
  border-color: #3498db;
}

.btn-primary:hover {
  background-color: #2980b9;
  border-color: #2980b9;
}

a {
  color: #3498db;
}

a:hover {
  color: #2980b9;
}

@media (max-width: 576px) {
  .card-body {
    padding: 1.5rem;
  }
}
</style>
