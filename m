Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E342046D012
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhLHJb1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 04:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHJb0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 04:31:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC09C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 01:27:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mutEu-0004Fx-LL; Wed, 08 Dec 2021 10:27:52 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-e45e-c028-b01c-c307.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e45e:c028:b01c:c307])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 928E56BF9B9;
        Wed,  8 Dec 2021 09:27:51 +0000 (UTC)
Date:   Wed, 8 Dec 2021 10:27:50 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v1 0/5] kvaser_{pciefd,usb} fixes
Message-ID: <20211208092750.mgeve7zlmpmivdnf@pengutronix.de>
References: <20211119131915.2033234-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="66qhts3p4p5rlxil"
Content-Disposition: inline
In-Reply-To: <20211119131915.2033234-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--66qhts3p4p5rlxil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.11.2021 14:19:10, Jimmy Assarsson wrote:
> The first patches fix net_device_stats when receiving error frames.
> The last two patches fix the CAN clock frequency for Kvaser Leaf devices.
>=20
> Note that this series contains patches for both kvaser_usb and
> kvaser_pciefd driver.

What's left of this series, after applying Vincent's stats cleanup [1]
series?

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.=
fr/

Can you send a series only containing the remaining patches?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--66qhts3p4p5rlxil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGwepQACgkQqclaivrt
76mUsAf/QFcFGYCWTF6ZVSqT0xqCbCAHxSX+OYIBT1JXrRmfVuDNqv15o2aF7IZ2
/DrEzFIPbRd+vxazTcv9y6C+2eBatmK2HQwCQzBv8qa2CI6N1XVDM/DyPyQeYs7N
igRFYfQ5dwoLXtxdmLLLMwBTeem84VdUm5q7UwE097XGy2uus5vSzCZ8rDt1aIjf
j0/Otcf4PPQF5uIDdsyri5DgPtgWqRgO545EjtUAADFgN2hSJeXbM8PBJ31sfyDU
vshD+gLV2i71CaYXtWI3fC6BIatscgMGjQbPwGUWPGfycWiFLAl8/VdvJPGvrkib
KtVEV9lcSA7962OaNlDBpWVAW3N3aw==
=1g2m
-----END PGP SIGNATURE-----

--66qhts3p4p5rlxil--
