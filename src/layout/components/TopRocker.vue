<template>
  <div class="topbar d-flex align-items-center">
    <nav class="navbar navbar-expand">
      <div class="topbar-logo-header">
        <div class="">
          <img
            src="../../../src/assets/images/avatars/nfc.png"
            class="logo-icon"
            style="width: 70px; height: 70px"
            alt="logo icon"
          />
        </div>
        <div class="">
          <h4 style="color: grey">QLNS</h4>
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
            src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVXfyEhQhRGvOMPozJ9m2y7T3Xul_CUsIPKQ&s"
            class="user-img"
            alt="user avatar"
          />
          <div class="user-info ps-3">
            <p class="user-name mb-0">{{ profile.ho_va_ten }}</p>
            <p class=" text-center">{{ chuc_vu.ten_chuc_vu }}</p>
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
      profile: {},
      chuc_vu: {},
    };
  },
  mounted() {
    this.loadThongBao();
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
/* ... existing code ... */

/* Update icon colors */
.bx {
  color: black !important;
}

.fa-solid,
.fas {
  color: black !important;
}

.notify i {
  color: #e2d9f3 !important;
}

.mobile-toggle-menu i {
  color: #e2d9f3 !important;
  font-size: 1.5rem;
}

.search-show i,
.search-close i {
  color: #e2d9f3 !important;
}

.dropdown-item i {
  color: #e2d9f3 !important;
}

/* Hover states for icons */
.nav-link:hover .bx,
.nav-link:hover .fa-solid,
.nav-link:hover .fas,
.dropdown-item:hover i {
  color: #5a23b5 !important;
}

/* ... rest of existing code ... */
</style>
