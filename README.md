# Flagship Example

This is a simple example project using the Flagship platform.

## Running

Simply run the following command:
```shell
make run
```

This will run everything necessary via docker-compose.

You can see the example project UI at: http://localhost:3001


## How It Works

Firstly, we have a docker-compose file that runs everything.

- MySQL
  - Initialized with all necessary sample project data (found in `mysql` folder)
- Redis Cluster
- Flagship Admin API
- Flagship Flags API
- Flagship UI Server
  - Found at: http://localhost:3000
  - You can see how everything is set up on the Flagship side here
  - Log in with email `owner@flag.ship` and password `Test123!`
- Example Project UI
  - Simple React app using Javascript SDK
  - Found at: http://localhost:3001
- Example Project Server
  - FastAPI server using Python SDK


The example project works like so:

- There is one dropdown with question: "What kind of user are you?"
- The dropdown has options "Normal" and "Cool"
- When you select from the dropdown, your Flagship "context" changes, which results in a call to Flagship to load enabled feature flags
- There is a single feature flag configured called "COOL_FEATURE". This is set to only be enabled when the "user_type" context field equals 2 (i.e. "when you select "Cool" from the dropdown)
- If the UI detects that "COOL_FEATURE" is enabled, it will show the "new feature"


You may be thinking... couldn't this whole thing be done without Flagship? And you are absolutely right. This point of this project is just to show the whole end-to-end system in action.

