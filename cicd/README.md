# CI/CD Module — Task 1 & Task 2

This folder documents the CI/CD pipelines built for the DevOps learning module,
covering Continuous Integration (Task 1) and Continuous Deployment (Task 2).

Repository root: `devops-learning/`
This folder: `devops-learning/cicd/`

**Status: both pipelines passing on GitHub Actions.**

---

## Folder structure

```
cicd/
    task-1/
        calc.py            # small Python app (add function)
        test_calc.py       # pytest unit test for calc.py
        task.yaml           # copy of the CI workflow (documentation copy)
    task-2/
        app.py              # minimal Flask "Hello, World!" app
        Dockerfile          # builds a container image for app.py
        cd.yaml              # copy of the CD workflow (documentation copy)
    any-scripts/
    screenshots/
    README.md               # this file
```

The **live, trigger-able** copies of both workflow files live at repo root in
`devops-learning/.github/workflows/` (`task1.yml` and `cd.yaml`), since GitHub
Actions only picks up workflows from that exact location. The copies inside
`cicd/task-1/` and `cicd/task-2/` exist so the pipelines are documented
alongside the code they test/deploy, per the assignment's folder structure.

---

## Task 1 — Continuous Integration (CI)

**What it does:** runs automatically on every push to the repo. It checks
out the code, sets up Python, installs `pytest`, and runs the unit test
suite against `calc.py`.

**Files:**
- `task-1/calc.py` — a small function, `add(a, b)`, used as a stand-in
  piece of "real" application code for the pipeline to check.
- `task-1/test_calc.py` — a pytest test asserting `add(2, 3) == 5`.
- `task-1/task.yaml` (workflow copy):

```yaml
name: Basic CI pipeline

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: checkout code
        uses: actions/checkout@v2

      - name: install python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: install pip
        run: pip install pytest

      - name: test calc.py
        run: pytest cicd/task-1
```

**What I learnt:**
- The difference between `jobs`, `runs-on`, and `steps`, and how each job
  needs its own name (e.g. `build:`) with `runs-on`/`steps` nested underneath.
- `steps` is a YAML list — every step needs its own `-`, and two keys under
  one `-` describe the *same* step, not two separate ones.
- The difference between `uses:` (a reusable action, e.g. `actions/checkout`)
  and `run:` (a raw shell command).
- Reusable actions can take extra configuration via `with:` — used to pin
  the Python version with `actions/setup-python`.
- Paths inside a workflow are relative to the repo root (where `.git`
  lives), not to wherever the file happens to sit locally — this tripped
  me up when my `pytest` command couldn't find the test files until I
  changed it to the full relative path (`cicd/task-1`).
- Workflow files must live in `.github/workflows/` at the repo root for
  GitHub to trigger them — a file sitting anywhere else (like `cicd/task-1/`)
  is just a plain file as far as GitHub Actions is concerned.

**Issues I solved:**
- Fixed repeated YAML indentation/structure mistakes (jobs not nested
  correctly, `runs-on`/`steps` floating outside a job, duplicate keys under
  one step).
