# A Dockerfile for Agentic conversion of TL-Verilog to Verilog using Claude Code.
#
# Includes:
# - Claude Code IDE
# - SandPiper SaaS (TL-Verilog compiler)
# - Verilator (SystemVerilog simulator)
# - OSS CAD Suite (Yosys, nextpnr, icestorm, trellis, etc.)
#
# This is used via Docker Compose with possible project-specific customization.

FROM node:20-bookworm-slim

# Security: Use specific user ID and avoid conflicts
ARG USER_ID=1001
ARG USER_NAME=claude

# Create non-root user with specific UID/GID
RUN groupadd -g ${USER_ID} ${USER_NAME} && \
    useradd -m -u ${USER_ID} -g ${USER_ID} -s /bin/bash ${USER_NAME}

COPY install_verilator /install_verilator

# Install system dependencies with security hardening
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget ca-certificates python3 python3-pip build-essential \
    # Security packages
    dumb-init \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    # Remove unnecessary setuid binaries
    && find / -xdev -perm -4000 -type f -exec chmod u-s {} \; 2>/dev/null || true \
    && find / -xdev -perm -2000 -type f -exec chmod g-s {} \; 2>/dev/null || true \
    # Remove network tools that could be used for reconnaissance (but keep essential shells)
    && rm -f /usr/bin/nc /usr/bin/netcat /bin/netstat /usr/bin/ss || true

RUN apt-get update && apt-get install -y jq time

# Install basic Python tools
RUN pip3 install --no-cache-dir --break-system-packages \
    requests \
    python-dotenv

# Install Python security tools
RUN pip3 install --no-cache-dir --break-system-packages \
    semgrep \
    solc-select

# Setup solc-select with a default Solidity compiler
RUN solc-select install 0.8.20 && solc-select use 0.8.20

# Install Node.js tools
RUN npm install -g --no-optional \
    typescript \
    ts-node \
    prettier \
    eslint \
    solhint

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

################ Configure MCP Providers  --->

# Copy pre-built MCP server into container (from mcp/chonky)
#COPY --chown=${USER_NAME}:${USER_NAME} mcp/chonky /workspace/mcp-servers/chonky-mcp-server

# Install MCP server runtime dependencies only (using package-lock.json for exact versions)
#RUN cd /workspace/mcp-servers/chonky-mcp-server && npm ci --production

# Don't forget to configure the MCP in claude-config.json

################# <--- Configure MCP Providers 

# Setup secure workspace with proper permissions
#    && mkdir -p /workspace/data \
#    && mkdir -p /workspace/temp \
#    && mkdir -p /workspace/mcp-servers \
#    && chmod 750 /workspace/data \
#    && chmod 755 /workspace/temp \
#    && chmod 755 /workspace/mcp-servers
RUN mkdir -p /workspace/proj \
    && chown -R ${USER_NAME}:${USER_NAME} /workspace \
    && chmod 755 /workspace \
    && chmod 755 /workspace/proj


# Copy the working Claude config
COPY --chown=${USER_NAME}:${USER_NAME} claude-config.json /tmp/claude-config.json
COPY --chown=${USER_NAME}:${USER_NAME} settings.local.json /tmp/settings.local.json

# Setup Claude configuration (as root, will switch to claude user)
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Setting up Claude configuration..."\n\
\n\
# Switch to claude user for configuration\n\
su - claude << "EOF_CLAUDE_USER"\n\
set -e\n\
cd /workspace\n\
\n\
# Copy the pre-configured Claude config\n\
cp /tmp/claude-config.json ~/.claude.json\n\
\n\
# Create .claude directory and copy settings.local.json\n\
mkdir -p ~/.claude\n\
cp /tmp/settings.local.json ~/.claude/settings.local.json\n\
mkdir -p /workspace/.claude\n\
cp /tmp/settings.local.json /workspace/.claude/settings.local.json\n\
\n\
echo "Claude configuration complete"\n\
ls -la ~/.claude.json\n\
ls -la ~/.claude/settings.local.json\n\
ls -la /workspace/.claude/settings.local.json\n\
\n\
EOF_CLAUDE_USER\n\
\n\
' > /usr/local/bin/configure-claude.sh \
    && chmod +x /usr/local/bin/configure-claude.sh \
    && /usr/local/bin/configure-claude.sh

# Install SandPiper SaaS and Verilator
RUN pip3 install --no-cache-dir --break-system-packages sandpiper-saas \
    && bash /install_verilator

# Install OSS CAD Suite (includes Yosys, nextpnr, icestorm, trellis, etc.)
RUN cd /tmp \
    && wget -q https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-10-29/oss-cad-suite-linux-x64-20251029.tgz \
    && tar -xzf oss-cad-suite-linux-x64-20251029.tgz \
    && mv oss-cad-suite /opt/ \
    && rm oss-cad-suite-linux-x64-20251029.tgz \
    && chown -R root:root /opt/oss-cad-suite \
    && chmod -R 755 /opt/oss-cad-suite

# Switch to non-root user for security
USER ${USER_NAME}
WORKDIR /workspace
ENV PATH="/opt/oss-cad-suite/bin:$PATH"

# Create simple startup script for runtime
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Starting Claude Code..."\n\
# Use environment variable for API key\n\
# Run Claude Code with dangerous skip permissions for jailfree mode\n\
exec claude --dangerously-skip-permissions "$@"\n\
' > /home/${USER_NAME}/start-claude.sh \
    && chmod +x /home/${USER_NAME}/start-claude.sh

# Security: Set secure environment variables and limits
ENV DEBIAN_FRONTEND=noninteractive \
    NODE_ENV=production \
    NPM_CONFIG_AUDIT=false \
    NPM_CONFIG_FUND=false \
    # Prevent core dumps
    RLIMIT_CORE=0 \
    # Limit file descriptors
    RLIMIT_NOFILE=1024 \
    # Prevent ptrace (debugging other processes)
    YAMA_PTRACE_SCOPE=1

# Add security labels
LABEL security.non-root=true \
      security.hardened=true \
      security.version="1.0"

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD test -f ~/.claude/settings.json || exit 1

# Security: Use dumb-init for proper signal handling and process reaping
CMD ["dumb-init", "--", "/home/claude/start-claude.sh"]
RUN touch /home/claude/.makerchip_accepted
USER root
RUN touch /root/.makerchip_accepted
USER claude
