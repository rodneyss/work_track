$(document).ready(function(){




    var startWork = function() {

        if( $('startBox').html() === "" ){

          var jobData = {
              job: {
                  start: "1",
              }

          };

          $.ajax({
              url: '/startstop/' + $('#jobInfo').data('jobid'),
              method: 'POST',
              data: jobData

          }).done(function(data) {
              console.log(Date(data));
              var dateRead = Date(data.timeTaken).replace(/GMT.*/, "")
              $('#startBox').html(dateRead);
           
          });
        }

    }

     var finishWork = function() {

        var jobData = {
            job: {
                start: "2",
            }

        };

        $.ajax({
            url: '/startstop/' + $('#jobInfo').data('jobid'),
            method: 'POST',
            data: jobData

        }).done(function(data) {

            var dateRead = Date(data.timeTaken).replace(/GMT.*/, "")
            $('#finishBox').html(dateRead);
            $('#hoursDone').html(data.hours)
            
        });

    }


    $('#finishBox').on('click', finishWork);

    $('#startBox').on('click', startWork);


});
