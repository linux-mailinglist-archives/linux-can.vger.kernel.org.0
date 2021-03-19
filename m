Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD87341786
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 09:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhCSI3s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 04:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhCSI3b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 04:29:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D7C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 01:29:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNAVe-0005Kp-8Q; Fri, 19 Mar 2021 09:29:30 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 080045FA680;
        Fri, 19 Mar 2021 08:29:28 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:29:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: dev: do not increment rx stats when generating a
 CAN error skb
Message-ID: <20210319082928.jaoxkrswpvdgnaae@pengutronix.de>
References: <20210317085223.91282-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yn4tybc4uwawxbwo"
Content-Disposition: inline
In-Reply-To: <20210317085223.91282-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--yn4tybc4uwawxbwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.03.2021 17:52:23, Vincent Mailhol wrote:
> CAN error skb is an interface specific to socket CAN. The CAN error
> skb does not correspond to any actual CAN frame sent on the wire. Only
> an error flag is transmitted when an error occurs (c.f. ISO 11898-1
> section 10.4.4.2 "Error flag").
>=20
> For this reason, it makes no sense to increment the rx_packets and
> rx_bytes fields of struct net_device_stats.

I think we increment the rx packets and bytes (more or less
consistently) in all drivers for CAN error skbs.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yn4tybc4uwawxbwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUYOUACgkQqclaivrt
76kAbgf6Apjt+iHsPJWf3dnCX0s70xLriIlxR9Xweu5H8SFnGOuGnvhXoaTzxIIY
oqRdaBywqkqoHtAPX7SZX6iqtUQUwKB1hsMNfcbh2gQyPgSXrOsejDObwZpm8kMa
rOWcZJIxrr6RbM50i+Un/eom2qE+B2t3Vdby+RFKZPhCNne5lC5ubHc5dzumE1C3
DjZhILqGPi6Ot/Tp7yGxOHwzw2diDGx0NUaZrjdMLzsP/Bs51Nx6ss32JzzALNuo
7En2sPsz5M5Z6M5gQ5f7syG7B4DgPGdX2IkrVdbbtcmKdnfzJez/rNucpVHaS52s
b6QOWWRQ5f9d+0ExunAGsrBili/7qA==
=WctT
-----END PGP SIGNATURE-----

--yn4tybc4uwawxbwo--
