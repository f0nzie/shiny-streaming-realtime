


Data were gathered from the [Open APC initiative](https://github.com/openapc/openapc-de) for limiting this dashboard only to those hybrid open access journals, in which OA articles were actually published and where institutions covered the publication fee. Journal and licensing metadata were obtained from [Crossref](https://www.crossref.org/), a DOI minting agency for scholarly literature using the wonderful [rcrossref](https://github.com/ropensci/rcrossref) client, developed and maintained by the rOpenSci initiative (https://ropensci.org/). 

Data gathering and analysis, documented in a R script, involved the following steps:

1. Retrieving journal article volume and corresponding licensing information for the period  2013 - 2017 for each ISSN found in the Open APC dataset representing a hybrid OA journal. Results were stored in <data/jn_facets_df.json>

2. Matching those license URLs that indicate open access like Creative Commons licenses.

3.  We now know, whether and which open licenses were used by each journal. As a next step, licensing metadata was checked for delayed open access articles by using the Crossref API filter `license.url` and `license.delay` . Results were stored in <data/hybrid_license_df.json>

4. Because journal business models can change from hybrid to fully open access over time, DOAJ was checked for OA transition.

5. Next, the following indicators used for the dashboard were calculated:

The following indicators will be presented through the dashboard. 
- `publisher_n`: number of complient hybrid oa publishers
- `journal_n`: number of complient hybrid oa journals
- `license_ref_n`: number of articles published under the license `license_ref` in `year`
- `jn_published`: number of articles a journal (`issn`) published in `year`
- `pbl_published`: overall publisher output hybrid oa journals per `year`
- `year_all`: all articles published in oa hybrid oa journals per `year`
 
 and stored as [`json`](data/hybrid_license_indicators.json) and [`csv`](data/hybrid_license_indicators.csv) file.

 6. 


## Meta



This open source dashboard presents the uptake of hybrid open access to support reproducible and transparent open access monitoring. It brings together openly available datasets about hybrid open access into one easy-to-use tool. The following sources are used:

- Crowd-sourced cost information from the [Open APC initiative](https://github.com/openapc/openapc-de) for identifying subscription journals that published open access articles where research institutions sponsored the publication fee. These journals are gathered from the [hybrid OA subset](https://github.com/OpenAPC/openapc-de/blob/master/data/apc_de.csv) and the [offsetting dataset](https://github.com/OpenAPC/openapc-de/tree/master/data/offsetting).
- Journal and licensing metadata from [Crossref](https://www.crossref.org/), a DOI minting agency for scholarly literature.
- [Directory of Open Access Journals (DOAJ)](https://doaj.org/) for identifying journals that were flipped from hybrid to full open access between 2013 - 2017.

## Technical Overview

This [Shiny web application](https://shiny.rstudio.com/) is built using [flexdashboard](http://rmarkdown.rstudio.com/flexdashboard/) package. 

A live demo is available here:

<https://najkoja.shinyapps.io/dashboard/>


## Using the app

Choose a publisher or journal via the select boxes in the left sidebar. Publisher names are decreasingly sorted according to the number of hybrid open access articles published. Corresponding journals are filtered conditionally to the publisher selection and are sorted alphabetically. 

Information is presented using dynamic graphs. The first tab of the upper graph shows the relational uptake of hybrid open access, the second tab the absolute number of published hybrid open access articles. Bar charts are sub-grouped according to the licensing links found via Crossref. 

The lower left chart compares the number of articles found via Open APC and Crossref for the selection. The lower right chart indicates from which countries the institutional support originated from. The figures are based on the Open APC datasets.

## Why did you build this?

As a data analyst working in a library, I have been often asked to provide figures about the uptake and share of hybrid open access articles. Contrary to full open access journals, hybrid open access journals provide open access only to some articles they publish. Although many publishers offer hybrid open access, it is hard to keep track of how many articles were made immediately available this way, and how these figures relate to the overall article volume academic journals published.

One problem is the diversity of hybrid open access business models ranging from options aimed at individual articles to transitional models including offsetting deals where all articles from an research institution or a country are immediately published in open access. There are also journals making back issues openly available after an embargo period. Another problem is that not all publishers and libraries share comprehensive metadata about the articles they publish or sponsor.

This dashboard, which unifies different datasets, demonstrates how existing pieces of an evolving and freely available data infrastructure for monitoring scholarly publishing can be re-used to gain a better understanding of hybrid open access publishing. It, thus, contributes to recent calls including [OA2020](https://oa2020.org/) and [Open Knowledge](https://blog.okfn.org/2017/10/24/understanding-the-costs-of-scholarly-publishing-why-we-need-a-public-data-infrastructure-of-publishing-costs/) aiming at an informed debate about how to transition subscription-based journal publishing to open access business models.

## Known unknowns



Crossref thoroughly covers open access journals. Yet, not all publishers share access indicators via Crossref. In our case, 30 publishers provided licensing
metadata via the Crossref API, representing 22 %) of all publishers included in our study. At the journal-level, 72 % of all hybrid open access journal titles covered by the Open APC initiative share proper licensing metadata with Crossref.

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png)

## As a publisher, how can I support proper hybrid open access monitoring?

Crossref supports publishers who wish to make licensing metadata available via the Crossref APIs:
<https://support.crossref.org/hc/en-us/articles/214572423-License-metadata-Access-Indicators->

As a publisher to be best represented in this dashboard, make sure to include license URL element and a `start_date` equal to the date of publication.

## Technical notes

## How to contribute?

## Meta
