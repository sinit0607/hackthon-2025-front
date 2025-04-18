'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "0d8aa9088339dc83996d16a3e2b1df9c",
"version.json": "2cb8c1441bcc4632eb43ddcf6bdf4a38",
"index.html": "1ab639a4bf964c56d4cee8bea40fb4ce",
"/": "1ab639a4bf964c56d4cee8bea40fb4ce",
"main.dart.js": "79d7f4f34e72312739e3d443400b8762",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "6c2b2654be141facc1dacfea8a002316",
"icons/Icon-192.png": "81d4c5b36d129ae2e6bd8890f0b74629",
"icons/Icon-maskable-192.png": "7f34c490eb05a2b3976dd55d66b5e132",
"icons/Icon-maskable-512.png": "7f34c490eb05a2b3976dd55d66b5e132",
"icons/Icon-512.png": "7f34c490eb05a2b3976dd55d66b5e132",
"manifest.json": "def61c410602dfe7a3aed2043393cccb",
"assets/AssetManifest.json": "89a47f2bb2b7c31d3dd1d58d1d62dac4",
"assets/NOTICES": "1345810aefe0197c438be07fbf0a3ccf",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "7dfdaba875f127cfeb1668a621608f86",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "5656c26e8e8914ceeacdad0a99242bd6",
"assets/fonts/MaterialIcons-Regular.otf": "36613318b30e29d4d04a3839c5da4884",
"assets/assets/icons/selected_category_icon.png": "2af594b7a261c832d9a34504c11b0dda",
"assets/assets/icons/selected_profile_icon.png": "1b5d2fb47dbf0e3f4cf38c09f738c78b",
"assets/assets/icons/category_icon.png": "b6d001cf12905718cf1c6997e6b05a61",
"assets/assets/icons/profile_icon.png": "c57a54eadb27b6dc86e134a67b44013b",
"assets/assets/icons/app_icon.png": "87515855064da92311d165b1bf8a7390",
"assets/assets/icons/selected_home.png": "77b2ad7084fa31ba54e96f64b6cd6eda",
"assets/assets/icons/selected_shorts_icon.png": "33a0197d48cd856b006f0e996f0b0757",
"assets/assets/icons/home.png": "56b21f960503d7eed5f0ddf6540d0e46",
"assets/assets/icons/appIcon_without_bg.png": "4067f2202ff30a67a55cd5416003a0a6",
"assets/assets/icons/search_icon.png": "76b56836344d0a513d5329ae3b33a67f",
"assets/assets/icons/heart_red.png": "74914c32e8bd99c546809e21b35c442b",
"assets/assets/icons/message_icon.png": "ce2286e11e088a4a07feaaa8d9d1a06f",
"assets/assets/icons/heart.png": "8b7d08cceb2b298764c4dca2c8866455",
"assets/assets/icons/shorts_icon.png": "897a1c9db926a3956f2c50bed1da8bd5",
"assets/assets/icons/selected_search_icon.png": "3b0b28eb49ac32b4a88372dcb05c1c29",
"assets/assets/icons/comment.png": "1bce005b881dfb3715dfe026e45c3aab",
"assets/assets/icons/selected_plus_icon.png": "69af4e82fded9dc7eec702c806991624",
"assets/assets/icons/plus_icon.png": "737907f1496cbdb403a465b8a5b783b1",
"assets/assets/icons/send.png": "86294ad1f2686b1e16fbeb58ca02e7eb",
"assets/assets/animations/onboarding_animation.json": "7ac894d43dafbe5401010cdace1b122d",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
