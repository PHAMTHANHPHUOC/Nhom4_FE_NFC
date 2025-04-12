<template>
  <div class="topbar d-flex align-items-center">
    <nav class="navbar navbar-expand">
      <div class="topbar-logo-header">
        <div class="">
          <img
            src="../../../src/assets/images/icons/logo.jpg"
            class="logo-icon"
            style="width: 50px; height: 50px"
            alt="logo icon"
          />
        </div>
        <div class="">
          <h4 class="logo-text">QUẢN LÝ NHÂN SỰ</h4>
        </div>
      </div>
      <div class="mobile-toggle-menu"><i class="bx bx-menu"></i></div>
      <div class="search-bar flex-grow-1">
        <div class="position-relative search-bar-box">
          <input
            type="text"
            class="form-control search-control"
            placeholder="Tìm Kiếm?"
          />
          <span class="position-absolute top-50 search-show translate-middle-y"
            ><i class="bx bx-search"></i
          ></span>
          <span class="position-absolute top-50 search-close translate-middle-y"
            ><i class="bx bx-x"></i
          ></span>
        </div>
      </div>
      <div class="top-menu ms-auto">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item mobile-search-icon">
            <a class="nav-link" href="#"> <i class="bx bx-search"></i> </a>
          </li>
          <li class="nav-item dropdown dropdown-large">
            <a
              class="nav-link dropdown-toggle dropdown-toggle-nocaret"
              href="#"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
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
          <li class="nav-item dropdown dropdown-large">
            <a
              class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative"
              href="#"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <span class="alert-count">7</span>
              <i class="bx bx-bell"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-end">
              <a href="javascript:;">
                <div class="msg-header">
                  <p class="msg-header-title">Notifications</p>
                  <p class="msg-header-clear ms-auto">Marks all as read</p>
                </div>
              </a>
              <div class="header-notifications-list">
                <template v-for="(value, index) in list" :key="index">
                  <a class="dropdown-item" href="javascript:;">
                    <div class="d-flex align-items-center">
                      <div
                        :class="
                          `notify bg-light-primary ` + value.color_thong_bao
                        "
                      >
                        <i :class="value.icon_thong_bao"></i>
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="msg-name">{{ value.tieu_de }}</h6>
                        <p class="msg-info">{{ value.noi_dung }}</p>
                      </div>
                    </div>
                  </a>
                </template>
              </div>
              <a href="javascript:;">
                <div class="text-center msg-footer">View All Notifications</div>
              </a>
            </div>
          </li>
        </ul>
      </div>
      <div class="user-box dropdown">
        <a
          class="d-flex align-items-center nav-link dropdown-toggle dropdown-toggle-nocaret"
          href="#"
          role="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
        >
          <img
            src="../../../src/assets/images/avatars/avatar-17.png"
            class="user-img"
            alt="user avatar"
          />
          <div class="user-info ps-3">
            <p class="user-name mb-0">Tên Người Dùng</p>
            <p class="designattion mb-0">Admin</p>
          </div>
        </a>
        <ul class="dropdown-menu dropdown-menu-end">
          <li>
            <router-link to="/admin/profile">
              <a class="dropdown-item" href="/admin/profile"
                ><i class="bx bx-user"></i><span>Profile</span></a
              >
            </router-link>
          </li>
          <li>
            <a v-on:click="dangXuat()" class="dropdown-item" href="javascript:;"
              ><i class="bx bx-log-out-circle"></i><span>Đăng Xuất</span></a
            >
          </li>
          <li>
            <a
              v-on:click="dangXuatAll()"
              class="dropdown-item"
              href="javascript:;"
              ><i class="bx bx-log-out-circle"></i
              ><span>Đăng Xuất Tất Cả</span></a
            >
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      list: [],
    };
  },
  mounted() {
    this.loadThongBao();
  },
  methods: {
    loadThongBao() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/thong-bao/data",
          {},
          {
            headers: {
              Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
            },
          }
        )
        .then((res) => {
          this.list = res.data.data;
        });
    },
    dangXuat() {
      axios
        .get("http://127.0.0.1:8000/api/admin/dang-xuat", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            localStorage.setItem("tk_nhan_vien", "");
            this.$router.push("/admin/dang-nhap");
          } else {
            this.$toast.error(res.data.message);
          }
        });
    },
    dangXuatAll() {
      axios
        .get("http://127.0.0.1:8000/api/admin/dang-xuat-all", {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("tk_nhan_vien"),
          },
        })
        .then((res) => {
          if (res.data.status) {
            this.$toast.success(res.data.message);
            localStorage.setItem("tk_nhan_vien", "");
            this.$router.push("/admin/dang-nhap");
          } else {
            this.$toast.error(res.data.message);
          }
        });
    },
  },
};
</script>
<style>
/* Main topbar styling */
.topbar {
  background-color: #fff;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  padding: 0.5rem 1rem;
  position: fixed;
  width: 100%;
  z-index: 1000;
  top: 0;
  left: 0;
}

