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
        <li class="nav-item">
          <router-link to="/">
            <a class="nav-link" href="/">
              <div class="parent-icon">
                <i class="fa-brands fa-product-hunt"></i>
              </div>
              <div class="menu-title">HOME</div>
            </a>
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/quan-ly/quan-ly-thuong-phat">
            <a class="nav-link" href="/quan-ly/quan-ly-thuong-phat">
              <div class="parent-icon">
                <i class="fa-brands fa-product-hunt"></i>
              </div>
              <div class="menu-title">Quản Lý Thưởng Phạt</div>
            </a>
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/quan-ly/quan-ly-yeu-cau-nghi-phep">
            <a class="nav-link" href="/quan-ly/quan-ly-yeu-cau-nghi-phep">
              <div class="parent-icon">
                <i class="fa-brands fa-product-hunt"></i>
              </div>
              <div class="menu-title">Quản Lý Yêu Cầu Nghĩ Phép</div>
            </a>
          </router-link>
        </li>
      </ul>
    </nav>
  </div>
</template>
<script>
export default {};
</script>
<style></style>
