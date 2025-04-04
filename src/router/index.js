import { createRouter, createWebHistory } from "vue-router"; // cài vue-router: npm install vue-router@next --save
import kiemTranNhanVien from "./kiemTraNhanVien";
const routes = [
  {
    path: "/",
    component: () => import("../components/Admin/Home/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/nhan-vien/bao-cao-vang",
    component: () => import("../components/Admin/BaoCaoVang/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/nhan-vien/bao-hiem-phuc-loi",
    component: () => import("../components/Admin/BaoHiemVaPhucLoi/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/nhan-vien/tieu-chi-kpi",
    component: () => import("../components/Admin/TieuChiKPI/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/quan-ly/quan-ly-thuong-phat",
    component: () => import("../components/Admin/QuanLyThuongPhat/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/quan-ly/quan-ly-yeu-cau-nghi-phep",
    component: () =>
      import("../components/Admin/QuanLyYeuCauNghiPhep/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/quan-ly/dang-ky",
    component: () => import("../components/Admin/DangKy/index.vue"),
    meta: { layout: "client" },
  },
  {
    path: "/quan-ly/dang-nhap",
    component: () => import("../components/Admin/DangNhap/index.vue"),
    meta: { layout: "client" },
  },
  {
    path: "/nhan-vien/ho-so",
    component: () => import("../components/Admin/Profile/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
  {
    path: "/nhan-vien/lich-lam-viec",
    component: () => import("../components/Admin/LichLamViec/index.vue"),
    meta: { layout: "client" },
    beforeEnter: kiemTranNhanVien,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

export default router;
