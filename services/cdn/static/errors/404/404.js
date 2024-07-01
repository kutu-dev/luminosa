const errorNumber = document.getElementById("errorNumber")
const goBackHomeText = document.getElementById("goBackHomeText")

let animationActivated = false

goBackHomeText.addEventListener("mouseover", event => {
    if (animationActivated === true) {
        return;
    }

    animationActivated = true
    let textRenewed = false

    const intervalId = setInterval(() => {
        if (errorNumber.textContent.length === 0 && textRenewed === false) {
            textRenewed = true;
            return;
        }

        if (errorNumber.textContent === "117") {
            clearInterval(intervalId);
            return;
        }

        if (textRenewed === true && errorNumber.textContent.length < 3) {
            errorNumber.textContent = errorNumber.textContent + "117"[errorNumber.textContent.length]
            return;
        }

        errorNumber.textContent = errorNumber.textContent.substring(0, errorNumber.textContent.length - 1);
    }, 100)
})
