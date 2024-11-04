using HTTP
using JSON3

function test_server_sent_event(url)
    headers = ["Content-Type" => "application/json"]

    HTTP.open("POST", url, headers; verbose = true) do io
        body = JSON3.write(Dict("message" => "Hello, World!"))
        write(io, body)

        response = startread(io)
        @show response

        while !eof(io)
            response = String(readavailable(io))
            @show response
        end
    end
end

test_server_sent_event("http://localhost:8080/event")
