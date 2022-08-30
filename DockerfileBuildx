ARG KUBECTL_VERSION=v1.23.0
ARG KUBECTL_PLATFORM=linux/amd64
ARG HELM_VERSION=v3.9.0
ARG HELM_PLATFORM=linux-amd64
ARG K3D_VERSION=v5.4.3
ARG K3D_PLATFORM=linux-amd64
ARG TEKTON_CLI_VERSION=0.24.0
ARG TEKTON_CLI_PLATFORM=Linux_x86_64
ARG KREW_VERSION=v0.4.3
ARG KREW_PLATFORM=linux_amd64
ARG KIND_VERSION=v0.14.0
ARG KIND_PLATFORM=linux-amd64
ARG KPT_VERSION=v1.0.0-beta.19
ARG KPT_PLATFORM=linux_amd64
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# syntax=docker/dockerfile:1.4
FROM alpine:3.16 as kubectl
ARG KUBECTL_VERSION
ARG KUBECTL_PLATFORM
RUN wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${KUBECTL_PLATFORM}/kubectl && \
    wget -O /tmp/kubectl.sha256 "https://dl.k8s.io/${KUBECTL_VERSION}/bin/${KUBECTL_PLATFORM}/kubectl.sha256" && \
    echo "$(cat /tmp/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - && \
    chmod +x /usr/local/bin/kubectl && \
    kubectl version --client --output=yaml

# https://helm.sh/docs/intro/install/
FROM alpine:3.16 as helm
ARG HELM_VERSION
ARG HELM_PLATFORM
RUN wget -O /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-${HELM_PLATFORM}.tar.gz && \
    wget -O /tmp/helm.sha256 https://get.helm.sh/helm-${HELM_VERSION}-${HELM_PLATFORM}.tar.gz.sha256sum && \
    echo "$(cat /tmp/helm.sha256 | awk '{ print $1 }')  /tmp/helm.tar.gz" | sha256sum -c - && \
    tar -zxvf /tmp/helm.tar.gz --directory /tmp && \
    mv /tmp/${HELM_PLATFORM}/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    helm version && \
    echo 'source <(helm completion bash)' >>~/.bashrc

# https://k3d.io/v5.4.3/#installation
FROM alpine:3.16 as k3d
ARG K3D_VERSION
ARG K3D_PLATFORM
RUN wget -O /usr/local/bin/k3d https://github.com/k3d-io/k3d/releases/download/${K3D_VERSION}/k3d-${K3D_PLATFORM} && \
    chmod +x /usr/local/bin/k3d && \
    k3d version

# https://tekton.dev/docs/cli/
FROM alpine:3.16 as tekton
ARG TEKTON_CLI_VERSION
ARG TEKTON_CLI_PLATFORM
RUN wget -O /tmp/tkn.tar.gz https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/tkn_${TEKTON_CLI_VERSION}_${TEKTON_CLI_PLATFORM}.tar.gz &&\
    wget -O /tmp/checksums.txt https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/checksums.txt && \
    echo "$(cat /tmp/checksums.txt | grep "tkn_${TEKTON_CLI_VERSION}_${TEKTON_CLI_PLATFORM}.tar.gz" | awk '{ print $1 }')  /tmp/tkn.tar.gz" | sha256sum -c - && \
    tar -zxvf /tmp/tkn.tar.gz --directory /tmp  && \
    mv /tmp/tkn /usr/local/bin/tkn && \
    chmod +x /usr/local/bin/tkn && \
    tkn version

# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
FROM alpine:3.16 as krew
ARG KREW_VERSION
ARG KREW_PLATFORM
RUN apk --no-cache add ncurses git
RUN wget -O /tmp/krew.tar.gz https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VERSION}/krew-${KREW_PLATFORM}.tar.gz && \
    wget -O /tmp/krew.sha256 https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VERSION}/krew-${KREW_PLATFORM}.tar.gz.sha256 && \
    echo "$(cat /tmp/krew.sha256 | awk '{ print $1 }')  /tmp/krew.tar.gz" | sha256sum -c - && \
    tar -zxvf /tmp/krew.tar.gz --directory /tmp && \
    chmod +x /tmp/krew-${KREW_PLATFORM} && \
    mv /tmp/krew-${KREW_PLATFORM} /tmp/krew && \
    wget -O /tmp/kubectx.bash https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash && \
    wget -O /tmp/kubens.bash https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.bash

