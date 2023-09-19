= Discovery <Chapter::Discovery>

== fly.rs

Use when connecting to instance of monolith on fly.io

=== struct FlyDiscoveryConfig
    pub monolith_port: u16
    
    -The port that monoliths should be listening on for load balancer connections.

    pub fly_app: String

=== struct FlyMonolithDiscoverer
    config: FlyDiscoveryConfig
    query: String

=== FlyMonolithDiscoverer(config: FlyDiscoveryConfig)

Tries to connect to monolith instance on fly.io

=== Ansync FlyMonolithDiscoverer 

== manual.rs

Use when manually connecting to local instance of monolith.

=== struct ManualDiscoveryConfig
    pub monoliths: Vec<MonolithConnectionConfig>

=== struct ManualMonolithDiscoverer
    config: ManualDiscoveryConfig

=== ManualMonolithDiscoverer(config: ManualDiscoveryConfig)

Tries to connect to monolith instance using manual config object

=== Async ManualMonolithDiscoverer
