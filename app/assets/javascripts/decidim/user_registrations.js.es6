$(() => {
    const userRegistrationForm = {
        $: $("#register-form"),
        toggleFromSteps: () => {
            $("[form-step]").toggle();
            $("[form-active-step]").toggleClass("step--active");
        },
        scrollTop: () => {
            $("html, body").animate({
                scrollTop: $("main").offset().top
            }, 200);
        },
        errors: {
            display: ($element) => {
                $element.addClass("is-invalid-input");
                $element.parent().addClass("is-invalid-label");
                $element.next("span").addClass("is-visible");
            }
        },
        buttons: {
            $forward: $(".form-step-forward-button"),
            $back: $(".form-step-back-button")
        }
    };

    const formStepsFields = {
        checkMandatoryFields: () => {
            return $.uniqueSort(formStepsFields.filledMandatoryFields().add(
                formStepsFields.password.samePassword()
            ))
        },
        filledMandatoryFields: () => {
            return formStepsFields.first.$mandatoryFields().map((index, element) => {
                if (formStepsFields.emptyOrFalse(element)) {
                    return element;
                }
                return null
            })
        },
        emptyOrFalse: (element) => {
            if ($(element)[0].type === "checkbox") {
                return $(element)[0].checked === false;
            }

            return $(element).val().length === 0;
        },
        first: {
            $: $("[form-step='1'] input"),
            $mandatoryFields: () => {
                return formStepsFields.first.$.not("#registration_user_newsletter").not("input[type ='hidden']").add(formStepsFields.$tosAgreement)
            }
        },
        $second: $("[form-step='2'] input"),
        password: {
            $: $("#registration_user_password"),
            $confirmation: $("#registration_user_password_confirmation"),
            samePassword: () => {
                if (formStepsFields.password.$.val() !== formStepsFields.password.$confirmation.val()) {
                    return formStepsFields.password.$confirmation;
                }
                return null;
            }
        },
        $underage: $("#registration_underage_registration"),
        statutoryRepresentativeEmail: {
            $: $("#statutory_representative_email"),
            toggle: () => {
                if (formStepsFields.$underage.is(":checked")) {
                    formStepsFields.statutoryRepresentativeEmail.$.removeClass("hide");
                    return
                }

                formStepsFields.statutoryRepresentativeEmail.$.addClass("hide");
            },
        },
        newsletter: {
            check: (check, $selector, $modal) => {
                $selector.prop("checked", check);
                $modal.data("continue", true);
                $modal.foundation("close");
                userRegistrationForm.$.submit()
            },
            $: $("input[type='checkbox'][name='user[newsletter]']"),
            selector: "input[type='checkbox'][name='user[newsletter]']",
            $modal: $("#sign-up-newsletter-modal"),
        },
        $userGroup: userRegistrationForm.$.find(".user-group-fields"),
        $tosAgreement: $("#registration_user_tos_agreement"),
        input: {
            selector: "input[name='user[sign_up_as]']",
        },
    };

    // Listen on newsletter checkbox
    formStepsFields.newsletter.$modal.find(".check-newsletter").on("click", (event) => {
        formStepsFields.newsletter.check(
            $(event.target).data("check"),
            formStepsFields.newsletter.$,
            formStepsFields.newsletter.$modal
        )
    });

    // Listen on button 'Continue'
    userRegistrationForm.buttons.$forward.on("click", (event) => {
        event.preventDefault();

        userRegistrationForm.scrollTop();

        // validate only input elements from step 1
        formStepsFields.first.$.each((index, element) => {
            userRegistrationForm.$.foundation("validateInput", $(element))
        });

        if (!userRegistrationForm.$.find("[data-invalid]:visible").length) {
            userRegistrationForm.toggleFromSteps()
        }
    });

    // Listen on button 'Back'
    userRegistrationForm.buttons.$back.on("click", (event) => {
        event.preventDefault();

        userRegistrationForm.scrollTop();
        userRegistrationForm.toggleFromSteps()
    })

    formStepsFields.$underage.on("click", () => {
        formStepsFields.statutoryRepresentativeEmail.toggle()
    });

    formStepsFields.checkMandatoryFields().on("change", (event) => {
        const disableForwardButton = !(formStepsFields.checkMandatoryFields().length === 0)

        if (formStepsFields.emptyOrFalse($(event.target))) {
            userRegistrationForm.errors.display($(event.target));
        }

        userRegistrationForm.buttons.$forward.attr("disabled", disableForwardButton);
    })

    // The rails validations possibly removes the error message of password confirmation field. This solution allows to toggle the span error message of confirmation field when password or confirmation changes
    formStepsFields.password.$confirmation.add(formStepsFields.password.$).on("focusout", () => {
        if (formStepsFields.password.$confirmation.val() !== formStepsFields.password.$.val()) {
            formStepsFields.password.$confirmation.next("span").show()
        } else {
            formStepsFields.password.$confirmation.next("span").hide()
        }
    })

    userRegistrationForm.$.on("submit", (event) => {
        if (!formStepsFields.newsletter.$modal.data("continue")) {
            if (!formStepsFields.newsletter.$.prop("checked")) {
                event.preventDefault();
                formStepsFields.newsletter.$modal.foundation("open")
            }
        }
    });
});
