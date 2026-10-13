$csharp = @'
using System;
using System.IO;
using System.Net;
using System.Threading;
using System.Collections.Generic;

public class FireSafetyServer
{
    private readonly HttpListener _listener = new HttpListener();
    private readonly string _rootDir;
    private readonly int _port;
    private volatile bool _running;

    private static readonly Dictionary<string, string> MimeTypes = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
    {
        { ".html", "text/html; charset=utf-8" },
        { ".htm", "text/html; charset=utf-8" },
        { ".css", "text/css; charset=utf-8" },
        { ".js", "application/javascript; charset=utf-8" },
        { ".json", "application/json; charset=utf-8" },
        { ".png", "image/png" },
        { ".jpg", "image/jpeg" },
        { ".jpeg", "image/jpeg" },
        { ".webp", "image/webp" },
        { ".svg", "image/svg+xml" },
        { ".ico", "image/x-icon" },
        { ".woff2", "font/woff2" },
        { ".woff", "font/woff" },
        { ".ttf", "font/ttf" }
    };

    public FireSafetyServer(string rootDir, int port)
    {
        _rootDir = Path.GetFullPath(rootDir);
        _port = port;
        _listener.Prefixes.Add("http://localhost:" + port + "/");
        _listener.Prefixes.Add("http://127.0.0.1:" + port + "/");
    }

    public void Start()
    {
        _running = true;
        _listener.Start();

        Thread listenerThread = new Thread(() =>
        {
            while (_running)
            {
                try
                {
                    HttpListenerContext context = _listener.GetContext();
                    ThreadPool.QueueUserWorkItem((ctx) =>
                    {
                        ProcessRequest((HttpListenerContext)ctx);
                    }, context);
                }
                catch
                {
                    if (!_running) break;
                }
            }
        })
        {
            IsBackground = true
        };

        listenerThread.Start();
    }

    private void ProcessRequest(HttpListenerContext context)
    {
        HttpListenerRequest request = context.Request;
        HttpListenerResponse response = context.Response;

        try
        {
            string urlPath = request.Url.AbsolutePath.TrimStart('/');
            if (string.IsNullOrEmpty(urlPath) || urlPath == "/")
            {
                urlPath = "index.html";
            }

            urlPath = Uri.UnescapeDataString(urlPath).Replace('/', Path.DirectorySeparatorChar);
            string filePath = Path.Combine(_rootDir, urlPath);

            if (!File.Exists(filePath))
            {
                if (File.Exists(filePath + ".html"))
                {
                    filePath = filePath + ".html";
                }
                else if (Directory.Exists(filePath) && File.Exists(Path.Combine(filePath, "index.html")))
                {
                    filePath = Path.Combine(filePath, "index.html");
                }
            }

            if (File.Exists(filePath))
            {
                string ext = Path.GetExtension(filePath);
                string contentType;
                if (!MimeTypes.TryGetValue(ext, out contentType))
                {
                    contentType = "application/octet-stream";
                }

                response.ContentType = contentType;
                response.Headers["Access-Control-Allow-Origin"] = "*";
                response.Headers["Cache-Control"] = "no-cache";

                byte[] buffer = File.ReadAllBytes(filePath);
                response.ContentLength64 = buffer.Length;
                response.StatusCode = 200;
                response.OutputStream.Write(buffer, 0, buffer.Length);
            }
            else
            {
                response.StatusCode = 404;
                byte[] notFound = System.Text.Encoding.UTF8.GetBytes("404 Not Found: " + urlPath);
                response.ContentLength64 = notFound.Length;
                response.ContentType = "text/plain; charset=utf-8";
                response.OutputStream.Write(notFound, 0, notFound.Length);
            }
        }
        catch (Exception ex)
        {
            try
            {
                response.StatusCode = 500;
                byte[] err = System.Text.Encoding.UTF8.GetBytes("500 Server Error: " + ex.Message);
                response.OutputStream.Write(err, 0, err.Length);
            }
            catch { }
        }
        finally
        {
            try { response.Close(); } catch { }
        }
    }

    public void Stop()
    {
        _running = false;
        try { _listener.Stop(); } catch { }
        try { _listener.Close(); } catch { }
    }
}
'@

Add-Type -TypeDefinition $csharp

$root = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$port = 5500

$server = [FireSafetyServer]::new($root, $port)
$server.Start()

Write-Output "SERVER_STARTED: http://localhost:$port/ and http://127.0.0.1:$port/"

while ($true) {
    Start-Sleep -Seconds 1
}
