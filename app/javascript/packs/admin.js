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