using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ManattMacroNamespace
/// </summary>
using CMS.Base;
using CMS.MacroEngine;

[Extension(typeof(ManattMacroMethods))]
public class ManattMacroNamespace : MacroNamespace<ManattMacroNamespace>
{
}