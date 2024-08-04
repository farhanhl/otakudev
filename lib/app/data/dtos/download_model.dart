class DownloadOption {
  String? format;
  String? quality;
  List<Link>? links;
  String? size;

  DownloadOption({
    this.format,
    this.quality,
    this.links,
    this.size,
  });
}

class Link {
  String? server;
  String? url;

  Link({
    this.server,
    this.url,
  });
}
