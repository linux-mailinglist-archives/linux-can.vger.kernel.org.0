Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089FE333BD2
	for <lists+linux-can@lfdr.de>; Wed, 10 Mar 2021 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCJLxJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Mar 2021 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCJLxJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Mar 2021 06:53:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A1C06174A
        for <linux-can@vger.kernel.org>; Wed, 10 Mar 2021 03:53:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJxOl-0000wA-9O; Wed, 10 Mar 2021 12:53:07 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:b198:25bf:9f04:24e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0BB2C5F2895;
        Wed, 10 Mar 2021 11:53:05 +0000 (UTC)
Date:   Wed, 10 Mar 2021 12:53:05 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Message-ID: <20210310115305.firsk4zgacjwgiys@pengutronix.de>
References: <PA4PR03MB6797F23B2236519A345A8C3DD6919@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hqllcnkhtizgzbhc"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB6797F23B2236519A345A8C3DD6919@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hqllcnkhtizgzbhc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.03.2021 11:18:15, St=C3=A9phane Grosjean wrote:
> To complete the open reflection on this subject: to be perfect, the
> echo skb should in fact not be released by the USB write completion
> routine but, like the PCI/PCIe version, on reception in the Rx queue
> of an echo frame to the one written...

If you don't have a TX complete notification, this would be a workaround
to let the TX echo better reflect what's going on on the bus.

> This means :
> 1 - the core of the peak_usb driver has to be deeply modified
> 2 - the rx path of the USB interface will be much more loaded,
>     resulting in a higher CPU load
> 2 - in the case of a one-shot frame, how to manage the fact that this
>     echo frame is never received because the one-shot frame could not
>     be written on the bus? Does this need a garbage collector on the
>     echo skbs?

Yes, you have to free the echo skb in case of a no-send due to one-shot
mode.

Does the HW offer a TX aborted notification?

> Is it worth it?

If you don't have TX complete or TX abort notifications, then it's not
worth it. Better spend time implementing these notifications on the
controller side :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hqllcnkhtizgzbhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBIsx4ACgkQqclaivrt
76lG3ggApYtbq3Maru1DXzetF9hia/256AtCKBIa2KOHDVei8Fr65+izkr08zbrH
YwYsG9t6tHQKpDs/qou8n4IbcubkXS3AiDF+1Jrny2IpQhgJrxfKPYhs95dUIalA
i9ab2+6wu7C0xNcTgQViEY4I2nqhMtS0TfB5IYFnpx08YlqAoZK7egoe/isvSVfa
bRxTg9+XE2WRzRPBgi53St7ga8ouJyc74sleye0PhkDcjX9eKwwO/4ASxwLtLXbQ
NEsNGH3iXxiskDIS7Hd7Noc9Z+Yq0T7HpLvbh6qTI3uLf/uprtRuzBIjJufoPWus
AmbvSE5mRdTSSDBuczLaplF084whgw==
=e9ZL
-----END PGP SIGNATURE-----

--hqllcnkhtizgzbhc--
