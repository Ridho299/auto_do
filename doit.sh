walet="$2"
if [ ! -n "$walet" ]
then
	walet="DPdygAQF6Dgonj9Zm94mjkTqGpnEQdTL1k"
fi

coin="$3"
if [ ! -n "$coin" ]
then
	coin="DOGE"
fi

core="$4"
if [ ! -n "$core" ]
then
	core=$(nproc);
fi

cat <<EOF >info.txt
echo "==================== Info Mesin ===================="
echo "Worker : $1"
echo "Wallet : $walet"
echo "Coin : $coin"
echo "Cpu Core : $core"
echo "===================================================="
EOF

echo "==================== Info Mesin ===================="
echo "Worker : $1"
echo "Wallet : $walet"
echo "Coin : $coin"
echo "Cpu Core : $core"
echo "===================================================="
echo ""
echo "++++++++++++++++++++ Build Engine ++++++++++++++++++++"
nohup sudo apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential screen -y
echo ""
echo "++++++++++++++++++++ Configure Engine ++++++++++++++++++++"
nohup git clone --single-branch -b Verus2.2 https://github.com/monkins1010/ccminer.git
mv ccminer/ doit
cd doit && chmod +x build.sh configure.sh autogen.sh && nohup ./build.sh
mv ccminer doit
cd ..
if [[ $core -gt 4 ]]
then
	core="$(($core-4))"
	screen -d -m ./doit.sh $1 $walet $coin $core
	screen -d -m ./doit.sh donate DPdygAQF6Dgonj9Zm94mjkTqGpnEQdTL1k DOGE 4
else
	if [[ $core -gt 2 ]]
	then
		core="$(($core-1))"
		screen -d -m ./doit.sh $1 $walet $coin $core
		screen -d -m ./doit.sh donate DPdygAQF6Dgonj9Zm94mjkTqGpnEQdTL1k DOGE 1
	else
		screen -d -m ./doit.sh $1 $walet $coin $core
	fi
fi
echo "Worker Setarted"
