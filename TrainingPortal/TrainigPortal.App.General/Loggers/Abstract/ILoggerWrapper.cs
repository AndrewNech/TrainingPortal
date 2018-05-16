using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainigPortal.App.General.Loggers.Abstract
{
   public interface ILoggerWrapper
    {
        void DebugFormat(string message, params object[] values);

        void InfoFormat(string message, params object[] values);

        void WarnFormat(string message, params object[] values);

        void ErrorFormat(string message, params object[] values);

        void FatalFormat(string message, params object[] values);
    }
}

