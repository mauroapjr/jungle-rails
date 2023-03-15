describe('Add product to cart', () => {
  beforeEach(() => {
	  cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Click on the product", () => {
    cy.get(".products article").first().click()
    cy.url().should("include", "/products/2")
  })

  it("Add product to cart", () => {
    cy.contains('My Cart (0)')
    cy.contains("Add").first().click({force: true})
    cy.contains("My Cart (1)")
  })

});