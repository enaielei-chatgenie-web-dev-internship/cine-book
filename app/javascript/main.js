$(() => {
    $('.ui.calendar.time').calendar({
        type: 'time'
    });

    $('.ui.selection.dropdown').dropdown(

    );

    $('.message .close').on('click', function() {
        $(this)
        .closest('.message')
        .transition('fade');
    });

    $(".image-upload").on("change", (ev) => {
        let files = ev.currentTarget.files;
        if(files.length > 0) {
            $("#image-previews-parent").removeAttr("style");
            $("#image-previews .image-preview").remove();
            for(file of files) {
                img = $("#image-preview").clone().appendTo("#image-previews");
                id = img.attr("id");
                img.removeAttr("id");
                img.addClass(id);
                img.removeAttr("style");
                img.children("img").attr("src", URL.createObjectURL(file));
            }
        } else {
            $("#image-previews-parent").css("display", "none");
        }
    });

    $.fn.api.settings.api = {
        'get data': "/api?type={type}&data={data}",
        'get showing timeslots' : '/api?type={type}&data={data}&cinema_id={cinema_id}',
        'get booking seats' : '/api?type={type}&data={data}&showing_id={showing_id}',
    };

    function toggleShowingTimeslot() {
        let cinema = $("#showing-cinema").dropdown("get value");
        $("#showing-timeslot").dropdown("clear");
        if(cinema != "") {
            $("#showing-timeslot").removeClass("disabled");
        } else {
            $("#showing-timeslot").addClass("disabled");
        }
        // let movie = $("#showing-movie").dropdown("get value");
        // if(cinema != '' && movie != '') {
        //     $("#showing-timeslot").removeClass("disabled");
        // } else {
        //     $("#showing-timeslot").addClass("disabled");
        // }
    }

    function toggleBookingSeat() {
        let showing = $("#booking-showing").dropdown("get value");
        if(showing != '') {
            $("#booking-seat").removeClass("disabled");
        } else {
            $("#booking-seat").addClass("disabled");
        }
    }
    

    function limitSize(file, mb) {
        let size_in_megabytes = file.size/1024/1024;
        if (size_in_megabytes > mb) {
            alert(`Maximum file size is ${mb}MB. Please choose a smaller file.`);
            return true;
        }

        return false;
    }

    $("#showing-cinema").dropdown({
        apiSettings: {
            action: "get data",
            cache: false,
            beforeSend: function(settings) {
                settings.urlData = {
                    type: "dropdown",
                    data: "cinemas"
                }
                return settings;
            }
        },
        saveRemoteData: false,
        message: {
            noResults: "No registered cinemas."
        },
        onChange: function(value, text, $choice) {
            toggleShowingTimeslot();
        }
    });

    let value = $("#showing-cinema").dropdown("get value");
    $("#showing-cinema").dropdown("clear");
    $("#showing-cinema").dropdown("set selected", value);

    // $("#showing-movie").dropdown({
    //     apiSettings: {
    //         action: "get data",
    //         cache: false,
    //         beforeSend: function(settings) {
    //             settings.urlData = {
    //                 type: "dropdown",
    //                 data: "movies"
    //             }
    //             return settings;
    //         }
    //     },
    //     saveRemoteData: false,
    //     message: {
    //         noResults: "No registered movies."
    //     },
    //     onChange: function(value, text, $choice) {
    //         toggleShowingTimeslot();
    //     }
    // });

    $("#showing-timeslot").dropdown({
        apiSettings: {
            action: "get showing timeslots",
            cache: false,
            beforeSend: function(settings) {
                settings.urlData = {
                    type: "dropdown",
                    data: "showing-timeslots",
                    cinema_id: $("#showing-cinema").dropdown("get value"),
                    // movie_id: $("#showing-movie").dropdown("get value"),
                }
                return settings;
            }
        },
        saveRemoteData: false,
        message: {
            noResults: "No more timeslots available for the selected cinema."
        }
    });


    $("#booking-showing").dropdown({
        apiSettings: {
            action: "get data",
            cache: false,
            beforeSend: function(settings) {
                settings.urlData = {
                    type: "dropdown",
                    data: "booking-showings"
                }
                return settings;
            }
        },
        saveRemoteData: false,
        message: {
            noResults: "No showing movies yet."
        },
        onChange: function(value, text, $choice) {
            toggleBookingSeat();
        }
    });

    value = $("#booking-showing").dropdown("get value");
    $("#booking-showing").dropdown("clear");
    $("#booking-showing").dropdown("set selected", value);

    $("#booking-seat").dropdown({
        apiSettings: {
            action: "get booking seats",
            cache: false,
            beforeSend: function(settings) {
                settings.urlData = {
                    type: "dropdown",
                    data: "booking-seats",
                    showing_id: $("#booking-showing").dropdown("get value"),
                }
                return settings;
            }
        },
        saveRemoteData: false,
        message: {
            noResults: "No more seats available for this showing."
        }
    });

    $("input[type=file]").on("change", function(ev) {
        for(let file of ev.currentTarget.files) {
            limitSize(file, 5);
        }
    });

    $(".ui.accordion").accordion();
});