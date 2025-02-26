using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Extensions.Logging;
using WepApi.Controllers;  // WeatherForecastController'ı ve WeatherForecast'ı bulabilmek için bu using eklenmeli
using System.Linq;
using WepApi;

namespace WebApiTest
{
    [TestClass]
    public class WeatherForecastControllerTest
    {
        private WeatherForecastController _controller;

        [TestInitialize]
        public void TestInitialize()
        {
            // Geçici olarak Logger ekliyoruz. ILogger'ın null geçilememesi uyarısını engellemek için.
            var logger = new LoggerFactory().CreateLogger<WeatherForecastController>();

            // Controller'ı logger ile başlatıyoruz
            _controller = new WeatherForecastController(logger);
        }

        [TestMethod]
        public void Get_Returns_WeatherForecast()
        {
            // Act
            var result = _controller.Get();

            // Assert
            Assert.IsNotNull(result);  // Sonucun null olmaması gerektiğini kontrol ederiz.
            Assert.AreEqual(5, result.Count());  // Sonucun 5 öğe içermesi gerektiğini kontrol ederiz.
            
            foreach (var weather in result)
            {
                // Hava durumu tipinin doğru olup olmadığını kontrol ederiz.
                Assert.IsInstanceOfType(weather, typeof(WeatherForecast));  
                
                // Sıcaklık değerinin geçerli bir aralıkta olup olmadığını kontrol ederiz.
                Assert.IsTrue(weather.TemperatureC >= -20 && weather.TemperatureC <= 55); 

                // Summary'nin null olmaması gerektiğini kontrol ederiz.
                Assert.IsNotNull(weather.Summary);  
            }
        }
    }
}
