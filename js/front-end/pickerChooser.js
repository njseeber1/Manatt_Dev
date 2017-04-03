jQuery(document).ready(function($) {
    // DOM ready
    $(function() {
        var $theSelect = $('<select/>').addClass('form-control pickerChooser-select'),
            $theTarget = $('.pickerChooser-choice');

        // Create the dropdown base
        $theSelect.insertAfter(".pickerChooser-list");

        // Create default option "Go to..."
        $("<option />", {
            "selected": "selected",
            "value": "",
            "text": "Select a Key Topic"
        }).appendTo($theSelect);

        // Populate dropdown with menu items
        $(".pickerChooser-list li a").each(function() {
            var el = $(this);
            $("<option />", {
                "value": el.text(),
                "text": el.text()
            }).appendTo($theSelect);
        });

        $theSelect.change(function() {
                var optionSelected = $("option:selected", this).val();
                $('.pickerChooser-choice').removeClass('is-visible flashMe');
                //alert(optionSelected);
                $('.pickerChooser-choice[data-choose="' + optionSelected + '"]').addClass('is-visible flashMe');
                $('.pickerChooser-choice[data-choose="' + optionSelected + '"]')[0].offsetWidth;
            }) //.change();

        $('.pickerChooser-list li a').on("click", function(e) {
            e.preventDefault();
            $('.pickerChooser-list li').removeClass('selected');
            $(this).closest('li').addClass('selected');


            var target = $(this).attr('data-target');
            $(".pickerChooser-choice").each(function() {
                $('.pickerChooser-choice').removeClass('is-visible flashMe');
                $('.pickerChooser-choice[data-choose="' + target + '"]').addClass('is-visible flashMe');
                $('.pickerChooser-choice[data-choose="' + target + '"]')[0].offsetWidth;
            });
        });

    });
});
