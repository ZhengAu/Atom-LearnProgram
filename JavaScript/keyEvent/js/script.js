// 全局变量
var aArr = ["Alicia", "Shelly", "Kitty", "Mary", "Alice", "Gracie", "Kate", "Catherine", "Olivia","Leia","Ezra","Eram","Maggie","Matilda","Milly","Miya","Karen","Mariah","Mavis","Maxine",
"Melissa","Molody","Meredith","Michelle","Miranda","Miriam","Nancy","Olina","Kathy","Kelly","Keisey","Christy","Casey","Kara","Michaela","Morgan","Makayla","Lola","Lula"];
var timer = null;
var flag = 0;

window.onload = function() {
    var oTxt = document.getElementById('txt');
    var oPlay = document.getElementById('play');
    var oStop = document.getElementById('stop');
    // 开始
    oPlay.onclick = playFun;
    oStop.onclick = stopFun;
    //键盘事件
    document.onkeyup = function(event) {
        event = event || window.event;
        if (event.keyCode == 13 && flag == 0) {
            playFun();
            flag = 1;
        } else {
            stopFun();
            flag = 0;
        }
    }
}
// playFun函数
function playFun() {
    var oTxt = document.getElementById('txt');
    var oPlay = document.getElementById('play');
    clearInterval(timer);
    timer = setInterval(function() {
        var num = Math.floor(Math.random() * aArr.length);
        oTxt.innerHTML = aArr[num];
    }, 50);
    oPlay.style.background = "#999";
}
// stopFun函数
function stopFun() {
    clearInterval(timer);
    var oPlay = document.getElementById('play');
    oPlay.style.background = "#003366";
}
