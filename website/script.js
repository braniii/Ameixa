// @license magnet:?xt=urn:btih:c80d50af7d3db9be66a4d0a86db0286e4fd33292&dn=bsd-x3-clause.txt
var lazyImageObserver = new IntersectionObserver(function(entries, observer){
  entries.forEach(function(entry){
    if (entry.isIntersecting) {
      let lazyImage = entry.target;
      lazyImage.src = lazyImage.dataset.src;
      lazyImage.className = '';
      lazyImageObserver.unobserve(lazyImage);
    }
  });
});

function openPopup(){
  var fig = document.createElement('figure');
  var title = document.createElement('figcaption');
  title.appendChild(document.createTextNode(this.title));
  var img = document.createElement('img');
  img.src = this.src;
  img.alt = this.alt;
  fig.onclick = closePopup;
  fig.appendChild(title);
  fig.appendChild(img);
  document.body.appendChild(fig);
}

function closePopup(){
  var fig = document.getElementsByTagName('figure')[0];
  fig.parentNode.removeChild(fig);
}

function search(){
  document.getElementById('results').setAttribute('aria-disabled', 'false');
  var busq = '.tab img[title*="'+this.value.toLocaleLowerCase()+'"]';
  var todo = '.tab img';
  var validos = Array.prototype.slice.call(document.querySelectorAll(busq));
  var todos = Array.prototype.slice.call(document.querySelectorAll(todo));
  for (var i of todos){
    if (this.value){
      if (validos.indexOf(i) == -1){
        i.style.display = 'none';
      }else{
        i.style.display = 'inline-block';
      }
    }else{
      i.style.display = 'inline-block';
    }
  }
}

function toggleColor(){
  if (this.getAttribute('data-colored')){
    document.getElementsByClassName('tab')[0].style.display = 'none';
    document.getElementsByClassName('tab')[1].style.display = 'grid';
    this.removeAttribute('data-colored');
  }else{
    document.getElementsByClassName('tab')[1].style.display = 'none';
    document.getElementsByClassName('tab')[0].style.display = 'grid';
    this.dataset.colored = 'true';
  }
}

function sortIcons(a, b){
  var nameA = a.getAttribute('drawable');
  var nameB = b.getAttribute('drawable');
  if (nameA < nameB){ return -1; }
  if (nameA > nameB){ return 1; }
  return 0;
}

function genImageGrid(){
  var parse = new DOMParser();
  var xmldoc = parse.parseFromString(this.responseText, 'application/xml');
  // Generate carrousel
  var docs = Array.prototype.slice.call(xmldoc.querySelectorAll('item'));
  var latest = docs.slice(-8);
  var carrousel = document.createElement('section');
  carrousel.id = 'carrousel';
  carrousel.innerHTML = '<h2>Latest icons</h2><div class="latest content"></div>';
  for (var i of latest){
    var im = document.createElement('img');
    im.src = 'https://gitlab.com/xphnx/ameixa/raw/master/icons/chromatic/' + i.attributes.drawable.value + '.svg';
    im.alt = i.attributes.drawable.value;
    im.title = i.attributes.drawable.value;
    carrousel.children[1].appendChild(im);
  }
  var abst = document.getElementById('abstract');
  abst.parentNode.insertBefore(carrousel, abst.nextSibling);
  // Generate grid
  for (var i of docs.sort(sortIcons)){
    // Chromatic
    var im = document.createElement('img');
    im.className = 'lazy';
    lazyImageObserver.observe(im);
    im.src = 'c.svg';
    im.dataset.src = 'https://gitlab.com/xphnx/ameixa/raw/master/icons/chromatic/' + i.attributes.drawable.value + '.svg';
    im.alt = i.attributes.drawable.value;
    im.title = i.attributes.drawable.value;
    im.onclick = openPopup;
    document.getElementsByClassName('tab')[0].appendChild(im);
    // Monochromatic
    im = document.createElement('img');
    im.className = 'lazy';
    lazyImageObserver.observe(im);
    im.src = 'mc.svg';
    im.dataset.src = 'https://gitlab.com/xphnx/ameixa/raw/master/icons/monochromatic/' + i.attributes.drawable.value + '.svg';
    im.alt = i.attributes.drawable.value;
    im.title = i.attributes.drawable.value;
    im.onclick = openPopup;
    document.getElementsByClassName('tab')[1].appendChild(im);
  }
}
document.addEventListener("DOMContentLoaded", function(){
  document.getElementById('colored').onclick = toggleColor;
  document.getElementsByClassName('tab')[1].style.display = 'none';
  document.getElementById('search').oninput = search;
  //var b = new XMLHttpRequest();
  //b.open('GET', 'https://cors-anywhere.herokuapp.com/https://gitlab.com/xphnx/ameixa/raw/website/newdrawable.xml');
  //b.open('GET', 'newdrawable.xml');
  //b.onload = genImageCarrousel;
  //b.send();
  var a = new XMLHttpRequest();
  a.open('GET', 'https://cors-anywhere.herokuapp.com/https://gitlab.com/xphnx/ameixa/-/raw/website/website/drawable.xml');
  a.onload = genImageGrid;
  a.send();
});
// @license-end
