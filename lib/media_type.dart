/// Top level media types
enum MediaToptype {
  text,
  image,
  audio,
  video,
  application,
  multipart,
  message,
  model,
  other
}

/// Detailed media types
enum MediaSubtype {
  textPlain,
  textHtml,
  textCalendar,
  audioBasic,
  audioMpeg,
  audioMp3,
  audioMp4,
  audioOgg,
  audioWav,
  audioMidi,
  audioMod,
  audioAiff,
  audioWebm,
  audioAac,
  imageJpeg,
  imagePng,
  imageGif,
  imageWebp,
  imageBmp,
  imageSvgXml,
  videoMpeg,
  videoMp4,
  videoWebm,
  videoH264,
  videoOgg,
  applicationJson,
  applicationZip,
  applicationXml,
  applicationOctetStream,
  modelMesh,
  modelVrml,
  modelX3dXml,
  modelX3dVrml,
  modelX3dBinary,
  modelVndColladaXml,
  multipartAlternative,
  multipartMixed,
  multipartParallel,
  multipartPartial,
  multipartRelated,
  multipartDigest,
  multipartRfc822,
  other
}

/// Describes the media type of a MIME message part
class MediaType {
  static const MediaType textPlain =
      MediaType('text/plain', MediaToptype.text, MediaSubtype.textPlain);

  static const Map<String, MediaToptype> _topLevelByMimeName =
      <String, MediaToptype>{
    'text': MediaToptype.text,
    'image': MediaToptype.image,
    'video': MediaToptype.video,
    'application': MediaToptype.application,
    'model': MediaToptype.model,
    'multipart': MediaToptype.multipart,
    'message': MediaToptype.message
  };

  static const Map<String, MediaSubtype> _subtypesByMimeType =
      <String, MediaSubtype>{
    'text/plain': MediaSubtype.textPlain,
    'text/html': MediaSubtype.textHtml,
    'text/calendar': MediaSubtype.textCalendar,
    'text/x-vcalendar': MediaSubtype.textCalendar,
    'audio/basic': MediaSubtype.audioBasic,
    'audio/webm': MediaSubtype.audioWebm,
    'audio/aac': MediaSubtype.audioAac,
    'audio/aiff': MediaSubtype.audioAiff,
    'audio/mp4': MediaSubtype.audioMp4,
    'audio/mp3': MediaSubtype.audioMp3,
    'audio/midi': MediaSubtype.audioMidi,
    'audio/mod': MediaSubtype.audioMod,
    'audio/x-mod': MediaSubtype.audioMod,
    'audio/mpeg': MediaSubtype.audioMpeg,
    'audio/ogg': MediaSubtype.audioOgg,
    'audio/wav': MediaSubtype.audioWav,
    'audio/x-wav': MediaSubtype.audioWav,
    'video/ogg': MediaSubtype.videoOgg,
    'application/ogg': MediaSubtype.videoOgg,
    'video/h264': MediaSubtype.videoH264,
    'video/mp4': MediaSubtype.videoMp4,
    'application/mp4': MediaSubtype.videoMp4,
    'video/mpeg': MediaSubtype.videoMpeg,
    'video/webm': MediaSubtype.videoWebm,
    'model/mesh': MediaSubtype.modelMesh,
    'model/vnd.collada+xml': MediaSubtype.modelVndColladaXml,
    'model/vrml': MediaSubtype.modelVrml,
    'model/x3d+xml': MediaSubtype.modelX3dXml,
    'model/x3d+vrml': MediaSubtype.modelX3dVrml,
    'model/x3d-vrml': MediaSubtype.modelX3dVrml,
    'model/x3d+binary': MediaSubtype.modelX3dBinary,
    'model/x3d+fastinfoset': MediaSubtype.modelX3dBinary,
    'application/json': MediaSubtype.applicationJson,
    'application/octet-stream': MediaSubtype.applicationOctetStream,
    'application/xml': MediaSubtype.applicationXml,
    'application/zip': MediaSubtype.applicationZip,
    'application/x-zip': MediaSubtype.applicationZip,
    'multipart/alternative': MediaSubtype.multipartAlternative,
    'multipart/mixed': MediaSubtype.multipartMixed,
    'multipart/parallel': MediaSubtype.multipartParallel,
    'multipart/related': MediaSubtype.multipartRelated,
    'multipart/partial': MediaSubtype.multipartPartial,
    'multipart/digest': MediaSubtype.multipartDigest,
    'multipart/rfc822': MediaSubtype.multipartRfc822,
    'message/rfc822': MediaSubtype.multipartRfc822
  };

  /// The original text of the media type, e.g. 'text/plain' or 'image/png'.
  final String text;

  /// The top level media type, e.g. text, image, video, audio, application, model, multipart or other
  final MediaToptype top;

  /// The subtdetailed type of the media, e.g. text/plain
  final MediaSubtype sub;

  /// Convenience getter to check of the [top] MediaTopType is text
  bool get isText => top == MediaToptype.text;

  /// Convenience getter to check of the [top] MediaTopType is image
  bool get isImage => top == MediaToptype.image;

  /// Convenience getter to check of the [top] MediaTopType is video
  bool get isVideo => top == MediaToptype.video;

  /// Convenience getter to check of the [top] MediaTopType is audio
  bool get isAudio => top == MediaToptype.audio;

  /// Convenience getter to check of the [top] MediaTopType is application
  bool get isApplication => top == MediaToptype.application;

  /// Convenience getter to check of the [top] MediaTopType is multipart
  bool get isMultipart => top == MediaToptype.multipart;

  /// Convenience getter to check of the [top] MediaTopType is model
  bool get isModel => top == MediaToptype.model;

  /// Convenience getter to check of the [top] MediaTopType is message
  bool get isMessage => top == MediaToptype.message;

  const MediaType(this.text, this.top, this.sub);

  static MediaType fromText(String text) {
    var splitPos = text.indexOf('/');
    if (splitPos != -1) {
      var topText = text.substring(0, splitPos);
      var top = _topLevelByMimeName[topText] ?? MediaToptype.other;
      var sub = _subtypesByMimeType[text] ?? MediaSubtype.other;
      return MediaType(text, top, sub);
    } else {
      var top = _topLevelByMimeName[text] ?? MediaToptype.other;
      return MediaType(text, top, MediaSubtype.other);
    }
  }

  @override
  String toString() {
    return text;
  }
}
