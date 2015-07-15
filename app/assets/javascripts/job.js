$(document).ready(function(){
    var job = {};

    job.workers = [];


    var startWork = function() {

        if( $('#startBox').html() === "click" ){

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
      if( $('#finishBox').html() === "click" ){
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

    var addWorkers = function() {
      if( !job.allWorkers ){

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

      }else{
        displayWorkerPic(job.allWorkers);
         $('#workerPic .workForce').on('click', workerSelect);
         $('#doneSelect').on('click', backToJob);
      }

     


    };

    var displayWorkerPic = function(data){
        $('#workerPic').html('');
        $('#workerPic').html('<div id="doneSelect">Done</div> <div id="myUserSelect"></div>');

        $('#container').hide();
        
        for( var i= 0 ; i< data.length ; i++){
              var onJob = '"';
              var userId = (data[i].id).toString();

              for(var k = 0 ; k < job.workers.length ; k++){
                if(job.workers[k].id === userId){ onJob = ' workerSelected"' };

              }

              $('#myUserSelect').append('<div class="bottomMenu workForce' +onJob+  ' data-workid='+ data[i].id + '>' + data[i].name +'</div>')
        }

    }


    var upDateWorkers = function(){
      var workers = $('.workForce');
      for( var i = 0 ; i < workers.length ; i++){
        var user = {"id" : workers[i].dataset.workid, "name" : workers[i].innerHTML };
        job.workers.push( user );
        console.log(user);
      }

      
    };


    var workerSelect = function() {
      var name = this.innerHTML;
      var workid = this.dataset.workid;
      var selected = this.classList.contains('workerSelected');
      
      if(selected){
        this.classList.remove('workerSelected');

        job.workers = job.workers.filter(function(i){ return i.id != workid; });

        console.log(job.workers.length);

      }else{
        this.classList.add('workerSelected');
        var worker = {"id": workid, "name" : name};
        job.workers.push(worker);
        console.log(job.workers.length);

      }
     
    }

    var backToJob = function(){
      $('#container').show();
      $('#workerPic').html('');
      displayWorkersOnJob();
    };


    var displayWorkersOnJob = function(){
      $('#onSite').html("");
      var onJobSite = ""

      for( var i = 0 ; i < job.workers.length ; i++){
       $('#onSite').append('<div class="bottomMenu workForce" data-workid='+ job.workers[i].id + '>' + job.workers[i].name +'</div>');

       onJobSite += " "+ job.workers[i].id
      }

      $('#chosenWorkers')[0].value = onJobSite;

    };



    var workCompleted = function() {
      if( $('#startBox').html() != "click" && $('#finishBox').html() != "click"){

      var jobData = {
            job: {
                comments: $('textarea')[1].value
            }

        };

        $.ajax({
            url: '/jobcomplete/' + $('#jobInfo').data('jobid'),
            method: 'POST',
            data: jobData

        }).done(function(data) {

          console.log(data)
            
        });


      }
    };

   

    if( $('#addWorkers') ){  upDateWorkers()  };


    $('#complete').on('click', workCompleted);

    $('#finishBox').on('click', finishWork);

    $('#startBox').on('click', startWork);

    $('#addWorkers').on('click', addWorkers);


});
