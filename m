Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE77B156A
	for <lists+linux-can@lfdr.de>; Thu, 28 Sep 2023 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjI1Hxb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Sep 2023 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjI1Hxa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Sep 2023 03:53:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE9B3
        for <linux-can@vger.kernel.org>; Thu, 28 Sep 2023 00:53:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qllpn-0001KQ-JF; Thu, 28 Sep 2023 09:53:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qllpm-009WkC-In; Thu, 28 Sep 2023 09:53:18 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2CBB322A28F;
        Thu, 28 Sep 2023 07:53:18 +0000 (UTC)
Date:   Thu, 28 Sep 2023 09:53:17 +0200
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
Subject: Re: [PATCH v2] can: sja1000: Always restart the Tx queue after an
 overrun
Message-ID: <20230928-headphone-premiere-d92deb9c29e5-mkl@pengutronix.de>
References: <20230927164442.128204-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubhnszgeqgcjawt6"
Content-Disposition: inline
In-Reply-To: <20230927164442.128204-1-miquel.raynal@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ubhnszgeqgcjawt6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.09.2023 18:44:42, Miquel Raynal wrote:
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
> the transmit path to ensure serialization of both operations. As the
> reset handler might still be called after the transmission of a frame to
> the transceiver but before it actually gets transmitted, we must ensure
> we don't leak the skb, so we free it (the behavior is consistent, no
> matter if there was an skb on the stack or not).
>=20
> Fixes: 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with a soft re=
set on Renesas SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>=20
> Changes in v2:
> * As Marc sugested, use netif_tx_{,un}lock() instead of our own
>   spin_lock.
>=20
>  drivers/net/can/sja1000/sja1000.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/=
sja1000.c
> index ae47fc72aa96..91e3fb3eed20 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -297,6 +297,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff =
*skb,
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
> =20
> +	netif_tx_lock(dev);
>  	netif_stop_queue(dev);
> =20
>  	fi =3D dlc =3D cf->can_dlc;
> @@ -335,6 +336,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff =
*skb,
> =20
>  	sja1000_write_cmdreg(priv, cmd_reg_val);
> =20
> +	netif_tx_unlock(dev);
> +

I think netif_tx_lock() should be used in a different way. As far as I
understand it, you should call it only in the sja1000_reset_interrupt(),
where you want to tx path to interfere.

Please test the new code with lockdep enabled.

Marc

>  	return NETDEV_TX_OK;
>  }
> =20
> @@ -396,7 +399,13 @@ static irqreturn_t sja1000_reset_interrupt(int irq, =
void *dev_id)
>  	struct net_device *dev =3D (struct net_device *)dev_id;
> =20
>  	netdev_dbg(dev, "performing a soft reset upon overrun\n");
> -	sja1000_start(dev);
> +
> +	netif_tx_lock(dev);
> +
> +	can_free_echo_skb(dev, 0);
> +	sja1000_set_mode(dev, CAN_MODE_START);
> +
> +	netif_tx_unlock(dev);
> =20
>  	return IRQ_HANDLED;
>  }
> --=20
> 2.34.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ubhnszgeqgcjawt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUVMOoACgkQvlAcSiqK
BOglxgf+Kwi7Em2vSA6/cuQGPluAhGuXsyUHgOY0hkuRW47y63FhXrkUTylD0/Jy
Bf5WX2gm+fFQZvo3BJphPalQq7pQopv4ewDBKBC1wtRWFSqQqaFS86eIzQ2su19f
Ox9QliSCS6QI91K+5eZguv0FnsHn48mDe076NpLUrERsQjb0M9ocxjeNChknqk+3
JZQILGjmF/moHS8oISZj6YCQ8dj/EnBZVieKJFWHunbxqep2Q9U/j897apUjOGXr
N1Okes5SIA+ou51FxRgR/jhywyZUIjyMN0uNc3K5lufHQHKBt0GKqyTIZCzrYd+X
maJNukSC0G55y55Gx2ZkNC4iO2mljQ==
=Pj/g
-----END PGP SIGNATURE-----

--ubhnszgeqgcjawt6--
