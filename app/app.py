from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import os


class PageHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        page = b"<!doctype html><html><head><meta charset=\"utf-8\"><title>New world</title></head><body>new world</body></html>"
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(page)))
        self.end_headers()
        self.wfile.write(page)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", "8000"))
    server = ThreadingHTTPServer(("0.0.0.0", port), PageHandler)
    print(f"Serving on port {port}")
    server.serve_forever()
