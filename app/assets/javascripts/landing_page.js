/* Set the width of the side navigation to 250px */
function openNav() {
    
if (window.matchMedia('screen and (max-width:970px) , (max-height:465px').matches) {
// do smth
document.getElementById("mySidenav").style.width = "100%";
} else {
// do smth.else 
document.getElementById("mySidenav").style.width = "25%";
}



}

/* Set the width of the side navigation to 0 */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}

