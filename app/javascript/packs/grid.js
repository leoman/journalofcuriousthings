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

window.addEventListener("resize", resizeAllGridItems);

document.addEventListener("turbolinks:load", function() {

  let counter = 0;
  if(document.getElementById('gridView')) {

    function incrementCounter() {
      counter++;
      if ( counter === length ) {
        resizeAllGridItems();
      }
    }

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