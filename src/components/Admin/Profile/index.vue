<template>
  <div class="row">
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
              <div class="col-lg-4">
                <div class="card">
                  <div class="card-body">
                    <div
                      class="d-flex flex-column align-items-center text-center"
                    >
                      <img
                        src="https://xahara.vn/wp-content/uploads/ch%C3%B3-husky-ng%C3%A1o.jpg"
                        alt=""
                        class="rounded-circle p-1 bg-primary"
                        width="110"
                      />
                      <div class="mt-3">
                        <h4>{{ profile.ho_va_ten }}</h4>
                        <p class="text-secondary mb-1">{{ profile.email }}</p>
                      </div>
                    </div>
                    <hr class="my-4" />
                    <ul class="list-group list-group-flush">
                      <li
                        class="list-group-item d-flex justify-content-between align-items-center flex-wrap"
                      >
                        <h6 class="mb-0">
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="feather feather-instagram me-2 icon-inline text-danger"
                          >
                            <rect
                              x="2"
                              y="2"
                              width="20"
                              height="20"
                              rx="5"
                              ry="5"
                            ></rect>
                            <path
                              d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"
                            ></path>
                            <line
                              x1="17.5"
                              y1="6.5"
                              x2="17.51"
                              y2="6.5"
                            ></line></svg
                          >Instagram
                        </h6>
                        <span class="text-secondary">DZFullStack</span>
                      </li>
                      <li
                        class="list-group-item d-flex justify-content-between align-items-center flex-wrap"
                      >
                        <h6 class="mb-0">
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="feather feather-facebook me-2 icon-inline text-primary"
                          >
                            <path
                              d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"
                            ></path></svg
                          >Facebook
                        </h6>
                        <span class="text-secondary">DZFullStack</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-lg-8">
                <div class="card">
                  <div class="card-body">
                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Họ và tên</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <input
                          v-model="profile.ho_va_ten"
                          type="text"
                          class="form-control"
                          placeholder="Nhập họ và tên"
                        />
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Email</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <input
                          v-model="profile.email"
                          type="email"
                          class="form-control"
                          placeholder="Nhập email"
                          readonly
                        />
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Số điện thoại</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <input
                          v-model="profile.so_dien_thoai"
                          type="text"
                          class="form-control"
                          placeholder="Nhập số điện thoại"
                        />
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Ngày sinh</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <input
                          v-model="profile.ngay_sinh"
                          type="date"
                          class="form-control"
                        />
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Giới tính</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <select v-model="profile.gioi_tinh" class="form-select">
                          <option :value="1">Nam</option>
                          <option :value="0">Nữ</option>
                        </select>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Ngày tuyển dụng</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <input
                          v-model="profile.ngay_tuyen_dung"
                          type="date"
                          class="form-control"
                          readonly
                        />
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Phòng ban</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <select
                          v-model="profile.id_phong_ban"
                          class="form-select"
                        >
                          <option value="">Chọn phòng ban</option>
                          <option
                            v-for="pb in phongBanList"
                            :key="pb.id"
                            :value="pb.id"
                          >
                            {{ pb.ten_phong_ban }}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Chức danh</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <select
                          v-model="profile.id_chuc_danh"
                          class="form-select"
                        >
                          <option value="">Chọn chức danh</option>
                          <option
                            v-for="cd in chucDanhList"
                            :key="cd.id"
                            :value="cd.id"
                          >
                            {{ cd.ten_chuc_danh }}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Loại hợp đồng</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <input
                          v-model="profile.loai_hop_dong"
                          type="text"
                          class="form-control"
                          readonly
                        />
                      </div>
                    </div>

                    <div class="row mb-3">
                      <div class="col-sm-3">
                        <h6 class="mb-0">Trạng thái</h6>
                      </div>
                      <div class="col-sm-9 text-secondary">
                        <select
                          v-model="profile.trang_thai"
                          class="form-select"
                          disabled
                        >
                          <option :value="1">Đang làm việc</option>
                          <option :value="0">Đã nghỉ việc</option>
                        </select>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-sm-3"></div>
                      <div class="col-sm-9 text-secondary">
                        <button
                          class="btn btn-primary px-4"
                          v-on:click="updateProfile()"
                        >
                          <i class="fas fa-save me-2"></i>Lưu thay đổi
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
              <div class="col-2">
                <label for="">Mật khẩu cũ</label>
              </div>
              <div class="col-3">
                <input
                  v-model="update_password.old_password"
                  type="text"
                  placeholder="Nhập mật khẩu cũ"
                  class="form-control"
                />
              </div>
            </div>

            <div class="row mb-2">
              <div class="col-2">
                <label for="">Mật khẩu mới</label>
              </div>
              <div class="col-3">
                <input
                  v-model="update_password.password"
                  type="password"
                  placeholder="Nhập mật khẩu mới"
                  class="form-control"
                />
              </div>
            </div>
            <div class="row mb-2">
              <div class="col-2">
                <label for="">Nhập lại Mật khẩu mới </label>
              </div>
              <div class="col-3">
                <input
                  v-model="update_password.re_password"
                  type="password"
                  placeholder="Nhập lại mật khẩu mới"
                  class="form-control"
                />
              </div>
            </div>
            <button class="btn btn-primary" v-on:click="updateMatKhau()">
              Lưu
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { createToaster } from "@meforma/vue-toaster";
import baseRequest from "../../../core/baseRequest";
const toaster = createToaster({ position: "top-right" });
baseRequest;
export default {
  data() {
    return {
      profile: {},
      update_password: {},
      dia_chi_create: {},
      dia_chi_update: {},
      dia_chi_delete: {},
      list_dia_chi: [],
      phongBanList: [],
      chucDanhList: [],
    };
  },
  mounted() {
    this.getProfile();
    this.loadPhongBan();
    this.loadChucDanh();
  },
  methods: {
    getProfile() {
      baseRequest.get("khach-hang/thong-tin").then((res) => {
        this.profile = res.data.data;
      });
    },

    updateProfile() {
      baseRequest
        .post("khach-hang/update-thong-tin", this.profile)
        .then((res) => {
          if (res.data.status) {
            toaster.success(res.data.message);
            this.getProfile();
          } else {
            toaster.error(res.data.message);
          }
        });
    },

    updateMatKhau() {
      baseRequest
        .post("khach-hang/update-mat-khau", this.update_password)
        .then((res) => {
          if (res.data.status) {
            toaster.success(res.data.message);
            this.getProfile();
            this.update_password = {};
          } else {
            toaster.error(res.data.message);
          }
        });
    },

    async loadPhongBan() {
      try {
        const response = await baseRequest.get("phong-ban/data");
        this.phongBanList = response.data.data;
      } catch (error) {
        console.error("Lỗi khi tải phòng ban:", error);
      }
    },

    async loadChucDanh() {
      try {
        const response = await baseRequest.get("chuc-danh/data");
        this.chucDanhList = response.data.data;
      } catch (error) {
        console.error("Lỗi khi tải chức danh:", error);
      }
    },
  },
};
</script>
<style></style>
