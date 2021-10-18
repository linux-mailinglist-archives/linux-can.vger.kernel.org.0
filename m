Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A00431931
	for <lists+linux-can@lfdr.de>; Mon, 18 Oct 2021 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJRMgf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Oct 2021 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhJRMge (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Oct 2021 08:36:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B310C06161C
        for <linux-can@vger.kernel.org>; Mon, 18 Oct 2021 05:34:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mcRqP-0001Y4-Tw; Mon, 18 Oct 2021 14:34:22 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-c2ef-28ab-e0cd-e8fd.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c2ef:28ab:e0cd:e8fd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 02DA269673A;
        Mon, 18 Oct 2021 12:34:20 +0000 (UTC)
Date:   Mon, 18 Oct 2021 14:34:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: peak_usb: CANFD: store 64-bits hw timestamps
Message-ID: <20211018123420.3gbkmnhybpjo7rxa@pengutronix.de>
References: <20210930094603.23134-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7qqupfo7q64fbvj"
Content-Disposition: inline
In-Reply-To: <20210930094603.23134-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--t7qqupfo7q64fbvj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.09.2021 11:46:03, Stephane Grosjean wrote:
> This patch allows to use the whole 64-bit timestamps received from the
> CAN-FD device (expressed in =C2=B5s) rather than only its low part, in the
> hwtstamp structure of the skb transferred to the network layer, when a
> CAN/CANFD frame has been received.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 11 +++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  9 ++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index e8f43ed90b72..4bb6b9d53df4 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -205,6 +205,17 @@ int peak_usb_netif_rx(struct sk_buff *skb,
>  	return netif_rx(skb);
>  }
> =20
> +/* post received skb with native 64-bit hw timestamp */
> +int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high)
> +{
> +	struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
> +	u64 ns_ts =3D (((u64)ts_high << 32) + ts_low) * NSEC_PER_USEC;
> +
> +	hwts->hwtstamp =3D ns_to_ktime(ns_ts);
> +
> +	return netif_rx(skb);
> +}
> +

Applied to linux-can-next/testing, and I've reformatted the code a bit:

+/* post received skb with native 64-bit hw timestamp */
+int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high)
+{
+       struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
+       u64 ns_ts;
+
+       ns_ts =3D (u64)ts_high << 32 | ts_low;
+       ns_ts *=3D NSEC_PER_USEC;
+       hwts->hwtstamp =3D ns_to_ktime(ns_ts);
+
+       return netif_rx(skb);
+}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--t7qqupfo7q64fbvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFtaccACgkQqclaivrt
76mMdQgAofVJmPjuwXzYxscYXUbdQUyhm+zY+zM4lQr48NoCfy2mK021iH5AWEdf
z7izAkDcHcVz51kZPl/pAdY17IiTEqbxXB6mSN3a0CB8pM4f59T7l9sXuspjFRyi
YC/V89hq61lsE+VALWf2IKcVDzMGctapMtoSgEPRhkWKWXZaNLhMKZGjTku7VEih
jnGfClrN9k0mWXm+0jU4qhysaPfOyUwCeYaxn+n4gYXdl41vAoSjY7uRmJXdL8qr
VqCsKBxvEbmNHYcUY8FeM5DY8hCcSvSyGCifTQAs/y4PnfXDmiwcVJdZxgarqui7
fLKP0bREIUmNDSUlqLYLShzqeeA+Ow==
=bz0Q
-----END PGP SIGNATURE-----

--t7qqupfo7q64fbvj--
