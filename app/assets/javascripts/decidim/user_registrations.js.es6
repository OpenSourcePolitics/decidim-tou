$(() => {
    const $userRegistrationForm = $("#register-form");
    const $userGroupFields = $userRegistrationForm.find(".user-group-fields");
    const inputSelector = "input[name='user[sign_up_as]']";
    const $formStepForwardButton = $(".form-step-forward-button");
    const $formStepBackButton = $(".form-step-back-button");
    const $formFirstStepFields = $("[form-step='1'] input");
    const $tosAgreement = $("#registration_user_tos_agreement");
    const $mandatoryFormFirstStepFields = $formFirstStepFields.not("#registration_user_newsletter").not("input[type ='hidden']").add($tosAgreement);
    const $userPassword = $("#registration_user_password");
    const $userPasswordConfirmation = $("#registration_user_password_confirmation");
    const $userLivingArea = $("#registration_user_living_area");
    const $city_living_area = $(".city_living_area");
    const $metropolis_living_area = $(".metropolis_living_area");

    const $underageSelector = $("#registration_underage_registration");
    const $statutoryRepresentativeEmailSelector = $("#statutory_representative_email");

    $metropolis_living_area.hide();
    $city_living_area.hide();

    const emailSelectorToggle = () => {
        if ($underageSelector.is(":checked")) {
            $statutoryRepresentativeEmailSelector.removeClass("hide");
        } else {
            $statutoryRepresentativeEmailSelector.addClass("hide");
        }
    };

    if ($underageSelector.is(":checked")) {
        emailSelectorToggle();
    }

    $underageSelector.on("click", () => {
        console.log($statutoryRepresentativeEmailSelector)
        emailSelectorToggle();
    });

    $userLivingArea.on("change", () => {
        if ($userLivingArea.val() === "city") {
            $city_living_area.show();
            $metropolis_living_area.hide();
        } else if ($userLivingArea.val() === "metropolis") {
            $city_living_area.hide();
            $metropolis_living_area.show();
        } else {
            $city_living_area.hide();
            $metropolis_living_area.hide();
        }
    });

    const setGroupFieldsVisibility = (value) => {
        if (value === "user") {
            $userGroupFields.hide();
        } else {
            $userGroupFields.show();
        }
    };

    const toggleFromSteps = () => {
        $("[form-step]").toggle();
        $("[form-active-step]").toggleClass("step--active");
    };

    const scrollToTop = () => {
        $("html, body").animate({
            scrollTop: $("main").offset().top
        }, 200);
    };

    setGroupFieldsVisibility($userRegistrationForm.find(`${inputSelector}:checked`).val());

    $userRegistrationForm.on("change", inputSelector, (event) => {
        const value = event.target.value;

        setGroupFieldsVisibility(value);
    });

    $formStepForwardButton.on("click", (event) => {
        event.preventDefault();

        scrollToTop();

        // validate only input elements from step 1
        $formFirstStepFields.each((index, element) => {
            $userRegistrationForm.foundation("validateInput", $(element));
        });

        if (!$userRegistrationForm.find("[data-invalid]:visible").length) {
            toggleFromSteps();
        }
    });

    $formStepBackButton.on("click", (event) => {
        event.preventDefault();

        scrollToTop();

        toggleFromSteps();
    });

    let fieldEmptyOrFalse = (element) => {
        if ($(element)[0].type === "checkbox") {
            return $(element)[0].checked === false;
        }
        return $(element).val().length === 0;
    };

    let filledMandatoryFormField = () => {
        return $mandatoryFormFirstStepFields.map((index, element) => {
            if (fieldEmptyOrFalse(element)) {
                return element;
            }
            return null
        });
    };

    let samePassword = () => {
        if ($userPassword.val() !== $userPasswordConfirmation.val()) {
            return $userPasswordConfirmation;
        }
        return null;
    };

    const checkMandatoryFormField = () => {
        return $.uniqueSort(filledMandatoryFormField().add(samePassword()))
    };

    const displayError = (element) => {
        $(element).addClass("is-invalid-input");
        $(element).parent().addClass("is-invalid-label");
        $(element).next("span").addClass("is-visible");
    };

    $userRegistrationForm.on("click load change input", () => {
        checkMandatoryFormField().each((index, element) => {
            displayError(element);
        });

        $formStepForwardButton.attr("disabled", (checkMandatoryFormField().length > 0));
    });
});
