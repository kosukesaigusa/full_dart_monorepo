# protobuf_helpers_for_functions

## Generate codes

```sh
protoc --proto_path=protos --dart_out=grpc:lib/src **/*.proto
dart format lib/src
```
