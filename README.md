### Automatically tracked protobufs for Steam and Valve's games.

These protobufs are being dumped as updates come in the [SteamTracking](https://github.com/SteamDatabase/SteamTracking) repository.

Protobufs are dumped using [SteamKit's protobuf dumper](https://github.com/SteamRE/SteamKit/tree/master/Resources/ProtobufDumper).

For protobufs dumped from javascript files (in webui folder), we have a [separate dumper](https://github.com/SteamDatabase/SteamTracking/blob/master/dump_javascript_protobufs.mjs) which parses javascript files into abstract syntax tree and tries to find all the messages and services. As such, these dumps are not as complete as dumps from binary files because minified javascript files lack some information.

> [!NOTE]
> Artifact and Underlords protobufs are no longer being updated automatically.
