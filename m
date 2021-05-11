Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7237A42F
	for <lists+linux-can@lfdr.de>; Tue, 11 May 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhEKKDR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 May 2021 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhEKKDQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 May 2021 06:03:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8467DC061574
        for <linux-can@vger.kernel.org>; Tue, 11 May 2021 03:02:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lgPDN-0008HR-5f; Tue, 11 May 2021 12:02:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:9fa4:6162:2385:92e7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7FE196220A0;
        Tue, 11 May 2021 10:02:08 +0000 (UTC)
Date:   Tue, 11 May 2021 12:02:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Message-ID: <20210511100208.3fhnx32bo4epiwxj@pengutronix.de>
References: <20210510182038.1528631-1-mkl@pengutronix.de>
 <20210511100008.3hpqyhpavsqdvwwe@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7hosofcfl7lfyll"
Content-Disposition: inline
In-Reply-To: <20210511100008.3hpqyhpavsqdvwwe@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--l7hosofcfl7lfyll
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.05.2021 11:00:08, Torin Cooper-Bennun wrote:
> On Mon, May 10, 2021 at 08:20:39PM +0200, Marc Kleine-Budde wrote:
> > Fixes: e940e0895a82 ("can: skb: can_skb_set_owner(): fix ref counting i=
f socket was closed before setting skb ownership")
> > Reported-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Hey Torin,
> >=20
> > this is only compile time tested. Please give it a try.
> >=20
> > regards,
> > Marc
> >=20
> >  drivers/net/can/dev/skb.c |  2 ++
> >  include/linux/can/skb.h   | 14 +++++++++++---
> >  net/can/raw.c             |  2 +-
> >  3 files changed, 14 insertions(+), 4 deletions(-)
>=20
> Thanks Marc, works beautifully here.
>=20
> Tested-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>

\o/ ignore my last mail \o/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--l7hosofcfl7lfyll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCaVh0ACgkQqclaivrt
76nlWgf/SZiuY0ANqMImMy0KNcjxKvQsgE8XJXI532FY9HvRfk8IKs81gFOIv51N
wMuBblhrQgY9NALmKOwofUtaj8fZjdnQpzoiZNgAm4vpeBZ3dBYZHyf0QXwnvccU
X30y5sjA38T3SVLrh8AeD3UwXTl4OnD2lkstiKJjdddhjFjMdVHZ8WeNRq6kDbhP
6kv1nYSy5APtrkiQkFbmhChKzc3xJQUaAGQTzFNhRmkf7cjiB5/il87ms7Oz59Ye
SSyBmLzbxgSvJQJ5TeZQf3CPcGOtBsiLWBL57LXohacgweAZOaVpf1VxLAfVpmBf
+iRivukHnRMs8Ui/RWupUMEmST/J7w==
=U+X7
-----END PGP SIGNATURE-----

--l7hosofcfl7lfyll--
