# Introduction to GraphQL: Hasura demo

## Introduction


## Running the demo

1. Make sure you have Docker and docker-compose available on your system.
2. Run `docker-compose up` to bring up PostgreSQL and the Hasura GraphQL Engine.
3. Navigate to http://localhost:8080/console to view the Hasura GraphQL Engine Console.

## Queries

### Movie with reviews and actors

```graphql
query MovieAndReviewsQuery($title: String!) {
  movies(where: {title: {_like: $title}}) {
    id
    title
    yearProduced
    grossSalesRevenue
    movie_actors {
      actor {
        id
        firstName
        lastName       
      }
    }
    reviews {
      id
      created_at
      comment
    }
  }
}
```

Query variables

```json
{"title": "Good%"}
```


### Movie with reviews and actors and aggregate counts

```graphql
query MovieAndReviewsQueryWithCounts($title: String!) {
  movies(where: {title: {_eq: $title}}) {
    id
    title
    yearProduced
    grossSalesRevenue
    movie_actors {
      actor {
        id
        firstName
        lastName       
      }
    }
    movie_actors_aggregate {
      aggregate {
        count
      }
    }
    reviews {
      id
      created_at
      comment
    }
    reviews_aggregate {
      aggregate {
        count
      }
    }
  }
}
```

Query variables

```json
{"title": "Taxi Driver"}
```