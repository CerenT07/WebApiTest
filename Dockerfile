# .NET SDK imajını kullanıyoruz
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Çalışma dizini olarak /app ayarlıyoruz
WORKDIR /app

# Proje dosyasını kopyalıyoruz
COPY ["WebApiProject/WepApi.csproj", "WebApiProject/"]  # Proje dosyasını WebApiProject klasörüne kopyalıyoruz

# Bağımlılıkları yükliyoruz
RUN dotnet restore "WebApiProject/WepApi.csproj"

# Diğer dosyaları kopyalıyoruz
COPY . .

# Projeyi build ediyoruz
RUN dotnet build "WebApiProject/WepApi.csproj" --configuration Release

# Çalıştırma için kullanılacak ASP.NET runtime imajını kullanıyoruz
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

# Çalışma dizini olarak /app ayarlıyoruz
WORKDIR /app

# Yine proje dosyasını kopyalıyoruz
COPY --from=build /app/WebApiProject/bin/Release/net8.0/publish/ .  # Yayınlanan dosyaları kopyalıyoruz

# Konteyneri çalıştırırken hangi portu kullanacağımızı belirliyoruz
EXPOSE 80

# Uygulamayı başlatıyoruz
ENTRYPOINT ["dotnet", "WepApi.dll"]
