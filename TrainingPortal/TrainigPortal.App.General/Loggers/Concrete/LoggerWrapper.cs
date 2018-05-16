using log4net;
using log4net.Config;
using log4net.Repository.Hierarchy;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrainigPortal.App.General.Loggers.Abstract;

namespace TrainigPortal.App.General.Loggers
{
    public class LoggerWrapper : ILoggerWrapper
    {
        private static LoggerWrapper _loggerWrapper;
        private static object _lockObject = new object();
        private ILog _logger;
        private const string LOGGER_CONFIG = "logger.config";
        private const string LOGGER_NAME = "LOGGER";
        private LoggerWrapper()
        {
            _logger = LogManager.GetLogger(LOGGER_NAME);
            InitLogger();
        }

        public static LoggerWrapper GetInstance()
        {
            lock (_lockObject)
            {
                if (_loggerWrapper == null)
                {
                    _loggerWrapper = new LoggerWrapper();
                }
            }
            return _loggerWrapper;
        }

        private void InitLogger()
        {
            var appConfigPath = Path.Combine(AppDomain.CurrentDomain.SetupInformation.PrivateBinPath, LOGGER_CONFIG);
            var configFile = new FileInfo(appConfigPath);
            XmlConfigurator.ConfigureAndWatch(configFile);
        }

        public void DebugFormat(string message, params object[] values)
        {
            _logger.DebugFormat(message, values);
        }

        public void ErrorFormat(string message, params object[] values)
        {
            _logger.ErrorFormat(message, values);
        }

        public void FatalFormat(string message, params object[] values)
        {
            _logger.FatalFormat(message, values);
        }

        public void InfoFormat(string message, params object[] values)
        {
            _logger.InfoFormat(message, values);
        }

        public void WarnFormat(string message, params object[] values)
        {
            _logger.WarnFormat(message, values);
        }
    }
}

