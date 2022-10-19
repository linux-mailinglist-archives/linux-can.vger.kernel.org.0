Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB22605262
	for <lists+linux-can@lfdr.de>; Wed, 19 Oct 2022 23:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJSV6B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Oct 2022 17:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSV56 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Oct 2022 17:57:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EA14139D
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 14:57:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olH4R-00084K-E0; Wed, 19 Oct 2022 23:57:51 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3CD3D1041C8;
        Wed, 19 Oct 2022 21:57:49 +0000 (UTC)
Date:   Wed, 19 Oct 2022 23:57:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH can-next v5 10/11] can: kvaser_usb: Add struct
 kvaser_usb_busparams
Message-ID: <20221019215746.v7xwjt3zlxzdvqw7@pengutronix.de>
References: <20221010185237.319219-1-extja@kvaser.com>
 <20221010185237.319219-11-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flhw25aphi2nkh7i"
Content-Disposition: inline
In-Reply-To: <20221010185237.319219-11-extja@kvaser.com>
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


--flhw25aphi2nkh7i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.10.2022 20:52:36, Jimmy Assarsson wrote:
> Add struct kvaser_usb_busparams containing the busparameters used in
> CMD_{SET,GET}_BUSPARAMS* commands.
>=20
> Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---

[...]

> +struct kvaser_usb_busparams {
> +	__le32 bitrate;
> +	u8 tseg1;
> +	u8 tseg2;
> +	u8 sjw;
> +	u8 nsamples;
> +};

| drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c:169:30: error: field
| busparams within 'struct kvaser_cmd_busparams' is less aligned than
| 'struct kvaser_usb_busparams' and is usually due to 'struct
| kvaser_cmd_busparams' being packed, which can lead to unaligned
| accesses [-Werror,-Wunaligned-access]
|         struct kvaser_usb_busparams busparams;
|                                     ^

Fixed (again) while applying.

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/=
usb/kvaser_usb/kvaser_usb.h
index 8c4c2f00fb9f..ff10b3790d84 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -82,7 +82,7 @@ struct kvaser_usb_busparams {
        u8 tseg2;
        u8 sjw;
        u8 nsamples;
-};
+} __packed;
=20
 struct kvaser_usb {
        struct usb_device *udev;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--flhw25aphi2nkh7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNQctgACgkQrX5LkNig
012F2Af+OkSYujEc2AU9Ag0qCdJKEtk9jrOwkNa6tDi5lqolHK/aVWVyqGRneWAe
EKJPNz5AzCekPjmsvqDl4vPPFerNB2buWCcYO5SrIjU02a6PflgHeew180RbAFR8
3lUg8wwqPqR1Xy/Et1+Gp46qGp2z/TNPPEd9N7eIsyDy+YOyKN74k/piEXTdownt
i0Q2P2wXsmM3V5Gjw7T7K+02MqkmIEwGNDdnDL80SLBQ7TCWX03AejEDtE9U6CNz
CtCn42VZZgZwZT1ZGlPBSDVQBTxCSoo/wrpfXC52k39jj1pRpbvzWyEG3kRFwdkE
GHMkzaQpmwBrtE/dIXZZLpGet7BqUw==
=A8V9
-----END PGP SIGNATURE-----

--flhw25aphi2nkh7i--
