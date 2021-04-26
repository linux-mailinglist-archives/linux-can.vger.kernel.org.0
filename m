Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED036B362
	for <lists+linux-can@lfdr.de>; Mon, 26 Apr 2021 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhDZMrJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Apr 2021 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhDZMrI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Apr 2021 08:47:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5CC061756
        for <linux-can@vger.kernel.org>; Mon, 26 Apr 2021 05:46:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lb0d1-00016f-SD; Mon, 26 Apr 2021 14:46:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5abc:85dd:13f5:c6cb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6E3FE617338;
        Mon, 26 Apr 2021 12:24:51 +0000 (UTC)
Date:   Mon, 26 Apr 2021 14:24:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     wg@grandegger.com, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: softing: Remove redundant variable ptr
Message-ID: <20210426122450.v2qxdxjk52d5dh6o@pengutronix.de>
References: <1619431696-81853-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wznd2aj2syrjztbm"
Content-Disposition: inline
In-Reply-To: <1619431696-81853-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wznd2aj2syrjztbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.04.2021 18:08:16, Jiapeng Chong wrote:
> Variable ptr is being assigned a value from a calculation
> however the variable is never read,=20
                       ^^^^^^^^^^^^^

This is not 100% correct.

The variable ptr is read from, see a line directly above the line this
patch removes.

> so this redundant variable can be removed.

This patch doesn't remove the variable.

> Cleans up the following clang-analyzer warning:
>=20
> drivers/net/can/softing/softing_main.c:279:3: warning: Value stored to
> 'ptr' is never read [clang-analyzer-deadcode.DeadStores].
>=20
> drivers/net/can/softing/softing_main.c:242:3: warning: Value stored to
> 'ptr' is never read [clang-analyzer-deadcode.DeadStores].

The clang warning is more precise: the value stored to ptr in the
calculations this patch removes is not used, so the calculation and the
assignment can be removed.

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/can/softing/softing_main.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/sof=
ting/softing_main.c
> index c44f341..cfc1325 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -239,7 +239,6 @@ static int softing_handle_1(struct softing *card)
>  				DPRAM_INFO_BUSSTATE2 : DPRAM_INFO_BUSSTATE]);
>  		/* timestamp */
>  		tmp_u32 =3D le32_to_cpup((void *)ptr);
> -		ptr +=3D 4;
>  		ktime =3D softing_raw2ktime(card, tmp_u32);
> =20
>  		++netdev->stats.rx_errors;
> @@ -276,7 +275,6 @@ static int softing_handle_1(struct softing *card)
>  		ktime =3D softing_raw2ktime(card, tmp_u32);
>  		if (!(msg.can_id & CAN_RTR_FLAG))
>  			memcpy(&msg.data[0], ptr, 8);
> -		ptr +=3D 8;
>  		/* update socket */
>  		if (cmd & CMD_ACK) {
>  			/* acknowledge, was tx msg */
> --=20
> 1.8.3.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wznd2aj2syrjztbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCGsQ8ACgkQqclaivrt
76m4dwf+LEypbHlRV8Ln+xlJLnusE+7XBn4eX8MHwGCBJibJYNkhlDUd2+PpoeZ8
8UrAn5XQ8kwJisLJpxsftSUjInkIX4EZXUgJ1i6hVa/haYQbo7XYFD53kKH2WIJ6
4/XpYVfaJmei5D3NeBzC58uqE2TWaL5h9HSCHv+zoJAuJft7MPTQ3ZTFoDHmHulF
jATg5YS4m9nxYczQBk0WAmvT8QRQ3WWlZ5msG/PzY5Jg1pQEMTReRomhkpJXlDVy
v87lBV8bjyTnIhtpxbwBOdq9v6fZ8NqlwErC003ITHVr4ZBk25mhk2u6DBMVO1GW
y5jseqRG0gOPh81zxKmDF310SUP+2g==
=hxzG
-----END PGP SIGNATURE-----

--wznd2aj2syrjztbm--
