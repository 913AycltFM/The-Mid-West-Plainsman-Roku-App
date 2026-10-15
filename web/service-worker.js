const CACHE = "midwest-plainsman-web-v1";
const SHELL = ["./", "./index.html", "./manifest.json", "./icons/app-icon.svg"];
self.addEventListener("install", event => event.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting())));
self.addEventListener("activate", event => event.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim())));
self.addEventListener("fetch", event => {
  const req = event.request, url = new URL(req.url);
  if (req.method !== "GET" || url.origin !== self.location.origin) return;
  if (url.pathname.endsWith("/epg.json")) {
    event.respondWith(fetch(req).then(res => { if (res.ok) caches.open(CACHE).then(c => c.put(req, res.clone())); return res; }).catch(() => caches.match(req).then(c => c || caches.match("./epg.json"))));
    return;
  }
  if (req.mode === "navigate") {
    event.respondWith(fetch(req).then(res => { if (res.ok) caches.open(CACHE).then(c => c.put("./index.html", res.clone())); return res; }).catch(() => caches.match("./index.html")));
    return;
  }
  event.respondWith(caches.match(req).then(c => c || fetch(req)));
});