/* Logo styling - increased size */
.topbar-logo-header {
  display: flex;
  align-items: center;
  margin-right: 25px; /* Added space between logo and other elements */
}

.logo-icon {
  width: 65px !important; /* Increased from 50px */
  height: 65px !important; /* Increased from 50px */
  object-fit: contain;
  margin-right: 5px;
}

.logo-text {
  margin-left: 10px;
  margin-bottom: 0;
  font-weight: 600;
  color: #6c757d;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Center the search bar and make it smaller */
.search-bar {
  max-width: 400px;
  margin: 0 auto;
}

.search-bar-box {
  width: 100%;
}

.search-control {
  height: 38px;
  padding-left: 40px;
  padding-right: 40px;
  border-radius: 20px;
  border: 1px solid #e9ecef;
  background-color: #f8f9fa;
  transition: all 0.3s ease;
}

.search-control:focus {
  border-color: #80bdff;
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
  background-color: #fff;
}

/* Search icons positioning */
.search-show,
.search-close {
  left: 15px;
  color: #6c757d;
  cursor: pointer;
}

.search-close {
  left: auto;
  right: 15px;
  display: none;
}

/* Notifications and user box styling */
.top-menu {
  margin-left: auto;
}

.alert-count {
  position: absolute;
  top: -5px;
  right: -5px;
  width: 18px;
  height: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  font-size: 10px;
  font-weight: 600;
  color: #fff;
  background-color: #f62d51;
}

.nav-link i {
  font-size: 1.2rem;
  color: #6c757d;
}

/* User box styling */
.user-box {
  margin-left: 15px;
}

.user-img {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  border: 2px solid #eee;
}

.user-info {
  margin-left: 10px;
}

.user-name {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 0;
}

.designattion {
  font-size: 12px;
  color: #6c757d;
}

/* Make sure navbar expands properly with the larger logo */
.navbar-expand {
  padding-left: 0;
  padding-right: 0;
}

.navbar {
  padding: 0;
  align-items: center;
  height: 75px; /* Increased height to accommodate larger logo */
}

/* App boxes in dropdown */
.app-box {
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
  margin-bottom: 8px;
}

.app-box i {
  font-size: 24px;
}

.app-title {
  font-size: 12px;
  font-weight: 500;
}

/* Notification dropdown styling */
.dropdown-menu {
  padding: 10px;
  border: none;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}

.msg-header {
  display: flex;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #e9ecef;
}

.msg-header-title {
  margin-bottom: 0;
  font-weight: 600;
}

.msg-header-clear {
  color: #3461ff;
  cursor: pointer;
}

.header-notifications-list {
  max-height: 300px;
  overflow-y: auto;
}

.header-notifications-list a {
  padding: 10px;
  border-bottom: 1px solid #f0f0f0;
}

.notify {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  margin-right: 15px;
}

.msg-footer {
  padding: 10px;
  text-align: center;
  color: #3461ff;
  font-weight: 500;
  cursor: pointer;
}

/* Responsive adjustments */
@media (max-width: 991px) {
  .search-bar {
    max-width: 300px;
  }
}

@media (max-width: 767px) {
  .topbar-logo-header {
    max-width: 180px;
  }

  .logo-text {
    font-size: 16px;
  }

  .search-bar {
    display: none; /* Hide search bar on mobile */
  }

  .mobile-search-icon {
    display: block !important;
  }

  .logo-icon {
    width: 55px !important; /* Slightly smaller on mobile */
    height: 55px !important;
  }
}

/* Gradient backgrounds for app boxes */
.bg-gradient-cosmic {
  background: linear-gradient(135deg, #8e2de2, #4a00e0);
}

.bg-gradient-burning {
  background: linear-gradient(135deg, #ff416c, #ff4b2b);
}

.bg-gradient-lush {
  background: linear-gradient(135deg, #56ab2f, #a8e063);
}
</style>
