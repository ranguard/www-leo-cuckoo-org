---
	title: Open source
---

# Open source
	
Open source work I currently do, or have done over the years. Mostly taking
on roles that no one else wants! Be that sysadmin, editor or html code cleaner, along with developing modules and submitting patches to other open
source projects.
 
- [My Github account](http://github.com/ranguard/)
- [My Perl Blog](http://blogs.perl.org/users/leo_lapworth/) (not updated much)
- [My Perl CPAN modules](https://metacpan.org/author/LLAP)

### White camel
##### 2011

I received the [Perl White Camel Community Award](https://www.perl.org/advocacy/white_camel/2011.html) for some of the work listed below.

### London.pm Member and Leader
##### Since 1998 (leader for: Nov 2010 - April 2012)

I was elected leader of the [London Perl Mongers](http://london.pm.org). Big plans, but lack of time! Honored my commitment to let others organise both technical and social events.

## Websites 

### MetaCPAN.org <Badge text="active" type="tip"/>
##### 2012 - present

I act as the systems administrator, having written most of the [Puppet](https://github.com/metacpan/metacpan-puppet) setup, I also run the [Fastly CDN](https://www.fastly.com) config and the Honeycomb.io integrations. This site
is now run across 2 data centers (EU and US) with Elasticsearch backup
for assurance of continuity. Limiting the [bus factor](https://en.wikipedia.org/wiki/Bus_factor) has always been important for me. 

### *.Perl.org <Badge text="active" type="tip"/>
##### December 2009 - present
    
I revamped most of the [Perl.org](http://www.perl.org) websites, starting with the main [www.perl.org](http://www.perl.org) site, I also re-coded and either edited or replaced most of the copy for
[learn](http://learn.perl.org) (including introduction videos), [DBI](http://dbi.perl.org), [QA](http://qa.perl.org), [Dev](http://dev.perl.org).
I am still one of the 3 maintainers of these sites.

### Perlsphere.net <Badge text="active" type="tip"/>
##### Jan 2010 - present
    
Took on running and maintaining [Perlsphere.net](http://perlsphere.net/).

#### Perl.com <Badge text="completed" type="warn"/>
##### July 2010

I helped co-ordinate the migration of Perl.com from O'Reilly publishers to [The Perl Foundation](http://www.perlfoundation.org/).

### www.pm.org <Badge text="completed" type="warn"/>
##### August 2012

I redesigned  [www.pm.org](http://www.pm.org/) from scratch.

### www.cpan.org <Badge text="completed" type="warn"/>
##### March 2011
    
I reviewed/rewrote most of the content on [www.cpan.org](http://www.cpan.org/) I also implemented a new design.

### PerlNews.org <Badge text="deactivated" type="warn"/>
##### March 2011

I launched the Perl news site with Dave Cross, which targeted
major announcements within the Perl community. Now that [Perl.com](https://www.perl.com/) is active again we have redirected to there.

## Perl Modules

### PerlFAQ

I am one of the maintainers of the official [PerlFAQ](https://metacpan.org/release/perlfaq).

### Text::vCard
	
Text::vCard is used to parse a vCard formatted file into a Perl object with accessor methods. It can be downloaded from [https://metacpan.org/release/Text-vCard/](https://metacpan.org/release/Text-vCard/)

### Data::Pageset
	
This Perl object inherits from Data::Page and adds additional functionality so that one can create page sets rather than having one massive list of pages. Latest version can be downloaded from [https://metacpan.org/release/Data-Pageset/](https://metacpan.org/release/Data-Pageset/)
	
### SVG::TT::Graph
	
This Perl module makes creating presentation quality SVG graphs
from any data source very easy (it was created before [D3.js](https://d3js.org/) and other such libraries existed), with many display options;
key, title, sub title, x-lables, y-lables etc. 
[https://metacpan.org/release/SVG-TT-Graph/](https://metacpan.org/release/SVG-TT-Graph/), [Examples](/projects/SVG-TT-Graph/)

### Net::Amazon::S3

I am the maintainer of [https://metacpan.org/release/Net-Amazon-S3](https://metacpan.org/release/Net-Amazon-S3), specifically to get other people's patches merged and released.

### Apache::AuthCookieNTLM
	
This module created by myself and Fancoise Dehinbo uses [Apache::AuthenNTLM](https://metacpan.org/pod/Apache::AuthenNTLM) as a base class so that you can use the fact that IE will send the users Windows login details (if the server is trusted and the option is turned on) and authenticate the user against the Windows Network PDC. This is mostly useful for intranets so that users don't have to login.

Our extension of the module means that a cookie is set with the user's login name so that they are not authenticated for every page request and also allowing other scripts to access this info.

The module can be extended so that one is able to add any information you like (should you want to look up the users email address or something in a DB)
to the cookie.

[https://metacpan.org/release/Apache-AuthCookieNTLM](https://metacpan.org/release/Apache-AuthCookieNTLM)


### Mac::Glue::Apps::AddressBookExport
	
This module exports from Apple Address Book and generates HTML
pages. [https://metacpan.org/release/Mac-Glue-Apps-AddressBookExport](https://metacpan.org/release/Mac-Glue-Apps-AddressBookExport)
