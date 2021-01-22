Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB92FFEE6
	for <lists+linux-can@lfdr.de>; Fri, 22 Jan 2021 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbhAVI7s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jan 2021 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbhAVI7c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2021 03:59:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0AC06174A
        for <linux-can@vger.kernel.org>; Fri, 22 Jan 2021 00:58:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l2sHK-0007s3-5d; Fri, 22 Jan 2021 09:58:50 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:aed1:e241:8b32:9cc0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 665655CA5DB;
        Fri, 22 Jan 2021 08:58:48 +0000 (UTC)
Date:   Fri, 22 Jan 2021 09:58:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [5.10 CAN BUG report] kernel dump about echo skb
Message-ID: <20210122085847.xr6yo7wc6elwpbop@hardanger.blackshift.org>
References: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxz2vb6yc5n2vqrw"
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oxz2vb6yc5n2vqrw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 08:37:31AM +0000, Joakim Zhang wrote:
> Our auto test scripts reports below kernel dump, after revert Oleksij Rem=
pel
> patch "286228d382ba can: can_create_echo_skb(): fix echo skb generation: =
always
> use skb_clone()", this issue disappeared.  What strange is that, commit m=
essage
> intends to fix this issue. Report it here to see if anyone meets the same=
 issue
> or can give some suggestions. I will continue to dig how to reproduce it
> manually, now I don't know how to do it. Thanks.

The backtrace looks more or less like a normal TX-path to me. Although the =
send
is not directly in the call stack of a user space application, but it's
deferred and then sent by the net_tx_action().

I have the feeling, that this backtrace is triggered by the same problem th=
at
Oleksij tried to fix. Some CAN frames were send on a socket, that socket was
closed and the skbs have reached 0 refcount, after this the frames were put
into the driver.

With Oleksij's patch the skb is always cloned, this means the refcount is
always checked. Reverting that patch covers the problem.

If you can reproduce, revert the patch and add a refcount check againt 0 on=
ly.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oxz2vb6yc5n2vqrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAKk8QACgkQqclaivrt
76lj8Qf/Y0PmHOR60VxO2OrcpP0VXbvuA9SUgrFXE5Ei9knMFwghikeWU5NvSz8P
9NlsRo3Wtc5VTZnLHFNO95aRw2b2NM4F3bcYJWEZ3ocRA026m9wJ1bTvUMnR55Ze
l65oQTkkz+PP0L1uVTbQuFtBeHSX4TsuFZ/oqtSKeEKjDGn5ba1GUvwu3SD30kqX
yhsmlpoODU5wO4PJhQETSQ2HqWGU/Nb8eEQXt38LeugEswtO3W9WWj1C43zdnN79
CKML/xYDBHkXxTzqq3awdWFta1jwhC94dU6rc7J+WcdU8dY0XQwwiUjyTOlV/uKa
bAiwr/fw9DS87qQS1XUlrJisFUUQvA==
=7f+l
-----END PGP SIGNATURE-----

--oxz2vb6yc5n2vqrw--
