Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B854A4C4482
	for <lists+linux-can@lfdr.de>; Fri, 25 Feb 2022 13:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiBYMU7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Feb 2022 07:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiBYMU6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Feb 2022 07:20:58 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272931C3D13
        for <linux-can@vger.kernel.org>; Fri, 25 Feb 2022 04:20:25 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MD9nd-1nWgGl3tM9-009BbM; Fri, 25 Feb 2022 13:20:23 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id BF9B03B08B7;
        Fri, 25 Feb 2022 13:18:13 +0100 (CET)
Message-ID: <b5066414-fb63-71af-997c-07c1c531a218@photo-meter.com>
Date:   Fri, 25 Feb 2022 13:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: anochin@photo-meter.com
Subject: [PATCH] can: m_can: m_can_isr: IR_ERR_ALL_30X
Content-Language: en-US
From:   Michael Anochin <anochin@photo-meter.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <7c5b3abc-0836-1840-a322-0c582abf9692@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <7c5b3abc-0836-1840-a322-0c582abf9692@photo-meter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TdlzqaYy+YF4oHRhaYACgIFmzcVnlYkSrG1sUfpCCoyYDhVOXzk
 HDozy6F04Eqy87rIsIlTtWYioOyc9DEk38eX5KSeO1k5t3P2EvXcBJ5V38ge0+zPrrwHEbf
 2Lj6FQlFcJ3MnQQ3fruTmoZ+aRlfnSQKKQVR7u79GWYdhACGHfLLXB1fmeScYXIDkrbTA/S
 p0OjIMOG2as9kv+wcE9ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kckWXvyjPTA=:0wrKLFVKzipdc/H3WTciye
 pt+yWSawi5WLYL4q4Ko0k0QiUq2eq7TqFR5LBShkDitgcQFBxpAdRgkBORrus/4k/HWvx7Bbl
 PyLMz3VkpCehgRMTeasG7oKr+PU0+BzwkNawWPAyxhrDmQ0ukeee7vtNEcxs49qW716sUes6z
 mhTGcZXo56u9Fltp18jmtNpBztttcJflQPep+GbPJCP4c+il5d5fk0gUk7IgksjHtRFxDy+S6
 s6pv54ONL0EzKRhAYcU/VDZF69QZaGDdAW+N63urL2OJt2vKarfgtpNOIivbEjbJFQjkG1JLk
 4IUDBudaFOVwJrc6Mst9p+xhFydnLcCwzBPNBXDo9ObMI/jTLpKF2aNdyZuSWsU6a6o/LvBHx
 7lMG171ap4goLmbfVIWOXWtQ2mpj/4n7UQvYH4b9YBWBHEdYq6xIeHWYPJsYNGZZEtvwRo5A0
 /QcOcUCQXasyUp6GluZe4jC2g3rX36FMiSIN1QEC7H5/562IvkAYw+9tMWX3ExfF+B1JEmQaB
 9M0OOM7sPLI2u0RusUarG2IiGAPHm0HtdR3biuYp8F8+KIdtis4UOBMyYnS0vHoYnv3FsBE5w
 nf7C42zdrdAGnPaPJj1WVEwD7iJBvASmJUOjshegMBe7R7Nhe449FILY6RBQeSRGsr6puZThu
 EzLvHETOtzcBvX3kxYsP9+yXO44Lp+GYlj1aEQK7Eb+JVX2C8reL1ouc2JBxDVgikO4GtWpLv
 cJmViqUeQ9U0A6ls
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For m_can version >3.0 the correct IR_ERR_ALL_31X mask is used.
If an error occurs when processing RX status flags, the TX flags are 
processed anyway.

I am not sure, but maybe it is better to save IR to cdev->irqstatus
immediately before clear IR and not only by RX-Flags handling.

As far as I have seen, cdev->irqstatus is not accessed by tx-handling, 
therefore it does not matter.

This is my first patch, sorry if something is not right.

---
  drivers/net/can/m_can/m_can.c | 33 +++++++++++++++++++++++----------
  1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 1a4b56f6fa8c..eb9fd9c846a2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1053,6 +1053,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
  {
  	struct net_device *dev = (struct net_device *)dev_id;
  	struct m_can_classdev *cdev = netdev_priv(dev);
+	int err=0;
  	u32 ir;

  	if (pm_runtime_suspended(cdev->dev))
@@ -1073,16 +1074,17 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
  	 * - state change IRQ
  	 * - bus error IRQ and bus error reporting
  	 */
-	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
-		cdev->irqstatus = ir;
-		m_can_disable_all_interrupts(cdev);
-		if (!cdev->is_peripheral)
-			napi_schedule(&cdev->napi);
-		else if (m_can_rx_peripheral(dev) < 0)
-			goto out_fail;
-	}
-
  	if (cdev->version == 30) {
+
+		if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
+			cdev->irqstatus = ir;
+			m_can_disable_all_interrupts(cdev);
+			if (!cdev->is_peripheral)
+				napi_schedule(&cdev->napi);
+			else if (m_can_rx_peripheral(dev) < 0)
+				err=-1;
+		}
+
  		if (ir & IR_TC) {
  			/* Transmission Complete Interrupt*/
  			u32 timestamp = 0;
@@ -1095,10 +1097,18 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
  			netif_wake_queue(dev);
  		}
  	} else  {
+		if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_31X)) {
+			cdev->irqstatus = ir;
+			m_can_disable_all_interrupts(cdev);
+			if (!cdev->is_peripheral)
+				napi_schedule(&cdev->napi);
+			else if (m_can_rx_peripheral(dev) < 0)
+				err=-2;
+		}
  		if (ir & IR_TEFN) {
  			/* New TX FIFO Element arrived */
  			if (m_can_echo_tx_event(dev) != 0)
-				goto out_fail;
+				err=-2;

  			can_led_event(dev, CAN_LED_EVENT_TX);
  			if (netif_queue_stopped(dev) &&
@@ -1107,6 +1117,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
  		}
  	}

+	if (err)
+		goto out_fail;
+
  	if (cdev->is_peripheral)
  		can_rx_offload_threaded_irq_finish(&cdev->offload);

-- 
2.20.1
