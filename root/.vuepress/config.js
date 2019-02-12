module.exports = {
  title: "Leo Lapworth",
  ga: "UA-1820505-1",
  description: "Technologist, developer and manager",
  themeConfig: {
    sidebar: "auto",
    sidebarDepth: 5,
    displayAllHeaders: true,
    lastUpdated: "Last Updated",
    nav: [
      { text: "Home", link: "/" },
      { text: "CV", link: "/cv/" },
      { text: "Open Source", link: "/opensource/" },
      { text: "Talks", link: "/talks/" },
      { text: "Projects", link: "/projects/" }
    ]
  },
  head: [
    [
      "link",
      {
        rel: "stylesheet",
        href: "https://use.fontawesome.com/releases/v5.7.1/css/all.css",
        integrity:
          "sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr",
        crossorigin: "anonymous"
      }
    ]
  ]
};