FROM alpine:3.16 as other
# https://github.com/ahmetb/kubectl-aliases
RUN wget -O /tmp/.kubectl_aliases https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases && \
    echo '[ -f $HOME/.kubectl_aliases ] && source ~/.kubectl_aliases' >> ~/.bashrc
    #echo 'function kubectl() { echo "+ kubectl $@">&2; command kubectl "$@"; }' >> ~/.bashrc

FROM alpine:3.16 as kind
ARG KIND_VERSION
ARG KIND_PLATFORM
RUN wget -O /usr/local/bin/kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-${KIND_PLATFORM} && \
    chmod +x /usr/local/bin/kind

FROM alpine:3.16 as kpt
ARG KPT_VERSION
ARG KPT_PLATFORM
RUN wget -O /usr/local/bin/kpt https://github.com/GoogleContainerTools/kpt/releases/download/${KPT_VERSION}/kpt_${KPT_PLATFORM} && \
    chmod +x /usr/local/bin/kpt

# syntax=docker/dockerfile:1.4
FROM alpine:3.16 as final
RUN apk --no-cache add make curl bash-completion docker yq jq git ncurses zip nano && \
    echo 'source /etc/profile.d/bash_completion.sh' >>~/.bashrc

COPY --from=kubectl /usr/local/bin/kubectl /usr/local/bin
RUN kubectl version --client && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bashrc && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc

COPY --from=helm /usr/local/bin/helm /usr/local/bin
RUN helm version &&\
    echo 'source <(helm completion bash)' >>~/.bashrc


COPY --from=k3d /usr/local/bin/k3d /usr/local/bin
RUN k3d version && \
    echo 'source <(k3d completion bash)' >>~/.bashrc

COPY --from=kind /usr/local/bin/kind /usr/local/bin
RUN kind version &&\
    echo 'source <(kind completion bash)' >>~/.bashrc

COPY --from=tekton /usr/local/bin/tkn /usr/local/bin
RUN chmod +x /usr/local/bin/tkn && \
    tkn version && \
    ln -s /usr/local/bin/tkn /usr/local/bin/kubectl-tkn && \
    kubectl tkn version &&\
    echo 'source <(tkn completion bash)' >>~/.bashrc

COPY --from=krew /tmp/krew /tmp
COPY --from=krew /tmp/kubectx.bash /tmp/kubectx.bash
COPY --from=krew /tmp/kubens.bash /tmp/kubens.bash
RUN /tmp/krew install krew && \
    echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >>~/.bashrc && \
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" && \
    kubectl krew version && \
    echo 'source <(kubectl krew completion bash)' >>~/.bashrc && \
    kubectl krew install ctx && \
    kubectl krew install ns && \
    COMPDIR=$(pkg-config --variable=completionsdir bash-completion) && \
    mv /tmp/kubens.bash $COMPDIR && \
    mv /tmp/kubectx.bash $COMPDIR

COPY --from=other /tmp/.kubectl_aliases $HOME
RUN echo '[ -f $HOME/.kubectl_aliases ] && source ~/.kubectl_aliases' >> ~/.bashrc
# https://sdkman.io/install
RUN curl -s "https://get.sdkman.io" | bash && \
    echo 'source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.bashrc && \
    chmod +x $HOME/.sdkman/bin/sdkman-init.sh && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk version"
COPY --from=kpt /usr/local/bin/kpt /usr/local/bin
RUN kpt version &&\
    echo 'source <(kpt completion bash)' >>~/.bashrc

#RUN addgroup -S appgroup && adduser -S appuser -G appgroup
#USER appuser