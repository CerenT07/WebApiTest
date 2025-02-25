# Hata ayıklama kapsayıcınızı özelleştirme ve Visual Studio’nun daha hızlı hata ayıklama için görüntülerinizi derlemek üzere bu Dockerfile'ı nasıl kullandığı hakkında bilgi edinmek için https://aka.ms/customizecontainer sayfasına bakın.

# Bu aşama, VS'den hızlı modda çalıştırıldığında kullanılır (Hata ayıklama yapılandırması için varsayılan olarak ayarlıdır)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081


# Bu aşama, hizmet projesini oluşturmak için kullanılır
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Proje dosyasını doğrudan kök dizinden kopyalıyoruz
COPY ["WepApi.csproj", "./"]  # WepApi.csproj dosyasını doğrudan kök dizinden kopyala
RUN dotnet restore "WepApi.csproj"

# Diğer dosyaları kopyalıyoruz
COPY . .

WORKDIR "/src"
RUN dotnet build "WepApi.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Bu aşama, son aşamaya kopyalanacak hizmet projesini yayımlamak için kullanılır
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "WepApi.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Bu aşama üretimde veya VS'den normal modda çalıştırıldığında kullanılır (Hata Ayıklama yapılandırması kullanılmazken varsayılan olarak ayarlıdır)
FROM base AS final
WORKDIR /app

# Publish edilmiş dosyayı alıyoruz
COPY --from=publish /app/publish .

# Uygulamayı çalıştırıyoruz
ENTRYPOINT ["dotnet", "WepApi.dll"]
