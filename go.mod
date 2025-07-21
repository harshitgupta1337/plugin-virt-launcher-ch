module github.com/harshitgupta1337/independent-virt-launcher

go 1.23.0

toolchain go1.23.3

require (
	kubevirt.io/api v0.0.0-00010101000000-000000000000
	kubevirt.io/client-go v0.0.0-00010101000000-000000000000
	kubevirt.io/kubevirt v0.0.0-00010101000000-000000000000
)

require (
	github.com/fxamacker/cbor/v2 v2.7.0 // indirect
	github.com/go-kit/log v0.2.1 // indirect
	github.com/go-logfmt/logfmt v0.6.0 // indirect
	github.com/go-logr/logr v1.4.2 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/openshift/custom-resource-status v1.1.2 // indirect
	github.com/x448/float16 v0.8.4 // indirect
	go.uber.org/mock v0.5.1 // indirect
	golang.org/x/net v0.36.0 // indirect
	golang.org/x/sys v0.30.0 // indirect
	golang.org/x/text v0.22.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240826202546-f6391c0de4c7 // indirect
	google.golang.org/grpc v1.65.0 // indirect
	google.golang.org/protobuf v1.36.1 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	k8s.io/api v0.32.5 // indirect
	k8s.io/apiextensions-apiserver v0.32.5 // indirect
	k8s.io/apimachinery v0.32.5 // indirect
	k8s.io/klog/v2 v2.130.1 // indirect
	k8s.io/utils v0.0.0-20241104100929-3ea5e8cea738 // indirect
	kubevirt.io/containerized-data-importer-api v1.60.3-0.20241105012228-50fbed985de9 // indirect
	kubevirt.io/controller-lifecycle-operator-sdk/api v0.0.0-20220329064328-f3cc58c6ed90 // indirect
	sigs.k8s.io/json v0.0.0-20241010143419-9aa6b5e7a4b3 // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.4.3 // indirect
	sigs.k8s.io/yaml v1.4.0 // indirect
)

replace (
	kubevirt.io/api => ../kubevirt/staging/src/kubevirt.io/api
	kubevirt.io/client-go => ../kubevirt/staging/src/kubevirt.io/client-go
	kubevirt.io/kubevirt => ../kubevirt
)
