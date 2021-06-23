/// <reference types="cypress" />

context("Test template", () => {
  it("Action buttons disabled when form is invalid", () => {
    cy.visit("/auth/admin/");

    cy.get(".pf-c-brand").should("have.length", 1);
  });
});
