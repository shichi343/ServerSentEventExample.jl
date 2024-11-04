# Server-Sent Events Example in Julia

A simple example demonstrating Server-Sent Events (SSE) implementation in Julia using HTTP.jl.

## Features

* Server-side streaming using SSE protocol
* Word-by-word streaming response
* Simple client script for testing

## Requirements

* Julia 1.11 or later

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shichi343/ServerSentEventExample.jl.git
   ```

2. Navigate to the project directory and start Julia:
   ```bash
   cd ServerSentEventExample.jl
   julia
   ```

3. Activate and instantiate the project:
   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   ```

## Usage

### Start the server

```bash
julia --project=. bootstrap.jl
```

### Test with the provided client script

```bash
julia --project=. scripts/client.jl
```

### Test using curl

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello, World!"}' \
  http://localhost:8080/event
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
