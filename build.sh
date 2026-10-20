# 构建前端镜像，注入后端 API 地址（NEXT_PUBLIC_ 前缀变量会在构建时内联进客户端代码）
# 服务器部署请使用公网地址；本地开发请改为 http://localhost:8091
docker build -t zhaoyushi00/xfg:02-bigmarket-front --build-arg NEXT_PUBLIC_API_HOST_URL=http://47.114.39.182:8091 .
