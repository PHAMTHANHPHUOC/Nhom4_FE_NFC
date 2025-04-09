<template>
  <header>
    <div class="topbar d-flex align-items-center">
      <nav class="navbar navbar-expand">
        <!-- Logo Section -->
        <div class="topbar-logo-header d-flex align-items-center">
          <div class="logo-container">
            <img src="https://posapp.vn/wp-content/themes/twentysixteen-child/images/icon-user-slide.png"
              class="logo-icon" alt="logo icon" />
          </div>
          <div class="logo-text-container">
            <h4 class="logo-text">Quản Lý Nhân Sự</h4>
          </div>
        </div>

        <!-- Mobile Menu Toggle -->
        <div class="mobile-toggle-menu">
          <i class="bx bx-menu"></i>
        </div>

        <!-- Search Bar -->
        <div class="search-bar flex-grow-1">
          <div class="position-relative search-bar-box">
            <input type="text" class="form-control search-control" placeholder="Tìm kiếm..." />
            <span class="position-absolute top-50 search-show translate-middle-y">
              <i class="bx bx-search"></i>
            </span>
            <span class="position-absolute top-50 search-close translate-middle-y">
              <i class="bx bx-x"></i>
            </span>
          </div>
        </div>

        <!-- Top Menu -->
        <div class="top-menu ms-auto">
          <ul class="navbar-nav align-items-center">
            <li class="nav-item mobile-search-icon">
              <a class="nav-link" href="#">
                <i class="bx bx-search"></i>
              </a>
            </li>
            <li class="nav-item dropdown dropdown-large">
              <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" href="#" role="button"
                data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bx bx-category"></i>
              </a>
              <div class="dropdown-menu dropdown-menu-end">
                <div class="row row-cols-3 g-3 p-3">
                  <div class="col text-center">
                    <div class="app-box mx-auto bg-gradient-cosmic text-white">
                      <i class="bx bx-group"></i>
                    </div>
                    <div class="app-title">Nhân Viên</div>
                  </div>
                  <div class="col text-center">
                    <div class="app-box mx-auto bg-gradient-burning text-white">
                      <i class="bx bx-atom"></i>
                    </div>
                    <div class="app-title">Quản Lý</div>
                  </div>
                  <div class="col text-center">
                    <div class="app-box mx-auto bg-gradient-lush text-white">
                      <i class="bx bx-shield"></i>
                    </div>
                    <div class="app-title">Admin</div>
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </div>

        <!-- User Profile -->
        <div class="user-box dropdown">
          <a class="d-flex align-items-center nav-link dropdown-toggle dropdown-toggle-nocaret" href="#" role="button"
            data-bs-toggle="dropdown" aria-expanded="false">
            <img src="../../assets/images/avatars/avatar-2.png" class="user-img" alt="user avatar" />
            <div class="user-info ps-3">
              <p class="user-name mb-0">Tên Nhân Viên</p>
            </div>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li>
              <router-link :to="`/nhan-vien/ho-so/${id}`" class="dropdown-item">
                <i class="bx bx-user"></i>
                <span>Thông tin cá nhân</span>
              </router-link>
            </li>
            <li>
              <div class="dropdown-divider mb-0"></div>
            </li>
            <li>
              <a v-on:click="dangXuat()" class="dropdown-item" href="javascript:;">
                <i class="bx bx-log-out"></i>
                <span>Đăng xuất</span>
              </a>
            </li>
          </ul>
        </div>
      </nav>
    </div>
  </header>
</template>

<script>
import { createToaster } from "@meforma/vue-toaster";
import baseRequest from "../../core/baseRequest";

const toaster = createToaster({ position: "top-right" });

export default {
  data() {
    return {
      id: JSON.parse(localStorage.getItem("data"))?.id || null,
      profile: {
      },
    }
  },
  mounted() {

  },
  methods: {
    dangXuat() {
      baseRequest.get("dang-xuat").then((res) => {
        if (res.status == 200) {
          localStorage.removeItem("chia_khoa");
          localStorage.removeItem("data");
          toaster.success(res.data.message);
          this.$router.push("/quan-ly/dang-nhap");
        }
      })
    }

  },
};
</script>

<style scoped>
.topbar {
  background: #ffffff;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  padding: 0.5rem 1rem;
  position: fixed;
  top: 0;
  right: 0;
  left: 0;
  z-index: 999;
}

.logo-icon {
  width: 40px;
  height: 40px;
  object-fit: contain;
}

.logo-text {
  font-size: 1.2rem;
  margin: 0 0 0 1rem;
  color: #2b2b2b;
  font-weight: 600;
}

.search-bar-box {
  max-width: 400px;
  margin: 0 auto;
}

.search-control {
  padding-right: 35px;
  border-radius: 20px;
  border: 1px solid #e0e0e0;
}

.search-show,
.search-close {
  right: 15px;
  cursor: pointer;
  color: #757575;
}

.app-box {
  height: 50px;
  width: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
  font-size: 1.5rem;
  cursor: pointer;
  transition: all 0.3s;
}

.app-box:hover {
  transform: translateY(-2px);
}

.app-title {
  font-size: 0.875rem;
  margin-top: 0.5rem;
  color: #2b2b2b;
}

.user-img {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #e0e0e0;
}

.user-name {
  font-size: 0.9rem;
  font-weight: 500;
  color: #2b2b2b;
}

.dropdown-item {
  padding: 0.5rem 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.dropdown-item i {
  font-size: 1.1rem;
}

.bg-gradient-cosmic {
  background: linear-gradient(45deg, #8e2de2, #4a00e0);
}

.bg-gradient-burning {
  background: linear-gradient(45deg, #ff416c, #ff4b2b);
}

.bg-gradient-lush {
  background: linear-gradient(45deg, #56ab2f, #a8e063);
}

@media (max-width: 768px) {
  .search-bar {
    display: none;
  }

  .mobile-search-icon {
    display: block;
  }

  .logo-text {
    font-size: 1rem;
  }
}
</style>
