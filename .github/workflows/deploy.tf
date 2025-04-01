name: Deploy Homelab Infrastructure

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup OpenTofu
        uses: opentofu/setup-opentofu@v1
        with:
          tofu_version: 1.6.0
      
      - name: Set up Kubernetes config
        run: |
          # Setup your kubeconfig here
          mkdir -p $HOME/.kube
          echo "${{ secrets.KUBE_CONFIG }}" > $HOME/.kube/config
          chmod 600 $HOME/.kube/config

      - name: Initialize OpenTofu
        run: tofu init
        working-directory: environments/dev  # Adjust to your environment directory

      - name: Plan OpenTofu changes
        run: |
          tofu plan \
            -var="authelia_username=${{ secrets.AUTHELIA_USERNAME }}" \
            -var="authelia_password_hash=${{ secrets.AUTHELIA_PASSWORD_HASH }}" \
            -var="authelia_displayname=${{ secrets.AUTHELIA_DISPLAYNAME }}" \
            -var="authelia_email=${{ secrets.AUTHELIA_EMAIL }}" \
            -var="authelia_group=${{ secrets.AUTHELIA_GROUP }}"
        working-directory: environments/dev  # Adjust to your environment directory

      - name: Apply OpenTofu changes
        if: github.ref == 'refs/heads/main'
        run: |
          tofu apply -auto-approve \
            -var="authelia_username=${{ secrets.AUTHELIA_USERNAME }}" \
            -var="authelia_password_hash=${{ secrets.AUTHELIA_PASSWORD_HASH }}" \
            -var="authelia_displayname=${{ secrets.AUTHELIA_DISPLAYNAME }}" \
            -var="authelia_email=${{ secrets.AUTHELIA_EMAIL }}" \
            -var="authelia_group=${{ secrets.AUTHELIA_GROUP }}"
        working-directory: environments/dev  # Adjust to your environment directory