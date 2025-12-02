system_profiler SPHardwareDataType SPDisplaysDataType SPMemoryDataType; echo "cpu: $(sysctl -n machdep.cpu.brand_string)"; echo "Core count: $(sysctl -n machdep.cpu.core_count)"; ioreg -l -r -n AppleSmartBattery | awk '/AppleRawMaxCapacity/{raw=$3} /DesignCapacity/{design=$3} END{printf "The battery wear is: %.2f%%\n", (1 - raw/design) * 100}'; system_profiler SPStorageDataType | grep "Capacity"; open -a Safari "https://everymac.com/ultimate-mac-lookup/?search_keywords=$(system_profiler SPHardwareDataType | awk '/Serial Number/ {print $NF}')";sw_vers; profiles status -type enrollment; open -a "Safari" "https://google.com/search?q=everymac+$(system_profiler SPHardwareDataType | awk -F': ' '/Model Identifier/ {print $2}' | tr ' ' '+')+$(sysctl -n machdep.cpu.brand_string | awk '{print $3, $4}' | tr ' ' '+')+$(echo "scale=2; $(sysctl -n hw.cpufrequency) / 1000000000" | bc)+GHz";open -a "Safari" "https://www.eizo.be/monitor-test/";open -a "Safari" "https://www.onlinemictest.com";

processor_name=$(sysctl -n machdep.cpu.brand_string)

if [[ "$processor_name" == *"Apple M"* ]]; then
    echo "The script to determine COA & MFG does not run on Apple Silicon (M-series) processors. Please use everymac.com to get said information"
    exit 1
fi


serial=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $NF}')

char4=${serial:3:1}

case "$char4" in
    C) year="2020" ;;
    D) year="2020" ;;
    F) year="2021" ;;
    G) year="2021" ;;
    H) year="2012" ;;
    J) year="2012" ;;
    K) year="2013" ;;
    L) year="2013" ;;
    M) year="2014" ;;
    N) year="2014" ;;
    P) year="2015" ;;
    Q) year="2015" ;;
    R) year="2016" ;;
    S) year="2016" ;;
    T) year="2017" ;;
    V) year="2017" ;;
    W) year="2018" ;;
    X) year="2018" ;;
    Y) year="2019" ;;
    Z) year="2019" ;;
    *) year="Unknown" ;;
esac

case "$year" in
    "2020") coa="Catalina (Mac Pro)" ;;
    "2021") coa="Catalina (Mac Pro)" ;;
    "2022") coa="Monterey (Mac Pro)" ;;
    "2023"|"2024"|"2025") coa="Ventura (Mac Pro)" ;;
    "2016"|"2017") coa="Sierra (Mac Pro)" ;;
    "2018"|"2019") coa="High Sierra (Mac Pro)" ;;
    *) coa="Unknown" ;;
esac


echo "The year for serial character '$char4' is: $year"
echo "The COA for year '$year' is: $coa";

softwareupdate -i -a; say "updating now"
--
--
