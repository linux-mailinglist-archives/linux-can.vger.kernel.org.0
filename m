Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5642F84FB
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 20:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbhAOTBi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 14:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbhAOTBi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 14:01:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793CC061757
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 11:00:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l0UL7-0002sY-U2; Fri, 15 Jan 2021 20:00:54 +0100
Received: from [IPv6:2a03:f580:87bc:d400:2295:8eab:d63d:3b03] (unknown [IPv6:2a03:f580:87bc:d400:2295:8eab:d63d:3b03])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 228855C4C26;
        Fri, 15 Jan 2021 19:00:52 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de>
 <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de>
 <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
 <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de>
 <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
 <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
Message-ID: <a175e052-b721-54df-812b-9880f78cde9b@pengutronix.de>
Date:   Fri, 15 Jan 2021 20:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4MXMWpflxvyHHTYJ27JG5Z3EEfPOPbFoc"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4MXMWpflxvyHHTYJ27JG5Z3EEfPOPbFoc
Content-Type: multipart/mixed; boundary="vPg2EQeDl3OIjIaPyPWtT5A7KbVIqOgOR";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>,
 Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Jimmy Assarsson <extja@kvaser.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Message-ID: <a175e052-b721-54df-812b-9880f78cde9b@pengutronix.de>
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de>
 <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de>
 <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
 <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de>
 <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
 <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de>
In-Reply-To: <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de>

--vPg2EQeDl3OIjIaPyPWtT5A7KbVIqOgOR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/15/21 7:27 PM, Marc Kleine-Budde wrote:
>>> Option 4:
>>> We can introduce a struct can_bitiming_fd with the first member being=
 the struct
>>> can_bitiming and add tdc related variables after that. This way we ca=
n use the
>>> same function to calculate the bit timing on both CAN and CAN-FD.
>>
>> While option 3 is slightly easier, my preference will go to option 4.
>=20
> We still need the netlink enhancement from option 3.

Just tried option 4.

> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 7faf6a37d5b2..bf2326fe22a1 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -32,6 +32,10 @@ enum can_mode {
>         CAN_MODE_SLEEP
>  };
> =20
> +struct canfd_bittiming {
> +       struct can_bittiming dbt;

tdc to be added here....

> +};
> +
>  /*
>   * CAN common private data
>   */
> @@ -39,7 +43,8 @@ struct can_priv {
>         struct net_device *dev;
>         struct can_device_stats can_stats;
> =20
> -       struct can_bittiming bittiming, data_bittiming;
> +       struct can_bittiming bittiming;
> +       struct canfd_bittiming data_bittiming;
>         const struct can_bittiming_const *bittiming_const,
>                 *data_bittiming_const;
>         const u16 *termination_const;

But I had to add that ".dbt" everywhere....

> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -345,8 +345,8 @@ int open_candev(struct net_device *dev)
> =20
>         /* For CAN FD the data bitrate has to be >=3D the arbitration b=
itrate */
>         if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
> -           (!priv->data_bittiming.bitrate ||
> -            priv->data_bittiming.bitrate < priv->bittiming.bitrate)) {=

> +           (!priv->data_bittiming.dbt.bitrate ||
> +            priv->data_bittiming.dbt.bitrate < priv->bittiming.bitrate=
)) {
>                 netdev_err(dev, "incorrect/missing data bit-timing\n");=

>                 return -EINVAL;
>         }
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlin=
k.c
> index 3ae884cdf677..c8341cbd8a66 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -239,7 +239,7 @@ static size_t can_get_size(const struct net_device =
*dev)
>         size +=3D nla_total_size(sizeof(u32));                    /* IF=
LA_CAN_RESTART_MS */
>         if (priv->do_get_berr_counter)                          /* IFLA=
_CAN_BERR_COUNTER */
>                 size +=3D nla_total_size(sizeof(struct can_berr_counter=
));
> -       if (priv->data_bittiming.bitrate)                       /* IFLA=
_CAN_DATA_BITTIMING */
> +       if (priv->data_bittiming.dbt.bitrate)                   /* IFLA=
_CAN_DATA_BITTIMING */
>                 size +=3D nla_total_size(sizeof(struct can_bittiming));=

>         if (priv->data_bittiming_const)                         /* IFLA=
_CAN_DATA_BITTIMING_CONST */
>                 size +=3D nla_total_size(sizeof(struct can_bittiming_co=
nst));
> @@ -286,7 +286,7 @@ static int can_fill_info(struct sk_buff *skb, const=
 struct net_device *dev)
>              !priv->do_get_berr_counter(dev, &bec) &&
>              nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||=

> =20
> -           (priv->data_bittiming.bitrate &&
> +           (priv->data_bittiming.dbt.bitrate &&
>              nla_put(skb, IFLA_CAN_DATA_BITTIMING,
>                      sizeof(priv->data_bittiming), &priv->data_bittimin=
g)) ||
> =20

And that's not even everything.

I think best it to add a "struct can_tdc" directly to the struct can_priv=
=2E Then
add a netlink interface that returns the existing can_bittiming and the c=
an_tdc,
not as a struct, but each member with a separate tag (or whatever it's ca=
lled).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--vPg2EQeDl3OIjIaPyPWtT5A7KbVIqOgOR--

--4MXMWpflxvyHHTYJ27JG5Z3EEfPOPbFoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAB5mAACgkQqclaivrt
76lDdAf+IYVFDsQfdTuXjBlVC3cYuPPSVOX2mzbmTT58eUGk+sznwqVLfkiwcoyG
N27SILPUEpX3jx5UrBFdXZBwvwNdsjpc9WdTwrqs+4QOMDmDXc6GUeZrCYadGwrS
Mt+05sPEe3LpZjJ+LU0ATo7dd5tGnM1uEwyKkCIc161n4ohOPwfb55Q51G5jrT8m
QXRMM1oSCp2XP/MT3XtmXLHDvu2A64wjy5V5Xr5L3cOXSsWHqjXfYeGOu+MNoooh
iBB3t0iPoOyMRXNRX9seAbu+33goqIhH41/GK7BjNN9Jt/TK+MDzSD8njD0KSmQF
MjjyDN89Klim+/8N3qnY8EjcYunx4w==
=nhj/
-----END PGP SIGNATURE-----

--4MXMWpflxvyHHTYJ27JG5Z3EEfPOPbFoc--
