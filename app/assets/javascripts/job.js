$(document).ready(function() {
    var job = {};

    job.workers = [];


    var startWork = function() {

        if ($('#startBox').html() === "click") {

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

    };

    var finishWork = function() {
        if ($('#finishBox').html() === "click") {
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

    };

    var invoiceAmount = function() {
        console.log('fired');
        if ( $('#job_amount').val() != "" ) {
            var jobData = {
                job: {
                    amount: $('#job_amount').val()
                }
            };

            $.ajax({
                url: '/jobs/' + $('#jobInfo').data('jobid'),
                method: 'PUT',
                data: jobData,
                dataType: "json"

            }).done(function(data) {
              var amount = $('#job_amount').val();
              var string = numeral(amount).format('$0,0.00');

              $('#jAmount').remove();
              $('#jobInfo').append("<p>Invoice amount: " + string +"</p>" );

            });
        }

    };


    var addWorkers = function(e) {

        e.preventDefault();

        if (!job.allWorkers) {

            $.ajax({
                url: '/users',
                method: 'GET',
                dataType: "json"


            }).done(function(data) {
                job.allWorkers = data;

                displayWorkerPic(data);
                $('#workerPic .workForce').on('click', workerSelect);
                $('#doneSelect').on('click', backToJob);

            });

        } else {
            displayWorkerPic(job.allWorkers);
            $('#workerPic .workForce').on('click', workerSelect);
            $('#doneSelect').on('click', backToJob);
        }

    };

    var displayWorkerPic = function(data) {
        $('#workerPic').html('');
        $('#workerPic').html('<div id="doneSelect" class="comButton">Done</div> <div id="myUserSelect"></div>');

        $('#container').hide();

        for (var i = 0; i < data.length; i++) {
            var onJob = '"';
            var userId = (data[i].id).toString();

            for (var k = 0; k < job.workers.length; k++) {
                if (job.workers[k].id === userId) {
                    onJob = ' workerSelected"'
                };
            }

            $('#myUserSelect').append('<div class="workForce onsiteButton' + onJob + ' data-workid=' + data[i].id + '>' + data[i].name.match(/\S*\w*\s*\w*/) + '</div>')
        }
    }

    var upDateWorkers = function() {
        var workers = $('.workForce');
        for (var i = 0; i < workers.length; i++) {
            var user = {
                "id": workers[i].dataset.workid,
                "name": workers[i].innerHTML
            };
            job.workers.push(user);
            console.log(user);
        }
    };


    var workerSelect = function() {
        var name = this.innerHTML;
        var workid = this.dataset.workid;
        var selected = this.classList.contains('workerSelected');

        if (selected) {
            this.classList.remove('workerSelected');

            job.workers = job.workers.filter(function(i) {
                return i.id != workid;
            });

            console.log(job.workers.length);

        } else {
            this.classList.add('workerSelected');
            var worker = {
                "id": workid,
                "name": name
            };
            job.workers.push(worker);
            console.log(job.workers.length);
        }

    }

    var backToJob = function() {
        $('#container').show();
        $('#workerPic').html('');
        displayWorkersOnJob();
    };


    var displayWorkersOnJob = function() {
        $('#onSite').html("");
        var onJobSite = ""

        for (var i = 0; i < job.workers.length; i++) {
            $('#onSite').append('<div class="onsiteButton workForce" data-workid=' + job.workers[i].id + '>' + job.workers[i].name + '</div>');

            onJobSite += " " + job.workers[i].id
        }

        $('#chosenWorkers')[0].value = onJobSite;

    };

    var workCompleted = function() {
        if ($('#startBox').html() != "click" && $('#finishBox').html() != "click") {

            var jobData = {
                job: {
                    comments: $('textarea')[1].value
                }
            };

            $.ajax({
                url: '/jobcomplete/' + $('#jobInfo').data('jobid'),
                method: 'POST',
                data: jobData
            }).done(function() {
                window.location = "/jobs";
            });
        }
    };

    var finalizePay = function() {

        $.ajax({
            url: '/finalize',
            method: 'GET',
            dataType: "json"
        }).done(function() {
            $('table tbody td:nth-child(3)').html('true')

        });
    }

    var addClients = function() {

        if (!job.clients) {
            $.ajax({
                url: '/clientjob',
                method: 'GET'

            }).done(function(data) {
                job.clients = data;
                displayClientList();

            });
        } else {
            displayClientList();
        }
    }

    var displayClientList = function(element) {
        var $element = $('#jobContainer');
        $element.html('');
        for (var i = 0; i < job.clients.length; i++) {
            $element.append('<div class="bottomMenu clientPick">' + job.clients[i].name + '</div>');
        }
    };

    // display years present > past
    var yearsShow = function() {
        var $element = $('#jobContainer');
        console.log(job.clients);
        var n = $(this).index();
        var first = job.clients[n].first;
        var last = job.clients[n].last;

        $element.html('');
        for (var i = last; i >= first; i--) {
            h= "/archieve/" + job.clients[n].id + "/" + last;
            $element.append('<a href='+ h + '><div class="bottomMenu" data-client=' + job.clients[n].id + '>' + last + '</div></a>');
        }
    }

    var jobPaid = function(){
      console.log(this.dataset.jobid);
      console.log(this.innerHTML);
    }



    if ($('#addWorkers')) {
        upDateWorkers()
    };

    $('#amount').on('click', invoiceAmount);
    $('.comJobs tbody td:nth-child(4)').on('click', jobPaid);
    $('#finalize').on('click', finalizePay);
    $('#complete').on('click', workCompleted);
    $('#finishBox').on('click', finishWork);
    $('#startBox').on('click', startWork);
    $('#addWorkers').on('click', addWorkers);
    $('#allClients').on('click', addClients);
    $('#jobContainer').on('click', '.clientPick', yearsShow);

    $('#jobListing22').DataTable();

});
