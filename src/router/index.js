import { createRouter, createWebHistory } from "vue-router"; // cài vue-router: npm install vue-router@next --save
import checkLogin from "./checkLogin";

const routes = [
  {
    path: "/",
    component: () => import("../layout/wrapper/index.vue"),
    beforeEnter: checkLogin,
  },
  {
    path: "/admin/dang-nhap",
    component: () => import("../components/Admin/DangNhap/index.vue"),
    meta: { layout: "blank" },
  },
  {
    path: "/admin/phong-ban",
    component: () => import("../components/Admin/PhongBan/index.vue"),
    beforeEnter: checkLogin,
  },
  {
    path: "/admin/chuc-vu",
    component: () => import("../components/Admin/ChucVu/index.vue"),
    beforeEnter: checkLogin,
  },
  {
    path: "/admin/nhan-vien",
    component: () => import("../components/Admin/NhanVien/index.vue"),
    beforeEnter: checkLogin,
  },
  {
    path: "/admin/tieu-chi-kpi",
    component: () => import("../components/Admin/TieuChiKpi/index.vue"),
    beforeEnter: checkLogin,
  },
  {
    path: "/admin/kpi-nhan-vien",
    component: () => import("../components/Admin/KPINhanVien/index.vue"),
    beforeEnter: checkLogin,
  },
  {
    path: "/admin/quy-dinh-cho-diem",
    component: () => import("../components/Admin/QuyDinhChoDiem/index.vue"),
    beforeEnter: checkLogin,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

export default router;
