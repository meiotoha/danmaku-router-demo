#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine AS base
WORKDIR /app
EXPOSE 80/tcp
EXPOSE 80/udp

FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS build
WORKDIR /src
COPY ["DanmakuHub.csproj", ""]
RUN dotnet restore "./DanmakuHub.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DanmakuHub.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DanmakuHub.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DanmakuHub.dll"]