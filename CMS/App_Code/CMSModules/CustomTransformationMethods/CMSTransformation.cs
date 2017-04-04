using CMS.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CMS.Controls
{
    /// <summary>
    /// Extends the CMSTransformation partial class.
    /// </summary>
    public partial class CMSTransformation
    {
        /// <summary>
        /// Save parent name and returns true if parent name is different than previous parent name.
        /// Returns false if parent name is equals to previous parent name.
        /// </summary>
        /// <param name="parentName">Parent name to be compared with previous parent name</param>
        public static bool IsDifferentPreviousParent(object parentName)
        {
            bool result = false;
            string previousParentName = string.Empty;
            int count = 0;

            string currentParentName = ValidationHelper.GetString(parentName, string.Empty);

            if(string.IsNullOrEmpty(currentParentName))
            {
                result = true;
                RequestStockHelper.Add("PreviousParentName", currentParentName);
            }
            else
            {
                previousParentName = ValidationHelper.GetString(RequestStockHelper.GetItem("PreviousParentName"), string.Empty);
                if(previousParentName.Equals(currentParentName))
                {
                    count = ValidationHelper.GetInteger(RequestStockHelper.GetItem("ServiceCount"), 0);
                    count++;
                    RequestStockHelper.Add("ServiceCount", count);
                    result = false;
                }
                else
                {
                    result = true;
                    RequestStockHelper.Add("PreviousParentName", currentParentName);
                    count = 1;
                    RequestStockHelper.Add("ServiceCount", count);
                }
            }            

            return result;
        }

        public static bool IsLastChild(object countNumber)
        {
            int currentCount = ValidationHelper.GetInteger(countNumber, 0);
            return ValidationHelper.GetInteger(RequestStockHelper.GetItem("ServiceCount"), 0) == currentCount ? true : false;
        }
    }
}