# Docker Setup for Hexo Blog

This setup allows you to run and deploy your Hexo blog using Docker.
The configuration includes volume mounts for your blog source files and SSH directory for deployment.

## Prerequisites

1. Docker and Docker Compose installed on your system
1. Your Hexo blog source at `/home/$USER/hexo/blog-source`
1. SSH keys configured in `/home/$USER/.ssh` for GitHub deployment

## Directory tree structure

A sample tree structure is shown below:

```text
/home
└── $USER
    └── hexo
        ├── docker-hexo
        └── blog-source-dir
```

## Configuration

1. Download scripts.

    ```bash
    cd ~/hexo
    git clone https://github.com/hiroaki-ma1203/docker-hexo.git
    ```

1. Update the variables in `docker-compose.yml`:

    ```yaml
    volumes:
        - ../<blog-source-dir>:/blog
    environment:
        - GIT_EMAIL=<your-email@example.com>
        - GIT_USERNAME=<your-username>
    ```

1. Make sure your blog's `_config.yml` has the correct deployment settings:

    ```yaml
    deploy:
        type: git
        repo: git@github.com:<github-username>/<github-repository-name>.github.io.git
        branch: main
    ```

## Usage

### First Time Setup

1. Build the Docker image:

    ```bash
    cd docker
    docker compose -f docker-hexo/docker-compose.yml build
    ```

1. Add alias

    ```bash
    alias hexo='docker compose -f docker-hexo/docker-compose.yml run --rm hexo hexo'
    ```

    - If you want to alias permanent

        ```bash
        echo '' >> ~/.bashrc
        echo 'alias hexo="docker compose -f docker-hexo/docker-compose.yml run --rm hexo hexo"'
        source ~/.bashrc
        ```

1. Install dependencies:

    ```bash
    hexo npm install
    ```

### Development

To start the Hexo development server:

```bash
docker compose -f docker-hexo/docker-compose.yml up
```

The blog will be available at <http://localhost:4000>

### Deployment

1. Generate static files:

    ```bash
    hexo generate
    ```

    If you did not set alies

    ```bash
    docker compose run --rm hexo hexo generate
    ```

1. Deploy to GitHub Pages:

    ```bash
    hexo deploy
    ```

1. Or combine generate and deploy:

    ```bash
    docker compose run --rm hexo hexo generate --deploy
    ```

### Add new draft or post

1. Add new Post

    ```bash
    hexo new "title"
    ```

1. Add new draft

    ```bash
    hexo new draft "title"
    ```

1. Publish draft

    ```bash
    hexo publish draft "title"
    ```

## Troubleshooting

1. SSH key issues:
    - Ensure SSH keys have correct permissions (700 for .ssh directory, 600 for key files)
    - Verify SSH keys are properly configured for GitHub

2. Volume mount issues:
    - Check that the paths in docker-compose.yml match your actual paths
    - Ensure the user has proper permissions for the mounted directories

3. Node.js dependencies:
    - If you encounter missing dependencies, run:

        ```bash
        docker compose -f docker-hexo/docker-compose.yml run --rm hexo npm install
        ```
