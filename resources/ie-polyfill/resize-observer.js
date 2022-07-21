/**
 * Minified by jsDelivr using Terser v5.3.5.
 * Original file: /npm/@juggle/resize-observer@3.3.1/lib/exports/resize-observer.umd.js
 *
 * Do NOT use SRI with dynamically generated files! More information: https://www.jsdelivr.com/using-sri-with-dynamic-files
 */
!function(e,t){"object"==typeof exports&&"undefined"!=typeof module?t(exports):"function"==typeof define&&define.amd?define(["exports"],t):t((e="undefined"!=typeof globalThis?globalThis:e||self).ResizeObserver={})}(this,(function(e){"use strict";var t,n=[],r="ResizeObserver loop completed with undelivered notifications.";!function(e){e.BORDER_BOX="border-box",e.CONTENT_BOX="content-box",e.DEVICE_PIXEL_CONTENT_BOX="device-pixel-content-box"}(t||(t={}));var i,o=function(e){return Object.freeze(e)},s=function(e,t){this.inlineSize=e,this.blockSize=t,o(this)},a=function(){function e(e,t,n,r){return this.x=e,this.y=t,this.width=n,this.height=r,this.top=this.y,this.left=this.x,this.bottom=this.top+this.height,this.right=this.left+this.width,o(this)}return e.prototype.toJSON=function(){var e=this;return{x:e.x,y:e.y,top:e.top,right:e.right,bottom:e.bottom,left:e.left,width:e.width,height:e.height}},e.fromRect=function(t){return new e(t.x,t.y,t.width,t.height)},e}(),c=function(e){return e instanceof SVGElement&&"getBBox"in e},u=function(e){if(c(e)){var t=e.getBBox(),n=t.width,r=t.height;return!n&&!r}var i=e,o=i.offsetWidth,s=i.offsetHeight;return!(o||s||e.getClientRects().length)},h=function(e){var t,n;if(e instanceof Element)return!0;var r=null===(n=null===(t=e)||void 0===t?void 0:t.ownerDocument)||void 0===n?void 0:n.defaultView;return!!(r&&e instanceof r.Element)},f="undefined"!=typeof window?window:{},d=new WeakMap,v=/auto|scroll/,l=/^tb|vertical/,p=/msie|trident/i.test(f.navigator&&f.navigator.userAgent),g=function(e){return parseFloat(e||"0")},b=function(e,t,n){return void 0===e&&(e=0),void 0===t&&(t=0),void 0===n&&(n=!1),new s((n?t:e)||0,(n?e:t)||0)},w=o({devicePixelContentBoxSize:b(),borderBoxSize:b(),contentBoxSize:b(),contentRect:new a(0,0,0,0)}),x=function(e,t){if(void 0===t&&(t=!1),d.has(e)&&!t)return d.get(e);if(u(e))return d.set(e,w),w;var n=getComputedStyle(e),r=c(e)&&e.ownerSVGElement&&e.getBBox(),i=!p&&"border-box"===n.boxSizing,s=l.test(n.writingMode||""),h=!r&&v.test(n.overflowY||""),f=!r&&v.test(n.overflowX||""),x=r?0:g(n.paddingTop),E=r?0:g(n.paddingRight),T=r?0:g(n.paddingBottom),y=r?0:g(n.paddingLeft),m=r?0:g(n.borderTopWidth),z=r?0:g(n.borderRightWidth),S=r?0:g(n.borderBottomWidth),B=y+E,O=x+T,R=(r?0:g(n.borderLeftWidth))+z,C=m+S,k=f?e.offsetHeight-C-e.clientHeight:0,N=h?e.offsetWidth-R-e.clientWidth:0,D=i?B+R:0,M=i?O+C:0,_=r?r.width:g(n.width)-D-N,P=r?r.height:g(n.height)-M-k,F=_+B+N+R,I=P+O+k+C,L=o({devicePixelContentBoxSize:b(Math.round(_*devicePixelRatio),Math.round(P*devicePixelRatio),s),borderBoxSize:b(F,I,s),contentBoxSize:b(_,P,s),contentRect:new a(y,x,_,P)});return d.set(e,L),L},E=function(e,n,r){var i=x(e,r),o=i.borderBoxSize,s=i.contentBoxSize,a=i.devicePixelContentBoxSize;switch(n){case t.DEVICE_PIXEL_CONTENT_BOX:return a;case t.BORDER_BOX:return o;default:return s}},T=function(e){var t=x(e);this.target=e,this.contentRect=t.contentRect,this.borderBoxSize=o([t.borderBoxSize]),this.contentBoxSize=o([t.contentBoxSize]),this.devicePixelContentBoxSize=o([t.devicePixelContentBoxSize])},y=function(e){if(u(e))return 1/0;for(var t=0,n=e.parentNode;n;)t+=1,n=n.parentNode;return t},m=function(){var e=1/0,t=[];n.forEach((function(n){if(0!==n.activeTargets.length){var r=[];n.activeTargets.forEach((function(t){var n=new T(t.target),i=y(t.target);r.push(n),t.lastReportedSize=E(t.target,t.observedBox),i<e&&(e=i)})),t.push((function(){n.callback.call(n.observer,r,n.observer)})),n.activeTargets.splice(0,n.activeTargets.length)}}));for(var r=0,i=t;r<i.length;r++){(0,i[r])()}return e},z=function(e){n.forEach((function(t){t.activeTargets.splice(0,t.activeTargets.length),t.skippedTargets.splice(0,t.skippedTargets.length),t.observationTargets.forEach((function(n){n.isActive()&&(y(n.target)>e?t.activeTargets.push(n):t.skippedTargets.push(n))}))}))},S=function(){var e,t=0;for(z(t);n.some((function(e){return e.activeTargets.length>0}));)t=m(),z(t);return n.some((function(e){return e.skippedTargets.length>0}))&&("function"==typeof ErrorEvent?e=new ErrorEvent("error",{message:r}):((e=document.createEvent("Event")).initEvent("error",!1,!1),e.message=r),window.dispatchEvent(e)),t>0},B=[],O=function(e){if(!i){var t=0,n=document.createTextNode("");new MutationObserver((function(){return B.splice(0).forEach((function(e){return e()}))})).observe(n,{characterData:!0}),i=function(){n.textContent=""+(t?t--:t++)}}B.push(e),i()},R=0,C={attributes:!0,characterData:!0,childList:!0,subtree:!0},k=["resize","load","transitionend","animationend","animationstart","animationiteration","keyup","keydown","mouseup","mousedown","mouseover","mouseout","blur","focus"],N=function(e){return void 0===e&&(e=0),Date.now()+e},D=!1,M=new(function(){function e(){var e=this;this.stopped=!0,this.listener=function(){return e.schedule()}}return e.prototype.run=function(e){var t=this;if(void 0===e&&(e=250),!D){D=!0;var n,r=N(e);n=function(){var n=!1;try{n=S()}finally{if(D=!1,e=r-N(),!R)return;n?t.run(1e3):e>0?t.run(e):t.start()}},O((function(){requestAnimationFrame(n)}))}},e.prototype.schedule=function(){this.stop(),this.run()},e.prototype.observe=function(){var e=this,t=function(){return e.observer&&e.observer.observe(document.body,C)};document.body?t():f.addEventListener("DOMContentLoaded",t)},e.prototype.start=function(){var e=this;this.stopped&&(this.stopped=!1,this.observer=new MutationObserver(this.listener),this.observe(),k.forEach((function(t){return f.addEventListener(t,e.listener,!0)})))},e.prototype.stop=function(){var e=this;this.stopped||(this.observer&&this.observer.disconnect(),k.forEach((function(t){return f.removeEventListener(t,e.listener,!0)})),this.stopped=!0)},e}()),_=function(e){!R&&e>0&&M.start(),!(R+=e)&&M.stop()},P=function(){function e(e,n){this.target=e,this.observedBox=n||t.CONTENT_BOX,this.lastReportedSize={inlineSize:0,blockSize:0}}return e.prototype.isActive=function(){var e,t=E(this.target,this.observedBox,!0);return e=this.target,c(e)||function(e){switch(e.tagName){case"INPUT":if("image"!==e.type)break;case"VIDEO":case"AUDIO":case"EMBED":case"OBJECT":case"CANVAS":case"IFRAME":case"IMG":return!0}return!1}(e)||"inline"!==getComputedStyle(e).display||(this.lastReportedSize=t),this.lastReportedSize.inlineSize!==t.inlineSize||this.lastReportedSize.blockSize!==t.blockSize},e}(),F=function(e,t){this.activeTargets=[],this.skippedTargets=[],this.observationTargets=[],this.observer=e,this.callback=t},I=new WeakMap,L=function(e,t){for(var n=0;n<e.length;n+=1)if(e[n].target===t)return n;return-1},W=function(){function e(){}return e.connect=function(e,t){var n=new F(e,t);I.set(e,n)},e.observe=function(e,t,r){var i=I.get(e),o=0===i.observationTargets.length;L(i.observationTargets,t)<0&&(o&&n.push(i),i.observationTargets.push(new P(t,r&&r.box)),_(1),M.schedule())},e.unobserve=function(e,t){var r=I.get(e),i=L(r.observationTargets,t),o=1===r.observationTargets.length;i>=0&&(o&&n.splice(n.indexOf(r),1),r.observationTargets.splice(i,1),_(-1))},e.disconnect=function(e){var t=this,n=I.get(e);n.observationTargets.slice().forEach((function(n){return t.unobserve(e,n.target)})),n.activeTargets.splice(0,n.activeTargets.length)},e}(),X=function(){function e(e){if(0===arguments.length)throw new TypeError("Failed to construct 'ResizeObserver': 1 argument required, but only 0 present.");if("function"!=typeof e)throw new TypeError("Failed to construct 'ResizeObserver': The callback provided as parameter 1 is not a function.");W.connect(this,e)}return e.prototype.observe=function(e,t){if(0===arguments.length)throw new TypeError("Failed to execute 'observe' on 'ResizeObserver': 1 argument required, but only 0 present.");if(!h(e))throw new TypeError("Failed to execute 'observe' on 'ResizeObserver': parameter 1 is not of type 'Element");W.observe(this,e,t)},e.prototype.unobserve=function(e){if(0===arguments.length)throw new TypeError("Failed to execute 'unobserve' on 'ResizeObserver': 1 argument required, but only 0 present.");if(!h(e))throw new TypeError("Failed to execute 'unobserve' on 'ResizeObserver': parameter 1 is not of type 'Element");W.unobserve(this,e)},e.prototype.disconnect=function(){W.disconnect(this)},e.toString=function(){return"function ResizeObserver () { [polyfill code] }"},e}();e.ResizeObserver=X,e.ResizeObserverEntry=T,e.ResizeObserverSize=s,Object.defineProperty(e,"__esModule",{value:!0})}));
//# sourceMappingURL=/sm/41341c17d254494283e24a3307ef93bf30ccaf683e24ad7a3220bf41bae67e18.map