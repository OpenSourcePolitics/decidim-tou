value=document.querySelector("#participatory_process_emitter_name_image").value;
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
    if(document.querySelector("#participatory_process_emitter_name_image").value != value){
        document.querySelector(".emitter_name_changed").value = true;
    } else {
        document.querySelector(".emitter_name_changed").value = false;
    }
});
