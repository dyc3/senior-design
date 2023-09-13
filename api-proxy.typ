= REST API Proxy <Chapter::RestApiProxy>

== Forwarding API Requests
When a REST API request is made to OpenTogetherTube, the request is first received by the load balancer
acting as the reverse proxy for API requests. The load balancer then selects one of the OTT monoliths based
on the current load balancing algorithm and forwards the request to the selected monolith. The monolith processes
the request and sends a response back to the load balancer acting as the reverse proxy. The load balancer then returns
the response to the client that made the original request.

#figure(
  image("figures/api-balancer.png"),
  caption: "API Balancer Flowchart."
) <Figure::api-balancer>

== Forwarding Requests Credentials

OpenTogetherTube platform uses tokens to authenticate and authorize users. When a user logs in, the
server generates a token that is stored in the browser's local storage and included in all subsequent requests made
by the user. The server verifies the token to ensure that the user is authenticated and has permission to access the
requested video stream. The token is used to look up the session information in Redis, which allows the server to
retrieve the user's permissions and session state.

== OpenAPI Endpoints Route Specification

// Table @tbl:endpoints shows each API endpoint and the route it will lead to. Additionally, it describes the function of each endpoint.

#{
  let api = yaml("api.yaml")
  let rows = ()
  for (path, methods) in api.paths {
    for (method, endpoint) in methods {
      if method == "parameters" {
        continue
      }
      let category = endpoint.at("tags", default: ("other",)).at(0)
      let description = endpoint.at("summary", default: "No summary")
      let row = (category, path, method, description)
      rows = rows + (row,)
    }
  }

  figure(
    table(
      columns: (auto, auto, auto, auto),
      inset: 5pt,
      align: horizon,
      [Category],
      [Endpoint],
      [Methods],
      [Description],
      ..rows.flatten()
    ),
    caption: "API Endpoints"
  ) // <tbl:endpoints>
}



The routing between categories can be determined based on the relationships between the endpoints and the logical flow of the application. For example, endpoints within the "Room" category may have routes connecting to each other within the category, while endpoints in different categories may have separate routes.

API Specifications:

- All `/api/room/:roomName` endpoints are routed to a specific monolith based on the `:roomName` parameter.
- `/api/room/generate` and `/api/room/create` are routed to the monolith with the least number of rooms.
- `/api/room/list` is a special case and will list rooms from all monoliths.
- `/api/status` and `/api/status/metrics` should not be forwarded as their responses are specific to each monolith and are only used for monitoring purposes.
- All other endpoints are stateless and can be routed to any available monolith.
