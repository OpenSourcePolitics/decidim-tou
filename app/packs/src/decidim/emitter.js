if(document.querySelector(".select-emitter")){
    document.querySelector(".select-emitter").addEventListener("change", () => {
        let select = document.querySelector(".select-emitter")
        document.querySelector(".select-emitter-image").innerHTML="<img src='"+select.options[select.selectedIndex].dataset.image+"'>";
    });
}
document.querySelector("#participatory_process_emitter_image").addEventListener("input", () => {
    if(document.querySelector("#participatory_process_emitter_image").value != null){
        document.querySelector("#participatory_process_emitter_image").required = true;
        document.querySelector("#participatory_process_emitter_name_image").required = true;
    }
});
document.querySelector("#participatory_process_emitter_name_image").addEventListener("input", () => {
    if(document.querySelector("#participatory_process_emitter_name_image").value != null){
        if(!document.querySelector("#participatory_process_emitter_image + label")){
            document.querySelector("#participatory_process_emitter_image").required = true;
        }
        document.querySelector("#participatory_process_emitter_name_image").required = true;
    }
});