<template>
    <div class="row">
        <div class="col-lg-3">
            <div class="card">
                <div class="card-header">
                    <h5 class="mt-2"><b>THÊM MỚI QUY ĐỊNH ĐIỂM</b></h5>
                </div>
                <div class="card-body">
                    <div class="mb-2">
                        <label class="form-label">Mã Số</label>
                        <input v-model="create_quy_dinh_cho_diem.ma_so" type="text" class="form-control"
                            placeholder="Vd: QD001" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Số Điểm</label>
                        <input v-model="create_quy_dinh_cho_diem.so_diem" type="number" class="form-control"
                            placeholder="Vd: 10" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Nội Dung</label>
                        <input v-model="create_quy_dinh_cho_diem.noi_dung" type="text" class="form-control"
                            placeholder="Vd: Điểm cho công việc đúng hạn" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Ghi Chú</label>
                        <textarea v-model="create_quy_dinh_cho_diem.ghi_chu" class="form-control" cols="30"
                            rows="2"></textarea>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Loại Điểm</label>
                        <select v-model="create_quy_dinh_cho_diem.loai_diem" class="form-control">
                            <option value="0">Thưởng</option>
                            <option value="1">Phạt</option>
                        </select>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Tình Trạng</label>
                        <select v-model="create_quy_dinh_cho_diem.tinh_trang" class="form-control">
                            <option value="0">Tạm Tắt</option>
                            <option value="1">Hiển Thị</option>
                        </select>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <button @click="createQuyDinhChoDiem()" class="btn btn-primary">Thêm Mới</button>
                </div>
            </div>
        </div>
        <div class="col-lg-9">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mt-2"><b>DANH SÁCH QUY ĐỊNH ĐIỂM</b></h5>
                    <button @click="xuatExcel()" type="button" class="btn btn-success me-2">
                        <i class="fa-regular fa-file-excel"></i> Xuất Excel
                    </button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th class="text-center align-middle">#</th>
                                    <th class="text-center align-middle">Mã Số</th>
                                    <th class="text-center align-middle">Số Điểm</th>
                                    <th class="text-center align-middle">Nội Dung</th>
                                    <th class="text-center align-middle">Ghi Chú</th>
                                    <th class="text-center align-middle">Loại Điểm</th>
                                    <th class="text-center align-middle">Tình Trạng</th>
                                    <th class="text-center align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="(v, k) in list_quy_dinh_cho_diem" :key="k">
                                    <tr>
                                        <th class="align-middle text-center">{{ k + 1 }}</th>
                                        <td class="align-middle">{{ v.ma_so }}</td>
                                        <td class="align-middle text-center">{{ v.so_diem }}</td>
                                        <td class="align-middle text-nowrap">
                                            {{ v.noi_dung }}
                                        </td>
                                        <td class="align-middle text-nowrap">
                                            {{ v.ghi_chu }}
                                        </td>
                                        <td class="align-middle text-center">
                                            <template v-if="v.loai_diem == 0">
                                                Thưởng
                                            </template>
                                            <template v-else>
                                                Phạt
                                            </template>
                                        </td>
                                        <td class="align-middle text-nowrap text-center">
                                            <template v-if="v.tinh_trang == 1">
                                                <button v-on:click="changeStatus(v)" class="btn btn-success w-100">Hiển
                                                    Thị</button>
                                            </template>
                                            <template v-else>
                                                <button v-on:click="changeStatus(v)" class="btn btn-danger w-100">Tạm
                                                    Tắt</button>
                                            </template>
                                        </td>
                                        <td class="align-middle text-center">
                                            <button class="btn btn-primary me-2" data-bs-toggle="modal"
                                                v-on:click="Object.assign(edit_quy_dinh_cho_diem, v)"
                                                data-bs-target="#capnhatMGG">
                                                Cập nhật
                                            </button>
                                            <button class="btn btn-danger" data-bs-toggle="modal"
                                                v-on:click="Object.assign(delete_quy_dinh_cho_diem, v)"
                                                data-bs-target="#delModal">
                                                Xóa
                                            </button>
                                        </td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="capnhatMGG" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                            Cập Nhật Quy Định Điểm
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-2">
                            <label class="form-label">Mã Số</label>
                            <input v-model="edit_quy_dinh_cho_diem.ma_so" type="text" class="form-control"
                                placeholder="Vd: QD001" />
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Số Điểm</label>
                            <input v-model="edit_quy_dinh_cho_diem.so_diem" type="number" class="form-control"
                                placeholder="Vd: 10" />
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Nội Dung</label>
                            <input v-model="edit_quy_dinh_cho_diem.noi_dung" type="text" class="form-control"
                                placeholder="Vd: Điểm cho công việc đúng hạn" />
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Ghi Chú</label>
                            <textarea v-model="edit_quy_dinh_cho_diem.ghi_chu" class="form-control" cols="30"
                                rows="2"></textarea>
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Loại Điểm</label>
                            <select v-model="edit_quy_dinh_cho_diem.loai_diem" class="form-control">
                                <option value="0">Thưởng</option>
                                <option value="1">Phạt</option>
                            </select>
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Tình Trạng</label>
                            <select v-model="edit_quy_dinh_cho_diem.tinh_trang" class="form-control">
                                <option value="0">Tạm Tắt</option>
                                <option value="1">Hiển Thị</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Đóng
                        </button>
                        <button @click="capNhatQuyDinhChoDiem()" type="button" class="btn btn-primary"
                            data-bs-dismiss="modal">
                            Cập nhật
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="delModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                            Xóa Quy Định Điểm
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger border-0 bg-danger alert-dismissible fade show py-2">
                            <div class="d-flex align-items-center">
                                <div class="font-35 text-white"><i class="bx bxs-message-square-x"></i>
                                </div>
                                <div class="ms-1">
                                    <h6 class="mb-1 text-white">Bạn chắc chắc xóa quy định cho điểm <b>{{
                                        delete_quy_dinh_cho_diem.ma_so }}</b> này chứ
                                        !!!</h6>
                                    <div class="text-white text-nowrap"><b>LƯU Ý !!!</b> Điều này không thể khôi phục
                                        khi ấn xác nhận
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Đóng
                        </button>
                        <button @click="xoaQuyDinhChoDiem()" type="button" class="btn btn-danger"
                            data-bs-dismiss="modal">
                            Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios';
