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
    for(x=0;x<allItems.length;x++){
      resizeGridItem(allItems[x]);
    }
  }
}

function resizeInstance(instance){
	item = instance.elements[0];
  resizeGridItem(item);
}

// window.onload = resizeAllGridItems();
window.addEventListener("resize", resizeAllGridItems);
document.addEventListener('DOMContentLoaded', (event) => resizeAllGridItems());
// setTimeout(() => {
//   resizeAllGridItems();
// }, 1000);


document.addEventListener('DOMContentLoaded', () => {

  let counter = 0;
  if(document.getElementById('gridView')) {

    function incrementCounter() {
      counter++;
      if ( counter === length ) {
        console.log('handle the resizeAllGridItems');
        resizeAllGridItems();
      }
    }

    console.log('handle the grid!');
    const grid = document.getElementById('gridView');
    const images = grid.getElementsByTagName('img');
    const length = images.length;

    [].forEach.call( images, function( image ) {
      if(image.complete) {
        incrementCounter();
      } else {
        image.addEventListener( 'load', incrementCounter, false );
      }
    });
  }

});