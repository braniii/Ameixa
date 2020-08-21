// @licensd magnet:?xt=urn:btih:c80d50af7d3db9be66a4d0a86db0286e4fd33292&dn=bsd-3-clause.txt BSD license
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

function abrirPopup(){
  var fig = document.createElement('figure');
  var title = document.createElement('figcaption');
  title.appendChild(document.createTextNode(this.title));
  var img = document.createElement('img');
  img.src = this.src;
  img.alt = this.alt;
  //var c = document.createElement('button');
  //c.append(document.createTextNode('Close'));
  //c.onclick = cerrarPopup;
  fig.onclick = cerrarPopup;
  fig.appendChild(title);
  fig.appendChild(img);
  //fig.appendChild(c);
  document.body.appendChild(fig)
}

function cerrarPopup(){
  var fig = document.getElementsByTagName('figure')[0];
  fig.parentNode.removeChild(fig);
}

function buscar(){
  document.getElementById('results').setAttribute('aria-disabled', 'false');
  var busq = '.tab img[title*="'+this.value.toLocaleLowerCase()+'"]';
  var todo = '.tab img';
  var validos = Array.prototype.slice.call(document.querySelectorAll(busq));
  var todos = Array.prototype.slice.call(document.querySelectorAll(todo));
  for (i of todos){
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

function genImageGrid(){
  var parse = new DOMParser();
  var xmldoc = parse.parseFromString(this.responseText, 'application/xml');
  var docs = xmldoc.querySelectorAll('item');
  //var loading = document.getElementsByTagName('p')[0];
  //loading.parentNode.removeChild(loading);
  for (i of docs){
    // Chromatic
    var im = document.createElement('img');
    im.className = 'lazy';
    lazyImageObserver.observe(im);
    im.src = 'c.svg';
    im.dataset.src = 'https://gitlab.com/xphnx/ameixa/raw/master/icons/chromatic/' + i.attributes.drawable.value + '.svg';
    im.alt = i.attributes.drawable.value;
    im.title = i.attributes.drawable.value;
    im.onclick = abrirPopup;
    document.getElementsByClassName('tab')[0].appendChild(im);
    // Monochromatic
    im = document.createElement('img');
    im.className = 'lazy';
    lazyImageObserver.observe(im);
    im.src = 'mc.svg';
    im.dataset.src = 'https://gitlab.com/xphnx/ameixa/raw/master/icons/monochromatic/' + i.attributes.drawable.value + '.svg';
    im.alt = i.attributes.drawable.value;
    im.title = i.attributes.drawable.value;
    im.onclick = abrirPopup;
    document.getElementsByClassName('tab')[1].appendChild(im);
  }
}
document.addEventListener("DOMContentLoaded", function(){
  document.getElementById('colored').onclick = toggleColor;
  document.getElementsByClassName('tab')[1].style.display = 'none';
  document.getElementById('search').oninput = buscar;
  var a = new XMLHttpRequest();
  a.open('GET', 'https://cors-anywhere.herokuapp.com/https://gitlab.com/xphnx/ameixa/-/raw/website/website/drawable.xml');
  a.onload = genImageGrid;
  a.send();
});
// @license-end
