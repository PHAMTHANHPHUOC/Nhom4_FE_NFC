<template>
  <footer class="page-footer">
    <div class="footer-content">
      <p class="mb-0">Copyright © 2025. All right reserved.</p>
      <div class="footer-links">
        <a href="#" class="footer-link">Terms</a>
        <a href="#" class="footer-link">Privacy</a>
        <a href="#" class="footer-link">Contact</a>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: "FooterClient",
};
</script>

<style scoped>
.page-footer {
  background: #ffffff;
  padding: 1rem;
  border-top: 1px solid #e0e0e0;
  position: fixed;
  bottom: 0;
  width: 100%;
  z-index: 999;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.footer-links {
  display: flex;
  gap: 1.5rem;
}

.footer-link {
  color: #666;
  text-decoration: none;
  font-size: 0.9rem;
  transition: color 0.3s ease;
}

.footer-link:hover {
  color: #333;
}

@media (max-width: 768px) {
  .footer-content {
    flex-direction: column;
    text-align: center;
    gap: 0.5rem;
  }
}
</style>
