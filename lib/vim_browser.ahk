class VimBrowser {
  __New(Vim) {
    this.Vim := Vim
  }

  Clear() {
    this.title := ""
    this.url := ""
    this.source := ""
    this.date := ""
    this.VidTime := ""
    this.comment := ""
  }

  GetInfo(NoRestore:=false, SkipCopying:=false) {
    this.clear()
    global WinClip
    if (!NoRestore)
      WinClip.Snap(ClipData)
    this.GetUrl(!NoRestore)
    this.GetTitleSourceDate(SkipCopying)
    if (!NoRestore)
      WinClip.Restore(ClipData)
  }

  ParseUrl(url) {
    url := RegExReplace(url, "#(.*)$")
    if (InStr(url, "youtube.com") && InStr(url, "v=")) {
      url := RegExReplace(url, "&.*")
    } else if (InStr(url, "bilibili.com/video")) {
      url := RegExReplace(url, "(\?|&).*")
    } else if (InStr(url, "netflix.com/watch")) {
      url := RegExReplace(url, "\?trackId=.*")
    }
    return url
  }

  GetTitleSourceDate(SkipCopying:=false) {
    WinGetActiveTitle CurrTitle
    this.Title := RegExReplace(CurrTitle, "( - Google Chrome| — Mozilla Firefox|( and [0-9]+ more pages?)? - [^-]+ - Microsoft​ Edge)$")

    ; Sites that have source in their title
    if (InStr(this.Title, "很帅的日报")) {
      this.Date := StrReplace(this.Title, "很帅的日报 ")
      this.Title := "很帅的日报"
    } else if (InStr(this.Title, "_百度百科")) {
      this.Source := "百度百科"
      this.Title := StrReplace(this.Title, "_百度百科")
    } else if (InStr(this.Title, "_百度知道")) {
      this.Source := "百度知道"
      this.Title := StrReplace(this.Title, "_百度知道")
    } else if (InStr(this.Url, "reddit.com")) {
      RegExMatch(this.Url, "reddit\.com\/\Kr\/[^\/]+", this.Source)
      this.Title := StrReplace(this.Title, " : " . StrReplace(this.Source, "r/"))

    ; Sites that don't include source in the title
    } else if (InStr(this.Url, "dailystoic.com")) {
      this.Source := "Daily Stoic"
    } else if (InStr(this.Url, "healthline.com")) {
      this.Source := "Healthline"
    } else if (InStr(this.Url, "medicalnewstoday.com")) {
      this.Source := "Medical News Today"
    } else if (InStr(this.Url, "investopedia.com")) {
      this.Source := "Investopedia"
    } else if (InStr(this.Url, "github.com")) {
      this.Source := "Github"

    ; Sites that should be skipped
    } else if (InStr(this.Url, "mp.weixin.qq.com")) {
      return
    } else if (InStr(this.Url, "universityhealthnews.com")) {
      return

    ; Sites that require special attention
    } else if (InStr(this.title, " - YouTube")) {
      this.source := "YouTube"
      this.title := StrReplace(this.title, " - YouTube")
      if (!SkipCopying) {
        sleep 20
        global WinClip
        WinClip.Clear()
        send ^a^c
        ClipWait 3
        send {esc}
        if (Clipboard) {
          this.date := this.MatchYTDate(Clipboard)
          this.source .= ": " . this.MatchYTSource(Clipboard)
        }
      }
    } else if (InStr(this.Title, "_哔哩哔哩_bilibili")) {
      this.Source := "哔哩哔哩"
      this.Title := StrReplace(this.Title, "_哔哩哔哩_bilibili")
      if (!SkipCopying) {
        sleep 20
        global WinClip
        WinClip.Clear()
        send ^a^c
        ClipWait 3
        send {esc}
        this.date := this.MatchBLDate(Clipboard)
      }

    ; Try to use - or | to find source
    } else {
      ReversedTitle := StrReverse(this.Title)
      if (InStr(ReversedTitle, " | ")
       && (!InStr(ReversedTitle, " - ")
        || InStr(ReversedTitle, " | ") < InStr(ReversedTitle, " - "))) {  ; used to find source
        separator := " | "
      } else if (InStr(ReversedTitle, " - ")) {
        separator := " - "
      } else if (InStr(ReversedTitle, " – ")) {
        separator := " – "  ; websites like BetterExplained
      } else {
        separator := ""
      }
      pos := separator ? InStr(StrReverse(this.Title), separator) : 0
      if (pos) {
        this.Source := SubStr(this.Title, StrLen(this.Title) - pos - 1, StrLen(this.Title))
        if (InStr(this.Source, separator))
          this.Source := StrReplace(this.Source, separator,,, 1)
        this.Title := SubStr(this.Title, 1, StrLen(this.Title) - pos - 2)
      }
    }
  }

  GetSecFromTime(TimeStamp) {
    TimeArray := StrSplit(TimeStamp, ":")
    TimeArray := RevArr(TimeArray)
    TimeArray[3] := TimeArray[3] ? TimeArray[3] : 0
    return (TimeArray[1] + TimeArray[2] * 60 + TimeArray[3] * 3600)
  }

  GetBrowserUrl(hwnd:="", browser:="chrome") {
    if (!hwnd)
      WinGet, hwnd, ID, A
    if (browser = "chrome" || WinActive("ahk_exe chrome.exe")) {
      accAddressBar := Acc_Get("Object", "4.1.1.2.1.2.5.3",, "ahk_id " . hwnd)
    } else if (browser = "edge" || WinActive("ahk_exe msedge.exe")) {
      accAddressBar := Acc_Get("Object", "4.1.1.4.1.2.5.4",, "ahk_id " . hwnd)
    }
    return (accAddressBar.accValue(0))
  }

  GetVidTime(site:="", NoRestore:=false) {
    if (!site) {
      CurrUrl := this.GetBrowserUrl()
      if (InStr(CurrUrl, "youtube.com")) {
        site := "yt"
      } else if (InStr(CurrUrl, "bilibili.com")) {
        site := "bl"
      }
    }
    global WinClip
    if (!NoRestore)
      WinClip.Snap(ClipData)
    WinClip.Clear()
    if (site = "bl") {
      MouseGetPos, XSaved, YSaved
      MouseMove, % A_ScreenWidth / 2, % A_ScreenHeight / 2, 0
      sleep 200
    }
    send ^a^c
    ClipWait 1
    send {esc}
    if (site = "yt") {
      VidTime := this.MatchYTTime(Clipboard)
    } else if (site = "bl") {
      VidTime := this.MatchBLTime(Clipboard)
    }
    if (site = "bl")
      MouseMove, XSaved, YSaved
    if (!NoRestore)
      WinClip.Restore(ClipData)
    return VidTime
  }

  GetUrl(NoRestore:=false) {
    global WinClip
    if (!NoRestore)
      WinClip.Snap(ClipData)
    WinClip.Clear()
    StartTime := A_TickCount
    send {f6}^l  ; for moronic websites that use ctrl+L as a shortcut (I'm looking at you, paratranz)
    while (!Clipboard) {
      send ^l^c
      ClipWait 0.1
      if (A_TickCount - StartTime > 500)
        return
    }
    send {esc}
    Clipboard := this.url := this.ParseUrl(Clipboard)
    if (!NoRestore)
      WinClip.Restore(ClipData)
    return url
  }

  MatchYTTime(text) {
    RegExMatch(text, "\r\n\K[0-9:]+(?= \/ )", VidTime)
    return VidTime
  }

  MatchYTSource(text) {
    RegExMatch(text, "SAVE(\r\n){3}\K.*", VidTime)
    return VidTime
  }

  MatchYTDate(text) {
    RegExMatch(text, " views((Streamed live|Premiered) on )?\K.*", date)
    return date
  }

  MatchBLTime(text) {
    RegExMatch(text, "\r\n\K[0-9:]+(?= \/ )", VidTime)
    return VidTime
  }

  MatchBLDate(text) {
    RegExMatch(text, "\n\K[0-9]{4}-[0-9]{2}-[0-9]{2}", date)
    return date
  }

  RunInIE(url) {
    ie := ComObjCreate("InternetExplorer.Application")
    ie.Visible := true
    ie.Navigate(url)
  }
}