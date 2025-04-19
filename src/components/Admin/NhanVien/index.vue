<template>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center mt-2">
                    <h6><b>DANH SÁCH NHÂN VIÊN</b></h6>
                    <div>
                        <button @click="xuatExcel()" type="button" class="btn btn-success me-2">
                            <i class="fa-regular fa-file-excel"></i> Xuất Excel
                        </button>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#exampleModal">
                            Thêm Mới
                        </button>
                    </div>
                </div>
                <div class="card-body table-responsive">
                    <div class="input-group mt-3 w-100 mb-3">
                        <input v-on:keyup.enter="TimKiemBE()" v-model="search.noi_dung" type="text"
                            class="form-control search-control border border-1 border-secondary"
                            placeholder="Search...">
                        <span class="position-absolute top-50 search-show translate-middle-y" style="left: 15px;"><i
                                class="bx bx-search"></i></span>
                        <button v-on:click="TimKiemBE()" class="btn btn-outline-secondary" type="button"
                            id="button-addon2">Tìm
                            Kiếm</button>
                    </div>
                    <table class="table table-bordered table-hover ">
                        <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th class="text-center">Họ Và Tên</th>
                                <th class="text-center">Email</th>
                                <th class="text-center">Ngày Sinh</th>
                                <th class="text-center">Số Điện Thoại</th>
                                <th class="text-center">Địa Chỉ</th>
                                <th class="text-center">Lương Cơ Bản</th>
                                <th class="text-center">Chức Vụ</th>
                                <th class="text-center">Phòng Ban</th>
                                <th class="text-center">Tình Trạng</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-for="(v, k) in list_nhan_vien" :key="k">
                                <tr>
                                    <th class="align-middle text-center">{{ k + 1 }}</th>
                                    <td class="align-middle">{{ v.ho_va_ten }}</td>
                                    <td class="align-middle">{{ v.email }}</td>
                                    <td class="align-middle text-center">{{ v.ngay_sinh }}</td>
                                    <td class="align-middle text-center">{{ v.so_dien_thoai }}</td>
                                    <td class="align-middle">{{ v.dia_chi }}</td>
                                    <td class="align-middle text-end">{{ v.luong_co_ban }} đ</td>
                                    <td class="align-middle text-center">{{ v.ten_chuc_vu }}</td>
                                    <td class="align-middle text-center">{{ v.ten_phong_ban }}</td>
                                    <td class="align-middle text-center">
                                        <template v-if="v.is_block == 0">
                                            <button v-on:click="changeStatus(v)" class="btn btn-success w-100">Hoạt
                                                Động</button>
                                        </template>
                                        <template v-else>
                                            <button v-on:click="changeStatus(v)" class="btn btn-danger w-100">Tạm
                                                Khóa</button>
                                        </template>
                                    </td>
                                    <td class="align-middle text-center">
                                        <button class="btn btn-warning me-2" data-bs-toggle="modal"
                                            data-bs-target="#phanQuyenModal" v-on:click="loadChucNang(v)">Phân
                                            Quyền</button>
                                        <button class="btn btn-info me-2" data-bs-toggle="modal"
                                            data-bs-target="#hopDongModal"
                                            v-on:click="Object.assign(create_hop_dong, v)">Tạo Hợp Đồng</button>
                                        <button class="btn btn-primary me-2" data-bs-toggle="modal"
                                            data-bs-target="#capnhatDM"
                                            v-on:click="Object.assign(edit_nhan_vien, v)">Cập nhật</button>
                                        <button class="btn btn-danger" data-bs-toggle="modal"
                                            v-on:click="Object.assign(delete_nhan_vien, v)"
                                            data-bs-target="#delModal">Xóa</button>
                                    </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Thêm Mới Nhân Viên</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-2">
                            <label class="form-label">Họ Và Tên</label>
                            <input v-model="create_nhan_vien.ho_va_ten" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Email</label>
                            <input v-model="create_nhan_vien.email" type="email" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Ngày Sinh</label>
                            <input v-model="create_nhan_vien.ngay_sinh" type="date" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Số Điện Thoại</label>
                            <input v-model="create_nhan_vien.so_dien_thoai" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Password</label>
                            <input v-model="create_nhan_vien.password" type="password" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Địa Chỉ</label>
                            <input v-model="create_nhan_vien.dia_chi" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Lương Cơ Bản</label>
                            <input v-model="create_nhan_vien.luong_co_ban" type="number" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label>Chức Vụ</label>
                            <select v-model="create_nhan_vien.id_chuc_vu" class="form-control mt-2">
                                <template v-for="(v, k) in list_chuc_vu" :key="k">
                                    <option v-bind:value="v.id">{{ v.ten_chuc_vu }}</option>
                                </template>
                            </select>
                        </div>
                        <div class="mb-2">
                            <label>Phòng Ban</label>
                            <select v-model="create_nhan_vien.id_phong_ban" class="form-control mt-2">
                                <template v-for="(v, k) in list_phong_ban" :key="k">
                                    <option v-bind:value="v.id">{{ v.ten_phong_ban }}</option>
                                </template>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button v-on:click="createNhanVien()" class="btn btn-primary" data-bs-dismiss="modal">Thêm
                            Mới</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="delModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Xóa Nhân Viên</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
                            <div class="d-flex align-items-center">
                                <div class="font-35 text-white"><i class="bx bxs-message-square-x"></i>
                                </div>
                                <div class="ms-1">
                                    <h6 class="mb-1 text-white">Bạn chắc chắc xóa nhân viên <b>{{
                                        delete_nhan_vien.ho_va_ten }}</b> này chứ
                                        !!!</h6>
                                    <div class="text-white text-nowrap"><b>LƯU Ý !!!</b> Điều này không thể khôi
                                        phục
                                        khi ấn xác nhận
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal"
                            v-on:click="xoaNhanVien()">Xác
                            nhận</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="phanQuyenModal" tabindex="-1" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Phân Quyền Cho Nhân Viên {{
                            phan_quyen_nhan_vien.ho_va_ten }}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class='table table-bordered table-hover'>
                            <thead>
                                <tr>
                                    <th class='align-middle text-center'>#</th>
                                    <th class='align-middle text-center'>Tên Chức Năng</th>
                                    <th class='align-middle text-center'>Trạng Thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="(v, k) in list_chuc_nang" :key="k">
                                    <tr>
                                        <th class="text-center align-middle">
                                            {{ k + 1 }}
                                        </th>
                                        <td class="align-middle">
                                            {{ v.ten_chuc_nang }}
                                        </td>
                                        <td class="text-center align-middle">
                                            <button v-if="v.is_phan_quyen == 1" v-on:click="removeQuyen(v)"
                                                class="btn btn-primary">Đã Phân
                                                Quyền</button>
                                            <button v-else v-on:click="setQuyen(v)" class="btn btn-danger">Chưa Phân
                                                Quyền</button>
                                        </td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="capnhatDM" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Cập nhật Nhân Viên</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-2">
                            <label class="form-label">Họ Và Tên</label>
                            <input v-model="edit_nhan_vien.ho_va_ten" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Email</label>
                            <input v-model="edit_nhan_vien.email" type="email" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Ngày Sinh</label>
                            <input v-model="edit_nhan_vien.ngay_sinh" type="date" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Số Điện Thoại</label>
                            <input v-model="edit_nhan_vien.so_dien_thoai" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Địa Chỉ</label>
                            <input v-model="edit_nhan_vien.dia_chi" type="text" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Lương Cơ Bản</label>
                            <input v-model="edit_nhan_vien.luong_co_ban" type="number" class="form-control">
                        </div>
                        <div class="mb-2">
                            <label>Chức Vụ</label>
                            <select v-model="edit_nhan_vien.id_chuc_vu" class="form-control mt-2">
                                <template v-for="(v, k) in list_chuc_vu" :key="k">
                                    <option v-bind:value="v.id">{{ v.ten_chuc_vu }}</option>
                                </template>
                            </select>
                        </div>
                        <div class="mb-2">
                            <label>Phòng Ban</label>
                            <select v-model="edit_nhan_vien.id_phong_ban" class="form-control mt-2">
                                <template v-for="(v, k) in list_phong_ban" :key="k">
                                    <option v-bind:value="v.id">{{ v.ten_phong_ban }}</option>
                                </template>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal"
                            v-on:click="capNhatNhanVien()">Cập
                            nhật</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="hopDongModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Tạo Hợp Đồng Nhân Viên</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <label class="form-label fw-bold">Chọn Hợp Đồng</label>
                                <select v-model="create_hop_dong.id_loai_hop_dong" v-on:change="loadNoiDung()"
                                    class="form-control">
                                    <template v-for="(v, k) in list_hop_dong" :key="k">
                                        <option v-bind:value="v.id">{{ v.ten_hop_dong }}</option>
                                    </template>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-lg-12">
                                <!-- <textarea v-model="create_hop_dong.noi_dung" class="form-control" cols="30"
                                    rows="10"></textarea> -->
                                <ckeditor v-model="create_hop_dong.noi_dung" :editor="editor"
                                    :config="editorConfig" />
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-lg-4">
                                <label class="form-label fw-bold">Ngày Bắt Đầu</label>
                                <input v-model="create_hop_dong.ngay_bat_dau" type="date" class="form-control">
                            </div>
                            <div class="col-lg-4">
                                <label class="form-label fw-bold">Ngày Kết Thúc</label>
                                <input v-model="create_hop_dong.ngay_ket_thuc" type="date" class="form-control">
                            </div>
                            <div class="col-lg-4">
                                <label class="form-label fw-bold">Ngày Ký</label>
                                <input v-model="create_hop_dong.ngay_ky" type="date" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal"
                            v-on:click="taoHopDong()">Tạo Hợp
                            Đồng</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios';
