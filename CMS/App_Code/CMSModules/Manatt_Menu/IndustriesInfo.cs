using System;
using System.Data;
using System.Runtime.Serialization;
using System.Collections.Generic;

using CMS;
using CMS.DataEngine;
using CMS.Helpers;
using Manatt_Menu;

[assembly: RegisterObjectType(typeof(IndustriesInfo), IndustriesInfo.OBJECT_TYPE)]
    
namespace Manatt_Menu
{
    /// <summary>
    /// IndustriesInfo data container class.
    /// </summary>
	[Serializable]
    public class IndustriesInfo : AbstractInfo<IndustriesInfo>
    {
        #region "Type information"

        /// <summary>
        /// Object type
        /// </summary>
        public const string OBJECT_TYPE = "manatt_menu.industries";


        /// <summary>
        /// Type information.
        /// </summary>
#warning "You will need to configure the type info."
        public static ObjectTypeInfo TYPEINFO = new ObjectTypeInfo(typeof(IndustriesInfoProvider), OBJECT_TYPE, "Manatt_Menu.Industries", "IndustriesID", "IndustriesLastModified", "IndustriesGuid", null, null, null, null, null, null)
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
        /// Industries ID
        /// </summary>
        [DatabaseField]
        public virtual int IndustriesID
        {
            get
            {
                return ValidationHelper.GetInteger(GetValue("IndustriesID"), 0);
            }
            set
            {
                SetValue("IndustriesID", value);
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
        /// Industries guid
        /// </summary>
        [DatabaseField]
        public virtual Guid IndustriesGuid
        {
            get
            {
                return ValidationHelper.GetGuid(GetValue("IndustriesGuid"), Guid.Empty);
            }
            set
            {
                SetValue("IndustriesGuid", value);
            }
        }


        /// <summary>
        /// Industries last modified
        /// </summary>
        [DatabaseField]
        public virtual DateTime IndustriesLastModified
        {
            get
            {
                return ValidationHelper.GetDateTime(GetValue("IndustriesLastModified"), DateTimeHelper.ZERO_TIME);
            }
            set
            {
                SetValue("IndustriesLastModified", value);
            }
        }

        #endregion


        #region "Type based properties and methods"

        /// <summary>
        /// Deletes the object using appropriate provider.
        /// </summary>
        protected override void DeleteObject()
        {
            IndustriesInfoProvider.DeleteIndustriesInfo(this);
        }


        /// <summary>
        /// Updates the object using appropriate provider.
        /// </summary>
        protected override void SetObject()
        {
            IndustriesInfoProvider.SetIndustriesInfo(this);
        }

        #endregion


        #region "Constructors"

		/// <summary>
        /// Constructor for de-serialization.
        /// </summary>
        /// <param name="info">Serialization info</param>
        /// <param name="context">Streaming context</param>
        public IndustriesInfo(SerializationInfo info, StreamingContext context)
            : base(info, context, TYPEINFO)
        {
        }


        /// <summary>
        /// Constructor - Creates an empty IndustriesInfo object.
        /// </summary>
        public IndustriesInfo()
            : base(TYPEINFO)
        {
        }


        /// <summary>
        /// Constructor - Creates a new IndustriesInfo object from the given DataRow.
        /// </summary>
        /// <param name="dr">DataRow with the object data</param>
        public IndustriesInfo(DataRow dr)
            : base(TYPEINFO, dr)
        {
        }

        #endregion
    }
}