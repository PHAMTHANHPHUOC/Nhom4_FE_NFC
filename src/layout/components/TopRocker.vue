<template>

	<div class="topbar d-flex align-items-center">
		<nav class="navbar navbar-expand">
			<div class="topbar-logo-header">
				<div class="">
					<img src="../../assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
				</div>
				<div class="">
					<h4 class="logo-text">Rocker</h4>
				</div>
			</div>
			<div class="mobile-toggle-menu"><i class='bx bx-menu'></i></div>
			<div class="search-bar flex-grow-1">
				<div class="position-relative search-bar-box">
					<input type="text" class="form-control search-control" placeholder="Tìm Kiếm?">
					<span class="position-absolute top-50 search-show translate-middle-y"><i
							class='bx bx-search'></i></span>
					<span class="position-absolute top-50 search-close translate-middle-y"><i
							class='bx bx-x'></i></span>
				</div>
			</div>
			<div class="top-menu ms-auto">
				<ul class="navbar-nav align-items-center">
					<li class="nav-item mobile-search-icon">
						<a class="nav-link" href="#"> <i class='bx bx-search'></i>
						</a>
					</li>
					<li class="nav-item dropdown dropdown-large">
						<a class="nav-link dropdown-toggle dropdown-toggle-nocaret" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> <i class='bx bx-category'></i>
						</a>
						<div class="dropdown-menu dropdown-menu-end">
							<div class="row row-cols-3 g-3 p-3">
								<div class="col text-center">
									<div class="app-box mx-auto bg-gradient-cosmic text-white"><i
											class='bx bx-group'></i>
									</div>
									<div class="app-title">Teams</div>
								</div>
								<div class="col text-center">
									<div class="app-box mx-auto bg-gradient-burning text-white"><i
											class='bx bx-atom'></i>
									</div>
									<div class="app-title">Projects</div>
								</div>
								<div class="col text-center">
									<div class="app-box mx-auto bg-gradient-lush text-white"><i
											class='bx bx-shield'></i>
									</div>
									<div class="app-title">Tasks</div>
								</div>
								<div class="col text-center">
									<div class="app-box mx-auto bg-gradient-kyoto text-dark"><i
											class='bx bx-notification'></i>
									</div>
									<div class="app-title">Feeds</div>
								</div>
								<div class="col text-center">
									<div class="app-box mx-auto bg-gradient-blues text-dark"><i class='bx bx-file'></i>
									</div>
									<div class="app-title">Files</div>
								</div>
								<div class="col text-center">
									<div class="app-box mx-auto bg-gradient-moonlit text-white"><i
											class='bx bx-filter-alt'></i>
									</div>
									<div class="app-title">Alerts</div>
								</div>
							</div>
						</div>
					</li>
					<li class="nav-item dropdown dropdown-large">
						<a class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false"> <span
								class="alert-count">7</span>
							<i class='bx bx-bell'></i>
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
											<div :class="`notify bg-light-primary `+ value.color_thong_bao">
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
					<li class="nav-item dropdown dropdown-large">
						<a class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false"> <span
								class="alert-count">8</span>
							<i class='bx bx-comment'></i>
						</a>
						<div class="dropdown-menu dropdown-menu-end">
							<a href="javascript:;">
								<div class="msg-header">
									<p class="msg-header-title">Messages</p>
									<p class="msg-header-clear ms-auto">Marks all as read</p>
								</div>
							</a>
							<div class="header-message-list">
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-1.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Daisy Anderson <span class="msg-time float-end">5 sec
													ago</span></h6>
											<p class="msg-info">The standard chunk of lorem</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-2.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Althea Cabardo <span class="msg-time float-end">14
													sec ago</span></h6>
											<p class="msg-info">Many desktop publishing packages</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-3.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Oscar Garner <span class="msg-time float-end">8 min
													ago</span></h6>
											<p class="msg-info">Various versions have evolved over</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-4.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Katherine Pechon <span class="msg-time float-end">15
													min ago</span></h6>
											<p class="msg-info">Making this the first true generator</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-5.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Amelia Doe <span class="msg-time float-end">22 min
													ago</span></h6>
											<p class="msg-info">Duis aute irure dolor in reprehenderit</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-6.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Cristina Jhons <span class="msg-time float-end">2 hrs
													ago</span></h6>
											<p class="msg-info">The passage is attributed to an unknown</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-7.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">James Caviness <span class="msg-time float-end">4 hrs
													ago</span></h6>
											<p class="msg-info">The point of using Lorem</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-8.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Peter Costanzo <span class="msg-time float-end">6 hrs
													ago</span></h6>
											<p class="msg-info">It was popularised in the 1960s</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-9.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">David Buckley <span class="msg-time float-end">2 hrs
													ago</span></h6>
											<p class="msg-info">Various versions have evolved over</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-10.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Thomas Wheeler <span class="msg-time float-end">2 days
													ago</span></h6>
											<p class="msg-info">If you are going to use a passage</p>
										</div>
									</div>
								</a>
								<a class="dropdown-item" href="javascript:;">
									<div class="d-flex align-items-center">
										<div class="user-online">
											<img src="assets/images/avatars/avatar-11.png" class="msg-avatar"
												alt="user avatar">
										</div>
										<div class="flex-grow-1">
											<h6 class="msg-name">Johnny Seitz <span class="msg-time float-end">5 days
													ago</span></h6>
											<p class="msg-info">All the Lorem Ipsum generators</p>
										</div>
									</div>
								</a>
							</div>
							<a href="javascript:;">
								<div class="text-center msg-footer">View All Messages</div>
							</a>
						</div>
					</li>
				</ul>
			</div>
			<div class="user-box dropdown">
				<a class="d-flex align-items-center nav-link dropdown-toggle dropdown-toggle-nocaret" href="#"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
					<img src="https://dzfullstack.com/assets/images/logo-img.png" class="user-img" alt="user avatar">
					<div class="user-info ps-3">
						<p class="user-name mb-0">DZFullStack</p>
						<p class="designattion mb-0">Admin</p>
					</div>
				</a>
				<ul class="dropdown-menu dropdown-menu-end">
					<li>
						<router-link to="/admin/profile">
							<a class="dropdown-item" href="/admin/profile"><i
									class="bx bx-user"></i><span>Profile</span></a>
						</router-link>
					</li>
					<li>
						<a v-on:click="dangXuat()" class="dropdown-item" href="javascript:;"><i
								class='bx bx-log-out-circle'></i><span>Đăng Xuất</span></a>
					</li>
					<li><a v-on:click="dangXuatAll()" class="dropdown-item" href="javascript:;"><i
								class='bx bx-log-out-circle'></i><span>Đăng Xuất Tất Cả</span></a>
					</li>
				</ul>
			</div>
		</nav>
	</div>
