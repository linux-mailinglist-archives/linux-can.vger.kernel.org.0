Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0FB7B54F0
	for <lists+linux-can@lfdr.de>; Mon,  2 Oct 2023 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjJBO0O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Oct 2023 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjJBO0N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Oct 2023 10:26:13 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3315B4;
        Mon,  2 Oct 2023 07:26:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E88ED1BF21C;
        Mon,  2 Oct 2023 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696256765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmtQpL7yD9K5R93X88aFmp9q9g0Bm+ji2G+JTmzoZxc=;
        b=YdBh3ay/jIFEahGJm81XGZb59LZmZz3/3iwUxcTQbynepQjjqIZX43elILNuV52VflPfGO
        itpqOCnHukAvPJ29X+zuJ2jvml9KptC8i8uVImcJiImNanu+wK+/Bn6BpTIQlt8mXjEKPj
        uzMhuy+gs4g5/quHPUA5vOYK8WcTHPAI7BEf5qSCvw/O12wKKTvh4fE4RnxJL2jY+HBXub
        pLoFOXwA+aRJElja/pTkXRw86fa2D3+wqH0e++58W+TzTcziZDT6gNrI63OE8ocjzS3nfa
        Ah6msA7v4U5RGZjelVm7P1G3xwSEBZZZbfgYiXoAvDFNosVJrPnMMtRvfoSJxQ==
Date:   Mon, 2 Oct 2023 16:26:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        =?UTF-8?B?SsOpcsOpbWll?= Dautheribes 
        <jeremie.dautheribes@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        sylvain.girard@se.com, pascal.eberhard@se.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] can: sja1000: Always restart the Tx queue after an
 overrun
Message-ID: <20231002162601.6b71c4d9@xps-13>
In-Reply-To: <20230928-headphone-premiere-d92deb9c29e5-mkl@pengutronix.de>
References: <20230927164442.128204-1-miquel.raynal@bootlin.com>
        <20230928-headphone-premiere-d92deb9c29e5-mkl@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

mkl@pengutronix.de wrote on Thu, 28 Sep 2023 09:53:17 +0200:

> On 27.09.2023 18:44:42, Miquel Raynal wrote:
> > Upstream commit 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with
> > a soft reset on Renesas SoCs") fixes an issue with Renesas own SJA1000
> > CAN controller reception: the Rx buffer is only 5 messages long, so when
> > the bus loaded (eg. a message every 50us), overrun may easily
> > happen. Upon an overrun situation, due to a possible internal crosstalk
> > situation, the controller enters a frozen state which only can be
> > unlocked with a soft reset (experimentally). The solution was to offload
> > a call to sja1000_start() in a threaded handler. This needs to happen in
> > process context as this operation requires to sleep. sja1000_start()
> > basically enters "reset mode", performs a proper software reset and
> > returns back into "normal mode".
> >=20
> > Since this fix was introduced, we no longer observe any stalls in
> > reception. However it was sporadically observed that the transmit path
> > would now freeze. Further investigation blamed the fix mentioned above,
> > and especially the reset operation. Reproducing the reset in a loop
> > helped identifying what could possibly go wrong. The sja1000 is a single
> > Tx queue device, which leverages the netdev helpers to process one Tx
> > message at a time. The logic is: the queue is stopped, the message sent
> > to the transceiver, once properly transmitted the controller sets a
> > status bit which triggers an interrupt, in the interrupt handler the
> > transmission status is checked and the queue woken up. Unfortunately, if
> > an overrun happens, we might perform the soft reset precisely between
> > the transmission of the buffer to the transceiver and the advent of the
> > transmission status bit. We would then stop the transmission operation
> > without re-enabling the queue, leading to all further transmissions to
> > be ignored.
> >=20
> > The reset interrupt can only happen while the device is "open", and
> > after a reset we anyway want to resume normal operations, no matter if a
> > packet to transmit got dropped in the process, so we shall wake up the
> > queue. Restarting the device and waking-up the queue is exactly what
> > sja1000_set_mode(CAN_MODE_START) does. In order to be consistent about
> > the queue state, we must acquire a lock both in the reset handler and in
> > the transmit path to ensure serialization of both operations. As the
> > reset handler might still be called after the transmission of a frame to
> > the transceiver but before it actually gets transmitted, we must ensure
> > we don't leak the skb, so we free it (the behavior is consistent, no
> > matter if there was an skb on the stack or not).
> >=20
> > Fixes: 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with a soft =
reset on Renesas SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >=20
> > Changes in v2:
> > * As Marc sugested, use netif_tx_{,un}lock() instead of our own
> >   spin_lock.
> >=20
> >  drivers/net/can/sja1000/sja1000.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja100=
0/sja1000.c
> > index ae47fc72aa96..91e3fb3eed20 100644
> > --- a/drivers/net/can/sja1000/sja1000.c
> > +++ b/drivers/net/can/sja1000/sja1000.c
> > @@ -297,6 +297,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
> >  	if (can_dropped_invalid_skb(dev, skb))
> >  		return NETDEV_TX_OK;
> > =20
> > +	netif_tx_lock(dev);
> >  	netif_stop_queue(dev);
> > =20
> >  	fi =3D dlc =3D cf->can_dlc;
> > @@ -335,6 +336,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
> > =20
> >  	sja1000_write_cmdreg(priv, cmd_reg_val);
> > =20
> > +	netif_tx_unlock(dev);
> > + =20
>=20
> I think netif_tx_lock() should be used in a different way. As far as I
> understand it, you should call it only in the sja1000_reset_interrupt(),
> where you want to tx path to interfere.

I believe you meant "don't want"? And yes you're right current use
can't properly handle my problem.

> Please test the new code with lockdep enabled.

I will fix the current implementation and test again by manually
producing overruns.

Thanks,
Miqu=C3=A8l
