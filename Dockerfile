FROM alpine:3.7 as builder

RUN apk --no-cache add alpine-sdk snappy protobuf file

ENV PIKA  /pika
COPY . ${PIKA}
WORKDIR ${PIKA}
RUN make DISABLE_UPDATE_SB=1 360=1 V=1
ENV PATH ${PIKA}/output/bin:${PATH}

FROM alpine:3.7
ENV PIKA  /pika

RUN apk --no-cache add snappy protobuf

COPY --from=builder ${PIKA}/output ${PIKA}/output

WORKDIR ${PIKA}/output
