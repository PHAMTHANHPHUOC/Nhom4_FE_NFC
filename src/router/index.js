import { createRouter, createWebHistory } from "vue-router"; // cài vue-router: npm install vue-router@next --save

const routes = [
  {
    path: "/",
    component: () => import("../components/NhanVien/Home/index.vue"),
    meta: { layout: "client" },
  },
  {
    path : '/profile',
    component: ()=>import('../components/NhanVien/Profile/index.vue'),
    meta: { layout: "client" },
  },
  {
    path : '/nhanvien/lichlamviec',
    component: ()=>import('../components/NhanVien/LichLamViec/index.vue'),
    meta: { layout: "client" },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

export default router;
