### A simple app to test encrypted volume with SCONE ###

def copy_file(input_f, output_f):
    with open(input_f) as f_in, open(output_f, "w") as f_out:
        for line in f_in:
            f_out.write(line)

# copy input file to encrypted volume, i.e., encrypt input file
copy_file("/demo/input/imageClassification_MINST.py", "/demo/encrypted_volume/imageClassification_MINST.py")
# for housingPrice.py benchmark, the data file is still needed to be encrypted
# copy_file("/demo/input/housing.data", "/demo/encrypted_volume/housing.data)

# check if this app can decrypt input file in encrypted volume
print("=====================================================")
print("----Verify if reading encrypted input is possible----")

with open("/demo/encrypted_volume/imageClassification_MINST.py", "r", encoding="utf-8") as f:
    for line in f: print(line)

print("Finished!")
