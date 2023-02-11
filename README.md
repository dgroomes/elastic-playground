# elastic-playground

📚 Learning and exploring the Elastic stack.

> Elasticsearch is a distributed, RESTful search and analytics engine capable of addressing a growing number of use
> cases. As the heart of the Elastic Stack, it centrally stores your data for lightning fast search, fine‑tuned
> relevancy, and powerful analytics that scale with ease.
> 
> -- <cite>https://www.elastic.co/elasticsearch/</cite>


## Description

**NOTE**: This project was developed on macOS. It is for my own personal use.

The Elastic stack is in widespread use. I think it has number one market share in its space. While it doesn't necessarily
have the most polished user and developer experience, it has its bright spots and is feature-rich. I would like to learn
it better. This repository is a playground-style codebase which helps me gather my thoughts, findings, and executable
instructions for learning a technology. In this case, the technology is Elasticsearch. I might venture to other components
of the Elastic stack, like Kibana.  


## Instructions

Follow these instructions to execute an Elasticsearch demo:

1. Install Elasticsearch
   * A pre-requisite to this step is installing Elasticsearch to your computer. Read the section [*Elasticsearch for Personal Use*](#elasticsearch-for-personal-use)
     for more information. Consider alternative installation options, if desired.
2. Start Elasticsearch:
   * ```shell
     elasticsearch
     ```
   * This will print out lots of stuff. Read the output to boost your understanding. Elasticsearch should be listening
     for requests at <http://[::1]:9200> and various other ports, depending on your configuration.
3. Upload some data:
   * ```shell
     ./load-zip-areas.sh
     ```
   * It should look like this:
     ```text
     $ ./load-zip-areas.sh
     ⏳ Loading 1000 ZIP area records into Elasticsearch...
     ✨ Done.
     ```
4. Query the data:
   * ```shell
     ./query-zip-areas.sh
     ```
   * It should look like this (abbreviated):
     ```text
     $ ./query-zip-areas.sh
     {
       "took": 10,
       "timed_out": false,
       "_shards": {
         "total": 1,
         "successful": 1,
         "skipped": 0,
         "failed": 0
       },
       "hits": {
         "total": {
           "value": 1000,
           "relation": "eq"
         },
         "max_score": 1.0,
         "hits": [
           {
             "_index": "zip_areas",
             "_id": "SPY2pIAB-VPuR9g79rxi",
             "_score": 1.0,
             "_source": {
               "zip_code": "01001",
               "city": "AGAWAM",
               "loc": [
                 -72.622739,
                 42.070206
               ],
               "pop": 15338,
               "state": "MA"
             }
           },
           {
             "_index": "zip_areas",
             "_id": "SfY2pIAB-VPuR9g797xD",
             "_score": 1.0,
             "_source": {
               "zip_code": "01002",
               "city": "CUSHMAN",
               "loc": [
                 -72.51565,
                 42.377017
               ],
               "pop": 36963,
               "state": "MA"
             }
           } (abbreviated, there are 8 more "hits" elements. Elasticsearch by default limits the response to 10 elements)
     ```
   * Success, you've accomplished the "Hello world" of Elasticsearch! Try your own queries and explore the technology.
5. Delete the data:
   * When you are finished or just want to reset everything, delete the data.
   * ```shell
     ./delete-zip-areas.sh
     ```

## Elasticsearch for Personal Use

If you want to run Elasticsearch in any capacity, you'll have to understand the array of options. Elastic (the company)
advertises their managed offerings on their website and they offer some options for the do-it-yourself path too. The do-it-yourself
installation options include subscription features, so you are expected to know the restrictions. For example, notice the
language used in the [Install Elasticsearch from archive on Linux or MacOS](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html)
page (emphasis my own):

> Elasticsearch is available as a .tar.gz archive for Linux and MacOS.
>
> This package contains both free and **subscription features**. Start a 30-day trial to try out all of the features.

In the end, I'm not really sure what the right option is for running Elasticsearch in a way where I can dip my toes in
the API. I'd like to load some data, index it, and then query it back.

I think I'm going to go with the [*Build from source*](https://github.com/elastic/elasticsearch#build-from-source) instructions
in the Elasticsearch GitHub repository. Here are the steps I followed to build from source and install on my computer:

1. Clone Elasticsearch
   * ```shell
     git clone https://github.com/elastic/elasticsearch --depth 1
     ```
   * Notice that it's a shallow clone.
2. Use Java 17
3. Build the distribution
   * From the `elasticsearch` project, run the following command.
   * ```shell
     ./gradlew localDistro
     ``` 
   * The build process will print something like the following at the very end.
   * > Elasticsearch distribution installed to /Users/davidgroomes/repos/opensource/elasticsearch/build/distribution/local/elasticsearch-8.3.0-SNAPSHOT
4. Add the distribution to your PATH
   * Add something like the following to your `.bashrc` (if using Bash).
   * `export PATH="$PATH:$HOME/repos/opensource/elasticsearch/build/distribution/local/elasticsearch-8.3.0-SNAPSHOT/bin"`
5. Customize the configuration
   * We want to run in a "local and offline" style. By default Elasticsearch will use `0.0.0.0` and bind on all network
     interfaces we absolutely do not care for this because after all, we're not treating our computer as a networked host
     for clients to connect to. Elasticsearch also enables SSL security too. That's pretty cool, but we don't need it
     because we're running locally (and also using toy data). Make the following changes to the `config/elasticsearch.yml`
     file.
   * ```yaml
     network.host: "[::1]"
     network.bind_host: "[::1]"
     network.publish_host: "[::1]"
     http.host: "[::1]"
     transport.host: "[::1]"
     xpack.security.enabled: false
     ```


## Notes

The [Quick Start](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html) has good instructions
for getting started with your first uploads and queries to the Elasticsearch instance. It's as simple as a few `curl`
commands!


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [x] DONE More queries. Search by name, population. Aggregate the populations. Other interesting queries?


## Reference

* [Elasticsearch GitHub repository](https://github.com/elastic/elasticsearch)
* [Elasticsearch guide: *Search your data*](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-your-data.html)
* [Elasticsearch guide: *Term-level queries*](https://www.elastic.co/guide/en/elasticsearch/reference/current/term-level-queries.html)
  > You can use term-level queries to find documents based on precise values in structured data. Examples of structured data include date ranges, IP addresses, prices, or product IDs.
* [Elasticsearch guide: *Query and filter context*](https://www.elastic.co/guide/en/elasticsearch/reference/8.2/query-filter-context.html)
  > In a filter context, a query clause answers the question "*Does this document match this query clause?*" The answer is a simple Yes or No–no scores are calculated. Filter context is mostly used for filtering structured data...
* [Elasticsearch guide: *Avg aggregation*](https://www.elastic.co/guide/en/elasticsearch/reference/8.2/search-aggregations-metrics-avg-aggregation.html)
