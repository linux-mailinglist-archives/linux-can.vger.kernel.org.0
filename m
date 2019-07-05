Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06E601E1
	for <lists+linux-can@lfdr.de>; Fri,  5 Jul 2019 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfGEH77 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Jul 2019 03:59:59 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:41092 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfGEH76 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Jul 2019 03:59:58 -0400
X-ASG-Debug-ID: 1562313593-0a7ff535a4901420001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.226.adsl.dyn.edpnet.net [77.109.119.226]) by relay-b01.edpnet.be with ESMTP id DGkmzJ8gRRpVnvv9; Fri, 05 Jul 2019 09:59:53 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Apparent-Source-IP: 77.109.119.226
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 940448E856E;
        Fri,  5 Jul 2019 09:59:53 +0200 (CEST)
Date:   Fri, 5 Jul 2019 09:59:52 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        linux-can@vger.kernel.org
Subject: Re: C_CAN/D_CAN bug and fix
Message-ID: <20190705075952.GA22538@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: C_CAN/D_CAN bug and fix
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        linux-can@vger.kernel.org
References: <0a1254be-05d0-0c4b-1635-2efbaa96466b@devtank.co.uk>
 <d6f5ebde-5bfc-4581-5992-822b02cd8b35@grandegger.com>
 <7dfe0ceb-a545-2ee1-45f2-83c3b5e1d185@devtank.co.uk>
 <89dea51f-b6b6-e536-6e6e-12f6ff5f79f9@grandegger.com>
 <e2aba5fe-2dd0-f809-345a-409f0df91ae8@grandegger.com>
 <068bca32-6a17-1fb4-8ca6-c14f6266593e@devtank.co.uk>
 <1ff9e388-ced5-e049-1e24-45950d286259@grandegger.com>
 <f18302a4-274e-d013-fe12-a5cb6d809e6e@devtank.co.uk>
 <32f3534b-dd99-d48d-dbc7-41eaac32f678@grandegger.com>
 <41cb639d-d3f4-cec4-f7a4-b8139762d561@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41cb639d-d3f4-cec4-f7a4-b8139762d561@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Start-Time: 1562313593
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5835
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7139 1.0000 1.4760
X-Barracuda-Spam-Score: 2.48
X-Barracuda-Spam-Status: No, SCORE=2.48 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73540
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE_7582B         Custom Rule 7582B
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey all,

I ran into this same problem, and picked up the patches.

On ma, 23 jul 2018 13:36:14 +0200, Marc Kleine-Budde wrote:
> On 06/21/2018 03:20 PM, Wolfgang Grandegger wrote:
...
> >>> Looking to the code, I see a problem with reading the status register
> >>> (C_CAN_STS_REG). It should *only* be read if bit 15 of the interrupt
> >>> status register (C_CAN_INT_REG) is set/pending. According to the manual,
> >>> reading the status register will also clear the bit in C_CAN_INT_REG.
> >>> This could explain lost (bus-off) status interrupts and also the strange
> >>> messages I mentioned above.
> >>>
> >>> Wolfgang.
> >>
> >> It sounds plausible. I can try it. Have you got a good datasheet for D_Can ?
> > 
> > I have attached my (untested) patch. TXOK and RXOK is still handled
> > unconditionally, but that's maybe less critical.
> 
> Has someone tested this patch?

I believe Wolfgang's analysis is right, so I tested the patch and it
doesn't work, because C_CAN_INT_REG is already read in c_can_isr.
On my BeagleBone-like board, the INT_STS_PENDING bit is gone by the
second read.

I modified the patch with an atomic_t in priv, which holds the relevant
bit.

commit 388d1d0d53fb1c000e43e1d58b91e7782d60fcfe
Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date:   Thu Jul 4 22:37:11 2019

    net can c_can: only read status register after status irq

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7f..d5567a7 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -198,6 +198,7 @@ struct c_can_priv {
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
+	atomic_t sie_pending;
 	unsigned long tx_dir;
 	int last_status;
 	u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8..61c7331 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -97,6 +97,9 @@
 #define BTR_TSEG2_SHIFT		12
 #define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
 
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
 /* brp extension register */
 #define BRP_EXT_BRPE_MASK	0x0f
 #define BRP_EXT_BRPE_SHIFT	0
@@ -1029,40 +1032,48 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	u16 curr, last = priv->last_status;
 	int work_done = 0;
 
-	priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
-	/* Ack status on C_CAN. D_CAN is self clearing */
-	if (priv->type != BOSCH_D_CAN)
-		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	/* Only read the status register if a status interrupt was pending */
+	if (atomic_xchg(&priv->sie_pending, 0)) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+
+		/* handle state changes */
+		if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
+			netdev_dbg(dev, "entered error warning state\n");
+			work_done +=
+				c_can_handle_state_change(dev,
+							  C_CAN_ERROR_WARNING);
+		}
 
-	/* handle state changes */
-	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
-		netdev_dbg(dev, "entered error warning state\n");
-		work_done += c_can_handle_state_change(dev, C_CAN_ERROR_WARNING);
-	}
+		if ((curr & STATUS_EPASS) && (!(last & STATUS_EPASS))) {
+			netdev_dbg(dev, "entered error passive state\n");
+			work_done +=
+				c_can_handle_state_change(dev,
+							  C_CAN_ERROR_PASSIVE);
+		}
 
-	if ((curr & STATUS_EPASS) && (!(last & STATUS_EPASS))) {
-		netdev_dbg(dev, "entered error passive state\n");
-		work_done += c_can_handle_state_change(dev, C_CAN_ERROR_PASSIVE);
-	}
+		if ((curr & STATUS_BOFF) && (!(last & STATUS_BOFF))) {
+			netdev_dbg(dev, "entered bus off state\n");
+			work_done +=
+				c_can_handle_state_change(dev, C_CAN_BUS_OFF);
+			goto end;
+		}
 
-	if ((curr & STATUS_BOFF) && (!(last & STATUS_BOFF))) {
-		netdev_dbg(dev, "entered bus off state\n");
-		work_done += c_can_handle_state_change(dev, C_CAN_BUS_OFF);
-		goto end;
-	}
+		/* handle bus recovery events */
+		if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
+			netdev_dbg(dev, "left bus off state\n");
+			priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		}
+		if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
+			netdev_dbg(dev, "left error passive state\n");
+			priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		}
 
-	/* handle bus recovery events */
-	if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
-		netdev_dbg(dev, "left bus off state\n");
-		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		/* handle lec errors on the bus */
+		work_done += c_can_handle_bus_err(dev, curr & LEC_MASK);
 	}
-	if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
-		netdev_dbg(dev, "left error passive state\n");
-		priv->can.state = CAN_STATE_ERROR_ACTIVE;
-	}
-
-	/* handle lec errors on the bus */
-	work_done += c_can_handle_bus_err(dev, curr & LEC_MASK);
 
 	/* Handle Tx/Rx events. We do this unconditionally */
 	work_done += c_can_do_rx_poll(dev, (quota - work_done));
@@ -1083,10 +1094,16 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
+	int intreg;
 
-	if (!priv->read_reg(priv, C_CAN_INT_REG))
+	intreg = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!intreg)
 		return IRQ_NONE;
 
+	/* save for later use */
+	if (intreg & INT_STS_PENDING)
+		atomic_set(&priv->sie_pending, 1);
+
 	/* disable all interrupts and schedule the NAPI */
 	c_can_irq_control(priv, false);
 	napi_schedule(&priv->napi);
