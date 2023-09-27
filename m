Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872247B0A43
	for <lists+linux-can@lfdr.de>; Wed, 27 Sep 2023 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjI0Qcp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Sep 2023 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjI0Qcm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Sep 2023 12:32:42 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC39DE;
        Wed, 27 Sep 2023 09:32:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21C3D40003;
        Wed, 27 Sep 2023 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695832356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzRiLFiE96j5NL7WdLRQOP7BxkPSHo+tKBTr1xJAHQs=;
        b=oVxsmLmr1QcdLdX+GqOgV/9cSAzUpOwHqs/oQQJYOOLPeVFM2D93hSjArz7bqsQPidvP8c
        a1Mx0bFN3pN4lWyGVeQHKU925Wqamzm42rzaRFs9i1sxEuA96JxWqRUow37WCXsdAzfU5n
        TxxmWw2A3gxWR1H1sjfeifeygp6EjmqAsDSIOkgr0HwoM4HWuW+rtiM9iyaAZGNDDL6rHX
        OrOMDGc1krienB8n9H9Ybwv61rcd7kwIrSks5nDDhKWrlCUMUMODwxoZtRO2lwO6BhBiXJ
        VTpv+6h9tI336phloScM1/ieYlRKVywqiyfUH1XI3tvBGO+9D127OIOdcW10bw==
Date:   Wed, 27 Sep 2023 18:32:30 +0200
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
Subject: Re: [PATCH net] can: sja1000: Always restart the Tx queue after an
 overrun
Message-ID: <20230927183214.39c2986b@xps-13>
In-Reply-To: <20230927-mystified-speak-d6aff435e38d-mkl@pengutronix.de>
References: <20230922154727.591672-1-miquel.raynal@bootlin.com>
        <20230927-fantasize-refuse-7fef75242672-mkl@pengutronix.de>
        <20230927-mystified-speak-d6aff435e38d-mkl@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

mkl@pengutronix.de wrote on Wed, 27 Sep 2023 11:33:32 +0200:

> On 27.09.2023 11:30:16, Marc Kleine-Budde wrote:
> > On 22.09.2023 17:47:27, Miquel Raynal wrote: =20
> > > Upstream commit 717c6ec241b5 ("can: sja1000: Prevent overrun stalls w=
ith
> > > a soft reset on Renesas SoCs") fixes an issue with Renesas own SJA1000
> > > CAN controller reception: the Rx buffer is only 5 messages long, so w=
hen
> > > the bus loaded (eg. a message every 50us), overrun may easily
> > > happen. Upon an overrun situation, due to a possible internal crossta=
lk
> > > situation, the controller enters a frozen state which only can be
> > > unlocked with a soft reset (experimentally). The solution was to offl=
oad
> > > a call to sja1000_start() in a threaded handler. This needs to happen=
 in
> > > process context as this operation requires to sleep. sja1000_start()
> > > basically enters "reset mode", performs a proper software reset and
> > > returns back into "normal mode".
> > >=20
> > > Since this fix was introduced, we no longer observe any stalls in
> > > reception. However it was sporadically observed that the transmit path
> > > would now freeze. Further investigation blamed the fix mentioned abov=
e,
> > > and especially the reset operation. Reproducing the reset in a loop
> > > helped identifying what could possibly go wrong. The sja1000 is a sin=
gle
> > > Tx queue device, which leverages the netdev helpers to process one Tx
> > > message at a time. The logic is: the queue is stopped, the message se=
nt
> > > to the transceiver, once properly transmitted the controller sets a
> > > status bit which triggers an interrupt, in the interrupt handler the
> > > transmission status is checked and the queue woken up. Unfortunately,=
 if
> > > an overrun happens, we might perform the soft reset precisely between
> > > the transmission of the buffer to the transceiver and the advent of t=
he
> > > transmission status bit. We would then stop the transmission operation
> > > without re-enabling the queue, leading to all further transmissions to
> > > be ignored.
> > >=20
> > > The reset interrupt can only happen while the device is "open", and
> > > after a reset we anyway want to resume normal operations, no matter i=
f a
> > > packet to transmit got dropped in the process, so we shall wake up the
> > > queue. Restarting the device and waking-up the queue is exactly what
> > > sja1000_set_mode(CAN_MODE_START) does. In order to be consistent about
> > > the queue state, we must acquire a lock both in the reset handler and=
 in
> > > the transmit path to ensure serialization of both operations. As the
> > > reset handler might still be called after the transmission of a frame=
 to
> > > the transceiver but before it actually gets transmitted, we must ensu=
re
> > > we don't leak the skb, so we free it (the behavior is consistent, no
> > > matter if there was an skb on the stack or not). =20
> >=20
> > Can you make use of netif_tx_disable() and netif_wake_queue() in
> > sja1000_reset_interrupt() instead of the lock? =20
>=20
> ...or netif_tx_lock()/netif_tx_unlock().

As that's also a spinlock behind I guess it would fit. A quick look
does not seem to show any specific constraint in using it, so let's go
for it.

Thanks,
Miqu=C3=A8l