import { ClassicEditor, Bold, Essentials, Italic, Mention, Paragraph, Undo, Heading, BlockQuote, Font, Link, List, Alignment } from 'ckeditor5';
import { Ckeditor } from '@ckeditor/ckeditor5-vue';
import 'ckeditor5/ckeditor5.css';
export default {
    components: {
        Ckeditor
    },
    data() {
        return {
            create_nhan_vien: {},
            edit_nhan_vien: {},
            delete_nhan_vien: {},
            list_nhan_vien: [],
            list_chuc_vu: [],
            list_phong_ban: [],
            list_hop_dong: [],
            search: {},
            create_hop_dong: {},
            phan_quyen_nhan_vien: {},
            list_chuc_nang: [],
            editor: ClassicEditor,
            editorConfig: {
                plugins: [Bold, Essentials, Italic, Mention, Paragraph, Undo, Heading, BlockQuote, Font, Link, List, Alignment],
                toolbar: ['heading',
                    '|', 'undo', 'redo', '|', 'bold', 'italic',
                    'fontSize',
                    'fontFamily',
                    'fontColor',
                    '|',
                    'link',
                    'bulletedList',
                    'numberedList',
                    'blockQuote',
                    '|',
                    'Alignment'
                ],
            }
        }

    },
    mounted() {
        this.loadNhanVien();
        this.loadChucVu();
        this.loadPhongBan();
        this.loadHopDong();
    },
    methods: {
        removeQuyen(value) {
            value.id_nhan_vien = this.phan_quyen_nhan_vien.id
            axios
                .post('http://127.0.0.1:8000/api/admin/phan-quyen/delete', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadChucNang(this.phan_quyen_nhan_vien);
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        },
        setQuyen(value) {
            value.id_nhan_vien = this.phan_quyen_nhan_vien.id
            axios
                .post('http://127.0.0.1:8000/api/admin/phan-quyen/create', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadChucNang(this.phan_quyen_nhan_vien);
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        },
        loadChucNang(value) {
            this.phan_quyen_nhan_vien = value;
            axios
                .post('http://127.0.0.1:8000/api/admin/chuc-nang/data', this.phan_quyen_nhan_vien, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_chuc_nang = res.data.data
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        xuatExcel() {
            axios
                .get('http://127.0.0.1:8000/api/admin/nhan-vien/xuat-excel', {
                    responseType: 'blob',
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status == false) {
                        this.$toast.error(res.data.message);
                    }
                    const url = window.URL.createObjectURL(new Blob([res.data]));
                    const link = document.createElement('a');
                    link.href = url;
                    link.setAttribute('download', 'nhan_vien.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },
        loadNoiDung() {
            this.list_hop_dong.forEach((v, k) => {
                if (v.id == this.create_hop_dong.id_loai_hop_dong) {
                    this.create_hop_dong.noi_dung = v.noi_dung
                }
            })
        },
        taoHopDong() {
            axios
                .post('http://127.0.0.1:8000/api/admin/chi-tiet-hop-dong/create', this.create_hop_dong, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadNhanVien();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        },
        TimKiemBE() {
            axios
                .post('http://127.0.0.1:8000/api/admin/nhan-vien/tim-kiem', this.search, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_nhan_vien = res.data.data
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        },
        loadHopDong() {
            axios
                .get('http://127.0.0.1:8000/api/admin/loai-hop-dong/data-open', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_hop_dong = res.data.data;
                })
        },
        loadNhanVien() {
            axios
                .get('http://127.0.0.1:8000/api/admin/nhan-vien/data', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_nhan_vien = res.data.data;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        loadChucVu() {
            axios
                .get('http://127.0.0.1:8000/api/admin/chuc-vu/data-open', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_chuc_vu = res.data.data;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        loadPhongBan() {
            axios
                .get('http://127.0.0.1:8000/api/admin/phong-ban/data-open', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_phong_ban = res.data.data
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        createNhanVien() {
            axios
                .post('http://127.0.0.1:8000/api/admin/nhan-vien/create', this.create_nhan_vien, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadNhanVien();
                        this.create_nhan_vien = {};
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        },
        capNhatNhanVien() {
            axios
                .post('http://127.0.0.1:8000/api/admin/nhan-vien/update', this.edit_nhan_vien, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadNhanVien();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });

        },
        xoaNhanVien() {
            axios
                .post('http://127.0.0.1:8000/api/admin/nhan-vien/delete', this.delete_nhan_vien, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadNhanVien();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });

        },
        changeStatus(value) {
            axios
                .post('http://127.0.0.1:8000/api/admin/nhan-vien/change-status', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadNhanVien();
                    } else {
                        this.$toast.error(res.data.message);
                    }
                })
                .catch((res) => {
                    const errors = Object.values(res.response.data.errors);
                    errors.forEach((v) => {
                        this.$toast.error(v[0]);
                    });
                });
        }
    }
}
</script>
<style></style>
