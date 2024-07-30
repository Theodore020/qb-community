//防抖函数
function debounce(fn,wait){
    let timerId = null;
    return function(...args){
        if(timerId){
            clearTimeout(timerId);
        }
        timerId = setTimeout(()=>{
            fn.apply(this,args);
        },wait);
    }
}

export default debounce;
