using System;
using System.Data;

using CMS.Base;
using CMS.DataEngine;
using CMS.Helpers;

namespace Manatt_Menu
{    
    /// <summary>
    /// Class providing ServicesInfo management.
    /// </summary>
    public class ServicesInfoProvider : AbstractInfoProvider<ServicesInfo, ServicesInfoProvider>
    {
        #region "Constructors"

        /// <summary>
        /// Constructor
        /// </summary>
        public ServicesInfoProvider()
            : base(ServicesInfo.TYPEINFO)
        {
        }

        #endregion


        #region "Public methods - Basic"

        /// <summary>
        /// Returns a query for all the ServicesInfo objects.
        /// </summary>
        public static ObjectQuery<ServicesInfo> GetServices()
        {
            return ProviderObject.GetServicesInternal();
        }


        /// <summary>
        /// Returns ServicesInfo with specified ID.
        /// </summary>
        /// <param name="id">ServicesInfo ID</param>
        public static ServicesInfo GetServicesInfo(int id)
        {
            return ProviderObject.GetServicesInfoInternal(id);
        }


        /// <summary>
        /// Returns ServicesInfo with specified GUID.
        /// </summary>
        /// <param name="guid">ServicesInfo GUID</param>                
        public static ServicesInfo GetServicesInfo(Guid guid)
        {
            return ProviderObject.GetServicesInfoInternal(guid);
        }


        /// <summary>
        /// Sets (updates or inserts) specified ServicesInfo.
        /// </summary>
        /// <param name="infoObj">ServicesInfo to be set</param>
        public static void SetServicesInfo(ServicesInfo infoObj)
        {
            ProviderObject.SetServicesInfoInternal(infoObj);
        }


        /// <summary>
        /// Deletes specified ServicesInfo.
        /// </summary>
        /// <param name="infoObj">ServicesInfo to be deleted</param>
        public static void DeleteServicesInfo(ServicesInfo infoObj)
        {
            ProviderObject.DeleteServicesInfoInternal(infoObj);
        }


        /// <summary>
        /// Deletes ServicesInfo with specified ID.
        /// </summary>
        /// <param name="id">ServicesInfo ID</param>
        public static void DeleteServicesInfo(int id)
        {
            ServicesInfo infoObj = GetServicesInfo(id);
            DeleteServicesInfo(infoObj);
        }

        #endregion


        #region "Internal methods - Basic"
	
        /// <summary>
        /// Returns a query for all the ServicesInfo objects.
        /// </summary>
        protected virtual ObjectQuery<ServicesInfo> GetServicesInternal()
        {
            return GetObjectQuery();
        }    


        /// <summary>
        /// Returns ServicesInfo with specified ID.
        /// </summary>
        /// <param name="id">ServicesInfo ID</param>        
        protected virtual ServicesInfo GetServicesInfoInternal(int id)
        {	
            return GetInfoById(id);
        }


        /// <summary>
        /// Returns ServicesInfo with specified GUID.
        /// </summary>
        /// <param name="guid">ServicesInfo GUID</param>
        protected virtual ServicesInfo GetServicesInfoInternal(Guid guid)
        {
            return GetInfoByGuid(guid);
        }


        /// <summary>
        /// Sets (updates or inserts) specified ServicesInfo.
        /// </summary>
        /// <param name="infoObj">ServicesInfo to be set</param>        
        protected virtual void SetServicesInfoInternal(ServicesInfo infoObj)
        {
            SetInfo(infoObj);
        }


        /// <summary>
        /// Deletes specified ServicesInfo.
        /// </summary>
        /// <param name="infoObj">ServicesInfo to be deleted</param>        
        protected virtual void DeleteServicesInfoInternal(ServicesInfo infoObj)
        {
            DeleteInfo(infoObj);
        }	

        #endregion
    }
}