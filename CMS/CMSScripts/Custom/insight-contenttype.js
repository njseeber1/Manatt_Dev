$(function () {
    var selected = $("select[name$='$ContentTypeFilter$drpFilter'] option:selected")[0];
    if (selected.value != location.pathname.toLowerCase())
        $("select[name$='$ContentTypeFilter$drpFilter'] option[value='" + location.pathname.toLowerCase() + "']").prop("selected", true);

    $("input[name$='$srchDialog$btnSearch'],input[name$='$ManattSmartSearchBox$btnSearch']").click(function () {
        var selected = $("select[name$='$ContentTypeFilter$drpFilter'] option:selected")[0];
        if (selected.value != "" && location.pathname.toLowerCase() != selected.value.toLowerCase()) {
            var searchText = $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$ManattSmartSearchBox$txtWord']").val();
            //var searchTextId = $("input[name$='$SearchText$txtFilter'],input[name$='$txtWord']").attr('id');
            //var searchText = document.getElementById(searchTextId).value;
            if (searchText == "Search")
                searchText = "";
            var servicesFilter = $("select[name$='$ServicesFilter$drpFilter'] option:selected").index();
            var contentTypeFilter = $("select[name$='$ContentTypeFilter$drpFilter'] option:selected").index();
            var dateFilter = $("input[name$='$DateFilter$txtFilter']").val();
            var dateFilter1 = $("input[name$='$DateFilter1$txtFilter']").val();            

            var url = selected.value + "?searchtext=" + searchText
                                  + "&contenttypefilter=" + contentTypeFilter
                                  + "&servicesfilter=" + servicesFilter;
            if (dateFilter != null && !isNaN(Date.parse(dateFilter)))
                url += "&datefilter=" + dateFilter;
            if (dateFilter1 != null && !isNaN(Date.parse(dateFilter1)))
                url += "&datefilter1=" + dateFilter1;

            window.location.href = url + "&searchmode=exactphrase";
            return false;
        }
    });
});