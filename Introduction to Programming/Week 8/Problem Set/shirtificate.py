from fpdf import FPDF


def main():
    name = input("Name: ")

    pdf = FPDF(orientation="portrait", format="A4")
    pdf.add_page()

    pdf.set_font("helvetica", size=50)
    pdf.text(45, 45, "CS50 Shirtificate")

    pdf.image("shirtificate.png", 10, 65, 190, 190)

    pdf.set_font("helvetica", size=30)
    pdf.set_text_color(255, 255, 255)
    pdf.text(50, 140, f"{name} took CS50")

    pdf.output("shirtificate.pdf")



if __name__ == "__main__":
    main()