Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223A4BFC49
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiBVPTa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBVPT3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:19:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2815E6F4
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:19:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMWwQ-0004kT-53; Tue, 22 Feb 2022 16:19:02 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 98D013A923;
        Tue, 22 Feb 2022 15:19:01 +0000 (UTC)
Date:   Tue, 22 Feb 2022 16:19:01 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x: wake pin
Message-ID: <20220222151901.tn5sq6ihbaycwiuo@pengutronix.de>
References: <20220222150334.rbhm3uzbh4jp4ap4@skn-laptop.hadsten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="syhmy3he6xpdfic2"
Content-Disposition: inline
In-Reply-To: <20220222150334.rbhm3uzbh4jp4ap4@skn-laptop.hadsten>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--syhmy3he6xpdfic2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 16:03:34, Sean Nyekjaer wrote:
> The TCAN4x5x device have 2 wake pins. One for waking the host controller
> and one for waking the tcan controller it self.
>=20
> We only have the wake for the tcan controller it self implemented
> right?

Sort of. The tcan driver contains handling for the device_state_gpio. I
think should be the pin from the tcan to SoC. The handling of this pin
looks fishy.

> I have a task that would enable our host to wake-on-can traffic.

Due to lack of time, I haven't looked deeply into the sleep and wakeup
of the tcan and the wake from the tcan towards the SoC. As said above,
the device_state_gpio handling looks fishy. Probably first remove the
device_state_gpio handling from the driver, add missing power management
to the m_can and tcan driver, then add wakeup support.

Have a look at this series, I haven't reviewed it in detail, but it
looks good at the first glance.

| https://lore.kernel.org/all/20220111002109.927308-1-phil@quantulum.co.uk

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--syhmy3he6xpdfic2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIU/uIACgkQrX5LkNig
010Vowf/f3zQZZe7qEn68CZ3toY6FdGEIyQzduqpMrmcKt+bXkQeYfeU1Q6wxYZV
nF6YG11byNiBkJuBjYp8YSydfgEkLwWG4xqKzWyWB8aoB/Y6zCPJgnxrwqeEAGU1
/ulDOGtbifAyd3PIVFLivoG/7+JBK/O5f40/XmEVIUpHoFsUITFsrSVaurxZE4dj
Lx1WKo8XcV/twC+xZkdaVhjYmZv89w4LpE5SWcal9mSJGJmSETGMonp09gzV6s3p
0q3OElE8/CsWut40oFJNhMd36tBJziOT72V1RxYDQ3p1qWs+8wAQJkRjh0Xau4Uz
3a1HnvP5WS+pA1xwwLhhzJjfzl5VZg==
=KrYk
-----END PGP SIGNATURE-----

--syhmy3he6xpdfic2--
