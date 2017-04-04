using System;
using System.Data;

using CMS.Base;
using CMS.DataEngine;
using CMS.Helpers;

namespace Manatt_Menu
{    
    /// <summary>
    /// Class providing IndustriesInfo management.
    /// </summary>
    public class IndustriesInfoProvider : AbstractInfoProvider<IndustriesInfo, IndustriesInfoProvider>
    {
        #region "Constructors"

        /// <summary>
        /// Constructor
        /// </summary>
        public IndustriesInfoProvider()
            : base(IndustriesInfo.TYPEINFO)
        {
        }

        #endregion


        #region "Public methods - Basic"

        /// <summary>
        /// Returns a query for all the IndustriesInfo objects.
        /// </summary>
        public static ObjectQuery<IndustriesInfo> GetIndustries()
        {
            return ProviderObject.GetIndustriesInternal();
        }


        /// <summary>
        /// Returns IndustriesInfo with specified ID.
        /// </summary>
        /// <param name="id">IndustriesInfo ID</param>
        public static IndustriesInfo GetIndustriesInfo(int id)
        {
            return ProviderObject.GetIndustriesInfoInternal(id);
        }


        /// <summary>
        /// Returns IndustriesInfo with specified GUID.
        /// </summary>
        /// <param name="guid">IndustriesInfo GUID</param>                
        public static IndustriesInfo GetIndustriesInfo(Guid guid)
        {
            return ProviderObject.GetIndustriesInfoInternal(guid);
        }


        /// <summary>
        /// Sets (updates or inserts) specified IndustriesInfo.
        /// </summary>
        /// <param name="infoObj">IndustriesInfo to be set</param>
        public static void SetIndustriesInfo(IndustriesInfo infoObj)
        {
            ProviderObject.SetIndustriesInfoInternal(infoObj);
        }


        /// <summary>
        /// Deletes specified IndustriesInfo.
        /// </summary>
        /// <param name="infoObj">IndustriesInfo to be deleted</param>
        public static void DeleteIndustriesInfo(IndustriesInfo infoObj)
        {
            ProviderObject.DeleteIndustriesInfoInternal(infoObj);
        }


        /// <summary>
        /// Deletes IndustriesInfo with specified ID.
        /// </summary>
        /// <param name="id">IndustriesInfo ID</param>
        public static void DeleteIndustriesInfo(int id)
        {
            IndustriesInfo infoObj = GetIndustriesInfo(id);
            DeleteIndustriesInfo(infoObj);
        }

        #endregion


        #region "Internal methods - Basic"
	
        /// <summary>
        /// Returns a query for all the IndustriesInfo objects.
        /// </summary>
        protected virtual ObjectQuery<IndustriesInfo> GetIndustriesInternal()
        {
            return GetObjectQuery();
        }    


        /// <summary>
        /// Returns IndustriesInfo with specified ID.
        /// </summary>
        /// <param name="id">IndustriesInfo ID</param>        
        protected virtual IndustriesInfo GetIndustriesInfoInternal(int id)
        {	
            return GetInfoById(id);
        }


        /// <summary>
        /// Returns IndustriesInfo with specified GUID.
        /// </summary>
        /// <param name="guid">IndustriesInfo GUID</param>
        protected virtual IndustriesInfo GetIndustriesInfoInternal(Guid guid)
        {
            return GetInfoByGuid(guid);
        }


        /// <summary>
        /// Sets (updates or inserts) specified IndustriesInfo.
        /// </summary>
        /// <param name="infoObj">IndustriesInfo to be set</param>        
        protected virtual void SetIndustriesInfoInternal(IndustriesInfo infoObj)
        {
            SetInfo(infoObj);
        }


        /// <summary>
        /// Deletes specified IndustriesInfo.
        /// </summary>
        /// <param name="infoObj">IndustriesInfo to be deleted</param>        
        protected virtual void DeleteIndustriesInfoInternal(IndustriesInfo infoObj)
        {
            DeleteInfo(infoObj);
        }	

        #endregion
    }
}