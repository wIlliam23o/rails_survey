/*
$(function(){

    var numDataPoints = 150;
    var myCount = $("#num-responses").text();
    myCount = parseInt(myCount);
    var seriesData = [];

    for(var k = 0; k < numDataPoints; k++) {
        var timeBase = Math.floor(new Date().getTime() / 1000);
        var data = {};
        data = {x: k + timeBase, y:myCount};
        seriesData[k] = data;
    }

    function populateData() {
        var newSeriesData = [];
        for (var i = 0; i < numDataPoints - 1; i++){
            newSeriesData[i] = seriesData[i + 1];
        }
        var num = $("#num-responses").text();
        var timeBase = Math.floor(new Date().getTime() / 1000);
        seriesData.push({x: numDataPoints + timeBase, y: parseInt(num)});
    }

    var palette = new Rickshaw.Color.Palette( { scheme: 'classic9' } );

    var realtimeGraph;
    try {
        realtimeGraph = new Rickshaw.Graph({
            element: document.getElementById("survey-realtime-chart"),
            height: 300,
            renderer: 'area',
            stroke: true,
            preserve: true,
            series: [
                {
                    color: "blue",
                    data: seriesData,
                    name: 'Responses'
                }
            ]
        });
        realtimeGraph.render();
    }
    catch (err) {

    }


    $(window).resize(function(){
        realtimeGraph.width = $("#chart-container").width();
        realtimeGraph.render();
    });

    var hoverDetail = new Rickshaw.Graph.HoverDetail( {
        graph: realtimeGraph
    } );

    var annotator = new Rickshaw.Graph.Annotate( {
        graph: realtimeGraph,
        element: document.getElementById('timeline')
    } );

    var legend = new Rickshaw.Graph.Legend( {
        graph: realtimeGraph,
        element: document.getElementById('legend')

    } );

    var shelving = new Rickshaw.Graph.Behavior.Series.Toggle( {
        graph: realtimeGraph,
        legend: legend
    } );

    var order = new Rickshaw.Graph.Behavior.Series.Order( {
        graph: realtimeGraph,
        legend: legend
    } );

    var highlighter = new Rickshaw.Graph.Behavior.Series.Highlight( {
        graph: realtimeGraph,
        legend: legend
    } );

    var ticksTreatment = 'glow';

    var xAxis = new Rickshaw.Graph.Axis.Time( {
       graph: realtimeGraph,
        ticksTreatment: ticksTreatment
    } );

    xAxis.render();

    var yAxis = new Rickshaw.Graph.Axis.Y( {
        graph: realtimeGraph,
        tickFormat: Rickshaw.Fixtures.Number.formatKMBT,
        ticksTreatment: ticksTreatment
    } );

    yAxis.render();


    var messages = [
        "Changed home page welcome message",
        "Minified JS and CSS",
        "Changed button color from blue to green",
        "Refactored SQL query to use indexed columns",
        "Added additional logging for debugging",
        "Fixed typo",
        "Rewrite conditional logic for clarity",
        "Added documentation for new methods"
    ];

    setInterval( function() {
        //random.addData(seriesData);
        //graph.series.data = populateData();
        populateData();
        realtimeGraph.update();
        //console.log("updated graph");
    }, 1500 );

    function addAnnotation(force) {
        if (messages.length > 0 && (force || Math.random() >= 0.95)) {
            annotator.add(seriesData[2][seriesData[2].length-1].x, messages.shift());
        }
    }

    addAnnotation(true);
    setTimeout( function() { setInterval( addAnnotation, 3000 ) }, 3000 );

});*/
