# RSSFeedReader

The simple iOS app that fetches and displays RSS feeds. 

Сreated mostly for educational purposes.

App is written in Swift.

Dependencies:
- Kingfisher for work with images;
- FeedKit for rss parsing;
- R.swift for work with resources.

SPM used as a dependency manager.

## <a name="description"/> UI Description

- User can add/remove/modify RSS feed sources.
- News entities are displayed in a sectioned list (each section is a feed source with its title).
- Show image, title, short description for each news article (in list).
- Full news article can be opened in a separate screen, opened by tap on a list item. Also full article can be opened in a separate webView screen.

## <a name="requirements"/> Requirements

- Target version of iOS: 15.5
- Xcode 13.4.1

## <a name="licence"/> Licence
MIT
