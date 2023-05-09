FROM rust:1.69-buster as builder

WORKDIR /app

ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL

COPY . .

RUN cargo build --release

# production stage

FROM debian:buster-slim

WORKDIR usr/src/app

COPY --from=builder /app/target/release/rust-crud-api .

CMD ["./rust-crud-api"]