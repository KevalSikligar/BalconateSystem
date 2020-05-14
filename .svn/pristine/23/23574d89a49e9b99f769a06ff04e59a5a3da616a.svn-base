using System;
using System.Diagnostics;
using Balcony.Miracle.Core;
using log4net;
using NHibernate;
using NHibernate.Context;
using Quartz;

namespace Balcony.Miracle.Server.Jobs
{
    public abstract class JobBase: IJob 
    {
        protected ISession session;
        protected ILog logger;

        protected abstract void Execute(IJobExecutionContext context);

        protected abstract string Name { get; }

        public abstract ITrigger GetTrigger();

        #region Implementation of IJob

        void IJob.Execute(IJobExecutionContext context)
        {
            var sw = Stopwatch.StartNew();
            try
            {
                this.logger = logger = LogManager.GetLogger("root");

                this.logger.InfoFormat("Starting job '{0}' ({1})", Name, GetType().Name);

                this.session = Global.SessionFactory.OpenSession();
                CurrentSessionContext.Bind(this.session);

                Execute(context);

                CurrentSessionContext.Unbind(Global.SessionFactory);
                this.session.Dispose();
            }
            catch (Exception ex)
            {
                this.logger.Error($"Error executing job '{Name}' ({GetType().Name}", ex);
            }
            finally
            {
                sw.Stop();
                this.logger.InfoFormat("Finished job '{0}' ({1}) took {2}", Name, GetType().Name, TimeSpan.FromMilliseconds(sw.ElapsedMilliseconds));
            }
        }

        #endregion
    }
}
