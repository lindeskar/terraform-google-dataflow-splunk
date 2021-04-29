function transform(inJson) {
  var obj = { "data" : JSON.parse(inJson) };
  obj._metadata = {
    source: obj.data.logName || "default",
    sourcetype: "google:gcp:pubsub:message"
  };
  return JSON.stringify(obj);
}
