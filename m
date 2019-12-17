Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09B1122DB5
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfLQN5H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 08:57:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51341 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfLQN5H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 08:57:07 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ihDLV-0007fx-AV; Tue, 17 Dec 2019 14:57:05 +0100
Received: from [IPv6:2a03:f580:87bc:d400:80c5:62b8:1b6b:1f31] (unknown [IPv6:2a03:f580:87bc:d400:80c5:62b8:1b6b:1f31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8BFC3491B3F;
        Tue, 17 Dec 2019 13:57:02 +0000 (UTC)
Subject: Re: [PATCH 09/11] can: c_can: support 64 message objects for D_CAN
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can@vger.kernel.org
Cc:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <1576590786-22075-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <446aa2d9-2310-a423-8aa0-ea17a5303191@pengutronix.de>
Date:   Tue, 17 Dec 2019 14:56:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576590786-22075-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LsyNTioAV6nZgN6W02Q6N95b8TZMKOiAq"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LsyNTioAV6nZgN6W02Q6N95b8TZMKOiAq
Content-Type: multipart/mixed; boundary="42KMXHPyCJrucATG9u9rHrjmpwRcU3cse";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 linux-can@vger.kernel.org
Cc: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
Message-ID: <446aa2d9-2310-a423-8aa0-ea17a5303191@pengutronix.de>
Subject: Re: [PATCH 09/11] can: c_can: support 64 message objects for D_CAN
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <1576590786-22075-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
In-Reply-To: <1576590786-22075-2-git-send-email-dev.kurt@vandijck-laurijssen.be>

--42KMXHPyCJrucATG9u9rHrjmpwRcU3cse
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/17/19 2:53 PM, Kurt Van Dijck wrote:
> From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
>=20
> D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
> However, some CPUs with D_CAN controller have their own limits:
> TI AM335x Sitara CPU, for example, supports max of 64 message objects.
>=20
> This patch extends max D_CAN message objects up to 64.
>=20
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  drivers/net/can/c_can/Kconfig |  1 +
>  drivers/net/can/c_can/c_can.c | 34 ++++++++++++++--------------------
>  drivers/net/can/c_can/c_can.h | 20 ++++++++++++++++----
>  3 files changed, 31 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kcon=
fig
> index b0f206d3..9cd8523 100644
> --- a/drivers/net/can/c_can/Kconfig
> +++ b/drivers/net/can/c_can/Kconfig
> @@ -21,4 +21,5 @@ config CAN_C_CAN_PCI
>  	---help---
>  	  This driver adds support for the C_CAN/D_CAN chips connected
>  	  to the PCI bus.
> +
>  endif
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index cf2d47e..848cc77 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -357,15 +357,6 @@ static void c_can_setup_tx_object(struct net_devic=
e *dev, int iface,
>  	}
>  }
> =20
> -static inline void c_can_activate_all_lower_rx_msg_obj(struct net_devi=
ce *dev,
> -						       int iface)
> -{
> -	int i;
> -
> -	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_MSG_RX_LOW_LAST; i++)=

> -		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
> -}
> -
>  static int c_can_handle_lost_msg_obj(struct net_device *dev,
>  				     int iface, int objno, u32 ctrl)
>  {
> @@ -737,7 +728,12 @@ static void c_can_do_tx(struct net_device *dev)
>  	struct sk_buff *skb;
>  	u8 len;
> =20
> -	clr =3D pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
> +	if (priv->type =3D=3D BOSCH_D_CAN) {
> +		pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
> +	} else {
> +		pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
> +	}
> +	clr =3D pend;
> =20
>  	while ((idx =3D ffs(pend))) {
>  		idx--;
> @@ -847,7 +843,13 @@ static int c_can_read_objects(struct net_device *d=
ev, struct c_can_priv *priv,
> =20
>  static inline u32 c_can_get_pending(struct c_can_priv *priv)
>  {
> -	u32 pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
> +	u32 pend;
> +
> +	if (priv->type =3D=3D BOSCH_D_CAN) {
> +		pend =3D priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
> +	} else {
> +		pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
> +	}
> =20
>  	return pend;
>  }
> @@ -858,8 +860,7 @@ static inline u32 c_can_get_pending(struct c_can_pr=
iv *priv)
>   * c_can core saves a received CAN message into the first free message=

>   * object it finds free (starting with the lowest). Bits NEWDAT and
>   * INTPND are set for this message object indicating that a new messag=
e
> - * has arrived. To work-around this issue, we keep two groups of messa=
ge
> - * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
> + * has arrived.
>   *
>   * We clear the newdat bit right away.
>   *
> @@ -870,13 +871,6 @@ static int c_can_do_rx_poll(struct net_device *dev=
)
>  	struct c_can_priv *priv =3D netdev_priv(dev);
>  	u32 pkts =3D 0, pend =3D 0, toread, n;
> =20
> -	/*
> -	 * It is faster to read only one 16bit register. This is only possibl=
e
> -	 * for a maximum number of 16 objects.
> -	 */
> -	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
> -			"Implementation does not support more message objects than 16");
> -
>  	for (;;) {
>  		if (!pend) {
>  			pend =3D c_can_get_pending(priv);
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 8387b3f..24128e7 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -25,9 +25,15 @@
>  #include <linux/can/rx-offload.h>
> =20
>  /* message object split */
> +
> +#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS

There's an ifdef left.

> +#define C_CAN_NO_OF_OBJECTS	64
> +#else
>  #define C_CAN_NO_OF_OBJECTS	32
> -#define C_CAN_MSG_OBJ_RX_NUM	16
> -#define C_CAN_MSG_OBJ_TX_NUM	16
> +#endif
> +
> +#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
> +#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_N=
UM)
> =20
>  #define C_CAN_MSG_OBJ_RX_FIRST	1
>  #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
> @@ -37,9 +43,11 @@
>  #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
>  				C_CAN_MSG_OBJ_TX_NUM - 1)
> =20
> -#define C_CAN_MSG_OBJ_RX_SPLIT	9
> -#define C_CAN_MSG_RX_LOW_LAST	(C_CAN_MSG_OBJ_RX_SPLIT - 1)
> +#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
> +#define RECEIVE_OBJECT_BITS	0xffffffff
> +#else
>  #define RECEIVE_OBJECT_BITS	0x0000ffff
> +#endif
> =20
>  enum reg {
>  	C_CAN_CTRL_REG =3D 0,
> @@ -78,6 +86,8 @@ enum reg {
>  	C_CAN_NEWDAT2_REG,
>  	C_CAN_INTPND1_REG,
>  	C_CAN_INTPND2_REG,
> +	C_CAN_INTPND3_REG,
> +	C_CAN_INTPND4_REG,
>  	C_CAN_MSGVAL1_REG,
>  	C_CAN_MSGVAL2_REG,
>  	C_CAN_FUNCTION_REG,
> @@ -139,6 +149,8 @@ enum reg {
>  	[C_CAN_NEWDAT2_REG]	=3D 0x9E,
>  	[C_CAN_INTPND1_REG]	=3D 0xB0,
>  	[C_CAN_INTPND2_REG]	=3D 0xB2,
> +	[C_CAN_INTPND3_REG]	=3D 0xB4,
> +	[C_CAN_INTPND4_REG]	=3D 0xB6,
>  	[C_CAN_MSGVAL1_REG]	=3D 0xC4,
>  	[C_CAN_MSGVAL2_REG]	=3D 0xC6,
>  	[C_CAN_IF1_COMREQ_REG]	=3D 0x100,
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--42KMXHPyCJrucATG9u9rHrjmpwRcU3cse--

--LsyNTioAV6nZgN6W02Q6N95b8TZMKOiAq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl343qkACgkQWsYho5Hk
nSB9AAf/YRikBFcGXLVmRZVXmWEhzjlRylKPahMhrrAZnM+LOvJNipCGJo+N5z3y
8/7B/p32/eEK1sWVEn2Bhf5608/6p9HCkBFxDTDyKHugfT3KxzYk9Nvkq4SKhF1f
b1ZdpPaJkJUOU3jAxH8+hm9wGlmlplkZ4C6q9ncZUov9QfvKOlaF1A8un53uDPsj
33TAJcqx9OVd9nJsCdVzgB3G4tCfrYFDkdkPMr4AshLADBP9WZVYkdGWoMITqEWI
TqyePoGL92laLcZ4V98eXPWJrg3RVRoVvAmpPOWtWqChLnBR6Sj35AQt3Xni9ha4
hMX7+piDDBHEHWJZ/Lw5PTRfKHTcdw==
=oDOO
-----END PGP SIGNATURE-----

--LsyNTioAV6nZgN6W02Q6N95b8TZMKOiAq--
