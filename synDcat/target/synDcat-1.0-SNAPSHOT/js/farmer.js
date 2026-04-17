// Smooth Scroll Top
document.querySelector('.back-to-top').addEventListener('click', function(e){
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

// Auto hide alerts
setTimeout(() => {
    document.querySelectorAll('.alert').forEach(alert => {
        alert.style.transition = "opacity 0.5s";
        alert.style.opacity = "0";
        setTimeout(()=> alert.remove(), 500);
    });
}, 4000);

// Navbar active highlight on click
document.querySelectorAll('.nav-menu a').forEach(link => {
    link.addEventListener('click', function(){
        document.querySelectorAll('.nav-menu li').forEach(li => li.classList.remove('menu-active'));
        this.parentElement.classList.add('menu-active');
    });
});