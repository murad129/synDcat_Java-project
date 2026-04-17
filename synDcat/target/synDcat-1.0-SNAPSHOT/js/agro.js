// Back To Top Smooth Scroll
document.querySelector('.back-to-top').addEventListener('click', function(e){
    e.preventDefault();
    window.scrollTo({top:0, behavior:'smooth'});
});

// Auto hide alerts after 4 seconds
setTimeout(() => {
    let alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        alert.style.transition = "opacity 0.5s";
        alert.style.opacity = "0";
        setTimeout(()=> alert.remove(), 500);
    });
}, 4000);