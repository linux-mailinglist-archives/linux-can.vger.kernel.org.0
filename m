Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F8300339
	for <lists+linux-can@lfdr.de>; Fri, 22 Jan 2021 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAVJZZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jan 2021 04:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbhAVJYJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2021 04:24:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A91C06174A
        for <linux-can@vger.kernel.org>; Fri, 22 Jan 2021 01:23:28 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l2sf8-00024C-OF; Fri, 22 Jan 2021 10:23:26 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:aed1:e241:8b32:9cc0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5A76D5CA60B;
        Fri, 22 Jan 2021 09:23:25 +0000 (UTC)
Date:   Fri, 22 Jan 2021 10:23:24 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [5.10 CAN BUG report] kernel dump about echo skb
Message-ID: <20210122092324.fchsd253qnrjxwvr@hardanger.blackshift.org>
References: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <DB8PR04MB679559428DCCA341EE53A6E4E6A00@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <CAMZ6RqLuL_BzQisQ0kGEnj7zPTe3iKnsd6n2ivZQ+bPnZW_VhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="smtmghljxgzh4dot"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLuL_BzQisQ0kGEnj7zPTe3iKnsd6n2ivZQ+bPnZW_VhA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--smtmghljxgzh4dot
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 06:08:18PM +0900, Vincent MAILHOL wrote:
> > > 1. Kernel dump log:
> > > [  101.688327] ------------[ cut here ]------------ [  101.692968] re=
fcount_t:
> > > addition on 0; use-after-free.
>=20
> The skb already had its refcount at zero when reaching
> can_put_echo_skb(). It is as if it was already freed/consumed!

ACK

> If you remove Oleksij=E2=80=99s patch, can_put_echo_skb() will probably n=
ot
> clone the skb and thus not check the refcount: this means that you
> will not see the warning, however, it does not necessarily mean that
> the bug did not occur.

ACK

> So far, it seems to me to be another bug which was invisible until
> now and which Oleksij=E2=80=99s patch just uncovered. But I do not yet fu=
lly
> understand what the root cause could be.

Or it's the same bug, hitting earlier. Oleksij's backtrace was in the
TX-complete path and the problem was fixes by cloning the skb in before TX.
This means the refcount of the original skb was decremented between TX and
TX-complete. Here the refcount is decremented even before TX.

Does this make sense?

regareds,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--smtmghljxgzh4dot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAKmYkACgkQqclaivrt
76lm+Qf/ct67llpZ7NKjJAZY/6jVZ15GNV11RuaX0AJ6XwJW6w2AvUaSMK5I69nW
MwCcRZXNoA01GBeJxVb6I/LwtnoPKl0q+mzoHYw0zWq3NXcRY97z04PiAMs+oDZJ
AelzRoULV/N1w9rwaJh65ulmcbod1jpeaDfMzIEYYeqDQA60wm1jiYE6MUA4JLbC
AzPI6YKzFTj1iphu7Usd61M2fIvW4/rDunaLU7+UrP42gPXAWVSSlp7iokskV5u5
nR0m191BHcyiRVcpPTGDJCyY46Nd2aHnqiWjSa76G6WqZsGk1/09/pqmDNWk9l4f
FSNGUqOp3PVWgRpqVmUTEBDaKqWk1w==
=daH8
-----END PGP SIGNATURE-----

--smtmghljxgzh4dot--
