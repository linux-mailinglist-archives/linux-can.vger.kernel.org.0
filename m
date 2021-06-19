Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA43ADBB6
	for <lists+linux-can@lfdr.de>; Sat, 19 Jun 2021 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFSUnP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Jun 2021 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSUnP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 16:43:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B368BC061574
        for <linux-can@vger.kernel.org>; Sat, 19 Jun 2021 13:41:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luhm2-0006tP-3w; Sat, 19 Jun 2021 22:41:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8352:71b5:153f:5f88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4A3A263F7A5;
        Sat, 19 Jun 2021 20:41:01 +0000 (UTC)
Date:   Sat, 19 Jun 2021 22:41:00 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gw: syncronize rcu operations before removing gw
 job entry
Message-ID: <20210619204100.jlgqnmyxjw3hqg35@pengutronix.de>
References: <20210618173645.2238-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wc3pk3gsanpi4qbt"
Content-Disposition: inline
In-Reply-To: <20210618173645.2238-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wc3pk3gsanpi4qbt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 19:36:45, Oliver Hartkopp wrote:
> can_can_gw_rcv() is called under RCU protection, so after calling
> can_rx_unregister, we may call synchronize_rcu in order to wait for any
> RCU read-side critical sections to finish before removing the kmem_cache
> entry with the referenced gw job entry.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wc3pk3gsanpi4qbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDOVlkACgkQqclaivrt
76ngJAgAiPqgBaChHN4bciToywMDG4nVCfRo+iDJwTCA57grsSKM1BN+LPqdexnr
2DwDA6irTWmYe/saYoCTCFgiQ9MvnWGX9a1vLuNE2b+4b8HMxp4/utRw4rHvOhMe
forYfcUqduowRJclQ1zdkTHq42fRlpH3fMA39ywc0jvanhD8tHxIIsz62YRmskg4
HZxDJ+7V3liaquZOH62jO/j8GL6orHqd+UzDc0JZ6JYr1CHQMXON735P5nisp8Vk
KPWaHnsshk/BTn0GlrIVI1xexTHpUpgCo9aWXwBQoBseMt3unAPT8oCFAhOW/PK9
ZO7Xu+VFrujUvplRzgtBhpgZaqMR+A==
=Yywi
-----END PGP SIGNATURE-----

--wc3pk3gsanpi4qbt--
