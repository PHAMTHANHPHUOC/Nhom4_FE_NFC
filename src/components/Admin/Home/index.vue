<script setup>
import { ref } from "vue";

const currentDate = ref(
  new Date().toLocaleDateString("vi-VN", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  })
);
</script>

<template>
  <div class="dashboard">
    <!-- Header -->
    <div class="header">
      <div class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Tìm kiếm nhân viên..." />
      </div>
    </div>

    <div class="date">{{ currentDate }}</div>

    <!-- Statistics Cards -->
    <div class="stats-container">
      <div class="stat-card">
        <div class="stat-icon blue">
          <i class="fas fa-users"></i>
        </div>
        <div class="stat-info">
          <h3>Tổng nhân viên</h3>
          <p>--</p>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon green">
          <i class="fas fa-check-circle"></i>
        </div>
        <div class="stat-info">
          <h3>Đã điểm danh</h3>
          <p>--/--</p>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon yellow">
          <i class="fas fa-clock"></i>
        </div>
        <div class="stat-info">
          <h3>Đi muộn</h3>
          <p>--</p>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon red">
          <i class="fas fa-user-times"></i>
        </div>
        <div class="stat-info">
          <h3>Vắng mặt</h3>
          <p>--</p>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-grid">
      <!-- Left Section -->
      <div class="attendance-section">
        <div class="section-header">
          <h2>Chấm công hôm nay</h2>
          <div class="controls">
            <div class="filter">
              <i class="fas fa-filter"></i>
              <select>
                <option>Tất cả phòng ban</option>
              </select>
            </div>
            <button class="btn-export">
              <i class="fas fa-download"></i>
              Xuất báo cáo
            </button>
          </div>
        </div>

        <div class="attendance-list">
          <div class="list-header">
            <span>Nhân viên</span>
            <span>Phòng ban</span>
            <span>Giờ vào</span>
            <span>Giờ ra</span>
            <span>Trạng thái</span>
          </div>
          <!-- Sample attendance record -->
          <div class="list-item">
            <div class="employee-info">
              <span>Nguyễn Văn A</span>
            </div>
            <span>Kỹ thuật</span>
            <span>--:--</span>
            <span>--:--</span>
            <span class="status on-time">Đúng giờ</span>
          </div>
        </div>
      </div>

      <!-- Right Section -->
      <div class="side-section">
        <!-- Quick Actions -->
        <div class="quick-actions">
          <h3>Thao tác nhanh</h3>
          <div class="action-grid">
            <button class="action-btn">
              <i class="fas fa-user-plus"></i>
              <span>Thêm nhân viên</span>
            </button>
            <button class="action-btn">
              <i class="fas fa-id-card"></i>
              <span>Quản lý thẻ</span>
            </button>
            <button class="action-btn">
              <i class="fas fa-calendar-alt"></i>
              <span>Lịch làm việc</span>
            </button>
            <button class="action-btn">
              <i class="fas fa-chart-line"></i>
              <span>Báo cáo</span>
            </button>
          </div>
        </div>

        <!-- Recent Activities -->
        <div class="recent-activities">
          <h3>Hoạt động gần đây</h3>
          <div class="activity-feed">
            <div class="activity-item">
              <div class="activity-dot green"></div>
              <div class="activity-content">
                <p>Quẹt thẻ vào</p>
                <span class="time">2 phút trước</span>
              </div>
            </div>
            <div class="activity-item">
              <div class="activity-dot yellow"></div>
              <div class="activity-content">
                <p>Cập nhật thông tin thẻ</p>
                <span class="time">5 phút trước</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dashboard {
  padding: 1.5rem;
  background: #f8fafc;
  min-height: 100vh;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.search-box {
  display: flex;
  align-items: center;
  background: white;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  width: 300px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.search-box input {
  border: none;
  outline: none;
  margin-left: 0.5rem;
  width: 100%;
}

.profile {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.profile img {
  border-radius: 50%;
  border: 2px solid #e2e8f0;
}

.date {
  color: #64748b;
  margin-bottom: 2rem;
}

.stats-container {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.stat-card {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  transition: transform 0.2s;
}

.stat-card:hover {
  transform: translateY(-2px);
}

.stat-icon {
  padding: 1rem;
  border-radius: 10px;
  font-size: 1.5rem;
}

.blue {
  background: #dbeafe;
  color: #2563eb;
}
.green {
  background: #dcfce7;
  color: #16a34a;
}
.yellow {
  background: #fef3c7;
  color: #d97706;
}
.red {
  background: #fee2e2;
  color: #dc2626;
}

.stat-info h3 {
  color: #64748b;
  font-size: 0.875rem;
  margin-bottom: 0.5rem;
}

.stat-info p {
  font-size: 1.5rem;
  font-weight: bold;
  color: #1e293b;
}

.main-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 1.5rem;
}

.attendance-section,
.side-section > div {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  margin-bottom: 1.5rem;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.controls {
  display: flex;
  gap: 1rem;
}

.filter select {
  border: 1px solid #e2e8f0;
  padding: 0.5rem;
  border-radius: 6px;
  outline: none;
}

.btn-export {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: #2563eb;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.list-header {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
  padding: 1rem;
  background: #f8fafc;
  border-radius: 8px;
  font-weight: 500;
  color: #64748b;
}

.list-item {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
  padding: 1rem;
  align-items: center;
  border-bottom: 1px solid #f1f5f9;
}

.employee-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.employee-info img {
  border-radius: 50%;
}

.status {
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.875rem;
  text-align: center;
}

.on-time {
  background: #dcfce7;
  color: #16a34a;
}

.action-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  margin-top: 1rem;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: #f8fafc;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.action-btn:hover {
  background: #f1f5f9;
  transform: translateY(-2px);
}

.activity-feed {
  margin-top: 1rem;
}

.activity-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 0.75rem 0;
  border-bottom: 1px solid #f1f5f9;
}

.activity-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-top: 0.5rem;
}

.activity-content p {
  margin-bottom: 0.25rem;
}

.time {
  font-size: 0.75rem;
  color: #94a3b8;
}
</style>
