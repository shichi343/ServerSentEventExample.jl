module ServerSentEventExample

export main

using HTTP
using JSON3
using StructTypes

const WORD_DELAY = 0.2

struct Request
    message::String
end

StructTypes.StructType(::Type{Request}) = StructTypes.Struct()

function stream(stream::HTTP.Stream)
    HTTP.setheader(stream, "Access-Control-Allow-Origin" => "*")
    HTTP.setheader(stream, "Access-Control-Allow-Methods" => "POST, OPTIONS")
    HTTP.setheader(stream, "Access-Control-Allow-Headers" => "Content-Type")
    HTTP.setheader(stream, "Content-Type" => "text/event-stream")
    HTTP.setheader(stream, "Cache-Control" => "no-cache")

    startwrite(stream)

    if HTTP.method(stream.message) == "OPTIONS"
        return nothing
    end

    request = JSON3.read(String(readavailable(stream)), Request)

    response = "Hello! I am an AI assistant. " *
               "You said: $(request.message). " *
               "I am here to help you with your questions and provide assistance."

    for word in split(response)
        write(stream, "data: $(word)\n\n")
        sleep(WORD_DELAY)
    end

    write(stream, "data: [DONE]\n\n")

    closewrite(stream)

    return nothing
end

const ROUTER = HTTP.Router()

HTTP.register!(ROUTER, "/event", stream)

function main(; host = "0.0.0.0", port = 8080)
    println("Server is running on http://$(host):$(port)")
    HTTP.serve(ROUTER, host, port; stream = true, verbose = true)
end

end # module
