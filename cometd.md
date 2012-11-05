# Chapter 3. Concepts & Architecture

All messages the client and server exchange have a channel field. The channel field provides the characterization of messages in classes. The channel is a central concept in CometD: publishers publish messages to channels, and subscribers subscribe to channels to receive messages. This is strongly reflected in the CometD APIs.

## 3.1.1. Channel Definitions

A channel is a string that looks like a URL path such as /foo/bar, /meta/connect or /service/chat.

The Bayeux specification defines three types of channels: meta channels, service channels and broadcast channels (see Appendix C, The Bayeux Protocol Specification v 1.0).

A channel that starts with /meta/ is a meta channel, a channel that starts with /service/ is a service channel, and all other channels are broadcast channels.

A message whose channel field is a meta channel is referred to as a meta message, and similarly there are service messages and broadcast messages.

The application creates service channels and broadcast channels; an application can create as many as it needs, and can do so at any time.

### 3.1.1.1. Meta Channels

**The CometD implementation creates meta channels; applications cannot create new meta channels**. Meta channels provide to applications information about the Bayeux protocol (see Section 3.3.7, “Bayeux Protocol”), for example, whether handshakes have been successful or not, or whether the connection with the server is broken or has been re-established.

### 3.1.1.2. Service Channels

**Applications create service channels**, which are used in the case of request/response style of communication between client and server (as opposed to the publish/subscribe style of communication of broadcast channels, see below).

### 3.1.1.3. Broadcast Channels

**Applications also create broadcast channels**, which have the semantic of a messaging topic and are used in the case of the publish/subscribe style of communication, where one sender wants to broadcast information to multiple recipients.

### 3.1.1.4. Use of Wildcards in Channels

