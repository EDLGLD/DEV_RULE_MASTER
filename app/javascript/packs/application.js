import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import $ from 'jquery';  // jQueryをインポート
import 'bootstrap'; // BootstrapのJavaScriptをインポート
import '../stylesheets/application'; // CSSをインポート

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// jQueryをグローバルに設定
window.$ = window.jQuery = $;

// Turbolinksのイベントリスナーを追加
document.addEventListener('turbolinks:load', () => {
  // Bootstrapの初期化
  $('.dropdown-toggle').dropdown();
});
