Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69703E8AFB
	for <lists+linux-can@lfdr.de>; Wed, 11 Aug 2021 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhHKHXx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Aug 2021 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbhHKHXw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Aug 2021 03:23:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E9CC061765
        for <linux-can@vger.kernel.org>; Wed, 11 Aug 2021 00:23:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mDia9-0004XU-P4; Wed, 11 Aug 2021 09:23:21 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:bfe1:82c1:2f09:1ec3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 24CB8665030;
        Wed, 11 Aug 2021 07:23:18 +0000 (UTC)
Date:   Wed, 11 Aug 2021 09:23:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, socketcan@esd.eu,
        Stefan M??tje <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH v3] mailmap: update email address of Matthias Fuchs and
 Thomas K??rper
Message-ID: <20210811072317.tzyjm3p3m3u3b42n@pengutronix.de>
References: <20210809175843.207864-1-mkl@pengutronix.de>
 <YRNvhNtdzUA2NZZX@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vc5ulvgz6s6ff7ya"
Content-Disposition: inline
In-Reply-To: <YRNvhNtdzUA2NZZX@infradead.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vc5ulvgz6s6ff7ya
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.08.2021 07:34:44, Christoph Hellwig wrote:
> I do not think that this is proper use of .mailcap, which should
> redirect email to person from one address to another.  What you do
> is hijack mail to be sent to one person to a set of others.

With the patch applied, but "%ae" ignores the .mailmap:

| $ git log --author=3D"esd.eu" --format=3D"%aN <%ae> -- %h %s" drivers/net=
/can
| Stefan M=C3=A4tje <Stefan.Maetje@esd.eu> -- 396b3cedc9cf can: drivers: ad=
d len8_dlc support for esd_usb2 CAN adapter
| Stefan M=C3=A4tje <Stefan.Maetje@esd.eu> -- 72d92e865d15 can: esd_usb2: F=
ix can_dlc value for received RTR, frames
| Thomas K=C3=B6rper <thomas.koerper@esd.eu> -- 6d5a7a65a928 can: esd_usb2:=
 Fix sparse warnings
| Thomas K=C3=B6rper <thomas.koerper@esd.eu> -- 5247a589c240 can: dev: avoi=
d calling kfree_skb() from interrupt context
| Matthias Fuchs <matthias.fuchs@esd.eu> -- 7653ebd5f6a4 can: usb: esd_usb2=
: Add support for CAN-USB/Micro
| Matthias Fuchs <matthias.fuchs@esd.eu> -- a5f8f0e1a570 can: usb: esd_usb2=
: Add support for listen-only mode
| Matthias Fuchs <matthias.fuchs@esd.eu> -- 96d8e90382dc can: Add driver fo=
r esd CAN-USB/2 device
| Matthias Fuchs <matthias.fuchs@esd.eu> -- 82e381775f6d can: Add esd board=
 support to plx_pci CAN driver

=2E.."%aE" respects .mailmap:

| $ git log --author=3D"esd.eu" --format=3D"%aN <%aE> -- %h %s" drivers/net=
/can
| Stefan M=C3=A4tje <Stefan.Maetje@esd.eu> -- 396b3cedc9cf can: drivers: ad=
d len8_dlc support for esd_usb2 CAN adapter
| Stefan M=C3=A4tje <Stefan.Maetje@esd.eu> -- 72d92e865d15 can: esd_usb2: F=
ix can_dlc value for received RTR, frames
| Thomas K=C3=B6rper <socketcan@esd.eu> -- 6d5a7a65a928 can: esd_usb2: Fix =
sparse warnings
| Thomas K=C3=B6rper <socketcan@esd.eu> -- 5247a589c240 can: dev: avoid cal=
ling kfree_skb() from interrupt context
| Matthias Fuchs <socketcan@esd.eu> -- 7653ebd5f6a4 can: usb: esd_usb2: Add=
 support for CAN-USB/Micro
| Matthias Fuchs <socketcan@esd.eu> -- a5f8f0e1a570 can: usb: esd_usb2: Add=
 support for listen-only mode
| Matthias Fuchs <socketcan@esd.eu> -- 96d8e90382dc can: Add driver for esd=
 CAN-USB/2 device
| Matthias Fuchs <socketcan@esd.eu> -- 82e381775f6d can: Add esd board supp=
ort to plx_pci CAN driver

With this patch the non-working email addresses of Thomas and Matthias
are mapped to the role account socketcan@e.u. The address of Stefan is
unaffected.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vc5ulvgz6s6ff7ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmETeuIACgkQqclaivrt
76lFnAf/fgll5+cnquZ+kcTl3RO3kX5rDC2mn2q3vDQnoW/EToG0yvKrqcBQ3TER
Dh5ww06MPt5Zxu191rA9qQ0YlMn4dbcGkX4U5+SLPuXGWrRvGEVfAWdnzseejmqW
hH0P+HBuSwW+yO/tucNKBbKGCHAdelVZcgo0Bn7TOm6FpGCRyrmudU9oCtENITev
eYYCmm4TC/GLryE+7wN8NoMJRO8r+jNMTVE4erguNAf9/4TBg8PMWs3c4xmN6QzF
1uRMSBIJF5DX9VsPjfo1X98w3xjQHJtDi2iNvk9/575L3AVsO3bFzwhYT/kJyzf1
yM8Z1FzeVxvaMo+iDjXEbbT07aAopw==
=6ywX
-----END PGP SIGNATURE-----

--vc5ulvgz6s6ff7ya--
