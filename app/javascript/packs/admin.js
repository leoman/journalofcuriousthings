require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import SelectPure from "select-pure";
 
window.SelectPure = SelectPure;

import '../../assets/styles/admin.scss'
 
const componentRequireContext = require.context("components", true);
const ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);

const resizeHeader = () => {

  const html = document.getElementsByTagName('html')[0]
  const header = document.getElementsByTagName('header')[0]
  
  if (html.scrollTop > 100) {
    header.classList.add("shrink");
  }
  else {
    header.classList.remove("shrink");
  }
}

window.addEventListener("scroll", resizeHeader);