export function logger(url, status, duration) {

    const writeLog = false;
    if(!writeLog) {
        return;
    }

    // const currentDate = new Date(); 
    // const datetime = ":::: Test time: " + currentDate.getDate() + "/"
    //               + (currentDate.getMonth()+1)  + "/" 
    //               + currentDate.getFullYear() + " @ "  
    //               + currentDate.getHours() + ":"  
    //               + currentDate.getMinutes() + ":" 
    //               + currentDate.getSeconds();
  
    // console.log(datetime)
    console.log(`${url} [Status: ${status}] [Duration: ${duration}]`)
    console.log("=======================================================")
  
}