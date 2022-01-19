# Makefile
F5GC_BASE_NAME                     ?= f5gc-base
UERANSIM_NAME                      ?= ueransim
F5GC_AMF_NAME                      ?= f5gc-amf
F5GC_SMF_NAME                      ?= f5gc-smf
F5GC_UPF_NAME                      ?= f5gc-upf
F5GC_NRF_NAME                      ?= f5gc-nrf
F5GC_AUSF_NAME                     ?= f5gc-ausf
F5GC_NSSF_NAME                     ?= f5gc-nssf
F5GC_PCF_NAME                      ?= f5gc-pcf
F5GC_UDM_NAME                      ?= f5gc-udm
F5GC_UDR_NAME                      ?= f5gc-udr
F5GC_WEBUI_NAME                    ?= f5gc-webui
F5GC_N3IWF_NAME                    ?= f5gc-n3iwf

DOCKER_ENV                         ?= DOCKER_BUILDKIT=1
DOCKER_TAG_F5GC                    ?= v3.0.6
DOCKER_TAG_UERANSIM                ?= v3.2.6
DOCKER_REGISTRY                    ?= ip-10-0-0-10:5000
DOCKER_REPOSITORY                  ?= free5gc-k8s
DOCKER_BUILD_ARGS                  ?= --rm
#DOCKER_BUILD_ARGS                  ?= --rm --no-cache

BASE_IMAGE_NAME?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_BASE_NAME}:${DOCKER_TAG_F5GC}
UERANSIM_IMAGE_NAME?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${UERANSIM_NAME}:${DOCKER_TAG_UERANSIM}
AMF_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_AMF_NAME}:${DOCKER_TAG_F5GC}
SMF_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_SMF_NAME}:${DOCKER_TAG_F5GC}
UPF_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UPF_NAME}:${DOCKER_TAG_F5GC}
NRF_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_NRF_NAME}:${DOCKER_TAG_F5GC}
AUSF_IMAGE_NAME                   ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_AUSF_NAME}:${DOCKER_TAG_F5GC}
NSSF_IMAGE_NAME                   ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_NSSF_NAME}:${DOCKER_TAG_F5GC}
PCF_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_PCF_NAME}:${DOCKER_TAG_F5GC}
UDM_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UDM_NAME}:${DOCKER_TAG_F5GC}
UDR_IMAGE_NAME                    ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UDR_NAME}:${DOCKER_TAG_F5GC}
WEBUI_IMAGE_NAME                  ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_WEBUI_NAME}:${DOCKER_TAG_F5GC}
N3IWF_IMAGE_NAME                  ?= ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_N3IWF_NAME}:${DOCKER_TAG_F5GC}



build-all: build-base build-ueransim build-amf build-smf build-upf build-nrf build-ausf build-nssf build-pcf build-udm build-udr build-webui build-n3iwf
build-NF: build-base build-amf build-smf build-upf build-nrf build-ausf build-nssf build-pcf build-udm build-udr build-webui build-n3iwf


.PHONY: build-base
build-base:
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${BASE_IMAGE_NAME} \
	 --file ./images/${F5GC_BASE_NAME}/Dockerfile \
	 ./images/${F5GC_BASE_NAME}

.PHONY: build-ueransim
build-ueransim:
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${UERANSIM_IMAGE_NAME} \
	 --file ./images/${UERANSIM_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_UERANSIM} \
	 ./images/${UERANSIM_NAME}

.PHONY: build-amf
build-amf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${AMF_IMAGE_NAME} \
	 --file ./images/${F5GC_AMF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_AMF_NAME}

.PHONY: build-smf
build-smf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${SMF_IMAGE_NAME} \
	 --file ./images/${F5GC_SMF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_SMF_NAME}

.PHONY: build-upf
build-upf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${UPF_IMAGE_NAME} \
	 --file ./images/${F5GC_UPF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_UPF_NAME}

.PHONY: build-nrf
build-nrf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${NRF_IMAGE_NAME} \
	 --file ./images/${F5GC_NRF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_NRF_NAME}

.PHONY: build-ausf
build-ausf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${AUSF_IMAGE_NAME} \
	 --file ./images/${F5GC_AUSF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_AUSF_NAME}

.PHONY: build-nssf
build-nssf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${NSSF_IMAGE_NAME} \
	 --file ./images/${F5GC_NSSF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_NSSF_NAME}

.PHONY: build-pcf
build-pcf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${PCF_IMAGE_NAME} \
	 --file ./images/${F5GC_PCF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_PCF_NAME}

.PHONY: build-udm
build-udm: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${UDM_IMAGE_NAME} \
	 --file ./images/${F5GC_UDM_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_UDM_NAME}

.PHONY: build-udr
build-udr: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${UDR_IMAGE_NAME} \
	 --file ./images/${F5GC_UDR_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_UDR_NAME}

.PHONY: build-nssf
build-nssf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${NSSF_IMAGE_NAME} \
	 --file ./images/${F5GC_NSSF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_NSSF_NAME}

.PHONY: build-pcf
build-pcf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${PCF_IMAGE_NAME} \
	 --file ./images/${F5GC_PCF_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_PCF_NAME}

.PHONY: build-udm
build-udm: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${UDM_IMAGE_NAME} \
	 --file ./images/${F5GC_UDM_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_UDM_NAME}

.PHONY: build-udr
build-udr: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${UDR_IMAGE_NAME} \
	 --file ./images/${F5GC_UDR_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_UDR_NAME}

.PHONY: build-webui
build-webui: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${WEBUI_IMAGE_NAME} \
	 --file ./images/${F5GC_WEBUI_NAME}/Dockerfile \
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_WEBUI_NAME}

.PHONY: build-n3iwf
build-n3iwf: build-base
	${DOCKER_ENV} docker build ${DOCKER_BUILD_ARGS} \
	 --tag ${N3IWF_IMAGE_NAME} \
	 --file ./images/${F5GC_N3IWF_NAME}/Dockerfile\
	 --build-arg REGISTRY=${DOCKER_REGISTRY} \
	 --build-arg REPOSITORY=${DOCKER_REPOSITORY} \
	 --build-arg TAG=${DOCKER_TAG_F5GC} \
	 ./images/${F5GC_N3IWF_NAME}

clean:
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_BASE_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${UERANSIM_NAME}:${DOCKER_TAG_UERANSIM}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_AMF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_SMF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UPF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_NRF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_AUSF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_NSSF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_PCF_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UDM_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UDR_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_WEBUI_NAME}:${DOCKER_TAG_F5GC}
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_N3IWF_NAME}:${DOCKER_TAG_F5GC}

push:
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${UERANSIM_NAME}:${DOCKER_TAG_UERANSIM}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_AMF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_SMF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UPF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_NRF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_AUSF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_NSSF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_PCF_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UDM_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_UDR_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_WEBUI_NAME}:${DOCKER_TAG_F5GC}
	docker image push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${F5GC_N3IWF_NAME}:${DOCKER_TAG_F5GC}

all: build-all push
