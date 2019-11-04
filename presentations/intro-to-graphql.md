---
title: Introduction to GraphQL
author: Christopher Bartling
date: October 21, 2019
---

## REST 

::: incremental

+ Data requirements are dictated by the server-side 
  - Multiple requests to fetch object graphs
+ Multiple views of the same REST endpoint 
  - Compact vs full views
+ API evolution via versioned endpoints
+ Weakly-typed endpoints

:::


::: notes
Fetching complicated object graphs require multiple round trips between the client and server to render single views. For mobile applications operating in variable network conditions, these multiple roundtrips are highly undesirable.

Another solution to limit over-fetching is to provide multiple views – such as “compact” vs “full” – of the same REST endpoint, however this coarse granularity often does not offer adequate flexibility.
:::


## REST issues 

::: incremental

- Over-fetching superfluous data
+ Multiple requests to materialize resource graphs
  - Client is responsible for orchestrating data fetching
- Payloads tend to grow over time, resulting in over-fetching
- Code duplication when supporting multiple versions

:::


::: notes
Invariably fields and additional data are added to REST endpoints as the system requirements change. However, old clients also receive this additional data as well, because the data fetching specification is encoded on the server rather than the client. As result, these payloads tend to grow over time for all clients. When this becomes a problem for a system, one solution is to overlay a versioning system onto the REST endpoints. 

However, fetching this data correctly must be carefully done in order to provide a satisfactory user experience. Your application needs to retrieve only the data that it actually needs in a single round trip or else risk poor performance. In addition, your application might come in several different versions, or be used on several different devices, and needs to maintain its level of performance as updates are rolled out and additional features are added. All of these factors heighten the complexity involved in designing a modern web or phone application that relies on accessing external data stores.

One of the most common problems with REST is that of over- and underfetching. This happens because the only way for a client to download data is by hitting endpoints that return fixed data structures. It’s very difficult to design the API in a way that it’s able to provide clients with their exact data needs.

Overfetching: Downloading superfluous data
Overfetching means that a client downloads more information than is actually required in the app. Imagine for example a screen that needs to display a list of users only with their names. In a REST API, this app would usually hit the /users endpoint and receive a JSON array with user data. This response however might contain more info about the users that are returned, e.g. their birthdays or addresses - information that is useless for the client because it only needs to display the users’ names.

Underfetching and the n+1 problem
Another issue is underfetching and the n+1-requests problem. Underfetching generally means that a specific endpoint doesn’t provide enough of the required information. The client will have to make additional requests to fetch everything it needs. This can escalate to a situation where a client needs to first download a list of elements, but then needs to make one additional request per element to fetch the required data. As an example, consider the same app would also need to display the last three followers per user. The API provides the additional endpoint /users/<user-id>/followers. In order to be able to display the required information, the app will have to make one request to the /users endpoint and then hit the /users/<user-id>/followers endpoint for each user.

Versioning also complicates a server, and results in code duplication, spaghetti code, or a sophisticated, hand-rolled infrastructure to manage it.

REST endpoints are usually weakly-typed and lack machine-readable metadata. While there is much debate about the merits of strong- versus weak-typing in distributed systems, we believe in strong typing because of the correctness guarantees and tooling opportunities it provides. Developers deal with systems that lack this metadata by inspecting frequently out-of-date documentation and then writing code against the documentation.

Many of these attributes are linked to the fact that “REST is intended for long-lived network-based applications that span multiple organizations” according to its inventor. This is not a requirement for APIs that serve a client app built within the same organization.

Nearly all externally facing REST APIs we know of trend or end up in these non-ideal states, as well as nearly all internal REST APIs. The consequences of opaqueness and over-fetching are more severe in internal APIs since their velocity of change and level of usage is almost always higher.
:::


## GraphQL Principles

::: incremental

- Hierarchical, graph-oriented
- Product-centric data requirements
- Client-specified queries
- Backwards compatible
- Application-layer protocol
- Strongly-typed
- Introspective

