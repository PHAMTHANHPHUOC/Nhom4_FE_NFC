<template>
  <div
    class="authentication-reset-password d-flex align-items-center justify-content-center"
  >
    <div class="row">
      <div class="col-12 col-lg-10 mx-auto">
        <div class="card">
          <div class="row g-0">
            <div class="col-lg-5 border-end">
              <div class="card-body">
                <div class="p-5">
                  <div class="text-center">
                    <img
                      src="../../../assets/images/avatars/nfc.png"
                      width="180"
                      alt=""
                    />
                  </div>
                  <h4 class="mt-5 font-weight-bold">Thay Đổi Mật Khẩu</h4>
                  <p class="text-muted">
                    Nhập lại mật khẩu mới để thay đổi mật khẩu
                  </p>
                  <div class="mb-3 mt-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <input
                      v-model="lay_lai_mat_khau.password"
                      type="text"
                      class="form-control"
                      placeholder="Nhập mật khẩu của bạn"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu</label>
                    <input
                      v-model="lay_lai_mat_khau.re_password"
                      type="text"
                      class="form-control"
                      placeholder="Nhập lại mật khẩu của bạn"
                    />
                  </div>
                  <div class="d-grid gap-2">
                    <button
                      v-on:click="LayLaiMatKhau()"
                      type="button"
                      class="btn btn-primary"
                    >
                      Thay đổi mật khẩu
                    </button>
                    <!-- <router-link to="/dang-nhap">
                                                <a  class="btn btn-light"><i class="bx bx-arrow-back mr-1"></i>Quay lại trang đăng nhập</a>
                                            </router-link> -->
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-7">
              <img
                src="../../../assets/images/login-images/forgot-password-frent-img.jpg"
                class="card-img login-img h-100"
                alt="..."
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import { createToaster } from "@meforma/vue-toaster";
const toaster = createToaster({ position: "top-right" });
import baseRequest from "../../../core/baseRequest";
export default {
  props: ["hash_reset"],
  data() {
    return {
      lay_lai_mat_khau: {},
    };
  },
  mounted() {},
  methods: {
    LayLaiMatKhau() {
      axios
        .post(
          "http://127.0.0.1:8000/api/admin/lay-lai-mat-khau/" +
            this.$route.params.hash_reset,
          this.lay_lai_mat_khau
        )
        .then((res) => {
          if (res.data.status) {
            toaster.success(res.data.message);
            this.$router.push("/dang-nhap");
          } else {
            toaster.error(res.data.message);
          }
        });
    },
  },
};
</script>
<style></style>
