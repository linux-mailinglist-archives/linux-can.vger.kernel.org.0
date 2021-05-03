Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D5371836
	for <lists+linux-can@lfdr.de>; Mon,  3 May 2021 17:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhECPoI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 May 2021 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhECPoI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 May 2021 11:44:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E48C06174A
        for <linux-can@vger.kernel.org>; Mon,  3 May 2021 08:43:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldaj1-0004CS-Ub; Mon, 03 May 2021 17:43:12 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1b0:e062:be12:b9c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BC7D861B3D4;
        Mon,  3 May 2021 15:43:10 +0000 (UTC)
Date:   Mon, 3 May 2021 17:43:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Thomas Kopp <thomas.kopp@microchip.com>
Cc:     linux-can <linux-can@vger.kernel.org>, kayoub5@live.com
Subject: Re: More flags for logging
Message-ID: <20210503154309.ipp2arjvatdqfokz@pengutronix.de>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocdtxgwsmr466z2t"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ocdtxgwsmr466z2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2021 00:02:49, Vincent MAILHOL wrote:
> > > ACK bit in data frame
> > > - Some logging hardware can act as a "spy", meaning that it records C=
AN
> > >   Frames, but does not set the ACK bit
> > > - A way to know for a given frame (FD or not), was the ACK bit set or
> > >   not.
> > > - Current API allow detecting missing ACK, but it does not report what
> > >   Frame had a missing ACK.
> >
> > This means the driver has to set a flag if it's configured in
> > listen-only mode. That should be possible.
>
> For my understanding, when a controller does not see the ACK bit,
> it stops the transmission and sends an error flag. For this
> reason, the frame is not received and thus simply does not appear
> in the log.

Hmmm. That's not correct for the mcp251xfd in RX-listen only mode:

| (2021-05-03 17:11:28.493992)  mcp251xfd0  RX - -  222   [8]  05 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:28.994109)  mcp251xfd0  RX - -  222   [8]  06 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:29.494298)  mcp251xfd0  RX - -  222   [8]  07 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:29.994510)  mcp251xfd0  RX - -  222   [8]  08 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:30.494635)  mcp251xfd0  RX - -  222   [8]  09 00 00 00 =
00 00 00 00

unplugged 3rd device here (that's used to send the ACK)

| (2021-05-03 17:11:30.998388)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:30.998662)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:30.998936)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:30.999210)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:30.999484)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:30.999758)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.000032)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.000306)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.000580)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.000854)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.001128)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.001402)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.001676)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.001950)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.002224)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.002498)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.002772)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.003046)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.003320)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00
| (2021-05-03 17:11:31.003594)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00


---

The flexcan (can0) does behave differently:

| (2021-05-03 17:16:43.004939)        can0  RX - -  222   [8]  08 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:43.005846)  mcp251xfd0  RX - -  222   [8]  08 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:43.505052)        can0  RX - -  222   [8]  09 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:43.505729)  mcp251xfd0  RX - -  222   [8]  09 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:44.005193)        can0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:44.005856)  mcp251xfd0  RX - -  222   [8]  0A 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20

unplugged 3rd device here (that's used to send the ACK)

| (2021-05-03 17:16:44.507358)  mcp251xfd0  RX - -  222   [8]  0B 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:44.507399)  mcp251xfd0  RX - -  222   [8]  0B 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20
| (2021-05-03 17:16:44.508142)  mcp251xfd0  RX - -  222   [8]  0B 00 00 00 =
00 00 00 00                                                                =
                                                                           =
                               =20

Thomas, is that worth investigating in your side?

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ocdtxgwsmr466z2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCQGgoACgkQqclaivrt
76n+XAf/TuNQ3wIZz3oYADPtil14ZG1OPPnJCgPUCMcIH6lqYs9aP+Sq298ZGabO
9BS/dEM3Rb43TNXrugIB0mOXflcqe4PCTfBUS4L2UN5+EtXnOH8n7f8CfEhteVxT
vq0TdcF6cnjtLuI6Sno1eeJwkLQE9VEYdU9hQK4pbnV7he3gfVEWM65e4Ylq8WWl
nLTnx8Hce9ri1swKJOJAZtij9duZcF/7Ha7nM38UGttsTG8m8bwP1Zh3IRfmkJaD
J5mH1Wtu1Umq/wSoiqa4njNLiPE2lR2/NQ1wj71qZ23mL05JOfGM98VsT/RAS275
2KuXV7i4MGHQrcpK8X3FAM7QahKnFA==
=pEVw
-----END PGP SIGNATURE-----

--ocdtxgwsmr466z2t--
