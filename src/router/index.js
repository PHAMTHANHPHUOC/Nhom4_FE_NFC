import { createRouter, createWebHistory } from "vue-router"; // cài vue-router: npm install vue-router@next --save

const routes = [
  {
    path: "/",
    component: () => import("../components/NhanVien/Home/index.vue"),
    meta: { layout: "client" },
  },
  {
    path: "/nhan-vien/bao-hiem-phuc-loi",
    component: () =>
      import("../components/NhanVien/BaoHiemVaPhucLoi/index.vue"),
    meta: { layout: "client" },
  },
  {
    path: "/nhan-vien/tieu-chi-kpi", 
    component: () =>
      import("../components/NhanVien/TieuChiKPI/index.vue"),
    meta: { layout: "client" },
  },
  {
    path: "/nhan-vien/quan-ly-ho-so-nhan-su",
    component: () =>
      import("../components/NhanVien/QuanLyHoSoNhanSu/index.vue"),
    meta: { layout: "client" },
  },
  {
    path: "/nhan-vien/quan-ly-hop-dong",
    component: () =>
      import("../components/NhanVien/QuanLyHopDong/index.vue"),
    meta: { layout: "client" },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

export default router;
