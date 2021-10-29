Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EEF43FCBB
	for <lists+linux-can@lfdr.de>; Fri, 29 Oct 2021 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhJ2M5E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Oct 2021 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhJ2M5C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Oct 2021 08:57:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2EC061714
        for <linux-can@vger.kernel.org>; Fri, 29 Oct 2021 05:54:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mgROy-0005o5-1Y; Fri, 29 Oct 2021 14:54:32 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-e533-710f-3fbf-10c2.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e533:710f:3fbf:10c2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 468356A0A3D;
        Fri, 29 Oct 2021 12:54:31 +0000 (UTC)
Date:   Fri, 29 Oct 2021 14:54:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [RFC PATCH] can: peak_usb: CANFD: remove unused timestamp
 infrastructure
Message-ID: <20211029125430.joaspidvfkaaxgjf@pengutronix.de>
References: <20211018123203.2234904-1-mkl@pengutronix.de>
 <PA4PR03MB67977F6773983F04C7F0EB5DD6BE9@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwck3sp2pxhxo6ka"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB67977F6773983F04C7F0EB5DD6BE9@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vwck3sp2pxhxo6ka
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.10.2021 07:14:20, St=C3=A9phane Grosjean wrote:
> Nice shot! I confirm that all of this stuff that converted 32 bit
> timestamps into self-made 64 bit ones is now obsolete for the CANFD -
> USB interfaces from PEAK-System. However, note that requesting those
> PCAN_UFD_MSG_CALIBRATION messages is still mandatory to get valid hw
> timestamps from them.

Can you clean up the patch for me, so the device still gives valid
timestamps?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vwck3sp2pxhxo6ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmF77wQACgkQqclaivrt
76nUHAf/TB49AnS3N/yjFgTFXJpz30XMibXnd9mEDHOBAdIVuqLAIEZ0N435Kkb9
ha+hSQrAg7nefLYAKupN8g771m199a/8RDSkoXHHVhOdC3lm4xEpK+go2//zXIQ6
vilqNZ2dAUBiSy2KymtPEpwjydyBTcT1ivQN2rVjTCHusZfbeplQsgh11DHiqmu5
trcJ8f2ZTkdMwlUi3x1i2grJRABPs52Vko2zU8gX++kTK7N+6bFTDxCQNVKGjzpw
zl94KdWbe8KIcmBImg4ZpqE2Ttw+6nXcxnv1effc4fWbGhmN7qLWutdbQv++teuC
1//LWRQTkUfVJa9sT5ZBCDkdVyjZQg==
=j2rk
-----END PGP SIGNATURE-----

--vwck3sp2pxhxo6ka--
