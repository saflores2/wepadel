const toggleButton = document.getElementById('toggle-sidebar');
const sidebar = document.querySelector('.sidebar');

toggleButton.addEventListener('click', () => {
  sidebar.classList.toggle('hidden');
});
