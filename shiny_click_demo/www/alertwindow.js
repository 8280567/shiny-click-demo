function lxPopup(maskEl,popupEl,closeEl,popupMeEl){
    this.showTime=200;
    this.hideTime=200;
    this.maskEl='#'+maskEl;
    this.popupEl='#'+popupEl;
    this.closeEl='.'+closeEl;
    this.popupMeEl="."+popupMeEl;
    this.toDrag=$(this.popupEl+" .top");
    this.moveable=false;
    this.clientW=function(){
        return window.innerWidth?window.innerWidth:document.body.clientWidth;
    };
    this.clientH=function(){
        return window.innerHeight?window.innerHeight:document.body.clientHeight;
    };

    this.popup=function(me){
        $(this.popupMeEl).click(function(){
            me.PopupMe();
        });
        $(this.closeEl).click(function(){
            me.closePopup();
        });
        $(window).resize(function(){
            me.resizeAll();
        });

        $(this.toDrag).mousedown(function(e) {
            me.moveable = true;
            e = window.event?window.event:e;
            var moToDivX= e.clientX-parseInt($(me.popupEl).css("left"));
            var moToDivY= e.clientY-parseInt($(me.popupEl).css("top"));
            $(document).mousemove(function(e){
                if (me.moveable) {
                    e = window.event?window.event:e;
                    //鼠标在当前框中的位置//鼠标到window的距离减去但前窗口到window的距离
                    $(me.popupEl).css("left",e.x-moToDivX);
                    $(me.popupEl).css("top",e.y-moToDivY);
                }
            });
            $(document).mouseup(function(){
                me.moveable = false;
            });
        });

    };

    //当初始化或者窗口resize时，重新计算弹出窗口的位置。
    this.initPopup=function(){
        //由于IE浏览器的独特性，所以需要判断当前窗口的宽高
        $(this.popupEl).css({
            "top":(this.clientH()-parseInt($(this.popupEl).css("height")))/2,
            "left":(this.clientW()-parseInt($(this.popupEl).css("width")))/2
        }).fadeIn(this.showTime);
    };

    //当初始化或者窗口resize时，重新计算遮罩div的值。
    this.initMask=function(){
        $(this.maskEl).css({
            "top":0,
            "left":0,
            "width":this.clientW(),
            "height":this.clientH()
        }).fadeIn(this.showTime);
    };

    //当不需要弹出层时，将其隐藏掉
    this.closePopup=function(){
        $(this.maskEl).fadeOut(this.hideTime);
        $(this.popupEl).fadeOut(this.hideTime);
    };

    //点击弹框按钮后开始弹出div及遮罩层
    this.PopupMe=function(){
        this.initMask();
        this.initPopup();
    };

    //重置所有的样式及位置
    this.resizeAll=function(){
        if($(this.popupEl).css("display")!="none"){
            this.initMask();
            this.initPopup();
        }
    };


}
