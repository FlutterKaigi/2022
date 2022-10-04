'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "6ca60969d955557b7886c622423ef486",
"main.dart.js": "5c124ec56d6b83e382f8afe0594940ef",
"index.html": "4cc54b63440da084f3ae2fb324bf94c5",
"/": "4cc54b63440da084f3ae2fb324bf94c5",
"service-worker.js": "8e80dc880b1e22a2e73ff409d4b1d33e",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"manifest.json": "e21a8991a312b40b1643de826961b249",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"assets/flutterkaigi-navbar_light_logo.svg": "be9fb2e1ae8ee991547bc538c5998586",
"assets/discord_logo.svg": "7594b796fb440fa1ef63ca65f6b59c55",
"assets/AssetManifest.json": "f5e41cb6138bb6619e82f1bbd587e75a",
"assets/shaders/ink_sparkle.frag": "6b16a147d705beed121dfeee567d9ef4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/flutterkaigi-navbar_dark_logo.svg": "cdc1a26f38557372e4d824e6e27ecdc3",
"assets/flutter.png": "4611019c4559669d8ee7f242f5dbf4e4",
"assets/twitter_logo.svg": "631cd5664eb1d4a27681a21ca4ad6126",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/assets/flutterkaigi-navbar_light_logo.svg": "be9fb2e1ae8ee991547bc538c5998586",
"assets/assets/discord_logo.svg": "7594b796fb440fa1ef63ca65f6b59c55",
"assets/assets/flutterkaigi-navbar_dark_logo.svg": "cdc1a26f38557372e4d824e6e27ecdc3",
"assets/assets/banner.png": "67493d339345a988ac360e2d0c6a0087",
"assets/assets/photo/katsummy.png": "55a5191dca32b837439c52e763312f30",
"assets/assets/twitter_logo.svg": "631cd5664eb1d4a27681a21ca4ad6126",
"assets/assets/twitter_white.svg": "903d086cf532ce552a6241ab7aa158e4",
"assets/assets/sponsor/tokyu.svg": "7f67166bdc5f5462661acdf3aab646e1",
"assets/assets/sponsor/studyplus.svg": "f56fff3ed73916fa7bce215844adb238",
"assets/assets/sponsor/layerx.svg": "f4e2faf98fd94cea69a562be8862df25",
"assets/assets/sponsor/fastdoctor.svg": "638cc113a71658252c5e56f03f038b5e",
"assets/assets/sponsor/enechain.svg": "fd4de1fc5a6aae3858deebe2bf9e0308",
"assets/assets/sponsor/compass.svg": "c222055ffd477b1cccec47d1062451c8",
"assets/assets/sponsor/dena.svg": "31ad4855aa0e33fdbe871c14c371beec",
"assets/assets/sponsor/excite.svg": "3a34e4da7ef68321a53d951eda72913d",
"assets/assets/sponsor/demaecan.svg": "3c78147aca6f062e415bf590f8ee89ef",
"assets/assets/sponsor/diverse.svg": "8f3ddd2f010b1f4ee49d6b3c51db2502",
"assets/assets/sponsor/cyber_agent.svg": "0b3859147eeebd93a6bfd02dece3cbf1",
"assets/assets/sponsor/hokuto.svg": "0f3dbdb9cf6d2e2ab2c5032b2899a4d5",
"assets/assets/sponsor/m3.svg": "4fa06b5764221b403a24c98b6175a903",
"assets/assets/sponsor/autify.svg": "39794389c837831b981e4224586c8a29",
"assets/assets/sponsor/yumemi.svg": "0362be368f9de8af9883015ef0339a93",
"assets/assets/sponsor/youtrust.svg": "9e96ec4c175715895bce6d08f14888b5",
"assets/assets/sponsor/chompy.svg": "0a15a148cdd05da39fa24a570f671eb5",
"assets/assets/sponsor/tenx.svg": "c21b0433936809fe9a7713237e63a2af",
"assets/assets/github_logo.svg": "1bb027109345a90a9eab1e929d8669c2",
"assets/assets/flutterkaigi_logo.svg": "60e8766ea8433373b3dcc7c84848b883",
"assets/assets/medium_logo.svg": "58e9f9cb83a457fb381dc5ebc6bf39d3",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "eff1961a000da6e8a702d55e96b15ce4",
"assets/twitter_white.svg": "903d086cf532ce552a6241ab7aa158e4",
"assets/github_logo.svg": "1bb027109345a90a9eab1e929d8669c2",
"assets/flutterkaigi_ogp.png": "9e568fcbacdada983dd4ab8d636a1ea4",
"assets/flutterkaigi_logo.svg": "60e8766ea8433373b3dcc7c84848b883",
"assets/medium_logo.svg": "58e9f9cb83a457fb381dc5ebc6bf39d3",
"version.json": "f5952b3a36d0e2f8a98ed39dcc2f8afc",
"icons/Icon-512.png": "3f4f8b2bd2c99c17e609b03d55d09e14",
"icons/Icon-192.png": "02861f4b4a5637703ea4c586181ad448"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
