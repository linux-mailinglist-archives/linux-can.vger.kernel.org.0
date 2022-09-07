Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28FC5B0200
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 12:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIGKi5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 06:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIGKiw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 06:38:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE577EB4
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 03:38:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVsSH-0001JY-Qi
        for linux-can@vger.kernel.org; Wed, 07 Sep 2022 12:38:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 17533DC674
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 10:38:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 44EFADC66B;
        Wed,  7 Sep 2022 10:38:48 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 745196ee;
        Wed, 7 Sep 2022 10:38:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2 / 2 as default for SJW
Date:   Wed,  7 Sep 2022 12:38:45 +0200
Message-Id: <20220907103845.3929288-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907103845.3929288-1-mkl@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

"The (Re-)Synchronization Jump Width (SJW) defines how far a
 resynchronization may move the Sample Point inside the limits defined
 by the Phase Buffer Segments to compensate for edge phase errors." [1]

In other words this means the SJW parameter controls the tolerance of
the CAN controller against the frequency error compared to other CAN
controllers.

If the user space doesn't provide a SJW parameter, the kernel chooses
a default value of 1. This proved to be a good default value for CAN
controllers, but not anymore with modern controllers.

In the past, there were CAN controllers like the sja1000 with a rather
limited range of bit timing parameters. For the standard bit rates
this results in the following bit timing parameters:

| Bit timing parameters for sja1000 with 8.000000 MHz ref clock
|                     _----+--------------=> tseg1: 1 …   16
|                    /    /     _---------=> tseg2: 1 …    8
|                   |    |     /    _-----=> sjw:   1 …    4
|                   |    |    |    /    _-=> brp:   1 …   64 (inc: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   SampP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Error  BTR0 BTR1
|  1000000    125   2    3    2   1   1  1000000   0.0%  75.0%  75.0%   0.0%   0x00 0x14
|   800000    125   3    4    2   1   1   800000   0.0%  80.0%  80.0%   0.0%   0x00 0x16
|   666666    125   4    4    3   1   1   666666   0.0%  80.0%  75.0%   6.2%   0x00 0x27
|   500000    125   6    7    2   1   1   500000   0.0%  87.5%  87.5%   0.0%   0x00 0x1c
|   250000    250   6    7    2   1   2   250000   0.0%  87.5%  87.5%   0.0%   0x01 0x1c
|   125000    500   6    7    2   1   4   125000   0.0%  87.5%  87.5%   0.0%   0x03 0x1c
|   100000    625   6    7    2   1   5   100000   0.0%  87.5%  87.5%   0.0%   0x04 0x1c
|    83333    750   6    7    2   1   6    83333   0.0%  87.5%  87.5%   0.0%   0x05 0x1c
|    50000   1250   6    7    2   1  10    50000   0.0%  87.5%  87.5%   0.0%   0x09 0x1c
|    33333   1875   6    7    2   1  15    33333   0.0%  87.5%  87.5%   0.0%   0x0e 0x1c
|    20000   3125   6    7    2   1  25    20000   0.0%  87.5%  87.5%   0.0%   0x18 0x1c
|    10000   6250   6    7    2   1  50    10000   0.0%  87.5%  87.5%   0.0%   0x31 0x1c

The attentive reader notices that in most cases the SJW is 1, while
the Phase Seg2 is 2. Both values are in TQ units, which itself is a
duration in nanoseconds.

For example the 500 kbit/s configuration:

|  nominal                                  real  Bitrt    nom   real   SampP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Error  BTR0 BTR1
|   500000    125   6    7    2   1   1   500000   0.0%  87.5%  87.5%   0.0%   0x00 0x1c

the TQ is 125ns, the Phase Seg2 is "2" (== 250ns), the SJW is "1" (==
125 ns).

Looking at a more modern CAN controller like a mcp2518fd, it has wider
bit timing registers.

| Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock
|                     _----+--------------=> tseg1: 2 …  256
|                    /    /     _---------=> tseg2: 1 …  128
|                   |    |     /    _-----=> sjw:   1 …  128
|                   |    |    |    /    _-=> brp:   1 …  256 (inc: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   SampP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Error      NBTCFG
|   500000     25  34   35   10   1   1   500000   0.0%  87.5%  87.5%   0.0%   0x00440900

The TQ is 25ns, the Phase Seg 2 is "10" (== 250ns), the SJW is "1" (==
25ns).

As the kernel chooses a default SJW of 1 independent of the TQ, this
results in a much smaller SJW and thus much smaller tolerances against
frequency errors.

To get the same oscillator tolerances on controllers with wide bit
timing registers, choose a default SJW value of Phase Seg2 / 2. This
results in the following bit timing parameters:

| Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock
|                     _----+--------------=> tseg1: 2 …  256
|                    /    /     _---------=> tseg2: 1 …  128
|                   |    |     /    _-----=> sjw:   1 …  128
|                   |    |    |    /    _-=> brp:   1 …  256 (inc: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   SampP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Error      NBTCFG
|   500000     25  34   35   10   5   1   500000   0.0%  87.5%  87.5%   0.0%   0x00440904

The TQ is 25ns, the Phase Seg 2 is "10" (== 250ns), the SJW is "5" (==
125ns). Which is the same as on the sja1000 controller.

[1] http://web.archive.org/http://www.oertel-halle.de/files/cia99paper.pdf

Cc: Mark Bath <mark@baggywrinkle.co.uk>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index b9aa1f7d0b37..6b4ca7af05fa 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -154,9 +154,9 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	bt->phase_seg1 = tseg1 - bt->prop_seg;
 	bt->phase_seg2 = tseg2;
 
-	/* If user space provides no sjw, use 1 as default */
+	/* If user space provides no sjw, use sane default of phase_seg2 / 2 */
 	if (!bt->sjw)
-		bt->sjw = 1;
+		bt->sjw = max(1U, bt->phase_seg2 / 2);
 
 	/* sjw must not be higher than sjw_max, phase_seg1, and phase_seg2 */
 	bt->sjw = min3(bt->sjw, btc->sjw_max,
-- 
2.35.1


