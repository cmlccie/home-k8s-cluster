# Home Kubernetes Cluster Build

## Install `containerd` using `apt`

> "The containerd.io packages in DEB and RPM formats are distributed by Docker (not by the containerd project). See the [Docker documentation](https://docs.docker.com/engine/install/debian/) for how to set up apt-get or dnf to install containerd.io packages." [Containerd Docs](https://github.com/containerd/containerd/blob/main/docs/getting-started.md#option-2-from-apt-get-or-dnf)

### Setup the repository

[Source Docs](https://docs.docker.com/engine/install/debian/#set-up-the-repository)

I am using `apt` instead of `apt-get` - docs adapted.

1. Update the `apt` package index and install packages to allow `apt` to use a repository over HTTPS:

    ```shell
    sudo apt update
    sudo apt install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    ```

    <details>
    <summary>Output</summary>

    ```shell
    pi@rpi-70-4b:~ $ sudo apt update
    Get:1 http://security.debian.org/debian-security bullseye-security InRelease [48.4 kB]
    Hit:2 http://deb.debian.org/debian bullseye InRelease
    Hit:3 http://deb.debian.org/debian bullseye-updates InRelease
    Hit:4 http://archive.raspberrypi.org/debian bullseye InRelease
    Get:5 http://security.debian.org/debian-security bullseye-security/main armhf Packages [185 kB]
    Get:6 http://security.debian.org/debian-security bullseye-security/main arm64 Packages [184 kB]
    Get:7 http://security.debian.org/debian-security bullseye-security/main Translation-en [117 kB]
    Fetched 535 kB in 1s (427 kB/s)
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    All packages are up to date.
    pi@rpi-70-4b:~ $ sudo apt install ca-certificates curl gnupg lsb-release
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    ca-certificates is already the newest version (20210119).
    curl is already the newest version (7.74.0-1.3+deb11u3).
    gnupg is already the newest version (2.2.27-2+deb11u2).
    gnupg set to manually installed.
    lsb-release is already the newest version (11.1.0).
    lsb-release set to manually installed.
    0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
    ```

    </details>

    The needed system packages were already installed.

2. Add Docker's official GPG key:

    ```shell
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    ```

    <details>
    <summary>Output</summary>

    ```shell
    pi@rpi-70-4b:~ $ sudo mkdir -p /etc/apt/keyrings
    pi@rpi-70-4b:~ $ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    ```

    </details>

3. Use the following command to set up the repository:

    ```shell
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

    <details>
    <summary>Output</summary>

    ```shell
    pi@rpi-70-4b:~ $ echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

    </details>

### Install `containerd.io` package

[Source Docs](https://docs.docker.com/engine/install/debian/#install-docker-engine)

I am using `apt` instead of `apt-get` and I am only installing the `containerd.io` package - docs adapted.

The `containerd.io` package contains `runc` too, but does not contain CNI plugins.

1. Update the `apt` package index, and install the *latest version* of `containerd`.

    ```shell
    sudo apt update
    sudp apt install containerd.io
    ```

    <details>
    <summary>Output</summary>

    ```shell
    pi@rpi-70-4b:~ $ sudo apt update
    Hit:1 http://security.debian.org/debian-security bullseye-security InRelease
    Hit:2 http://deb.debian.org/debian bullseye InRelease
    Get:3 https://download.docker.com/linux/debian bullseye InRelease [43.3 kB]
    Hit:4 http://deb.debian.org/debian bullseye-updates InRelease
    Hit:5 http://archive.raspberrypi.org/debian bullseye InRelease
    Get:6 https://download.docker.com/linux/debian bullseye/stable arm64 Packages [11.7 kB]
    Fetched 55.1 kB in 1s (40.9 kB/s)
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    All packages are up to date.
    pi@rpi-70-4b:~ $ sudo apt install containerd.io
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    The following NEW packages will be installed:
    containerd.io
    0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    Need to get 20.9 MB of archives.
    After this operation, 107 MB of additional disk space will be used.
    Get:1 https://download.docker.com/linux/debian bullseye/stable arm64 containerd.io arm64 1.6.8-1 [20.9 MB]
    Fetched 20.9 MB in 1s (15.4 MB/s)
    Selecting previously unselected package containerd.io.
    (Reading database ... 37391 files and directories currently installed.)
    Preparing to unpack .../containerd.io_1.6.8-1_arm64.deb ...
    Unpacking containerd.io (1.6.8-1) ...
    Setting up containerd.io (1.6.8-1) ...
    Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
    Processing triggers for man-db (2.9.4-2) ...
    ```

    </details>

2. Verify `containerd.service` is running.

    ```shell
    sudo systemctl status containerd.service
    ```

    <details>
    <summary>Output</summary>

    ```shell
    pi@rpi-70-4b:~ $ sudo systemctl status containerd.service
    ● containerd.service - containerd container runtime
        Loaded: loaded (/lib/systemd/system/containerd.service; enabled; vendor preset: enabled)
        Active: active (running) since Wed 2022-09-28 09:55:32 EDT; 3min 0s ago
        Docs: https://containerd.io
        Process: 4198 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
    Main PID: 4201 (containerd)
        Tasks: 10
            CPU: 319ms
        CGroup: /system.slice/containerd.service
                └─4201 /usr/bin/containerd

    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.681271910-04:00" level=info msg="loading plugin \"io.containerd.grpc.v1.tasks\"..." type=io.containerd.grpc.v1
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.681322983-04:00" level=info msg="loading plugin \"io.containerd.grpc.v1.version\"..." type=io.containerd.grpc.v1
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.681428648-04:00" level=info msg="loading plugin \"io.containerd.tracing.processor.v1.otlp\"..." type=io.containerd.tracing.pro>
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.681506758-04:00" level=info msg="skip loading plugin \"io.containerd.tracing.processor.v1.otlp\"..." error="no OpenTelemetry e>
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.681558738-04:00" level=info msg="loading plugin \"io.containerd.internal.v1.tracing\"..." type=io.containerd.internal.v1
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.681621829-04:00" level=error msg="failed to initialize a tracing processor \"otlp\"" error="no OpenTelemetry endpoint: skip pl>
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.682532608-04:00" level=info msg=serving... address=/run/containerd/containerd.sock.ttrpc
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.682844066-04:00" level=info msg=serving... address=/run/containerd/containerd.sock
    Sep 28 09:55:32 rpi-70-4b systemd[1]: Started containerd container runtime.
    Sep 28 09:55:32 rpi-70-4b containerd[4201]: time="2022-09-28T09:55:32.685461053-04:00" level=info msg="containerd successfully booted in 0.102584s"
    ```

    </details>
