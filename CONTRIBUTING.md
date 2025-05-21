# Updating versions

Currently, the changelog is managed manually. If you update this tool, you must manually update the changelog with a new version number, and update the `PSIBASE_CONTRIBUTOR_VERSION` environment variable in `.devcontainer/docker-compose.yml`.

# Tag management

To allow people to easily switch between versions, when a PR is merged that contains a new version number, a new tag with the corresponding version number should be pushed. 

For example, these commands were used on `main` to create the `v0.6.0-pre` tag:

```bash
git tag -a v0.6.0-pre -m "psibase-contributor prerelease version v0.6.0"
git push origin v0.6.0-pre
```
