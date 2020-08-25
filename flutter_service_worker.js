'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "bd4cb094452e1b73e7a2a651c142db4b",
"index.html": "e6337217a53c8073692ceb40d96dbf9e",
"/": "e6337217a53c8073692ceb40d96dbf9e",
"manifest.json": "d9e6cf4c425faf6b99d42915e6abac6f",
"assets/FontManifest.json": "3a2c387e6ff9f311a5b6be7689372c3d",
"assets/fonts/ArmataRegular.ttf": "1ddb286c6c0f5271552cd4f23acea881",
"assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"assets/fonts/OldBookshop.ttf": "2089e6bf1dbd2f2b4ab241cdae8558e9",
"assets/fonts/Spartan.ttf": "e9fb5ac5844b6ffa324f5be47ca14b23",
"assets/fonts/Marvel-BoldItalic.ttf": "c1a4f515598294de30ab868e41fd90ee",
"assets/fonts/CabinSketchBold.ttf": "aaa30c6d03ddbf4cfd7077d3b2f109ed",
"assets/fonts/LoveYaLikeASister.ttf": "a24504df0b3fb457c4ac46ceffe395a6",
"assets/fonts/Cheveuxdange.ttf": "b719e4da42b0e9318d5f2b06cd2e1300",
"assets/fonts/BungeeInlineRegular.ttf": "b5db0222ce5354b7eb01874198685d71",
"assets/fonts/CoalhandLuke.ttf": "29aa40404bde09a459f713f9a002fe1e",
"assets/fonts/FrederickatheGreatRegular.ttf": "9122299e476671f970e1670bd7b900c8",
"assets/fonts/CabinSketchRegular.ttf": "dc97f34ade1b590e1688b6803b1a1f03",
"assets/fonts/conte.ttf": "fe55c915e7b5cd40aca74f9c7c6a8aff",
"assets/fonts/Marvel-Regular.ttf": "8551e505ff13322f7898d0415e90dda9",
"assets/fonts/Inconsolata.ttf": "3701d12f4e47a6214ef41b3273b5de5a",
"assets/fonts/Marvel-Italic.ttf": "48e5e57afda1e95b67d6c704b5c1154e",
"assets/fonts/LibreBarcode39.ttf": "5a7398c73d0171566d2e212afeae1561",
"assets/fonts/Marvel-Bold.ttf": "f93c7e79d54184101eb701f8deb278c5",
"assets/fonts/FingerPaintRegular.ttf": "56f00b16f3d350598d45793495dc778b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/AssetManifest.json": "8c4dc38df5471fa75cc8083cebe73340",
"assets/NOTICES": "2a9e34a559fe7f20bf58464527d30e72",
"assets/images/logo.png": "f9be0164031a4ebfc40ba152c6193d75",
"assets/images/p4.png": "e6adef64ed64275cb08962cb5336d6e8",
"assets/images/logo-.png": "5ccd0da80ee9fedcbb9ae345e54f636b",
"assets/images/p1.jpg": "2d67fe2e7ffc72cb1171fc7b59115d93",
"assets/images/GoogleLogo.png": "4565178284ac5c4b3690e2c46e1d259a",
"assets/images/Filip.flr": "5051aaf6e8829b512f89bbc83b5a7b9a",
"assets/images/LogoHappykids.png": "3aa9583cfb4a46b893a997e24e8ef9f6",
"assets/images/skiing.jpeg": "737df0a28307ce6b8391cad324d34031",
"assets/images/p3.jpg": "1b3ac91c05613e00befe46c9351f9c4c",
"assets/images/7615593ed2f6b3d0e69dd05c89baa18d.webp": "ed746dbb81aad302334fbf15de5c118a",
"assets/images/p0.png": "1f378b89d801bedc98a4d485bd01cde2",
"assets/images/home.png": "8da56e9566884d429cacf9dc8712e613",
"assets/images/monica.png": "0d15e78a8f9fa915458fbf20a36df15d",
"assets/images/splash.flr": "6382d4b342ceaf6bab1cffa3a58fe04b",
"assets/images/p2.png": "2c955d9f1c9d486a9177341c0701321a",
"assets/images/cycling.png": "deabcbc23379bbde07ac40d13685d521",
"assets/images/firebase-logo.png": "6e54c791dc8bd9e8ec9cc09a3cb9e30f",
"assets/images/graphic_designer.jpg": "9c03fb1761b78fa62ef6869a702a4d71",
"assets/images/side_menu.webp": "46352fc90d83e31cb3dd2ec76a9218cf",
"assets/images/coffee_header.jpeg": "c64b9bc8e93ae26f419a141766e52a76",
"assets/images/boating.jpg": "b8569fc1895f77a2c7030fa9dcbebf88",
"assets/images/swimming.jpg": "16ab979e3f93ef0015cb199ac1e15391",
"assets/images/a0.png": "87fe07d717feec6e8c3111cb239f1b2f",
"assets/database/database.txt": "d41d8cd98f00b204e9800998ecf8427e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a 'reload' param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'reload'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
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
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
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
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
