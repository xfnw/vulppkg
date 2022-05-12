{ theme_root ? null }:
rec {
  theme = ./theme;
  apacheConfig = let
    theme_root' = if isNull theme_root then theme else theme_root;
  in ''
    <Macro Apaxy %{folder} %{ignored}>
      Alias /theme ${theme_root'}
      <Directory ${theme_root'}>
        Options -Indexes
        AllowOverride None
        Require all granted
      </Directory>

      # mod_autoindex
      <Directory %{folder}>
        Options Indexes
        AllowOverride None
        Require all granted

        # Inspired from Apaxy by @adamwhitcroft

        IndexOptions +Charset=UTF-8 +FancyIndexing +IgnoreCase +FoldersFirst +XHTML +HTMLTable +SuppressRules +SuppressDescription +NameWidth=* +IconsAreLinks +ShowForbidden

        IndexHeadInsert "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />"

        IndexIgnoreReset ON
        IndexIgnore /theme .htaccess %{ignored}

        AddIcon /theme/icons/blank.png ^^BLANKICON^^
        AddIcon /theme/icons/folder.png ^^DIRECTORY^^
        AddIcon /theme/icons/folder-home.png ..

        AddIconByType (TXT,/theme/icons/text.png) text/*
        AddIconByType (IMG,/theme/icons/image.png) image/*
        AddIconByType (SND,/theme/icons/audio.png) audio/*
        AddIconByType (VID,/theme/icons/video.png) video/*

        AddIcon /theme/icons/archive.png .7z .bz2 .cab .gz .tar
        AddIcon /theme/icons/audio.png .aac .aif .aifc .aiff .ape .au .flac .iff .m4a .mid .mp3 .mpa .ra .wav .wma .f4a .f4b .oga .ogg .xm .it .s3m .mod
        AddIcon /theme/icons/bin.png .bin .hex
        AddIcon /theme/icons/bmp.png .bmp
        AddIcon /theme/icons/c.png .c
        AddIcon /theme/icons/calc.png .xlsx .xlsm .xltx .xltm .xlam .xlr .xls .csv
        AddIcon /theme/icons/cd.png .iso
        AddIcon /theme/icons/cpp.png .cpp
        AddIcon /theme/icons/css.png .css .sass .scss
        AddIcon /theme/icons/deb.png .deb
        AddIcon /theme/icons/doc.png .doc .docx .docm .dot .dotx .dotm .log .msg .odt .pages .rtf .tex .wpd .wps
        AddIcon /theme/icons/draw.png .svg .svgz
        AddIcon /theme/icons/eps.png .ai .eps
        AddIcon /theme/icons/exe.png .exe
        AddIcon /theme/icons/gif.png .gif
        AddIcon /theme/icons/h.png .h
        AddIcon /theme/icons/html.png .html .xhtml .shtml .htm .URL .url
        AddIcon /theme/icons/ico.png .ico
        AddIcon /theme/icons/java.png .jar
        AddIcon /theme/icons/jpg.png .jpg .jpeg .jpe
        AddIcon /theme/icons/js.png .js .json
        AddIcon /theme/icons/markdown.png .md
        AddIcon /theme/icons/package.png .pkg .dmg
        AddIcon /theme/icons/pdf.png .pdf
        AddIcon /theme/icons/php.png .php .phtml
        AddIcon /theme/icons/playlist.png .m3u .m3u8 .pls .pls8
        AddIcon /theme/icons/png.png .png
        AddIcon /theme/icons/ps.png .ps
        AddIcon /theme/icons/psd.png .psd
        AddIcon /theme/icons/py.png .py
        AddIcon /theme/icons/rar.png .rar
        AddIcon /theme/icons/rb.png .rb
        AddIcon /theme/icons/rpm.png .rpm
        AddIcon /theme/icons/rss.png .rss
        AddIcon /theme/icons/script.png .bat .cmd .sh
        AddIcon /theme/icons/sql.png .sql
        AddIcon /theme/icons/tiff.png .tiff .tif
        AddIcon /theme/icons/text.png .txt .nfo
        AddIcon /theme/icons/video.png .asf .asx .avi .flv .mkv .mov .mp4 .mpg .rm .srt .swf .vob .wmv .m4v .f4v .f4p .ogv
        AddIcon /theme/icons/xml.png .xml
        AddIcon /theme/icons/zip.png .zip
        DefaultIcon /theme/icons/default.png

        HeaderName /theme/header.html
        ReadmeName /theme/footer.html
        IndexStyleSheet /theme/style.css
      </Directory>
    </Macro>
  '';
}
