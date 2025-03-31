<template>
  <header>
    <div class="topbar d-flex align-items-center">
      <nav class="navbar navbar-expand">
        <router-link to="/">
          <div class="topbar-logo-header">
            <div class="">
              <img
                src="../../assets/images/logo-icon.png"
                class="logo-icon"
                alt="logo icon"
              />
            </div>
            <div class="">
              <router-link to="/">
                <h4 class="logo-text">Rocker</h4>
              </router-link>
            </div>
          </div>
        </router-link>
        <div class="mobile-toggle-menu"><i class="bx bx-menu"></i></div>
        <div class="search-bar flex-grow-1">
          <div class="row">
            <div class="col-lg-10">
              <input
                v-on:keyup.enter="timKiem()"
                v-model="thong_tin_search"
                type="text"
                class="form-control search-control ms-3"
                style="width: 100%"
                placeholder="Type to search..."
              />
            </div>
            <div class="col-lg-2">
              <button v-on:click="timKiem()" class="btn btn-secondary">
                <i class="fa-solid fa-magnifying-glass"></i>
              </button>
            </div>
          </div>
        </div>
        <template v-if="auth">
          <div class="top-menu ms-auto">
            <ul class="navbar-nav align-items-center">
              <li class="nav-item mobile-search-icon">
                <a class="nav-link" href="#"> <i class="bx bx-search"></i> </a>
              </li>
              <li class="nav-item dropdown dropdown-large">
                <router-link to="/don-hang">
                  <a
                    class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative"
                  >
                    <span class="alert-count">3</span>
                    <i class="fa-solid fa-credit-card"></i>
                  </a>
                </router-link>
              </li>
              <li class="nav-item dropdown dropdown-large">
                <router-link to="/gio-hang">
                  <a
                    class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative"
                  >
                    <span class="alert-count">3</span>
                    <i class="fa-solid fa-cart-shopping"></i>
                  </a>
                </router-link>
              </li>
              <li class="nav-item dropdown dropdown-large">
                <a
                  class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative"
                  href="#"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  <span class="alert-count">8</span>
                  <i class="bx bx-bell"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-end">
                  <a href="javascript:;">
                    <div class="msg-header">
                      <p class="msg-header-title">Thông Báo</p>
                    </div>
                  </a>
                  <div class="header-message-list">
                    <a class="dropdown-item" href="javascript:;">
                      <div class="d-flex align-items-center">
                        <div class="user-online">
                          <img
                            src="../../assets/images/avatars/avatar-1.png"
                            class="msg-avatar"
                            alt="user avatar"
                          />
                        </div>
                        <div class="flex-grow-1">
                          <h6 class="msg-name">
                            Daisy Anderson
                            <span class="msg-time float-end">5 sec ago</span>
                          </h6>
                          <p class="msg-info">The standard chunk of lorem</p>
                        </div>
                      </div>
                    </a>
                  </div>
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
                src="../../assets/images/avatars/avatar-2.png"
                class="user-img"
                alt="user avatar"
              />
              <div class="user-info ps-3">
                <p class="user-name mb-0">{{ name_kh }}</p>
                <p class="designattion mb-0">Web Designer</p>
              </div>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li>
                <router-link to="/profile">
                  <a class="dropdown-item" href="javascript:;">
                    <i class="bx bx-user"></i><span>Profile</span>
                  </a>
                </router-link>
              </li>
              <li>
                <div class="dropdown-divider mb-0"></div>
              </li>
              <li>
                <a v-on:click="dangXuat()" class="dropdown-item"
                  ><i class="bx bx-log-out-circle"></i><span>Đăng Xuất</span></a
                >
              </li>
              <li>
                <a v-on:click="dangXuatAll()" class="dropdown-item"
                  ><i class="bx bx-log-out-circle"></i
                  ><span>Đăng Xuất Tất Cả</span></a
                >
              </li>
            </ul>
          </div>
        </template>
        <template v-else>
          <div class="user-box">
            <a class="d-flex align-items-center">
              <router-link to="/dang-nhap">
                <button type="button" class="btn btn-primary me-2">
                  <i class="bx bxs-lock-open"></i> Đăng Nhập
                </button>
              </router-link>
              <router-link to="/dang-ky">
                <button type="button" class="btn btn-secondary">
                  <i class="fa-solid fa-right-to-bracket fa-2xs"></i> Đăng Ký
                </button>
              </router-link>
            </a>
          </div>
        </template>
      </nav>
    </div>
  </header>
</template>
<script>
import { createToaster } from "@meforma/vue-toaster";
import baseRequest from "../../core/baseRequest";
const toaster = createToaster({ position: "top-right" });
import kiemTraKhachHang from "../../router/kiemTraKhachHang.js";
export default {
  data() {
    return {
      auth: false,
      name_kh: "",
      thong_tin_search: "",
    };
  },
  mounted() {
    this.checkLogin();
    this.name_kh = localStorage.getItem("ten_kh");
  },
  methods: {
    checkLogin() {
      baseRequest.post("khach-hang/check-login").then((res) => {
        if (res.data.status) {
          this.auth = true;
        }
      });
    },
    timKiem() {
      this.$router.push({
        name: "timKiem",
        params: {
          thong_tin: this.thong_tin_search,
        },
      });
    },
    dangXuat() {
      baseRequest.get("khach-hang/dang-xuat").then((res) => {
        if (res.data.status) {
          toaster.success("Thông báo<br>" + res.data.message);
          window.localStorage.removeItem("chia_khoa_16");
          window.localStorage.removeItem("ten_kh");
          this.auth = false;
          this.$router.push("/");
        } else {
          toaster.error("Thông báo<br>" + res.data.message);
        }
      });
    },
    dangXuatAll() {
      baseRequest.get("khach-hang/dang-xuat-all").then((res) => {
        if (res.data.status) {
          toaster.success("Thông báo<br>" + res.data.message);
          window.localStorage.removeItem("chia_khoa_16");
          window.localStorage.removeItem("ten_kh");
          this.auth = false;
          this.$router.push("/");
        } else {
          toaster.error("Thông báo<br>" + res.data.message);
        }
      });
    },
  },
};
</script>
<style></style>
