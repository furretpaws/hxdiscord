package hxdiscord.utils;

/**
    A MimeResolver for file extensions. Used in Discord's attachments
**/

class MimeResolver {
    /**
        Returns the mime type for a filename
        @param file The filename
    **/
    public static function getMimeType(file:String)
    {
        var mimetype:String = "";
        var split = file.split(".");
        switch(split[split.length - 1])
        {
            case "aac":
                mimetype = "audio/aac";
            case "abw":
                mimetype = "application/x-abiword";
            case "arc":
                mimetype = "application/x-freearc";
            case "avif":
                mimetype = "image/avif";
            case "avi":
                mimetype = "video/x-msvideo";
            case "azw":
                mimetype = "application/vnd.amazon.ebook";
            case "bin":
                mimetype = "application/octet-stream";
            case "bmp":
                mimetype = "image/bmp";
            case "bz":
                mimetype = "application/x-bzip";
            case "bz2":
                mimetype = "application/x-bzip2";
            case "cda":
                mimetype = "application/x-cdf";
            case "csh":
                mimetype = "application/x-csh";
            case "css":
                mimetype = "text/css";
            case "csv":
                mimetype = "text/csv";
            case "doc":
                mimetype = "application/msword";
            case "docx":
                mimetype = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "eot":
                mimetype = "application/vnd.ms-fontopbject";
            case "epub":
                mimetype = "application/epub+zip";
            case "gz":
                mimetype = "application/gzip";
            case "gif":
                mimetype = "image/gif";
            case "htm" | "html":
                mimetype = "text/html";
            case "ico":
                mimetype = "image/vnd.microsoft.icon";
            case "ics":
                mimetype = "text/calendar";
            case "jar":
                mimetype = "application/java-archive";
            case "jpeg" | "jpg":
                mimetype = "image/jpeg";
            case "js":
                mimetype = "text/javascript";
            case "json":
                mimetype = "application/json";
            case "jsonld":
                mimetype = "application/ls+json";
            case "mid" | "midi":
                mimetype = "audio/midi";
            case "mjs":
                mimetype = "text/javascript";
            case "mp3":
                mimetype = "audio/mpeg";
            case "mp4":
                mimetype = "video/mp4";
            case "mpeg":
                mimetype = "video/mpeg";
            case "mpkg":
                mimetype = "application/vnd.apple.installer+xml";
            case "odp":
                mimetype = "application/vnd.oasis.opendocument.presentation";
            case "ods":
                mimetype = "application/vnd.oasis.opendocument.spreadsheet";
            case "odt":
                mimetype = "application/vnd.oasis.opendocument.text";
            case "oga" | "ogg":
                mimetype = "audio/ogg";
            case "ogv":
                mimetype = "video/ogg";
            case "opus":
                mimetype = "audio/opus";
            case "otf":
                mimetype = "font/otf";
            case "png":
                mimetype = "image/png";
            case "pdf":
                mimetype = "application/pdf";
            case "php":
                mimetype = "application/x-httpd-php";
            case "ppt":
                mimetype = "application/vnd.ms-powerpoint";
            case "pptx":
                mimetype = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
            case "rar":
                mimetype = "application/vnd.rar";
            case "rtf":
                mimetype = "application/rtf";
            case "sh":
                mimetype = "application/x-sh";
            case "svg":
                mimetype = "image/svg+xml";
            case "tar":
                mimetype = "application/x-tar";
            case "tif" | "tiff":
                mimetype = "image/tiff";
            case "ts":
                mimetype = "video/mp2t";
            case "ttf":
                mimetype = "font/ttf";
            case "txt":
                mimetype = "text/plain";
            case "vsd":
                mimetype = "application/vnd.visio";
            case "wav":
                mimetype = "audio/wav";
            case "weba":
                mimetype = "audio/webm";
            case "webm":
                mimetype = "video/webm";
            case "webp":
                mimetype = "image/webp";
            case "woff":
                mimetype = "font/woff";
            case "woff2":
                mimetype = "font/woff2";
            case "xhtml":
                mimetype = "application/xhtml+xml";
            case "xls":
                mimetype = "application/vnd.ms-excel";
            case "xlsx":
                mimetype = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            case "xml":
                mimetype = "application/xml";
            case "xul":
                mimetype = "application/vnd.mozilla.xul+xml";
            case "zip":
                mimetype = "application/zip";
            case "3gp":
                mimetype = "video/3gpp";
            case "3g2":
                mimetype = "video/3gpp2";
            case "7z":
                mimetype = "application/x-7z-compressed";
            default:
                mimetype = "text/plain";
        }
        return mimetype;
    }
}