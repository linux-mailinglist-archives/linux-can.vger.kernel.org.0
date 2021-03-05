Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713A332F5E9
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEWaV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 17:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCEWaC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 17:30:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FAC06175F
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 14:30:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIIxM-00006R-77; Fri, 05 Mar 2021 23:30:00 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:b538:dfcc:368f:bb27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2CCB95EEDA8;
        Fri,  5 Mar 2021 22:29:58 +0000 (UTC)
Date:   Fri, 5 Mar 2021 23:29:57 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH 3/3] can: m_can: fix RX path: use rx-offload to ensure
 skbs are sent from softirq context
Message-ID: <20210305222957.elzieau5s6kbdpus@pengutronix.de>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
 <20210305172015.1506525-4-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iuw3k3mel4hri7dd"
Content-Disposition: inline
In-Reply-To: <20210305172015.1506525-4-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--iuw3k3mel4hri7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.03.2021 17:20:15, Torin Cooper-Bennun wrote:
> For peripheral devices, m_can sent skbs directly from a threaded irq
> instead of from a softirq context. This patch transitions the driver to
> use the rx-offload helper, ensuring the skbs are sent from the correct
> context, with h/w timestamping to ensure correct ordering.

I think you beak the non-peripheral drivers here. They already have a
NAPI function m_can_poll(). It makes no sense and doesn't work, if you
do the RX in NAPI and then queue to rx-offload, which then needs to run
=66rom NAPI again. But it cannot as m_can_poll is the NAPI function.

For peripherals it works, as you do the RX in the threaded IRQ, queue to
rx-offload, which then schedules a NAPI, to push the CAN frames into the
networking stack.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--iuw3k3mel4hri7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBCsOIACgkQqclaivrt
76lCTwf+K1DGfrY2e6HM1UF9hRArOZOqVn8qUl8t43NFzDMR9fErEceKckTRxebW
Op/Y1Oslah7a//VHB3LUL6gvoyOMvnW+cavsCp0mnAZgcrao33xBoCSasWiWLen7
OxKAdML67lUB8bjjjsaTpjtumzUd7CRf7VxfNRownwITVxDigGAWtxzARnQvs+p2
685JQjzp5W2juHNIOT8ZkXC1KiXMKlMVpKw58x7oc8kQOIs6mh6941OwXA8qs2ZK
Xm3c27NjJ0DhbawvzDFLQH4NZm+Ti77aydyL9Jz8AaZihbiwaV0fg9lW7uW+P2Ly
mJqY7BT49QsULuO1SIlhO8PsEG39+g==
=6G0h
-----END PGP SIGNATURE-----

--iuw3k3mel4hri7dd--