</template>
<script>
import axios from 'axios';
export default {
	data() {
		return {
			list: [],
		}
	},
	mounted() {
		this.loadThongBao();
	},
	methods: {
		loadThongBao() {
			axios
				.post("http://127.0.0.1:8000/api/admin/thong-bao/data", {}, {
					headers: {
						Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
					}
				})
				.then((res) => {
					this.list = res.data.data;
				});
		},
		dangXuat() {
			axios
				.get("http://127.0.0.1:8000/api/admin/dang-xuat", {
					headers: {
						Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
					}
				})
				.then((res) => {
					if (res.data.status) {
						this.$toast.success(res.data.message);
						localStorage.setItem('tk_nhan_vien', '');
						this.$router.push('/admin/dang-nhap');
					} else {
						this.$toast.error(res.data.message);
					}
				});
		},
		dangXuatAll() {
			axios
				.get("http://127.0.0.1:8000/api/admin/dang-xuat-all", {
					headers: {
						Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
					}
				})
				.then((res) => {
					if (res.data.status) {
						this.$toast.success(res.data.message);
						localStorage.setItem('tk_nhan_vien', '');
						this.$router.push('/admin/dang-nhap');
					} else {
						this.$toast.error(res.data.message);
					}
				});
		}
	},

}
</script>
<style></style>