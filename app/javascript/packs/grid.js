function resizeGridItem(item){
  grid = document.getElementsByClassName("grid")[0];
  rowHeight = parseInt(window.getComputedStyle(grid).getPropertyValue('grid-auto-rows'));
  rowGap = parseInt(window.getComputedStyle(grid).getPropertyValue('grid-row-gap'));
  rowSpan = Math.ceil((item.querySelector('.content').getBoundingClientRect().height+rowGap)/(rowHeight+rowGap));
    item.style.gridRowEnd = "span "+rowSpan;
}

function resizeAllGridItems(){
  gridWrapper = document.getElementById('gridView');
  if(gridWrapper) {
    allItems = document.getElementById('gridView').getElementsByClassName("item");
    console.log(allItems.length, allItems);
    for(x=0;x<allItems.length;x++){
      resizeGridItem(allItems[x]);
    }
  }
}

function resizeInstance(instance){
	item = instance.elements[0];
  resizeGridItem(item);
}

window.onload = resizeAllGridItems();
window.addEventListener("resize", resizeAllGridItems);
document.addEventListener('DOMContentLoaded', (event) => resizeAllGridItems());
setTimeout(() => {
  resizeAllGridItems();
}, 1000);

allItems = document.getElementsByClassName("item");
for(x=0;x<allItems.length;x++){
  imagesLoaded( allItems[x], resizeInstance);
}