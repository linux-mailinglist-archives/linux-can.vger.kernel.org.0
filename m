Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69534CC61
	for <lists+linux-can@lfdr.de>; Mon, 29 Mar 2021 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhC2JBe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Mar 2021 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhC2I7h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Mar 2021 04:59:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C759C061574
        for <linux-can@vger.kernel.org>; Mon, 29 Mar 2021 01:59:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lQnkB-0004PO-1y
        for linux-can@vger.kernel.org; Mon, 29 Mar 2021 10:59:31 +0200
Received: from [IPv6:2a03:f580:87bc:d400:44b9:f06e:1c40:69b1] (unknown [IPv6:2a03:f580:87bc:d400:44b9:f06e:1c40:69b1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0DA87602D41
        for <linux-can@vger.kernel.org>; Mon, 29 Mar 2021 08:59:29 +0000 (UTC)
Date:   Mon, 29 Mar 2021 08:48:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2267:16: warning:
 taking address of packed member 'hw_tx_obj' of class or structure
 'mcp251xfd_tx_obj_load_buf::(anonymous)' may result in an unaligned pointer
 value
Message-ID: <20210329064850.vh7rlwh7oapjqucj@pengutronix.de>
References: <202103271812.xDwl25lD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="llupkarg5grkzwxh"
Content-Disposition: inline
In-Reply-To: <202103271812.xDwl25lD-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--llupkarg5grkzwxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.03.2021 18:16:14, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   0f4498cef9f5cd18d7c6639a2a902ec1edc5be4e
> commit: eb79a267c9b3e608e7762a1b221428f37ace3aa3 can: mcp251xfd: rename a=
ll remaining occurrence to mcp251xfd
> date:   6 months ago
> config: mips-randconfig-r035-20210327 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d50f=
e9f0d6b9ee61df8830a67ea0a33c27a637e7)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Deb79a267c9b3e608e7762a1b221428f37ace3aa3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout eb79a267c9b3e608e7762a1b221428f37ace3aa3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Dmips=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):

[...]

> >> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2267:16: warning: takin=
g address of packed member 'hw_tx_obj' of class or structure 'mcp251xfd_tx_=
obj_load_buf::(anonymous)' may result in an unaligned pointer value [-Waddr=
ess-of-packed-member]
>                    hw_tx_obj =3D &load_buf->crc.hw_tx_obj;
>                                 ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2269:16: warning: takin=
g address of packed member 'hw_tx_obj' of class or structure 'mcp251xfd_tx_=
obj_load_buf::(anonymous)' may result in an unaligned pointer value [-Waddr=
ess-of-packed-member]
>                    hw_tx_obj =3D &load_buf->nocrc.hw_tx_obj;
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>    4 warnings and 1 error generated.

That warning is technically correct, hw_tx_obj is an unaligned pointer in
the first warning, but...

> vim +2267 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>=20
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2215  static void
> eb79a267c9b3e6 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c Marc Kleine=
-Budde 2020-09-30  2216  mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_p=
riv *priv,
> eb79a267c9b3e6 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c Marc Kleine=
-Budde 2020-09-30  2217  			  struct mcp251xfd_tx_obj *tx_obj,
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2218  			  const struct sk_buff *skb,
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2219  			  unsigned int seq)
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2220  {
[...]
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2265  	load_buf =3D &tx_obj->buf;
> eb79a267c9b3e6 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c Marc Kleine=
-Budde 2020-09-30  2266  	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_C=
RC_TX)
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18 @2267  		hw_tx_obj =3D &load_buf->crc.hw_tx_obj;
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2268  	else
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2269  		hw_tx_obj =3D &load_buf->nocrc.hw_tx_obj;
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2270 =20
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2271  	put_unaligned_le32(id, &hw_tx_obj->id);
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2272  	put_unaligned_le32(flags, &hw_tx_obj->flags);
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2273 =20
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2274  	/* Clear data at end of CAN frame */
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2275  	offset =3D round_down(cfd->len, sizeof(u32));
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2276  	len =3D round_up(can_dlc2len(dlc), sizeof(u32)) -=
 offset;
> eb79a267c9b3e6 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c Marc Kleine=
-Budde 2020-09-30  2277  	if (MCP251XFD_SANITIZE_CAN && len)
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2278  		memset(hw_tx_obj->data + offset, 0x0, len);
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2279  	memcpy(hw_tx_obj->data, cfd->data, cfd->len);

=2E..it's only accessed via put_unaligned_* and memset()/memcpy().

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--llupkarg5grkzwxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBheE8ACgkQqclaivrt
76mb/ggAialDT5Q0UmXvRXviok/u+ts9aKl88dZGDQGiTbj0pgWdC1XGgfaJfF7g
sQEYSG7g9ogJP3hgFMx4NrtWEG24GPDFK7UzHp6adWsyKnAs6vopnO/Q0GZ4fNti
ZpUL1sPkOgsoblQPQCcj6OQX43wTW+n+QM14/6lZovYO5WrClaXwRROH+zeWvsCH
ENfZ4GhnGPkRHOqRh5hPBUIEhwrhfCAuyqn9OtshBfGw9hVkp5WliVkztej8e0OU
O7TbswKA9vbEq7ftxKxiZNFXEPaNUiwxy+yB6Gz2TffkDRfW3sSqDjS51+OYPkha
HEarrb0BuRtbHxDnLb5lnENlyLssLA==
=k7CE
-----END PGP SIGNATURE-----

--llupkarg5grkzwxh--
