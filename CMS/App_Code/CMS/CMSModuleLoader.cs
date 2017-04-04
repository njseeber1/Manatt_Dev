using System;
using System.Linq;

using CMS.Base;
using CMS.DocumentEngine;


/// <summary>
/// Module loader class, ensures initialization of other modules through this partial class
/// </summary>
public partial class CMSModuleLoader : CMSModuleLoaderBase
{
    /// <summary>
    /// Constructor
    /// </summary>
    public CMSModuleLoader() : base("CMSModuleLoader")
    {
	
    }
}