:::


::: notes
Most products deal in the creation and manipulation of view hierarchies. GraphQL queries model themselves as a hierarchical set of fields. The query is shaped just like the data it returns. It is a natural way for product engineers to describe data requirements.

GraphQL is unapologetically driven by the requirements of views and the front-end engineers that write them. We start with their way of thinking and requirements and build the language and runtime necessary to enable that.

Client-specified queries: In GraphQL, the specification for queries are encoded in the client rather than the server. These queries are specified at field-level granularity. In the vast majority of applications written without GraphQL, the server determines the data returned in its various scripted endpoints. A GraphQL query, on the other hand, returns exactly what a client asks for and no more.

Backwards Compatible: In a world of deployed native mobile applications with no forced upgrades, backwards compatibility is a challenge. Facebook, for example, releases apps on a two week fixed cycle and pledges to maintain those apps for at least two years. This means there are at a minimum 52 versions of our clients per platform querying our servers at any given time. Client-specified queries simplifies managing our backwards compatibility guarantees.

Application-Layer Protocol: GraphQL is an application-layer protocol and does not require a particular transport. It is a string that is parsed and interpreted by a server.

Strongly-typed: GraphQL is strongly-typed. Given a query, tooling can ensure that the query is both syntactically correct and valid within the GraphQL type system before execution, i.e. at development time, and the server can make certain guarantees about the shape and nature of the response. This makes it easier to build high quality client tools.

Introspective: GraphQL is introspective. Clients and tools can query the type system using the GraphQL syntax itself. This is a powerful platform for building tools and client software, such as automatic parsing of incoming data into strongly-typed interfaces. It is especially useful in statically typed languages such as Swift, Objective-C and Java, as it obviates the need for repetitive and error-prone code to shuffle raw, untyped JSON into strongly-typed business objects.
:::


## Declarative Data Fetching

::: incremental

- Query language to satisfy data requirements for the client
- Client defines what will be included in the query response, not the server
- Data requirements are specified as a hierarchy of fields
- Avoid calling multiple endpoints 
- Avoid aggregating data manually
- Avoid over-fetching and under-fetching data

:::


::: notes
With GraphQL, there's no need to call multiple endpoints from the client or aggregate the data manually like you have to with traditional REST data fetching. Instead, you specify the exact data you need and GraphQL gives you exactly what you asked for.

In GraphQL a single query is sent to the GraphQL server that includes the concrete data requirements as a hierarchy of fields. The server then responds with a JSON object where these requirements are fulfilled.

The key here was treating data like a hierarchy, not a table. This was indicative of an overall shift in how the app could make use of its hoards of available information. A single search could generate a variety of data points related to the original search term, all nested together.
:::


## Developer Experience

::: incremental

+ GraphQL delivers better developer experience with...
  -  a self describing API which can be introspected by tooling
  -  query and mutation input validation 
  -  query facilities that aggregate data on the server-side

:::


::: notes
:::


## Performance Improvements

::: incremental

+ GraphQL delivers better performance by...
  - reducing the number of requests for a data graph
  - aggregating the data graph on the server-side
  - only sending the data fields requested 

:::


::: notes
:::


## Schema Definition Language (SDL)

::: incremental

- Strong type system
- Type language: Schema Definition Language (SDL)

:::


::: notes
GraphQL has its own type system that’s used to define the schema of an API. GraphQL defines its own simple language. We'll use the "GraphQL schema language" - it's similar to the query language, and allows us to talk about GraphQL schemas in a language-agnostic way. The syntax for writing schemas is called Schema Definition Language (SDL). 

:::

## User-defined Scalars

```graphql

scalar uuid

scalar timestamp

scalar secureUrl

```

