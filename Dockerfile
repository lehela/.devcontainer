FROM python:3.11

# Install tools and oh-my-zsh
RUN apt update && apt install -y \
    vim git htop zsh tldr man && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    chsh -s $(which zsh) && \
    echo /bin/zsh >> ~/.bashrc

# Copy Docker client binary
COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

# Install python packages
COPY resources/requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Install PowerLevel10k
RUN apt install -y iproute2 sudo less && \
    bash -c "$(curl -LSs https://github.com/dfmgr/installer/raw/main/install.sh)" && \
    bash -c "$(curl -LSs https://github.com/fontmgr/MesloLGSNF/raw/main/install.sh)" && \
    fontmgr install MesloLGSNF

WORKDIR /root
RUN git clone https://github.com/romkatv/powerlevel10k.git

COPY resources/.zshrc .zshrc
COPY resources/.p10k.zsh .p10k.zsh

# Install zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 

# Install glow to render markdown on CLI
RUN sudo mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
    sudo apt update && sudo apt install glow

# Set timezone
RUN ln -sf /usr/share/zoneinfo/CET /etc/localtime