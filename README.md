# elastic-playground

NOT FULLY IMPLEMENTED

📚 Learning and exploring the Elastic stack.


## Description

**NOTE**: This project was developed on macOS. It is for my own personal use.

The Elastic stack is in widespread use. I think it has number one market share in its space. While it doesn't necessarily
have the most polished user and developer experience, it has its bright spots and is feature-rich. I would like to learn
it better. This repository is a playground-style codebase which helps me gather my thoughts, findings, and executable
instructions for learning a technology. In this case, the technology is Elasticsearch. I might venture to other components
of the Elastic stack like Kibana.  


## Instructions

Follow these instructions to execute an Elasticsearch demo:

1. Start Elasticsearch
   * `elasticsearch`
   * This will print out lots of stuff. Read the output to boost your understanding. Skim it, at least.
   * A pre-requisite to this step is installing Elasticsearch to your computer. Read the section [*Elasticsearch for Personal Use*](#elasticsearch-for-personal-use)
     for more information. Consider alternative installation options, if desired.
2. Upload some data
   * TODO


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
   * `git clone https://github.com/elastic/elasticsearch --depth 1`
   * Notice that it's a shallow clone.
1. Use Java 17
1. Build the distribution
   * From the `elasticsearch` project, run the following command.
   * `./gradlew localDistro` 
   * The build process will print something like the following at the very end.
   * > Elasticsearch distribution installed to /Users/davidgroomes/repos/opensource/elasticsearch/build/distribution/local/elasticsearch-8.3.0-SNAPSHOT
1. Add the distribution to your PATH
   * Add something like the following to your `.bashrc` (if using Bash).
   * `export PATH="$PATH:$HOME/repos/opensource/elasticsearch/build/distribution/local/elasticsearch-8.3.0-SNAPSHOT/bin"`


## Notes

The [Quick Start](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html) has good instructions
for getting started with your first uploads and queries to the Elasticsearch instance. It's as simple as a few `curl`
commands!


## Reference

* <https://github.com/elastic/elasticsearch>
