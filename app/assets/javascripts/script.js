
// --------------- Responsive Menu -------------- //
function responsiveMenu() {
  var topMenuBtn = document.getElementsByClassName("top-menu-btn")[0];
  var topNavigation =  document.getElementsByClassName("menu")[0];

  topMenuBtn.addEventListener("click", toggleNavigation);
  function toggleNavigation() {
    if(topNavigation.style.display !== "block")
    topNavigation.style.display = "block";
    else
    topNavigation.style.display = "none";
  }
}

// --------------- Drop down (menu) ------------- //
function dropdownFood() {
  var button = document.getElementsByClassName("dropdown-trigger");

  for(var i = 0; i < button.length; i++) {
    button[i].addEventListener("click", function() {
      var list = this.nextSibling;

      if(list.style.display !== "block")
        list.style.display = "block";
      else
        list.style.display = "none";
    });
  }
}
// -------------- Buy Product (menu) ----------- //

// --------------- Fixed Sidebar --------------- //
function fixedSidebar() {

  var sidebar = document.getElementsByClassName("fixedSidebar")[0];
  var sidebarParent = document.getElementsByClassName("sidebarContainer")[0];

  var viewportOffset = sidebar.getBoundingClientRect();
  var fromTop = viewportOffset.top;

  window.addEventListener("scroll", function() {

    var width = sidebarParent.offsetWidth;
    if(this.scrollY >= fromTop) {
      sidebar.style.cssText = "position:fixed; top:0px; width:"+width+"px; padding-bottom: 40px;";
    }
    else {
      sidebar.style.cssText = "position:static;";
    }
  });
}
/*
$(function() {
responsiveMenu();
dropdownFood();
buyProduct();
removeProduct();
fixedSidebar();
showHideMyOrder();
});
*/