export default {
    data() {
        return {
            create_quy_dinh_cho_diem: {},
            edit_quy_dinh_cho_diem: {},
            delete_quy_dinh_cho_diem: {},
            list_quy_dinh_cho_diem: [],
        }

    },
    mounted() {
        this.loadQuyDinhChoDiem();
    },
    methods: {
        xuatExcel() {
            axios
                .get('http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/xuat-excel', {
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
                    link.setAttribute('download', 'quy_dinh_cho_diem.xlsx');
                    document.body.appendChild(link);
                    link.click();
                });
        },
        loadQuyDinhChoDiem() {
            axios
                .get('http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/data', {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    this.list_quy_dinh_cho_diem = res.data.data;
                    if (res.data.status == 0) {
                        this.$toast.error(res.data.message);
                    }
                })
        },
        createQuyDinhChoDiem() {
            axios
                .post('http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/create', this.create_quy_dinh_cho_diem, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadQuyDinhChoDiem();
                        this.create_quy_dinh_cho_diem = {};
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
        capNhatQuyDinhChoDiem() {
            axios
                .post('http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/update', this.edit_quy_dinh_cho_diem, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadQuyDinhChoDiem();
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
        xoaQuyDinhChoDiem() {
            axios
                .post('http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/delete', this.delete_quy_dinh_cho_diem, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadQuyDinhChoDiem();
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
                .post('http://127.0.0.1:8000/api/admin/quy-dinh-cho-diem/change-status', value, {
                    headers: {
                        Authorization: 'Bearer ' + localStorage.getItem("tk_nhan_vien")
                    }
                })
                .then((res) => {
                    if (res.data.status) {
                        this.$toast.success(res.data.message);
                        this.loadQuyDinhChoDiem();
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
