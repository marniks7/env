ARG KUBECTL_VERSION=v1.24.0
ARG KUBECTL_PLATFORM=linux/amd64
ARG HELM_VERSION=v3.9.0
ARG HELM_PLATFORM=linux-amd64
ARG K3D_VERSION=v5.4.3
ARG K3D_PLATFORM=linux-amd64
ARG TEKTON_CLI_VERSION=0.24.0
ARG TEKTON_CLI_PLATFORM=Linux_x86_64
ARG KREW_VERSION=v0.4.3
ARG KREW_PLATFORM=linux_amd64
FROM alpine:3.16
ARG KUBECTL_VERSION
ARG KUBECTL_PLATFORM
ARG HELM_VERSION
ARG HELM_PLATFORM
ARG K3D_VERSION
ARG K3D_PLATFORM
ARG TEKTON_CLI_VERSION
ARG TEKTON_CLI_PLATFORM
ARG KREW_VERSION
ARG KREW_PLATFORM
# tput is required for `krew` and plugins (ncurses contains it)
# zip is required for sdkman bash file
RUN apk --no-cache add make curl bash-completion make docker yq jq git ncurses zip nano &&\
    echo 'source /etc/profile.d/bash_completion.sh' >>~/.bashrc
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
RUN wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${KUBECTL_PLATFORM}/kubectl && \
    wget -O /tmp/kubectl.sha256 "https://dl.k8s.io/${KUBECTL_VERSION}/bin/${KUBECTL_PLATFORM}/kubectl.sha256" && \
    echo "$(cat /tmp/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - && \
    rm -rf /tmp/kubectl.sha256 && \
    chmod +x /usr/local/bin/kubectl && \
    kubectl version --client --output=yaml && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bashrc && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
# https://helm.sh/docs/intro/install/
RUN wget -O /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-${HELM_PLATFORM}.tar.gz && \
    wget -O /tmp/helm.sha256 https://get.helm.sh/helm-${HELM_VERSION}-${HELM_PLATFORM}.tar.gz.sha256sum && \
    echo "$(cat /tmp/helm.sha256 | awk '{ print $1 }')  /tmp/helm.tar.gz" | sha256sum -c - && \
    tar -zxvf /tmp/helm.tar.gz --directory /tmp && \
    mv /tmp/${HELM_PLATFORM}/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    helm version && \
    echo 'source <(helm completion bash)' >>~/.bashrc
# https://k3d.io/v5.4.3/#installation
RUN wget -O /usr/local/bin/k3d https://github.com/k3d-io/k3d/releases/download/${K3D_VERSION}/k3d-${K3D_PLATFORM} && \
    chmod +x /usr/local/bin/k3d && \
    k3d version && \
    echo 'source <(k3d completion bash)' >>~/.bashrc
# https://tekton.dev/docs/cli/
RUN wget -O /tmp/tkn.tar.gz https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/tkn_${TEKTON_CLI_VERSION}_${TEKTON_CLI_PLATFORM}.tar.gz &&\
    wget -O /tmp/checksums.txt https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/checksums.txt && \
    echo "$(cat /tmp/checksums.txt | grep "tkn_${TEKTON_CLI_VERSION}_${TEKTON_CLI_PLATFORM}.tar.gz" | awk '{ print $1 }')  /tmp/tkn.tar.gz" | sha256sum -c - && \
    tar -zxvf /tmp/tkn.tar.gz --directory /tmp  && \
    mv /tmp/tkn /usr/local/bin/tkn && \
    chmod +x /usr/local/bin/tkn && \
    tkn version && \
    ln -s /usr/local/bin/tkn /usr/local/bin/kubectl-tkn && \
    kubectl tkn version
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
RUN wget -O /tmp/krew.tar.gz https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VERSION}/krew-${KREW_PLATFORM}.tar.gz && \
    wget -O /tmp/krew.sha256 https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VERSION}/krew-${KREW_PLATFORM}.tar.gz.sha256 && \
    echo "$(cat /tmp/krew.sha256 | awk '{ print $1 }')  /tmp/krew.tar.gz" | sha256sum -c - && \
    tar -zxvf /tmp/krew.tar.gz --directory /tmp && \
    chmod +x /tmp/krew-${KREW_PLATFORM} && \
    /tmp/krew-${KREW_PLATFORM} install krew && \
    echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >>~/.bashrc && \
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" && \
    kubectl krew version && \
    echo 'source <(kubectl krew completion bash)' >>~/.bashrc && \
    kubectl krew install ctx && \
    kubectl krew install ns
# https://sdkman.io/install
RUN curl -s "https://get.sdkman.io" | bash && \
    echo 'source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.bashrc && \
    chmod +x $HOME/.sdkman/bin/sdkman-init.sh && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk version"
# https://github.com/ahmetb/kubectl-aliases
RUN wget -O $HOME/.kubectl_aliases https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases && \
    echo '[ -f $HOME/.kubectl_aliases ] && source ~/.kubectl_aliases' >> ~/.bashrc
    #echo 'function kubectl() { echo "+ kubectl $@">&2; command kubectl "$@"; }' >> ~/.bashrc
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser