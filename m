Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547777B7C6E
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbjJDJlf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjJDJlY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:41:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FAAC
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:41:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnyNS-0000aU-7O; Wed, 04 Oct 2023 11:41:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qnyNR-00AzuG-78; Wed, 04 Oct 2023 11:41:09 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CB6AB22EC80;
        Wed,  4 Oct 2023 09:41:08 +0000 (UTC)
Date:   Wed, 4 Oct 2023 11:41:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        =?utf-8?B?SsOpcsOpbWll?= Dautheribes 
        <jeremie.dautheribes@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        sylvain.girard@se.com, pascal.eberhard@se.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] can: sja1000: Always restart the Tx queue after an
 overrun
Message-ID: <20231004-uneasy-backed-e01d77be9f51-mkl@pengutronix.de>
References: <20231002160206.190953-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gjgeg42sjz3xlio6"
Content-Disposition: inline
In-Reply-To: <20231002160206.190953-1-miquel.raynal@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gjgeg42sjz3xlio6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.10.2023 18:02:06, Miquel Raynal wrote:
> Upstream commit 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with
> a soft reset on Renesas SoCs") fixes an issue with Renesas own SJA1000
> CAN controller reception: the Rx buffer is only 5 messages long, so when
> the bus loaded (eg. a message every 50us), overrun may easily
> happen. Upon an overrun situation, due to a possible internal crosstalk
> situation, the controller enters a frozen state which only can be
> unlocked with a soft reset (experimentally). The solution was to offload
> a call to sja1000_start() in a threaded handler. This needs to happen in
> process context as this operation requires to sleep. sja1000_start()
> basically enters "reset mode", performs a proper software reset and
> returns back into "normal mode".
>=20
> Since this fix was introduced, we no longer observe any stalls in
> reception. However it was sporadically observed that the transmit path
> would now freeze. Further investigation blamed the fix mentioned above,
> and especially the reset operation. Reproducing the reset in a loop
> helped identifying what could possibly go wrong. The sja1000 is a single
> Tx queue device, which leverages the netdev helpers to process one Tx
> message at a time. The logic is: the queue is stopped, the message sent
> to the transceiver, once properly transmitted the controller sets a
> status bit which triggers an interrupt, in the interrupt handler the
> transmission status is checked and the queue woken up. Unfortunately, if
> an overrun happens, we might perform the soft reset precisely between
> the transmission of the buffer to the transceiver and the advent of the
> transmission status bit. We would then stop the transmission operation
> without re-enabling the queue, leading to all further transmissions to
> be ignored.
>=20
> The reset interrupt can only happen while the device is "open", and
> after a reset we anyway want to resume normal operations, no matter if a
> packet to transmit got dropped in the process, so we shall wake up the
> queue. Restarting the device and waking-up the queue is exactly what
> sja1000_set_mode(CAN_MODE_START) does. In order to be consistent about
> the queue state, we must acquire a lock both in the reset handler and in
> the transmit path to ensure serialization of both operations. It turns
> out, a lock is already held when entering the transmit path, so we can
> just acquire/release it as well with the regular net helpers inside the
> threaded interrupt handler and this way we should be safe. As the
> reset handler might still be called after the transmission of a frame to
> the transceiver but before it actually gets transmitted, we must ensure
> we don't leak the skb, so we free it (the behavior is consistent, no
> matter if there was an skb on the stack or not).
>=20
> Fixes: 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with a soft re=
set on Renesas SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Have you compile tested this against current net/main?

|   CC [M]  drivers/net/can/sja1000/sja1000.o
| drivers/net/can/sja1000/sja1000.c: In function =E2=80=98sja1000_reset_int=
errupt=E2=80=99:
| drivers/net/can/sja1000/sja1000.c:398:9: error: too few arguments to func=
tion =E2=80=98can_free_echo_skb=E2=80=99
|   398 |         can_free_echo_skb(dev, 0);
|       |         ^~~~~~~~~~~~~~~~~
| In file included from include/linux/can/dev.h:22,
|                  from drivers/net/can/sja1000/sja1000.c:62:
| include/linux/can/skb.h:28:6: note: declared here
|    28 | void can_free_echo_skb(struct net_device *dev, unsigned int idx,
|       |      ^~~~~~~~~~~~~~~~~
|

This chance is mainline since v5.13-rc1~94^2~297^2~34. I've fixed the
problem while applying the patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gjgeg42sjz3xlio6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdMzAACgkQvlAcSiqK
BOgJewf/Y2usjEyhkOtF96jCF8Hs6PViTHhYOPcoZkncutXTZ+/XJmRP0PEk8h6A
XNA/80yzpnwHtQQ/DXfcMGyQWY+3QNhYwQJMdt10i/BVowbwxiNy0cgVEPqichv/
kpf1wnkJZAr1W30xcn9K2hvZ0VT9KSgjNYuK5QygoJHhLGDnoyHEcZptOE7lTvMW
NKE69lpZoHYDGr1Q2rVD9R6E1hDiDTOaLPeKsPEUjVf/j49JLG3tKQ0FfL7jneH7
jlNxg4oUfqC7g2fJgCDDRWsCtQqPZMtxAAR+WDs6z1VL03Ljw7lTyoUTh83PbO4f
nJHApVhpS3o88GZ4HJqKyPBAa+BEFw==
=gLbK
-----END PGP SIGNATURE-----

--gjgeg42sjz3xlio6--
