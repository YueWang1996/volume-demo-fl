def get_mean_sd(filename):
    batch_size = "0"
    latency = "0"
    l_dict = {}
    mean_dict={}
    with open(filename, "r") as f:
        for line in f.readlines():
            if "batch size" in line:
                batch_size = line.split("size ")[1].split("\n")[0]
            if "===]" in line:
                record = line.split(" ")[3]
                if "ETA" not in record:
                    latency = record.split("s")[0]
                    if (batch_size != "0") and (latency != "0"):
                        print(batch_size, latency)
                        if batch_size in l_dict:
                            l_dict[batch_size].append(float(latency))
                        else:
                            l_dict[batch_size] = [float(latency)]
    for batch_size in l_dict:
        print(batch_size, l_dict[batch_size])
        m = mean(l_dict[batch_size])
        sd = pstdev(l_dict[batch_size])
        mean_dict[batch_size] = (m, sd)

    return mean_dict

epoch_latency = get_mean_sd(latency_cas.log)
print("epoch_latency:", epoch_latency)
