## Running

To run the project locally, follow these steps:

1. Install dependencies by running `make install_deps` in the project root.
2. Set up the database by running `make setup_db` (this will create the database and run the migrations).
3. Start the Phoenix server by running `make serve` (or use `iex -S mix phx.server` for an interactive shell).

## Built with Aider.chat

https://aider.chat is the only AI coding assistant that I've found actually
saves me some amount of time. I started using it shortly before starting this
coding challenge so I ended up using it a lot with this project to get a better
feel for the tool.

I am happy to walk through the code and explain everything, or whatever test you
want me to do to prove I understand what's happening here, and I didn't just
blindly do what the AI tool told me.

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

## TODOs
- add tests
- ensure logos load when on the proper tier
- add stock statistics
- add more stock details
