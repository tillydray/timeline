# Timeline Take Home Project

> **Note** This is designed to be done with Elixir specifically, but if you have
>talked about using a different programming language that you are more
>comfortable, stick with that.

## Prerequisites

You will need the following installed on your machine

- Elixir. Feel free to use any Elixir/OTP version. We recommend using
[asdf](https://asdf-vm.com/), in which case you can use the `.tool-versions`
file in this repository, to setup your development environment.

- PostgreSQL - You will need a local database, either PostgreSQL on your
machine,  or have Docker installed so we can create a PostgreSQL container. If
you want to  use docker, make sure it is installed --
https://docs.docker.com/get-docker/

- Review the docs of the Twelvedata API https://twelvedata.com/docs

- You will have to signup for a free account to get an API key. Go to
https://twelvedata.com/pricing and sign up for the free Basic plan to obtain
your API key.

- Please have your API key copied and ready to go. You can find your API key in
your account dashboard after signing up. The API key will be used to
authenticate your requests to the Twelve Data API.


## Assignment

This assignment consists of 8 different steps, that are functionally related,
and build upon each other.

### What is and isn't expected

- We don't expect you to complete all the steps.  The main goal of the
assignment is to have some code we can talk about in our next call.  We don't
want to use more of your free time than absolutely necessary.  The assignment is
intended to take **up to 5 hours**, but not more.

- You do not need to do the steps in the exact order they are listed.

- The application should work out of the box.

- We expect you to do **local refactorings and small code improvements** as you
  see fit.

- Last but not least we expect you to **use Git** during the assignment.  Put
your changes into appropriately sized commits, just as if you were working in a
collaborative environment. We will review these commits and  changes as part of
the pair review session. 


## Goals
1. Fetch stock data from the Twelve Data API. You will need to:
   - First fetch the list of available stocks using the `/stocks` endpoint
     ([https://api.twelvedata.com/stocks)](https://twelvedata.com/docs#stocks-list)
   - Then fetch time series data of the performance of the stock
     (https://twelvedata.com/docs#time-series)
   - Then fetch fundamentals data for the stocks you want to display using
     different fundamentals endpoints (e.g. https://twelvedata.com/docs#logo or
     https://twelvedata.com/docs#statistics)

2. Render the stock data in a grid view on the UI. We want to see a little CSS
   creativity here, so we intentionally did not provide designs. The grid view
   should show key info about the stock with appropriate formatting and styling.
   Feel free to choose LiveView or any SPA framework or library (Elm, React,
   Vue, Svelte, etc).

3. This is an expensive API and we don't care about intra-day changes; every
   time we load the page, we need to fetch all the data again from the Twelve
   Data API. Let's implement a cache that stores API calls in memory so we don't
   need to keep fetching it on each page reload.

4. Upper management wants to know how often we are making requests to the Twelve
   Data API, so let's capture the timestamp of each successful API call into a
   database table.

5. You will notice that we may want to fetch data for multiple stocks. Let's
   implement a pagination system to allow users to browse through different
   stock symbols in the UI. How does this affect our cache? Should we change
   anything?

6. Let's add more test coverage. We want to mock the API calls, test the
   front-end results, unit test the API authentication code, etc.

7. Returning to the UI, let's add a stock details page. Users should be able to
   click on any stock in the index view to see more details. Feel free to choose
   the information you  want to display here in any way you want.

8. What are some ways that we can improve the current code we just wrote?

## Handing in the solution

- Once you are done, ensure you committed and pushed all your changes, and then
  you can send your solution directly by email to
  [nacho@timeline.co](mailto:nacho@timeline.co?subject=Elixir%20Assignment), for
  example, as a zip archive. Please make sure the solution contains the entire
  project, including the `.git` directory, so we can have a look at your
  commits.

- [Schedule a follow up review
  call](https://calendly.com/d/cngq-hp9-fjn/technical-interview) to go over your
  final implementation.a
