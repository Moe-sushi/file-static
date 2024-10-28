rm /etc/resolv.conf
echo nameserver 1.1.1.1 > /etc/resolv.conf
echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
apk add wget make clang git xz-dev libintl libbsd-static libsemanage-dev libselinux-utils libselinux-static xz-libs zlib zlib-static libselinux-dev linux-headers libssl3 libbsd libbsd-dev gettext-libs gettext-static gettext-dev gettext python3 build-base openssl-misc openssl-libs-static openssl zlib-dev xz-dev openssl-dev automake libtool bison flex gettext autoconf gettext sqlite sqlite-dev pcre-dev wget texinfo docbook-xsl libxslt docbook2x musl-dev gettext gettext-asprintf gettext-dbg gettext-dev gettext-doc gettext-envsubst gettext-lang gettext-libs gettext-static
apk add upx
mkdir output

git clone https://github.com/file/file
cd file
autoreconf -vif
./configure LDFLAGS="-static -Wl,--gc-sections -ffunction-sections -fdata-sections" --disable-nss --enable-static --disable-shared --disable-liblastlog2
make -j8 LDFLAGS="-all-static -Wl,--gc-sections -ffunction-sections -fdata-sections"
strip src/file
cp src/file ../output/file-static
cp magic/magic.mgc ../output/
cc -static -o file ../file.c
strip file
upx file
cp file ../output/file
cp COPYING ../output/LICENSE-file
cd ..
cd output
tar -cvf ../$(uname -m).tar .
exit 0
