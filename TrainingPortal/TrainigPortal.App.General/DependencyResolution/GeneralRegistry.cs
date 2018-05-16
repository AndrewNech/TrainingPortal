using log4net;
using StructureMap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrainigPortal.App.General.Loggers;
using TrainigPortal.App.General.Loggers.Abstract;

namespace TrainigPortal.App.General.DependencyResolution
{
    public class GeneralRegistry : Registry
    {
        public GeneralRegistry()
        {
            Scan(scan =>
            {
                scan.TheCallingAssembly();
                scan.WithDefaultConventions();
            });
            For<ILoggerWrapper>().Use(LoggerWrapper.GetInstance());
        }
    }
}
