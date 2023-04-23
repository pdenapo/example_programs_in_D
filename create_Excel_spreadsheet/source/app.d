//import std.stdio;
import libxlsxd;

void main()
{
	/* Create a new workbook and add a worksheet.
	Workbook is RefCounted and will write the file
	when it is released.
	*/
	auto workbook = newWorkbook("demo.xlsx");
	auto worksheet = workbook.addWorksheet(null);

	/* Add a format. */
	auto format = workbook.addFormat();

	/* Set the bold property for the format */
	format.setBold();

	/* Change the column width for clarity. */
	worksheet.setColumn(0, 0, 20);

	/* Text with formatting. */
	worksheet.writeString(0, 0, "X", format);
	worksheet.writeString(0, 1, "Y", format);

	for (uint x = 0; x < 10; x++)
	{
		uint y = 2 * x;
		uint fila = x + 1;
		worksheet.writeNumber(fila, 0, double(x));
		worksheet.writeNumber(fila, 1, double(y));
	}
}
