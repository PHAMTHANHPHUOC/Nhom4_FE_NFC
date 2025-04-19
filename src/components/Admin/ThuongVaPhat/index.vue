<template>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center mt-2">
                    <h6><b>DANH SÁCH THƯỞNG VÀ PHẠT</b></h6>
                    <div>
                        <button @click="xuatExcel()" type="button" class="btn btn-success me-2">
                            <i class="fa-regular fa-file-excel"></i> Xuất Excel
                        </button>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#themMoiModal">
                            Thêm Mới
                        </button>
                    </div>
                </div>
                <div class="card-body table-responsive">
                    <div class="input-group mt-3 w-100">
                        <input type="text" v-model="search.noi_dung"
                            class="form-control search-control border border-1 border-secondary"
                            placeholder="Search..." />
                        <span class="position-absolute top-50 search-show translate-middle-y" style="left: 15px"><i
                                class="bx bx-search"></i></span>
                        <button class="btn btn-outline-secondary" type="button" id="button-addon2"
                            v-on:click="TimKiemThuongVaPhat()">
                            Tìm Kiếm
                        </button>
                    </div>
                    <table class="table table-bordered table-hover mt-2">
                        <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th class="text-center">Nhân Viên</th>
                                <th class="text-center">Người Cho Điểm</th>
                                <th class="text-center">Quy Định</th>
                                <th class="text-center">Điểm</th>
                                <th class="text-center">Lý Do</th>
                                <th class="text-center">Ngày Thưởng</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(v, k) in list_thuong_va_phat" :key="k">
                                <th class="align-middle text-center">{{ k + 1 }}</th>
                                <td class="align-middle">{{ v.ho_va_ten }}</td>
                                <td class="align-middle">{{ v.ten_nhan_vien_cho_diem }}</td>
                                <td class="align-middle"> {{ v.noi_dung }} </td>
                                <td class="align-middle text-center">{{ v.diem }}</td>
                                <td class="align-middle">{{ v.ly_do }}</td>
                                <td class="align-middle text-center">{{ v.ngay }}</td>
                                <td class="align-middle text-center">
                                    <button v-on:click="Object.assign(update, v)" class="btn btn-primary me-2"
                                        data-bs-toggle="modal" data-bs-target="#capnhatDM">
                                        Cập nhật
                                    </button>
                                    <button v-on:click="Object.assign(del, v)" class="btn btn-danger"
                                        data-bs-toggle="modal" data-bs-target="#delModal">
                                        Xóa
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                            Thêm Mới Thưởng Và Phạt
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Chọn Nhân Viên</label>
                            <select v-model="create.id_nhan_vien" class="form-control mt-1">
                                <template v-for="(v, k) in list_nhan_vien" :key="k">
                                    <option v-bind:value="v.id">{{ v.ho_va_ten }}</option>
                                </template>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Chọn Quy Định</label>
                            <select v-model="create.id_quy_dinh" class="form-control mt-1">
                                <template v-for="(v, k) in list_quy_dinh" :key="k">
                                    <option v-bind:value="v.id">{{ v.noi_dung }}</option>
                                </template>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Lý Do</label>
                            <textarea v-model="create.ly_do" class="form-control" cols="30" rows="10"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Đóng
                        </button>
                        <button v-on:click="createThuongvaPhat()" class="btn btn-primary" data-bs-dismiss="modal">
                            Thêm Mới
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="delModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Xóa Thưởng Hoặc Phạt</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
                            <div class="d-flex align-items-center">
                                <div class="font-35 text-white">
                                    <i class="bx bxs-message-square-x"></i>
                                </div>
                                <div class="ms-1">
                                    <h6 class="mb-1 text-white">
                                        Bạn chắc chắc xóa thưởng hoặc phạt <b>{{ del.noi_dung }}</b> của
                                        <b>{{ del.ho_va_ten }}</b> này
                                        chứ !!!
                                    </h6>
                                    <div class="text-white text-nowrap">
                                        <b>LƯU Ý !!!</b> Điều này không thể khôi phục khi ấn xác
                                        nhận
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Đóng
                        </button>
                        <button v-on:click="delThuongVaPhat()" type="button" class="btn btn-danger"
                            data-bs-dismiss="modal">
                            Xác nhận
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="capnhatDM" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                            Cập nhật Thưởng Hoặc Phạt
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Chọn Nhân Viên</label>
                            <select v-model="update.id_nhan_vien" class="form-control mt-1">
                                <template v-for="(v, k) in list_nhan_vien" :key="k">
                                    <option v-bind:value="v.id">{{ v.ho_va_ten }}</option>
                                </template>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Chọn Quy Định</label>
                            <select v-model="update.id_quy_dinh" class="form-control mt-1">
                                <template v-for="(v, k) in list_quy_dinh" :key="k">
                                    <option v-bind:value="v.id">{{ v.noi_dung }}</option>
                                </template>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Lý Do</label>
                            <textarea v-model="update.ly_do" class="form-control" cols="30" rows="10"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Đóng
                        </button>
                        <button v-on:click="updateThuongVaPhat()" type="button" class="btn btn-primary"
                            data-bs-dismiss="modal">
                            Cập nhật
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data() {
        return {
            list_nhan_vien: [],
            list_quy_dinh: [],
            list_thuong_va_phat: [],
            create: {},
            update: {},
            del: {},
            search: {}
        };
    },
    mounted() {
        this.loadDataNhanVien();
        this.loadDataQuyDinh();
        this.loadDataThuongVaPhat();
    },
    methods: {
        xuatExcel() {
            axios
                .get('http://127.0.0.1:8000/api/admin/thuong-va-phat/xuat-excel', {
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
                    link.setAttribute('download', 'thuong_va_phat.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },
        loadDataNhanVien() {
            axios
                .get("http://127.0.0.1:8000/api/admin/nhan-vien/data-open", {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_nhan_vien = res.data.data;
                });
        },

        loadDataQuyDinh() {
            axios
                .get("http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/data-open", {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_quy_dinh = res.data.data;
                });
        },

        loadDataThuongVaPhat() {
            axios
                .get('http://127.0.0.1:8000/api/admin/thuong-va-phat/data', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_thuong_va_phat = res.data.data;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                });
        },

        createThuongvaPhat() {
            axios
                .post('http://127.0.0.1:8000/api/admin/thuong-va-phat/create', this.create, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadDataThuongVaPhat();
                        this.create = {};
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

        updateThuongVaPhat() {
            axios
                .post('http://127.0.0.1:8000/api/admin/thuong-va-phat/update', this.update, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadDataThuongVaPhat();
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

        delThuongVaPhat() {
            axios
                .post('http://127.0.0.1:8000/api/admin/thuong-va-phat/delete', this.del, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadDataThuongVaPhat();
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
        TimKiemThuongVaPhat() {
            axios
                .post('http://127.0.0.1:8000/api/admin/thuong-va-phat/tim-kiem', this.search, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_thuong_va_phat = res.data.data
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
    },
};
</script>
<style></style>
