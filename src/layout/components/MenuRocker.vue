<template>
	<div class="nav-container primary-menu">
		<div class="mobile-topbar-header">
			<div>
				<img src="../../assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
			</div>
			<div>
				<h4 class="logo-text">Rukada</h4>
			</div>
			<div class="toggle-icon ms-auto"><i class='bx bx-arrow-to-left'></i>
			</div>
		</div>
		<nav class="navbar navbar-expand-xl w-100">
			<ul class="navbar-nav justify-content-start flex-grow-1 gap-1">
				<li class="nav-item">
					<router-link to="/">
						<a class="nav-link" href="/">
							<div class="parent-icon"><i class="fa-solid fa-home"></i>
							</div>
							<div class="menu-title">Home</div>
						</a>
					</router-link>
				</li>
				<li class="nav-item dropdown">
					<a href="javascript:;" class="nav-link dropdown-toggle dropdown-toggle-nocaret"
						data-bs-toggle="dropdown">
						<div class="parent-icon"><i class="fa-solid fa-user"></i>
						</div>
						<div class="menu-title">Quản Lý Nhân Viên</div>
					</a>
					<ul class="dropdown-menu">
						<li> 
							<router-link to="/admin/nhan-vien">
								<a class="dropdown-item" href="/admin/nhan-vien"><i
									class="bx bx-right-arrow-alt"></i>Nhân Viên</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/chuc-vu">
								<a class="dropdown-item" href="/admin/chuc-vu"><i
									class="bx bx-right-arrow-alt"></i>Chức Vụ</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/phong-ban">
								<a class="dropdown-item" href="/admin/phong-ban"><i
									class="bx bx-right-arrow-alt"></i>Phòng Ban</a>
							</router-link>
						</li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a href="javascript:;" class="nav-link dropdown-toggle dropdown-toggle-nocaret"
						data-bs-toggle="dropdown">
						<div class="parent-icon"><i class="fas fa-chart-line"></i>
						</div>
						<div class="menu-title">Quản Lý KPI</div>
					</a>
					<ul class="dropdown-menu">
						<li> 
							<router-link to="/admin/tieu-chi-kpi">
								<a class="dropdown-item" href="/admin/tieu-chi-kpi"><i
									class="bx bx-right-arrow-alt"></i>Tiêu Chí KPI</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/kpi-nhan-vien">
								<a class="dropdown-item" href="/admin/kpi-nhan-vien"><i
									class="bx bx-right-arrow-alt"></i>KPI Nhân Viên</a>
							</router-link>
						</li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a href="javascript:;" class="nav-link dropdown-toggle dropdown-toggle-nocaret"
						data-bs-toggle="dropdown">
						<div class="parent-icon"><i class="fa-solid fa-feather-pointed"></i>
						</div>
						<div class="menu-title">Quản Lý Thưởng Và Phạt</div>
					</a>
					<ul class="dropdown-menu">
						<li> 
							<router-link to="/admin/quy-dinh-cho-diem">
								<a class="dropdown-item" href="/admin/quy-dinh-cho-diem"><i
									class="bx bx-right-arrow-alt"></i>Quy Định Cho Điểm</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/thuong-va-phat">
								<a class="dropdown-item" href="/admin/thuong-va-phat"><i
									class="bx bx-right-arrow-alt"></i>Thưởng Và Phạt</a>
							</router-link>
						</li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a href="javascript:;" class="nav-link dropdown-toggle dropdown-toggle-nocaret"
						data-bs-toggle="dropdown">
						<div class="parent-icon"><i class="fa-solid fa-file-contract"></i>
						</div>
						<div class="menu-title">Quản Lý Hợp Đồng</div>
					</a>
					<ul class="dropdown-menu">
						<li> 
							<router-link to="/admin/loai-hop-dong">
								<a class="dropdown-item" href="/admin/loai-hop-dong"><i
									class="bx bx-right-arrow-alt"></i>Loại Hợp Đồng</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/chi-tiet-hop-dong">
								<a class="dropdown-item" href="/admin/chi-tiet-hop-dong"><i
									class="bx bx-right-arrow-alt"></i>Hợp Đồng Nhân Viên</a>
							</router-link>
						</li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a href="javascript:;" class="nav-link dropdown-toggle dropdown-toggle-nocaret"
						data-bs-toggle="dropdown">
						<div class="parent-icon"><i class="fa-solid fa-calendar-plus"></i>
						</div>
						<div class="menu-title">Quản Lý Chấm Công</div>
					</a>
					<ul class="dropdown-menu">
						<li> 
							<router-link to="/admin/cham-cong">
								<a class="dropdown-item" href="/admin/cham-cong"><i
									class="bx bx-right-arrow-alt"></i>Chấm Công</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/luong">
								<a class="dropdown-item" href="/admin/luong"><i
									class="bx bx-right-arrow-alt"></i>Lương</a>
							</router-link>
						</li>
						<li> 
							<router-link to="/admin/luong-theo-thang">
								<a class="dropdown-item" href="/admin/luong-theo-thang"><i
									class="bx bx-right-arrow-alt"></i>Lương Theo Tháng</a>
							</router-link>
						</li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a href="javascript:;" class="nav-link dropdown-toggle dropdown-toggle-nocaret"
						data-bs-toggle="dropdown">
						<div class="parent-icon"><i class="fa-solid fa-chart-simple"></i>
						</div>
						<div class="menu-title">Thống Kê</div>
					</a>
					<ul class="dropdown-menu">
						<li>
							<router-link to="/admin/thong-ke-ca-cham-cong">
								<a class="dropdown-item" href="/admin/thong-ke-ca-cham-cong"><i
										class="bx bx-right-arrow-alt"></i>Thống Kê Ca Chấm Công</a>
							</router-link>
						</li>
						<li>
							<router-link to="/admin/thong-ke-diem-kpi-nhan-vien">
								<a class="dropdown-item" href="/admin/thong-ke-diem-kpi-nhan-vien"><i
										class="bx bx-right-arrow-alt"></i>Thống Kê Điểm KPI Nhân Viên</a>
							</router-link>
						</li>
						<li>
							<router-link to="/admin/thong-ke-diem-phat">
								<a class="dropdown-item" href="/admin/thong-ke-diem-phat"><i
										class="bx bx-right-arrow-alt"></i>Thống Kê Điểm Phạt Nhân Viên</a>
							</router-link>
						</li>
						<li>
							<router-link to="/admin/thong-ke-diem-thuong">
								<a class="dropdown-item" href="/admin/thong-ke-diem-thuong"><i
										class="bx bx-right-arrow-alt"></i>Thống Kê Điểm Thưởng Nhân Viên</a>
							</router-link>
						</li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
</template>
<script>
export default {

}
</script>
<style></style>