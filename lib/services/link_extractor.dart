class LinkExtractor {

  String extract(String text){
    // Regular expression to match URLs (http, https, or www)
    RegExp urlRegExp = RegExp(
      r'(https?:\/\/[^\s]+|www\.[^\s]+)',
      caseSensitive: false,
    );

    // Find all matches in the input string
    Iterable<RegExpMatch> matches = urlRegExp.allMatches(text);

    // Extract all matched URLs
    List<String> urls = matches.map((match) => match.group(0)!).toList();

    return urls[0];
  }

}