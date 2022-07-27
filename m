Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EAD58282D
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiG0OEh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiG0OEg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 10:04:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E26B03
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 07:04:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGheM-00068f-Hh; Wed, 27 Jul 2022 16:04:34 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AD077BC300;
        Wed, 27 Jul 2022 14:04:33 +0000 (UTC)
Date:   Wed, 27 Jul 2022 16:04:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v6 5/7] can: canxl: update CAN infrastructure for CAN
 XL frames
Message-ID: <20220727140431.55g5aa35rko3vt5q@pengutronix.de>
References: <20220724074402.117394-1-socketcan@hartkopp.net>
 <20220724074402.117394-6-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ylvi2dbkkmnlawo"
Content-Disposition: inline
In-Reply-To: <20220724074402.117394-6-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6ylvi2dbkkmnlawo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.07.2022 09:44:00, Oliver Hartkopp wrote:
> - add new ETH_P_CANXL ethernet protocol type
> - update skb checks for CAN XL
> - add alloc_canxl_skb() which now needs a data length parameter
> - introduce init_can_skb_reserve() to reduce code duplication
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/skb.c     | 72 ++++++++++++++++++++++++++---------
>  include/linux/can/skb.h       | 23 ++++++++++-
>  include/uapi/linux/if_ether.h |  1 +
>  net/can/af_can.c              | 25 +++++++++++-
>  4 files changed, 101 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index ea9ea0128c48..e9e8fcbaa7be 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
[...]
> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> +				struct canxl_frame **cfx,
> +				unsigned int data_len)
> +{
> +	struct sk_buff *skb;
> +
> +	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
> +		goto out_error;
> +
> +	skb =3D netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +			       CANXL_HDR_SIZE + data_len);
> +	if (unlikely(!skb))
> +		goto out_error;
> +
> +	skb->protocol =3D htons(ETH_P_CANXL);
> +	init_can_skb_reserve(skb);
> +	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +
> +	*cfx =3D skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
> +
> +	/* set CAN XL flag and length information by default */
> +	(*cfx)->flags =3D CANXL_XLF;
> +	(*cfx)->len =3D data_len;
> +
> +	return skb;
> +
> +out_error:
> +		*cfx =3D NULL;
> +
> +		return NULL;

Nitpick:
Indent with one tab only here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6ylvi2dbkkmnlawo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLhRewACgkQrX5LkNig
013M3Qf+K+LSlvXN4EZgNAxrokYRWRIqoiqNsuMK/XXUGrJGV3thxROh57Xx88Bv
i9qhAhPRx5oD0Mkz/KjNt36447Dek+M5YmakWLiphLU5EAgkpB6TR+MnsPptrr1r
w784tYY+Kcj9M4u3HzVBxnBqTP4VWoqUeZAOfjLQgvpLuS1J4zQSEzxV8toJDwYs
jH5dV78iOchJe1opr867pYuWSVVfXtCHRVzLZ22xpNj9VEThIHAeqPWJb+ZLyBBi
ZXEfPwlpEJN55C4YooxGO1YezGHTRpC1SzTRi4xDyrOnpg+X6e9cvt9zZC1l6D/n
BSCGYtpBSds9+KVd5qXLIN1ggqIyoA==
=AaGH
-----END PGP SIGNATURE-----

--6ylvi2dbkkmnlawo--
