Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D415E7A73
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 14:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiIWMWI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIWMUW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 08:20:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB11C13EEB8
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 05:11:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1obhWV-0008AL-DE; Fri, 23 Sep 2022 14:11:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E83DFEB19C;
        Fri, 23 Sep 2022 12:11:10 +0000 (UTC)
Date:   Fri, 23 Sep 2022 14:11:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-can@vger.kernel.org,
        Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
Subject: Re: [PATCH v2] can: gs_usb: remove dma allocations
Message-ID: <20220923121110.luq5xwrlflgstlku@pengutronix.de>
References: <20220913204110.89730-1-rhett.aultman@samsara.com>
 <20220920154724.861093-1-rhett.aultman@samsara.com>
 <20220920154724.861093-2-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5fwvbx3ikzkrgr7"
Content-Disposition: inline
In-Reply-To: <20220920154724.861093-2-rhett.aultman@samsara.com>
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


--s5fwvbx3ikzkrgr7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.09.2022 11:47:24, Rhett Aultman wrote:
> From: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
>=20
> DMA allocated buffers are a precious resource. If there is no need for DM=
A=20
> allocations, then it might be worth to use non-dma allocated buffers.=20
> After testing the gs_usb driver with and without DMA allocation, there=20
> does not seem to be a significant change in latency or cpu utilization=20
> either way. Therefore, DMA allocation is not necessary and removed.=20
> Internal buffers used within urbs were managed and freed manually. These=
=20
> buffers are no longer needed to be managed by the driver. The=20
> URB_FREE_BUFFER flag, allows for the buffers in question to=20
> be automatically freed.
>=20
> Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
> Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> Signed-off-by: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--s5fwvbx3ikzkrgr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMtolsACgkQrX5LkNig
013JSQgAierCe62xI1ZgPNyMS8ObpHzvnSW1h5/F4VQYoi6ezoCvyJalF5dxqVvG
ahg6J1UHKLQb9fW5AxnKCpIKbZCnY50k7aIFUZjb8CVAkcAWTTJNXAHrg+l+8/qB
wSeQXpA2g4rC1Vs4UZmsk6VMcbsS+qAYFGKXsXRDfZgKS9rqWaIzzumTLnTyC+3O
HrpMuxV5ueW0FeO17npR+ZinIcT5ZAUcnocRxJqY9IhDEhxwoPve6mAraxrKFraL
IpAAwY80/x+HE3q7PfaLYyqITBvQXh+mgR9ENbL1miVJKBBP4YRxtSAbFOAh71iX
HeS7AneK+bO82qZ+1GbwYMF6AgNBtQ==
=Qqr6
-----END PGP SIGNATURE-----

--s5fwvbx3ikzkrgr7--
