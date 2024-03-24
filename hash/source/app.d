import std.stdio;
import std.digest.sha;
import std.file;
import std.ascii: LetterCase;

// This program emulates the utility sha256 of coreutils

string hash256_of_file(string file_name)
{
	ubyte[] content = cast(ubyte[]) read(file_name);
    auto sha256 = new SHA256Digest();
	ubyte[] hash256 = sha256.digest(content);
    string result= toHexString!(Order.increasing,LetterCase.lower)(hash256);
	return result;
}

void main(string[] args)
{
	foreach(i,arg;args)
		if (i>0)
			writeln(hash256_of_file(arg)," ",arg);
}
