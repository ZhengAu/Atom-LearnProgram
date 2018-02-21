/*
少用全局变量，
函数代码进行提炼，多复用
 */

var oDom = document.getElementById('canvas');
var ctx = oDom.getContext('2d');
var oWidth = ctx.canvas.width;
var oHeight = ctx.canvas.height;
var oR = oWidth / 2;
var oCuDate = document.getElementById('date');
var oTime = document.getElementById('time');
var oWeek = document.getElementById('week');
var oProportion = oWidth / 200; //时钟放大缩小比例

function drawBackground() {
    ctx.save();
    ctx.translate(oR, oR); //重置圆的中心-
    ctx.beginPath();
    ctx.lineWidth = 10 * oProportion; //圆的框度
    ctx.arc(0, 0, oR - 5 * oProportion, 0 * Math.PI, 2 * Math.PI, false); //false:顺时针画圆
    ctx.stroke();

    var hoursNum = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2];
    ctx.font = 18 * oProportion + "px Arial";
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    hoursNum.forEach(function(hour, i) { //画时钟数字
        var rad = 2 * Math.PI / 12 * i; //one hour, one rad. 一个小时，一个弧度
        var x = Math.cos(rad) * (oR - 25 * oProportion); //(oR-25):radius
        var y = Math.sin(rad) * (oR - 25 * oProportion); //
        ctx.fillText(hour, x, y);
    });
    for (var i = 0; i < 60; i++) { //画时钟上外圈的小点
        var rad = 2 * Math.PI / 60 * i;
        var x = Math.cos(rad) * (oR - 15 * oProportion);
        var y = Math.sin(rad) * (oR - 15 * oProportion);
        ctx.beginPath();
        if (i % 5 == 0) { //整点时，是大的圆点
            ctx.fillStyle = "#000";
            ctx.arc(x, y, 3 * oProportion, 0, 2 * Math.PI, false);
        } else {
            ctx.fillStyle = "#777";
            ctx.arc(x, y, 2 * oProportion, 0, 2 * Math.PI, false);
        }
        ctx.fill();
    }
    for (var i = 0; i < 60; i++) { //画时钟上内圈的小点
        var rad = 2 * Math.PI / 60 * i;
        var x = Math.cos(rad) * (oR - 46 * oProportion);
        var y = Math.sin(rad) * (oR - 46 * oProportion);
        ctx.beginPath();
        if (i % 5 == 0) { //整点时，是大的圆点
            ctx.fillStyle = "#000";
            ctx.arc(x, y, 2 * oProportion, 0, 2 * Math.PI, false);
        } else {
            ctx.fillStyle = "#777";
            ctx.arc(x, y, 1.5 * oProportion, 0, 2 * Math.PI, false);
        }
        ctx.fill();
    }
}

function drwaHour(hour, minute) { //时针
    ctx.save();
    ctx.beginPath();
    var hRad = 2 * Math.PI / 12 * hour;
    var mRad = 2 * Math.PI / (12 * 60) * minute;
    ctx.rotate(hRad + mRad);
    ctx.lineWidth = 6 * oProportion;
    ctx.lineCap = "round";
    ctx.moveTo(0, 10);
    ctx.lineTo(0, -oR / 2 - 5 * oProportion);
    ctx.stroke();
    ctx.restore();
}

function drawMinute(minute, second) { //分针
    ctx.save();
    ctx.beginPath();
    var mRad = 2 * Math.PI / 60 * minute;
    var sRad = 2 * Math.PI / (60 * 60) * second;
    ctx.rotate(mRad + sRad);
    ctx.lineWidth = 3 * oProportion;
    ctx.lineCap = "round";
    ctx.moveTo(0, 15);
    ctx.lineTo(0, -oR + 25 * oProportion);
    ctx.stroke();
    ctx.restore();
}

function drwaSecond(second) { //秒针
    ctx.save();
    ctx.beginPath();
    ctx.fillStyle = '#7d9d83';
    var mRad = 2 * Math.PI / 60 * second;
    ctx.rotate(mRad);
    ctx.moveTo(-2 * oProportion, 15 * oProportion);
    ctx.lineTo(2 * oProportion, 15 * oProportion);
    ctx.lineTo(1 * oProportion, -oR + 12 * oProportion);
    ctx.lineTo(-1 * oProportion, -oR + 12 * oProportion);
    ctx.fill();
    ctx.restore();
}

function drawRadius() { //三条针中心的圆点
    ctx.beginPath();
    ctx.fillStyle = "#FFF";
    ctx.arc(0, 0, 2 * oProportion, 0, 2 * Math.PI, false);
    ctx.fill();
}

function setTime(currentTime, hour, minute, second) { //画年月日，时间，星期几
    var oYear = currentTime.getFullYear();
    var oMonth = currentTime.getMonth()+1;
    var oDate = currentTime.getDate();
    var oDay = currentTime.getDay();
    var aWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thurday", "Friday", "Saturday"];

    if (minute < 10) {
        minute = "0" + minute;
    }
    if (second < 10) {
        second = "0" + second;
    }
    if (oMonth < 10){
        oMonth = "0" + oMonth;
    }
    if (oDate < 10) {
        oDate = "0" + oDate;
    }
    oCuDate.innerHTML = oYear + "/" + (oMonth) + "/" + oDate;
    oTime.innerHTML = hour + " : " + minute + " : " + second;
    oWeek.innerHTML = aWeek[oDay];
}

function setFont() { //设置字体大小
    oCuDate.style.fontSize = 18 * oProportion + "px";
    oTime.style.fontSize = 25 * oProportion + "px";
    oWeek.style.fontSize = 18 * oProportion + "px";
}

function draw() {
    ctx.clearRect(0, 0, oWidth, oHeight);
    var currentTime = new Date();
    var hour = currentTime.getHours();
    var minute = currentTime.getMinutes();
    var second = currentTime.getSeconds();
    drawBackground();
    drwaHour(hour, minute);
    drawMinute(minute, second);
    drwaSecond(second);
    drawRadius();
    setTime(currentTime, hour, minute, second);
    ctx.restore();
}
draw();
setInterval(draw, 1000);