You can use wildcards to match multiple channels: channel /foo/* matches /foo/bar but not /foo/bar/baz. The latter is matched by /foo/**. You can use wildcards for any type of channel: /meta/* matches all meta channels, and /service/** matches /service/bar as well as /service/bar/baz. Channel /** matches all channels. You can specify the wildcards only as the last segment of the channel, so these are invalid channels: /**/foo or /foo/*

## 3.2. The High Level View

Looking from a high level then, you see messages flowing back and forth among clients and server through the conduits. A single broadcast message might arrive at the server and be re-routed to all clients; you can imagine that when it arrives on the server, the message is copied and that a copy is sent to each client (although, for efficiency reasons, this is not exactly what happens). If the sender also subscribes to the channel it published the message to, it receives a copy of the message back.

## 3.3. The Lower Level View

It should be clear by now that CometD, at its heart, is a client/server system that communicates via a protocol, the Bayeux protocol.

In broad terms, the client is composed of the client half-object and the client transport, while the server is a more complex entity that groups server half-objects and server transports.

### 3.3.1. Sessions

Sessions are a central concept in CometD. They are the representation of the half-objects involved in the protocol communication.

**There are three types of sessions:**

- Client sessions – the client half-object on the remote client side. Client sessions are represented by the org.cometd.Cometd object in JavaScript, and by the org.cometd.bayeux.client.ClientSession class (but more frequently by its subclass org.cometd.bayeux.client.BayeuxClient) in Java. The client creates a client session to establish a Bayeux communication with the server, and this allows the client to publish and receive messages.

- Server sessions – the server half-object on the server side. Server sessions are on the server, and are represented by the org.cometd.bayeux.server.ServerSession class; they are the counterpart(副本；配对物) of client sessions. When a client creates a client session, it is not initially associated with a correspondent server session. Only when a client session establishes the Bayeux communication with the server does the server create its correspondent server session, as well as the link between the two half-objects. Each server session has a message queue. Messages publish to a channel and must be delivered to remote client sessions that subscribe to the channel. They are first queued into the server session's message queue, and then delivered to the correspondent client session.

- Local sessions – the client half-object on the server side, represented by class org.cometd.bayeux.server.LocalSession. Local sessions can be thought of as clients living in the server. They do not represent a remote client, but instead a server-side client. Local sessions can subscribe to channels and publish messages like a client session can, but they live on the server. The server only knows about server sessions, and the only way to create a server session is to create its correspondent client session first, and then make it establish the Bayeux communication with the server. For this reason, on the server side, there is the additional concept of local session. A local session is a client session that happens to live on the server, and hence is local to the server.

Server-side services are associated with a local session. Upon creation of the server-side service, the local session handshakes and creates the correspondent server session half-object, so that the server can treat client sessions and local sessions in the same way (because it sees them both as server sessions). The server delivers messages sent to a channel to all server sessions that subscribe to that channel, no matter if they are remote client sessions or local sessions.

### 3.3.2. The Server

The server is represented by an instance of `org.cometd.bayeux.server.BayeuxServer`. The BayeuxServer object acts as a:

- Repository for server sessions, see Section 3.3.1, “Sessions”.

- Repository for server transports – represented by the `org.cometd.bayeux.server.ServerTransport` class. A server transport is a server-side component that handles the details of the communication with the client. There are HTTP server transports as well as a WebSocket server transport, and you can plug in other types as well. Server transports abstract the communication details so that applications can work knowing only Bayeux messages, no matter how they arrive on the server.

- Repository for server channels – represented by the `org.cometd.bayeux.server.ServerChannel` class. A server channel is the server-side representation of a channel; it can receive and publish Bayeux messages.

- Repository for extensions – represented by the `org.cometd.bayeux.server.BayeuxServer.Extension` class. Extensions allow applications to interact with the Bayeux protocol by modifying or even deleting or replaying incoming and/or outgoing Bayeux messages.

- Central authorization authority, via an instance of the security policy – represented by the `org.cometd.bayeux.server.SecurityPolicy` class. CometD interrogates the security policy to authorize any sensible operation the server performs, such as handshakes, channel creation, channel subscription and channel publishing. Applications can provide their own security policy to implement their own authorization logic.

- Authorizers – represented by the `org.cometd.bayeux.server.Authorizer` class allow you to apply more fine-grained authorization policies.

- Message processor, by coordinating the work of server transports, extensions and security policy, and by implementing a message flow algorithm (see Section 3.3.4, “Message Processing”) that allows applications to interact with messages and channels to implement their application logic.

### 3.3.3. Listeners

Applications use listeners to interact with sessions, channels and the server. The Java and JavaScript APIs allow applications to register different kinds of listeners that receive notifications of the correspondent events. You can usefully think of extensions, security policies and authorizers as special types of listeners. The following sections treat them as such.

### 4.3.4. Subscribers versus Listeners

The JavaScript CometD API has two APIs to work with channel subscriptions:

- addListener() and the correspondent removeListener()
- subscribe() and the correspondent unsubscribe()

The addListener() method:

- Must be used to listen to meta channel messages.
- May be used to listen to service channel messages (you can also use subscribe(), but we do not recommend it).
- Should not be used to listen broadcast channel messages (use subscribe() instead).
- Does not involve any communication with the Bayeux server, and as such can be called before calling handshake().
- Is synchronous: when it returns, you are guaranteed that the listener has been added.

The subscribe() method:

- Must not be used to listen to meta channels messages (if attempted, the server returns an error).
- May be used to listen to service channel messages (you can also useaddListener(), which is preferred).
- Should be used to listen to broadcast channel messages.
- Involves a communication with the Bayeux server and as such cannot be called before calling handshake().
- Is asynchronous: it returns immediately, well before the Bayeux server has received the subscription request

### 4.3.7. Meta Channel List

These are the meta channels available in the JavaScript CometD implementation:

- /meta/handshake
- /meta/connect
- /meta/disconnect
- /meta/subscribe
- /meta/unsubscribe
- /meta/publish
- /meta/unsuccessful

## 4.7. JavaScript Transports

Appendix C, The Bayeux Protocol Specification v 1.0 defines two mandatory transports: long-polling and callback-polling.

The JavaScript CometD implementation implements these two transports and supports also the websocket transport (based on HTML 5 WebSockets).

**CometD falls back to long-polling if the websocket transport does not work.**

### 4.7.1. The long-polling Transport

The long-polling transport is the default transport if the browser and the server do not support WebSockets. This transport is used when the communication with the Bayeux server happens on the same domain, and also in the cross-domain mode for recent browsers, such as Firefox 3.5+ (see Section 4.7.5, “The cross-domain Mode”). The data is sent to the server by means of a POST request with Content-Type application/json via a plain XMLHttpRequest call.

### 4.7.2. The callback-polling Transport

The callback-polling transport is used when the communication with the Bayeux server happens on a different domain and when the cross-domain mode is not supported (see Section 4.7.5, “The cross-domain Mode”).

### 4.7.3. The websocket Transport

The websocket transport is available if the browser and the server support WebSocket (Jetty 7 and later support the WebSocket protocol). The WebSocket protocol is designed to be the bidirectional communication protocol for the web, so it is a natural fit in the CometD project.

Since browser support has greatly improved, the websocket transport is enabled by default since CometD 2.4.0, but you can easily disable it if you experience problems.

## 5.1. CometD Java Libraries and Servlet 2.5

The CometD Java implementation, though based on Jetty, is portable on other Servlet 2.5 compliant servlet containers because it uses the portable **Jetty Continuation API**.

## 5.2. CometD Java Libraries and Servlet 3.0

When deployed to a Servlet 3.0 compliant servlet container, the CometD implementation makes use of the asynchronous features the servlet container offers, and is fully portable and scalable (the scalability is as good as the servlet container's implementation). 

## 5.4. Server Library

### 5.4.1. Configuring the Java Server

