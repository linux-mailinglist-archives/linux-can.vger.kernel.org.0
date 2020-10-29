Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1E2A0E5C
	for <lists+linux-can@lfdr.de>; Fri, 30 Oct 2020 20:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3TNn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Oct 2020 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJ3TNm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Oct 2020 15:13:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AAC0613CF
        for <linux-can@vger.kernel.org>; Fri, 30 Oct 2020 12:13:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kYZqE-0003d6-2i
        for linux-can@vger.kernel.org; Fri, 30 Oct 2020 20:13:38 +0100
Received: from [IPv6:2a03:f580:87bc:d400:986b:b1c:42fa:9003] (unknown [IPv6:2a03:f580:87bc:d400:986b:b1c:42fa:9003])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 63B42585FE3
        for <linux-can@vger.kernel.org>; Fri, 30 Oct 2020 19:13:37 +0000 (UTC)
To:     kernel test robot <lkp@intel.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <202010290720.uQ3pTGrT-lkp@intel.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: net/can/isotp.c:1240:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <146bb489-abaf-c763-44b2-ac1200560885@pengutronix.de>
Date:   Thu, 29 Oct 2020 08:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202010290720.uQ3pTGrT-lkp@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EnuOEDQ5JLfKqrBFyQdyqNZnnGzaJz5MN"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EnuOEDQ5JLfKqrBFyQdyqNZnnGzaJz5MN
Content-Type: multipart/mixed; boundary="t7VfLF1HewxOWlyaMFGkwU0oDG4LQZKvD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel test robot <lkp@intel.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <146bb489-abaf-c763-44b2-ac1200560885@pengutronix.de>
Subject: Re: net/can/isotp.c:1240:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
References: <202010290720.uQ3pTGrT-lkp@intel.com>
In-Reply-To: <202010290720.uQ3pTGrT-lkp@intel.com>

--t7VfLF1HewxOWlyaMFGkwU0oDG4LQZKvD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello,

looks like sh is missing the some __user annotations so that sparse spwes=
 these
warnings. Adding sh maintainers to Cc.

regards,
Marc

On 10/29/20 12:01 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> head:   23859ae44402f4d935b9ee548135dd1e65e2cbf4
> commit: e057dd3fc20ffb3d7f150af46542a51b59b90127 can: add ISO 15765-2:2=
016 transport protocol
> date:   3 weeks ago
> config: sh-randconfig-s031-20201028 (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-56-gc09e8239-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3De057dd3fc20ffb3d7f150af46542a51b59b90127
>         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e057dd3fc20ffb3d7f150af46542a51b59b90127
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cr=
oss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dsh=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> "sparse warnings: (new ones prefixed by >>)"
>>> net/can/isotp.c:1240:13: sparse: sparse: incorrect type in initialize=
r (different address spaces) @@     expected int const *__gu_addr @@     =
got int [noderef] __user *optlen @@
>>> net/can/isotp.c:1240:13: sparse:     expected int const *__gu_addr
>>> net/can/isotp.c:1240:13: sparse:     got int [noderef] __user *optlen=

>>> net/can/isotp.c:1240:13: sparse: sparse: incorrect type in argument 1=
 (different address spaces) @@     expected void const volatile [noderef]=
 __user *ptr @@     got int const *__gu_addr @@
>>> net/can/isotp.c:1240:13: sparse:     expected void const volatile [no=
deref] __user *ptr
>>> net/can/isotp.c:1240:13: sparse:     got int const *__gu_addr
>=20
> vim +1240 net/can/isotp.c
>=20
>   1229=09
>   1230	static int isotp_getsockopt(struct socket *sock, int level, int =
optname,
>   1231				    char __user *optval, int __user *optlen)
>   1232	{
>   1233		struct sock *sk =3D sock->sk;
>   1234		struct isotp_sock *so =3D isotp_sk(sk);
>   1235		int len;
>   1236		void *val;
>   1237=09
>   1238		if (level !=3D SOL_CAN_ISOTP)
>   1239			return -EINVAL;
>> 1240		if (get_user(len, optlen))
>   1241			return -EFAULT;
>   1242		if (len < 0)
>   1243			return -EINVAL;
>   1244=09
>   1245		switch (optname) {
>   1246		case CAN_ISOTP_OPTS:
>   1247			len =3D min_t(int, len, sizeof(struct can_isotp_options));
>   1248			val =3D &so->opt;
>   1249			break;
>   1250=09
>   1251		case CAN_ISOTP_RECV_FC:
>   1252			len =3D min_t(int, len, sizeof(struct can_isotp_fc_options));
>   1253			val =3D &so->rxfc;
>   1254			break;
>   1255=09
>   1256		case CAN_ISOTP_TX_STMIN:
>   1257			len =3D min_t(int, len, sizeof(u32));
>   1258			val =3D &so->force_tx_stmin;
>   1259			break;
>   1260=09
>   1261		case CAN_ISOTP_RX_STMIN:
>   1262			len =3D min_t(int, len, sizeof(u32));
>   1263			val =3D &so->force_rx_stmin;
>   1264			break;
>   1265=09
>   1266		case CAN_ISOTP_LL_OPTS:
>   1267			len =3D min_t(int, len, sizeof(struct can_isotp_ll_options));
>   1268			val =3D &so->ll;
>   1269			break;
>   1270=09
>   1271		default:
>   1272			return -ENOPROTOOPT;
>   1273		}
>   1274=09
>   1275		if (put_user(len, optlen))
>   1276			return -EFAULT;
>   1277		if (copy_to_user(optval, val, len))
>   1278			return -EFAULT;
>   1279		return 0;
>   1280	}
>   1281=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20


--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--t7VfLF1HewxOWlyaMFGkwU0oDG4LQZKvD--

--EnuOEDQ5JLfKqrBFyQdyqNZnnGzaJz5MN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+acEYACgkQqclaivrt
76mNpAf9FBBLM4EXuIGTgLEAhNg56ZM5FUm0KDYHPBKozKsSTFvZIgLaWSC3zKdd
+6zcLBI9VBo6ik0vxqzFZt5tGfFQwkoq2ygRFdpA8WpzGJWPQoQf6/HYrIsIQz6f
ak1gLMETbXjJek1jzNPavAm8DTRx0R9DvvLD8/5B5YB71/fqZbwpkpT5AaPT5KrR
DauhOZndlQjtZpzGCvv66qNDR6GiiMX5HAT/NAV85TtgA3k6Uf2ayb9FsoMsDoav
bZb+8EXnojz6KoNZ3/akkrH7Yptrc97G8/jlZnCPaPUUArUfMpyc8iUFQ3agmdwX
bOObo9s2uqiak+8x2w3zRLRTNHlr8w==
=M95h
-----END PGP SIGNATURE-----

--EnuOEDQ5JLfKqrBFyQdyqNZnnGzaJz5MN--
