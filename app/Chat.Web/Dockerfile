
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /src

COPY *.csproj ./
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /src/out .
ENTRYPOINT ["dotnet", "Chat.Web.dll"]