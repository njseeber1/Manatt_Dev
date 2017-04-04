using System;
using System.Data;
using System.Runtime.Serialization;
using System.Collections.Generic;

using CMS;
using CMS.DataEngine;
using CMS.Helpers;
using Manatt_Menu;

[assembly: RegisterObjectType(typeof(ServicesInfo), ServicesInfo.OBJECT_TYPE)]
    
namespace Manatt_Menu
{
    /// <summary>
    /// ServicesInfo data container class.
    /// </summary>
	[Serializable]
    public class ServicesInfo : AbstractInfo<ServicesInfo>
    {
        #region "Type information"

        /// <summary>
        /// Object type
        /// </summary>
        public const string OBJECT_TYPE = "manatt_menu.services";


        /// <summary>
        /// Type information.
        /// </summary>
#warning "You will need to configure the type info."
        public static ObjectTypeInfo TYPEINFO = new ObjectTypeInfo(typeof(ServicesInfoProvider), OBJECT_TYPE, "Manatt_Menu.Services", "ServicesID", "ServicesLastModified", "ServicesGuid", null, null, null, null, null, null)
        {
			ModuleName = "Manatt_Menu",
			TouchCacheDependencies = true,
            DependsOn = new List<ObjectDependency>() 
			{
			    new ObjectDependency("PracticeId", "cms.document", ObjectDependencyEnum.NotRequired), 
            },
        };

        #endregion


        #region "Properties"

        /// <summary>
        /// Services ID
        /// </summary>
        [DatabaseField]
        public virtual int ServicesID
        {
            get
            {
                return ValidationHelper.GetInteger(GetValue("ServicesID"), 0);
            }
            set
            {
                SetValue("ServicesID", value);
            }
        }


        /// <summary>
        /// Practice id
        /// </summary>
        [DatabaseField]
        public virtual int PracticeId
        {
            get
            {
                return ValidationHelper.GetInteger(GetValue("PracticeId"), 0);
            }
            set
            {
                SetValue("PracticeId", value);
            }
        }


        /// <summary>
        /// Order
        /// </summary>
        [DatabaseField]
        public virtual int Order
        {
            get
            {
                return ValidationHelper.GetInteger(GetValue("Order"), 0);
            }
            set
            {
                SetValue("Order", value, 0);
            }
        }


        /// <summary>
        /// Services guid
        /// </summary>
        [DatabaseField]
        public virtual Guid ServicesGuid
        {
            get
            {
                return ValidationHelper.GetGuid(GetValue("ServicesGuid"), Guid.Empty);
            }
            set
            {
                SetValue("ServicesGuid", value);
            }
        }


        /// <summary>
        /// Services last modified
        /// </summary>
        [DatabaseField]
        public virtual DateTime ServicesLastModified
        {
            get
            {
                return ValidationHelper.GetDateTime(GetValue("ServicesLastModified"), DateTimeHelper.ZERO_TIME);
            }
            set
            {
                SetValue("ServicesLastModified", value);
            }
        }

        #endregion


        #region "Type based properties and methods"

        /// <summary>
        /// Deletes the object using appropriate provider.
        /// </summary>
        protected override void DeleteObject()
        {
            ServicesInfoProvider.DeleteServicesInfo(this);
        }


        /// <summary>
        /// Updates the object using appropriate provider.
        /// </summary>
        protected override void SetObject()
        {
            ServicesInfoProvider.SetServicesInfo(this);
        }

        #endregion


        #region "Constructors"

		/// <summary>
        /// Constructor for de-serialization.
        /// </summary>
        /// <param name="info">Serialization info</param>
        /// <param name="context">Streaming context</param>
        public ServicesInfo(SerializationInfo info, StreamingContext context)
            : base(info, context, TYPEINFO)
        {
        }


        /// <summary>
        /// Constructor - Creates an empty ServicesInfo object.
        /// </summary>
        public ServicesInfo()
            : base(TYPEINFO)
        {
        }


        /// <summary>
        /// Constructor - Creates a new ServicesInfo object from the given DataRow.
        /// </summary>
        /// <param name="dr">DataRow with the object data</param>
        public ServicesInfo(DataRow dr)
            : base(TYPEINFO, dr)
        {
        }

        #endregion
    }
}