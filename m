Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3129F37A4B7
	for <lists+linux-can@lfdr.de>; Tue, 11 May 2021 12:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEKKkQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 May 2021 06:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhEKKkQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 May 2021 06:40:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D11C061574
        for <linux-can@vger.kernel.org>; Tue, 11 May 2021 03:39:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lgPnA-0004gx-2X; Tue, 11 May 2021 12:39:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:9fa4:6162:2385:92e7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 921EF62211A;
        Tue, 11 May 2021 10:39:06 +0000 (UTC)
Date:   Tue, 11 May 2021 12:39:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: Re: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Message-ID: <20210511103905.eniozcfxccgwgirz@pengutronix.de>
References: <20210510182038.1528631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xj27d5dyoi2qojlb"
Content-Disposition: inline
In-Reply-To: <20210510182038.1528631-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xj27d5dyoi2qojlb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.05.2021 20:20:39, Marc Kleine-Budde wrote:
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 61660248c69e..9644c0d85bb6 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -200,6 +200,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev,=
 struct can_frame **cf)
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
>  	can_skb_prv(skb)->skbcnt =3D 0;
> +	can_skb_prv(skb)->flags =3D 0;
> =20
>  	*cf =3D skb_put_zero(skb, sizeof(struct can_frame));
> =20
> @@ -231,6 +232,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *de=
v,
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
>  	can_skb_prv(skb)->skbcnt =3D 0;
> +	can_skb_prv(skb)->flags =3D 0;
> =20
>  	*cfd =3D skb_put_zero(skb, sizeof(struct canfd_frame));
> =20
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index d311bc369a39..24a3e682b4a2 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -51,6 +51,7 @@ struct can_skb_priv {
>  	int ifindex;
>  	int skbcnt;
>  	unsigned int frame_len;
> +	unsigned int flags;
>  	struct can_frame cf[];
>  };
> =20
> @@ -71,9 +72,16 @@ static inline void can_skb_set_owner(struct sk_buff *s=
kb, struct sock *sk)
>  	 * after the last TX skb has been freed). So only increase
>  	 * socket refcount if the refcount is > 0.
>  	 */
> -	if (sk && refcount_inc_not_zero(&sk->sk_refcnt)) {
                  ^^^^^^^^^^^^^^^^^^^^^
> -		skb->destructor =3D sock_efree;
> -		skb->sk =3D sk;

This is the problem:

It was introduced by Oleksij and me in e940e0895a82 ("can: skb:
can_skb_set_owner(): fix ref counting if socket was closed before
setting skb ownership").

In e940e0895a82 we fix the ref counting on the socket problem, as
described in the comment of that patch:

|  static inline void can_skb_set_owner(struct sk_buff *skb, struct sock *s=
k)
|  {
| -       if (sk) {
| -               sock_hold(sk);
| +       /* If the socket has already been closed by user space, the
| +        * refcount may already be 0 (and the socket will be freed
| +        * after the last TX skb has been freed). So only increase
| +        * socket refcount if the refcount is > 0.
| +        */
| +       if (sk && refcount_inc_not_zero(&sk->sk_refcnt)) {
|                 skb->destructor =3D sock_efree;
|                 skb->sk =3D sk;
|         }

We missed the fact that skb->sk is used in raw_rcv() to determine if the
CAN frame was received from outside or it was the echo of a TX skb. As a
workaround/fix I introduced a new variable "flags" to the struct
can_skb_priv and added MSG_DONTROUTE directly there, if a socket was
associated with the skb. I haven't tested what that means for vxcan
devices in network name spaces.

> +	if (sk) {
> +		struct can_skb_priv *skb_priv;
> +
> +		skb_priv =3D can_skb_prv(skb);
> +		skb_priv->flags =3D MSG_DONTROUTE;
> +
> +		if (refcount_inc_not_zero(&sk->sk_refcnt)) {
> +			skb->destructor =3D sock_efree;
> +			skb->sk =3D sk;
> +		}
>  	}
>  }
> =20
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 139d9471ddcf..9bedd0672fae 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -169,7 +169,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>  	/* add CAN specific message flags for raw_recvmsg() */
>  	pflags =3D raw_flags(skb);
>  	*pflags =3D 0;
> -	if (oskb->sk)
> +	if (can_skb_prv(oskb)->flags =3D=3D MSG_DONTROUTE)
>  		*pflags |=3D MSG_DONTROUTE;
>  	if (oskb->sk =3D=3D sk)
>  		*pflags |=3D MSG_CONFIRM;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xj27d5dyoi2qojlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCaXscACgkQqclaivrt
76n2fwf/ShKomB9hi8ysmG8VZsexow8uaDmSbArQILv301Sb9QK9ToUXvZdVk1qr
nb8g2et41BEM6ojx8GnSxec2r5oEeTeWx/XRYxQreKQK65wxQgfbZCywz/4eaSrQ
YWZFi0r57ets7ipoar9miZdDcg0a1XnkPNicfXhb1MJ8CHLUE6QyfKPc2KYB9rW/
faB9i6BKDzVJ3Wp82E6xceaxxbHvhriY6EBKRuQtZjv13Kol+ndIqIl67m9O4ps8
mPX+fE9AOOi7nGfZczV1xdDaWBQ+ZRzr/5gTrdtLslvEMJumgbWYOlwq/sb50zrC
GkpBo1r0GnxJdd+VmrQ2QHL3AzemQA==
=PXKc
-----END PGP SIGNATURE-----

--xj27d5dyoi2qojlb--
