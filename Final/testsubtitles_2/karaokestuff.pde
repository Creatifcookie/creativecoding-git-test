class SubTitle // this is a data structure for timecode and lyrics
{
  float timecode;
  String lyric;

  SubTitle(float _timecode, String _lyric)
  {
    timecode = _timecode;
    lyric = _lyric;
  }
}  

String checkLyrics(float p)
{
  int current = 0;
  for (int i = 0; i<thelyrics.size (); i++)
  {
    if (p>thelyrics.get(i).timecode) current = i;
  }

  if (current<thelyrics.size()-1)
  {
    float point = map(p, thelyrics.get(current).timecode, thelyrics.get(current+1).timecode, 0., 1.);
    if(point < 0.5) lyricfade = map(point, 0., 0.1, 0, 255);
    else lyricfade = map(point, 0.75, 1.0, 255, 0);
  }
  
  return(thelyrics.get(current).lyric);
}

void parseLyrics(String f)
{
  thelyrics = new ArrayList<SubTitle>();

  String[] lyricfile = loadStrings(f);
  Pattern p = Pattern.compile("\\[[0-9][0-9]:[0-9][0-9].[0-9][0-9]\\]");
  for (int i =0; i<lyricfile.length; i++)
  {
    Matcher m = p.matcher(lyricfile[i]);
    if (m.find()) {
      String[] parts = lyricfile[i].split("]");
      if (parts.length>1) {
        String words = parts[1];
        String timestr = parts[0].substring(1);
        int mins = parseInt(timestr.substring(0, 2));
        float secs = parseFloat(timestr.substring(3));
        float tc = mins*60 + secs;
        //println(tc + " " + words);
        SubTitle s = new SubTitle(tc, words);
        thelyrics.add(s);
      }
    }
  }
}

