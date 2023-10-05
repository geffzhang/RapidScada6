# RapidScada6

RapidScada6 docker 容器附带的 systemd 大部分功能。您可以使用 [Dockerfile](./dockerfile) 构建启用 RapidScada6 systemd 的容器。

为了使用 systemd 运行容器，您需要从主机挂载 cgroups 卷。 

[Multiple OSs Docker containers (systemd included)](https://github.com/aminvakil/docker-os-systemd)

由于 Rapidskada 使用“systemd”，因此您需要使用 Podman （https://podman.io/） 而不是 Docker 来运行容器。Podman 的语法与 Docker 的语法相同，因此应该不会有任何复杂性。） 

构建容器 & 推送到dockerhub 
```
podman build -f dockerfile -t rapidscada:1.8 .
podman push docker.io/geffzhang/rapidscada_6:1.8

```
要启动容器，请输入命令： 
```
podman run –name rapidscada -p 10000:10000 -p 10002:10002 -p 10008:10008 docker.io/geffzhang/rapidscada_6:1.8
podman exec -it rapidscada bash
```
 
默认情况下，Podman 需要输入要下载的容器的完整地址，例如：podman run quay.io/aminvakil/ubuntu22.04-systemd，或者在我们的例子中，podman run docker.io/geffzhang/rapidscada_6:1.8。
为了使 docker 不输入其完整地址并能够执行命令：podman login，您需要通过创建文件来更改文件：$HOME/.config/containers/registries.conf，内容为：
unqualified-search-recistries = [“docker.io”]