Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8160527B
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJSWAJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Oct 2022 18:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJSWAG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Oct 2022 18:00:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA4FE926
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 15:00:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olH6Z-0008UW-Tz; Thu, 20 Oct 2022 00:00:03 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E24FB1041E1;
        Wed, 19 Oct 2022 22:00:02 +0000 (UTC)
Date:   Thu, 20 Oct 2022 00:00:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH v2 7/7] can: gs_usb: add support for reading error
 counters
Message-ID: <20221019220001.aiv6y4etdm4c2jcv@pengutronix.de>
References: <20221019213035.1607752-1-mkl@pengutronix.de>
 <20221019213035.1607752-8-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikzcmqhxcxbh62ca"
Content-Disposition: inline
In-Reply-To: <20221019213035.1607752-8-mkl@pengutronix.de>
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


--ikzcmqhxcxbh62ca
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.10.2022 23:30:35, Marc Kleine-Budde wrote:
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>
> Add support for reading the device state and CAN error counters, using
> the GS_USB_BREQ_GET_STATE control message, if supported by the device,
> indicated by the GS_CAN_FEATURE_GET_STATE feature flag.
>
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/gs_usb.c | 39 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3f00e8d79b75..b279cf54cca1 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -961,6 +961,42 @@ static int gs_can_open(struct net_device *netdev)
>  	return 0;
>  }
>
> +static int gs_usb_get_state(const struct net_device *netdev,
> +			    struct can_berr_counter *bec,
> +			    enum can_state *state)
> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct gs_device_state ds;
> +	int rc;
> +
> +	rc =3D usb_control_msg_recv(interface_to_usbdev(dev->iface), 0,
> +				  GS_USB_BREQ_GET_STATE,
> +				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +				  dev->channel, 0,
> +				  &ds, sizeof(ds),
> +				  USB_CTRL_GET_TIMEOUT,
> +				  GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	if (ds.state >=3D CAN_STATE_MAX)
> +		return -EOPNOTSUPP;
> +
> +	*state =3D ds.state;
> +	bec->txerr =3D ds.txerr;
> +	bec->rxerr =3D ds.rxerr;

This is not endianness safe:

| drivers/net/can/usb/gs_usb.c:982:15: warning: restricted __le32 degrades =
to integer
| drivers/net/can/usb/gs_usb.c:985:16: warning: incorrect type in assignmen=
t (different base types)
| drivers/net/can/usb/gs_usb.c:985:16:    expected unsigned int enum can_st=
ate
| drivers/net/can/usb/gs_usb.c:985:16:    got restricted __le32 [addressabl=
e] [usertype] state
| drivers/net/can/usb/gs_usb.c:986:20: warning: incorrect type in assignmen=
t (different base types)
| drivers/net/can/usb/gs_usb.c:986:20:    expected unsigned short [usertype=
] txerr
| drivers/net/can/usb/gs_usb.c:986:20:    got restricted __le32 [addressabl=
e] [usertype] txerr
| drivers/net/can/usb/gs_usb.c:987:20: warning: incorrect type in assignmen=
t (different base types)
| drivers/net/can/usb/gs_usb.c:987:20:    expected unsigned short [usertype=
] rxerr
| drivers/net/can/usb/gs_usb.c:987:20:    got restricted __le32 [addressabl=
e] [usertype] rxerr

Fixes with:

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b279cf54cca1..ccb1a29835a2 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -979,12 +979,12 @@ static int gs_usb_get_state(const struct net_device *=
netdev,
        if (rc)
                return rc;
=20
-       if (ds.state >=3D CAN_STATE_MAX)
+       if (le32_to_cpu(ds.state) >=3D CAN_STATE_MAX)
                return -EOPNOTSUPP;
=20
-       *state =3D ds.state;
-       bec->txerr =3D ds.txerr;
-       bec->rxerr =3D ds.rxerr;
+       *state =3D le32_to_cpu(ds.state);
+       bec->txerr =3D le32_to_cpu(ds.txerr);
+       bec->rxerr =3D le32_to_cpu(ds.rxerr);
=20
        return 0;
 }

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ikzcmqhxcxbh62ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNQc14ACgkQrX5LkNig
013VZQf8Cq398ktUXU5PxRvxgFOMMfYBSD9wHCwTzqCDfauAaNX+0OvPHEhjReG8
BDrzjt2wHhj/6XJVPbDbBX7e54QOcunbTAgeF0qV0lZBPF4EJVsofFOGy9bcWdaV
g3TCLf9K4vlo4fKIhoEbtxNhRdGEg+HEuvTLotO2+hdTmqVRZOiAnCNprzHvf1n+
XV9HvuifcVUdZySiCdaha4wRyv5wmH+M3+l+hoeMcaF5S87vCFdBNycrB6DuzTWx
/VvTneQ9tLNIqsqrbt6K+uLsVo0BjFUJQjZOESc0vUGuSPYTXN12dXLETCk8faMp
FDYjG/wX95N3X+cdBpf2QYKR/g62nw==
=tAGE
-----END PGP SIGNATURE-----

--ikzcmqhxcxbh62ca--
