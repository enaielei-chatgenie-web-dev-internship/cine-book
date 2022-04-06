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
        'get showing timeslots' : '/api?type={type}&data={data}&cinema_id={cinema_id}&movie_id={movie_id}',
    };

    function toggleShowingTimeslot() {
        let cinema = $("#showing-cinema").dropdown("get value");
        let movie = $("#showing-movie").dropdown("get value");
        if(cinema != '' && movie != '') {
            $(".showing-timeslot").removeClass("disabled");
        } else {
            $(".showing-timeslot").addClass("disabled");
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

    $("#showing-movie").dropdown({
        apiSettings: {
            action: "get data",
            cache: false,
            beforeSend: function(settings) {
                settings.urlData = {
                    type: "dropdown",
                    data: "movies"
                }
                return settings;
            }
        },
        saveRemoteData: false,
        message: {
            noResults: "No registered movies."
        },
        onChange: function(value, text, $choice) {
            toggleShowingTimeslot();
        }
    });

    $(".showing-timeslot").dropdown({
        apiSettings: {
            action: "get showing timeslots",
            cache: false,
            beforeSend: function(settings) {
                settings.urlData = {
                    type: "dropdown",
                    data: "showing-timeslots",
                    cinema_id: $("#showing-cinema").dropdown("get value"),
                    movie_id: $("#showing-movie").dropdown("get value"),
                }
                return settings;
            }
        },
        saveRemoteData: false,
        message: {
            noResults: "No more timeslots available for this showing."
        }
    });

    $("input[type=file]").on("change", function(ev) {
        for(let file of ev.currentTarget.files) {
            limitSize(file, 5);
        }
    });

    $(".ui.accordion").accordion();
});