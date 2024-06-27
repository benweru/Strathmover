// Flutter web bootstrap script
if ('serviceWorker' in navigator) {
    // Service workers are supported.
    navigator.serviceWorker.register('/flutter_service_worker.js');
  }
  
  // Set up the application window object and load main.dart.js
  window.addEventListener('load', function (e) {
    // Dynamically load the main Dart script
    var script = document.createElement('script');
    script.src = 'main.dart.js';
    document.body.appendChild(script);
  });
  