:::notes
In addition to built-in scalars, you can define your own custom scalar types. Often you need to support custom atomic data types (e.g. Date), or you want a version of an existing type that does some fine-grained validation. To enable this, GraphQL allows you to define custom scalar types. In a lot of cases you might want to check if an email, date-time or url format is valid. It is easily doable by defining your custom email/datetime/url scalars.
:::


## Enumerations

```graphql

enum ConflictAction {
  ignore
  update
}

```

:::notes
Enumerations are similar to custom scalars, but their values can only be one of a pre-defined list of strings.
:::


## Object Types and Fields

```graphql
     
type Actor {
  id: uuid!
  firstName: String!
  lastName: String!
}

```


## User-defined Object Type Field

```graphql

type ActorAggregateFields {
  count(columns: [ActorSelectColumn!], 
        distinct: Boolean): Int
  max: ActorMaxFields
  min: ActorMinFields
}

```


## Lists and Non-null

```graphql

type ActorsAggregate {
  aggregate: ActorAggregateFields
  nodes: [Actor!]!
}

```


## Interfaces

```graphql

interface Person { 
  id: ID! 
  firstName: String! 
  lastName: String!
}

type DraftProspect implements Person { 
  id: ID! 
  firstName: String! 
  lastName: String!
  position: FootballPosition!
}

```

## Union

```graphql

union SearchResult = Human | Droid | Starship

```

## Input Types

```graphql

input ReviewInput {
  stars: Int!
  commentary: String
}

```

## GraphQL Queries

::: incremental

- Queries retrieve data
- Query structure mimics data structure in response

:::


## Query type

```graphql

type Query {
  hero(episode: Episode): Character
  droid(id: ID!): Droid
}

```

## Query example

```graphql

query {
  hero {
    name
  }
  droid(id: "2000") {
    name
  }
}

```

## GraphQL Mutations

::: incremental

- Mutations create, update, or remove data
- Typically use input types for specifying a grouping of fields
  
:::


## Mutation type

```graphql

type Mutation {
  addBook(input: AddBookInput!): Book
  removeBook(id: ID!): Boolean
}

```

## Mutation example 

```graphql

mutation AddBook($input: AddBookInput!) {
  addBook(input: $input) {
    id
  }
}

```

- Input is bound to variables in client


## GraphQL Subscriptions

::: incremental

- Server-sent events
- Asynchronous
- Communication through WebSockets
- Server-side implementation dependent on platform 

:::


## Subscription type

```graphql

type Subscription {
  commentAdded(input: CommentAddedSubscribeInput!): Comment
}

```


## Subscription type

```graphql

subscription CommentAddedSubscription(
    $input: CommentAddedSubscribeInput!
  ) {
  commentAddedSubscribe(input: $input) {
    comment {
      id
      commentText
      commenter {id, firstName, lastName}
    }
  }
}


```


## Schema declaration

```graphql

schema {
  query: Query
  mutation: Mutation
  subscription: Subscription
}

```


## Server implementations

- Apollo Server (Node.js)
- 


## Clients

- Apollo Client (JavaScript, iOS, Android)
- Relay (https://relay.dev/)



## Tools

+ Insomnia
  - https://insomnia.rest/graphql/
+ Altair
  - https://altair.sirmuel.design/



## Recommended reading

+ Principled GraphQL
  - https://principledgraphql.com/
+ Production Ready GraphQL
  - https://productionreadygraphql.com/  
+ The GraphQL Guide
  - https://graphql.guide/



## This presentation




## Literature Cited

- https://reactjs.org/blog/2015/05/01/graphql-introduction.html
- https://www.upwork.com/hiring/development/why-facebooks-graphql-language-should-be-on-your-radar/
- https://www.youtube.com/watch?v=pJamhW2xPYw&amp=&feature=youtu.be
- https://speakerdeck.com/dschafer/graphql-client-driven-development?slide=61


## Literature Cited

- https://crystallize.com/blog/better-developer-experience-with-graphql
- https://graphql.org/blog/subscriptions-in-graphql-and-relay/




