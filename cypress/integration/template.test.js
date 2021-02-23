/// <reference types="cypress" />

context("Test template", () => {  
  it("Action buttons disabled when form is invalid", () => {
    cy.visit("/auth/admin/");

    cy.get(".pf-c-login__footer").contains("This is placeholder text only. Use this area to place any information or introductory message about your application that may be relevant to users.")    
  });
});
