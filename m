Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095C832D775
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 17:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhCDQME (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 11:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhCDQLg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 11:11:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C060C061574
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 08:10:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHqYw-0007tq-1d; Thu, 04 Mar 2021 17:10:54 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3b3:61f5:ff65:ce3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9B2445EDE1D;
        Thu,  4 Mar 2021 16:10:52 +0000 (UTC)
Date:   Thu, 4 Mar 2021 17:10:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [can-next 6/6] can: mcp251xfd: add HW timestamp to RX, TX and
 error CAN frames
Message-ID: <20210304161051.b3sdma2273yw5aeb@pengutronix.de>
References: <20210304160328.2752293-1-mkl@pengutronix.de>
 <20210304160328.2752293-7-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlcxx6t5x3uvqwva"
Content-Disposition: inline
In-Reply-To: <20210304160328.2752293-7-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wlcxx6t5x3uvqwva
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.03.2021 17:03:28, Marc Kleine-Budde wrote:
> This patch uses the previously added mcp251xfd_skb_set_timestamp()
> function to convert the timestamp done by the CAN controller into a
> proper skb hw timestamp.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 22 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 965f8d82b8a1..24b91a6f380b 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1268,7 +1268,8 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *p=
riv,
>  			   unsigned int *frame_len_ptr)
>  {
>  	struct net_device_stats *stats =3D &priv->ndev->stats;
> -	u32 seq, seq_masked, tef_tail_masked;
> +	struct sk_buff *skb;
> +	u32 seq, seq_masked, tef_tail_masked, tef_tail;
> =20
>  	seq =3D FIELD_GET(MCP251XFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK,
>  			hw_tef_obj->flags);
> @@ -1284,9 +1285,12 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *=
priv,
>  	if (seq_masked !=3D tef_tail_masked)
>  		return mcp251xfd_handle_tefif_recover(priv, seq);
> =20
> +	tef_tail =3D mcp251xfd_get_tef_tail(priv);
> +	skb =3D priv->can.echo_skb[tef_tail];
> +	mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);

Doh! I've send an old patch.

There's a NULL pointer check missing. skb can be NULL.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wlcxx6t5x3uvqwva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBBBocACgkQqclaivrt
76mBHggAjFaikYi8x9Q/khk2YYCPtUFODWHsHgBmy8FFV+nT0mL3XlLOHbce7o8b
9waiIl2WMADrZsv3eSfhPf0JxegRto5v4AWO2pJCIM0dK4YmYhga449KQ95dTAgw
gVYiuG0WSP2jI46WFMNaa91om/rrn5bPbQ6fc7ZCifkOXrEa2ceyXOjevSKWp0l3
iFBr2r8zymfsm19rHHEOp4XffX5dYANArfpI7P1m35wPhLtfyLCp31ivcJ0SKvl7
vyOO9PZv4/9cXxJp1rrxKxbpWO8VhQ/OEuh8Y8wGbwBTpw46hcgBUznrVI7G1voL
xSkbdwlwCcwjqrO9cSTDzjQyeYErpw==
=gcdT
-----END PGP SIGNATURE-----

--wlcxx6t5x3uvqwva--
