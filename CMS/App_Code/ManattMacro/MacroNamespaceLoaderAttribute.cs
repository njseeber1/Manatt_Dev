using CMS.Base;
using CMS.MacroEngine;

[MacroNamespaceLoader]
public partial class CMSModuleLoader
{
    /// <summary>
    /// Attribute class that ensures the registration of custom macro namespaces.
    /// </summary>
    private class MacroNamespaceLoaderAttribute : CMSLoaderAttribute
    {
        /// <summary>
        /// Called automatically when the application starts.
        /// </summary>
        public override void Init()
        {
            // Registers "CustomNamespace" into the macro engine
            MacroContext.GlobalResolver.SetNamedSourceData("ManattMacro", ManattMacroNamespace.Instance);
        }
    }
}