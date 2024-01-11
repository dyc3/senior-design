= Visualization Design

The visualization serves a dual purpose: To communicate the functionality of the load balancer at a glance to a non-technical audience, and to serve as a useful debugging tool during development.

== Hosting

Option 1: Self-Hosted
- Pros: No added cost, no compromises required   
- Cons: Not always online, longer startup time

Option 2: Buy a domain
- Pros: Always online, easy access
- Cons: Cost (that's probably enough of a con)

Option 3: Vercel
- Pros: Easy, free
- Cons: .vercel in the hostname, ???

Option 4: Another free hosting service
- Pros: No added cost
- Cons: Research required, design compromises may be needed, may be hard to setup

== Frameworks/Libraries

This is just a shortlist, looking at more tomorrow:

- *Cytoscape.js* - I wanna look into this one a little more but just look at this: https://js.cytoscape.org/demos/colajs-graph/
- D3 - Seems ok, esp force-directed graph. Like how popular/flexible it is, don't like how messy it seems
- React-vis - Seems promising, only works with react though
- Plotnine - probably not, just wanted to look at Python libraries

There's always the possibility of writing a graphing library, but that would be a full project in-of-itself

== Gathering Data

TBD
