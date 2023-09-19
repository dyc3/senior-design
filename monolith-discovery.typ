#import "@preview/in-dexter:0.0.5": *

= Discovery <Chapter::Discovery>

== fly.rs

Use when connecting to instance of monolith on fly.io

=== pub struct FlyDiscoveryConfig
    /// The port that monoliths should be listening on for load balancer connections.
    pub monolith_port: u16,
    pub fly_app: String,

=== pub struct FlyMonolithDiscoverer {
    config: FlyDiscoveryConfig,
    query: String,
}

=== impl FlyMonolithDiscoverer {
    pub fn new(config: FlyDiscoveryConfig) -> Self {
        info!(
            "Creating FlyMonolithDiscoverer, fly app: {}",
            &config.fly_app
        );
        let query = format!("global.{}.internal", &config.fly_app);
        Self { config, query }
    }
}

#[async_trait]
=== impl MonolithDiscovery for FlyMonolithDiscoverer {
    

== manual.rs

Use when manually connecting to local instance of monolith.