- Fixed `runs:` vs `run:` typo.
- Fixed an incorrect Python function definition (used C-style `{ }` instead
  of Python's colon + indentation).
- Fixed the relative path issue so `pytest` could actually find the test
  files once running from the repo root inside CI.

**Screenshot:** see `screenshots/` — Actions tab showing the CI workflow
completing with a green check.

---

## Task 2 — Continuous Deployment (CD)

**What it does:** builds a Docker image from a small Flask app and pushes
it to Docker Hub automatically on every push.

**Files:**
- `task-2/app.py` — a minimal Flask app with a single route (`/`) that
  returns `"Hello, World!"`. Bound to `host='0.0.0.0'` so it's reachable
  from outside the container, not just from within it. Runs on port 5001
  locally (5000 was taken by macOS's AirPlay Receiver).
- `task-2/Dockerfile`:

```dockerfile
FROM python:3.11-slim
WORKDIR /task-2
COPY app.py .
RUN pip install flask
EXPOSE 5001
CMD ["python3", "app.py"]
```

- `task-2/cd.yaml` (workflow copy):

```yaml
name: CD workflow for task-2

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: checkout code
        uses: actions/checkout@v2

      - name: login to docker
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: build container from docker image
        run: docker build -t dahiradan2004/task2-app cicd/task-2

      - name: push docker build
        run: docker push dahiradan2004/task2-app
```

**What I learnt:**
- The difference between CI (verifying code) and CD (shipping an artifact
  somewhere, e.g. pushing an image to a registry) — CD here stops once the
  image is pushed; it doesn't run the container anywhere.
- Core Docker concepts: image vs. container, `FROM`/`WORKDIR`/`COPY`/`RUN`/
  `EXPOSE`/`CMD`, and the difference between "shell form" and "exec form"
  (`["python3", "app.py"]`) for `CMD`.
- `WORKDIR` is a path *inside the container's own filesystem* — it has no
  relation to folder names on my local machine.
- `EXPOSE` is documentation only; actually publishing a port to the host
  happens via `-p` on `docker run`, not inside the Dockerfile.
- Docker Desktop has to actually be running in the background for the
  `docker` CLI to work at all — the daemon and the CLI are separate things.
- Docker Hub authentication for CI should use a scoped access token, not
  an account password, stored as GitHub repository secrets
  (`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`), referenced in YAML with
  `${{ secrets.NAME }}`.
- `docker build` needs an explicit build context (the folder containing
  the Dockerfile) — a workflow runs from the repo root after checkout, not
  from wherever the Dockerfile happens to sit, so the context has to be
  given as a path (`cicd/task-2`) rather than assumed to be `.`.
- An image pushed by a GitHub Actions runner never appears in local Docker
  Desktop — it's built and pushed on GitHub's own cloud machine. Checking
  Docker Hub itself (or `docker pull`-ing it locally) is how you confirm
  the push actually worked.

**Issues I solved:**
- Fixed several Dockerfile syntax mistakes (`EXPOSE` mistakenly given a
  `-p` flag that belongs to `docker run`, not `EXPOSE`; `COPY` missing a
  destination; `WORKDIR` mistakenly pointed at a filename instead of a
  directory).
- Resolved a local port conflict on 5000 (macOS AirPlay Receiver) by
  switching the app to port 5001.
- Resolved a "cannot connect to Docker daemon" error by starting Docker
  Desktop before running `docker build`.
- Fixed a workflow "startup failure" (0-second failure, no job graph)
  caused by a missing `on:` trigger key — without it, GitHub has no
  condition to evaluate and never starts a job at all.
- Fixed `docker build` failing with "requires 1 argument" by adding the
  missing build context.
- Fixed a follow-up "no such file or directory" build error by pointing
  the build context at `cicd/task-2` instead of the repo root (`.`), since
  the Dockerfile doesn't live at the root the runner starts from.

**Screenshot:** see `screenshots/` — Actions tab showing the CD workflow
completing with a green check, plus a screenshot of `task2-app` visible
under Repositories on Docker Hub.

---

## Screenshots

The `screenshots/` folder holds proof that each pipeline actually ran
successfully on GitHub, not just locally:

- A screenshot of the Actions tab showing the CI workflow (checkout → setup
  Python → install pytest → run tests) completing with a green check.
- A screenshot of the Actions tab showing the CD workflow (checkout →
  Docker Hub login → build → push) completing with a green check.
- A screenshot of the `task2-app` repository visible under Repositories on
  Docker Hub, confirming the pushed image actually landed.

---

## Resolved issue: large file blocking git push

A large Terraform provider binary (776MB, from an earlier module) had been
committed to this repo's history, which blocked every `git push` (GitHub's
100MB file size limit). Resolved by:

1. Adding a `.gitignore` (`.terraform/`, `*.tfstate`, `*.tfstate.backup`) to
   stop it from being re-added going forward.
2. Backing up the repo, then using `git filter-repo` to strip the
   `.terraform/` directories out of every commit in history (not just the
   latest one) — since the binary was safe to remove from history entirely
   as it's fully regenerable via `terraform init`.
3. Re-adding the `origin` remote and resetting the upstream tracking branch,
   both of which `git filter-repo` clears as a safety measure.
4. Force-pushing the rewritten history, since commit hashes change whenever
   history is rewritten.