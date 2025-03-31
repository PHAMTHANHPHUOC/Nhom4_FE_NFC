<template>
  <div class="nav-container primary-menu">
    <div class="mobile-topbar-header">
      <div>
        <img
          src="../../assets/images/logo-icon.png"
          class="logo-icon"
          alt="logo icon"
        />
      </div>
      <div>
        <h4 class="logo-text">Rukada</h4>
      </div>
      <div class="toggle-icon ms-auto"><i class="bx bx-arrow-to-left"></i></div>
    </div>
    <nav class="navbar navbar-expand-xl w-100">
      <ul class="navbar-nav justify-content-start flex-grow-1 gap-1">
        <ul class="navbar-nav justify-content-start flex-grow-1 gap-1">
          <template v-for="(value, key) in list_danh_muc" :key="key">
            <template v-if="value.id_danh_muc_cha == 0">
              <li class="nav-item dropdown">
                <a
                  href="/trang-chu/danh-sach-san-pham"
                  class="nav-link dropdown-toggle dropdown-toggle-nocaret"
                  data-bs-toggle="dropdown"
                >
                  <!-- <div class="parent-icon"><i class='bx bx-cart'></i>
                                    </div> -->
                  <img v-bind:src="value.hinh_anh" class="user-img me-1" />
                  <div class="menu-title">{{ value.ten_danh_muc }}</div>
                </a>
                <ul class="dropdown-menu">
                  <template v-for="(v, k) in list_danh_muc" :key="k">
                    <router-link
                      :to="
                        '/danh-sach-san-pham/' + v.id + '-' + v.slug_danh_muc
                      "
                    >
                      <a
                        v-if="value.id == v.id_danh_muc_cha"
                        class="dropdown-item"
                      >
                        {{ v.ten_danh_muc }}
                      </a>
                    </router-link>
                  </template>
                </ul>
              </li>
            </template>
          </template>
        </ul>
      </ul>
    </nav>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      list_danh_muc: [],
    };
  },
  mounted() {
    this.loadDataDanhMuc();
  },
  methods: {
    loadDataDanhMuc() {
      axios.get("http://127.0.0.1:8000/api/danh-muc/data").then((res) => {
        this.list_danh_muc = res.data.data;
      });
    },
  },
};
</script>
<style></style>
