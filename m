Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C767BB08
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 20:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjAYTvP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 14:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjAYTvM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 14:51:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F2EF88
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vw16so50582413ejc.12
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYyMkExZ6IN/MMZJH5eyzLSmSbOQmGlTSTJDGYdD9iE=;
        b=n/YOUFuMLzpqq1KdRJiK2At8DTnp5I75eAvwEu/+hxYgtIxUmJIaVmDpVghSuJIL+o
         DzUHlOx1qoZ/vXZBclIHHhfIt/ptnXZCFwFsyXJbPKiebK0TdZbPGeg6/iqpP8IKQi0x
         RKw2vJpjKi4arV1/RUmKZLscOA1YccgmBQppOKbFzdJlD6cecTX7gCWuQPvT5y2IU79R
         Ta0EApFZHJkL2ug1X8cu7Ch5m41hctck4gWEeKHKtPT5/chUcqpSAPrW2oetSCtu6jaX
         tOf4UhZKqwdQjmviSkFAT+fQ42EtlPs8fmhwgGZsJyhEyX+ZIStXS/XOHAZ6qqg+fKsj
         XgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYyMkExZ6IN/MMZJH5eyzLSmSbOQmGlTSTJDGYdD9iE=;
        b=T4rACisqj/1dssmWUrtS9ZAAStncQlrTU0HQejl7fD3ewGjRFDKQsRAALPTGWgsZM6
         q5+sgj5WT/oXztxvA3o74PXW0OyflkYqLC1EuF8vd9UtbyqqpCSimwl0I6Z/rDd98Spl
         fRv89ueArXByCVrdd8xxbQtvLY977vNKtA7cVG9hq73YzQxeWvxOQU/4Eu2J9baTQiPA
         vro/0joNCARavYBlUrGa0eZFREnykxAQ6FIDTbGgMhmMB7751Eds7ueuSdFEMNtxLjRj
         zC4UknnTRVRoV/xMkpdALUeUjkn+we5EmTUvwJcmbyHTM6F7l7jObR4QVMRMd/RB/fno
         S8Pg==
X-Gm-Message-State: AFqh2koA3zRYWrb/iMHKMyBIJm9kON6BR4U9aO2r2cJtx3YGCTvOLGm7
        6OLDif+1ouJ92YSCJDHuic3rg1e6Oy2kkqqN
X-Google-Smtp-Source: AMrXdXtTl1+9MnwHhRmB7/eZed+i8jveKPqK7mB3GpDCJDBRF4H0yNR54RNYPokijYxenyZm+eT4bA==
X-Received: by 2002:a17:906:6313:b0:872:6508:190 with SMTP id sk19-20020a170906631300b0087265080190mr37952541ejc.6.1674676270632;
        Wed, 25 Jan 2023 11:51:10 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:10 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 07/18] can: m_can: Keep interrupts enabled during peripheral read
Date:   Wed, 25 Jan 2023 20:50:48 +0100
Message-Id: <20230125195059.630377-8-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Interrupts currently get disabled if the interrupt status shows new
received data. Non-peripheral chips handle receiving in a worker thread,
but peripheral chips are handling the receive process in the threaded
interrupt routine itself without scheduling it for a different worker.
So there is no need to disable interrupts for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ef5ca5d37b0d..78f6ed744c36 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -972,8 +972,8 @@ static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
 	/* Don't re-enable interrupts if the driver had a fatal error
 	 * (e.g., FIFO read failure).
 	 */
-	if (work_done >= 0)
-		m_can_enable_all_interrupts(cdev);
+	if (work_done < 0)
+		m_can_disable_all_interrupts(cdev);
 
 	return work_done;
 }
@@ -1095,11 +1095,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	 */
 	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
 		cdev->irqstatus = ir;
-		m_can_disable_all_interrupts(cdev);
-		if (!cdev->is_peripheral)
+		if (!cdev->is_peripheral) {
+			m_can_disable_all_interrupts(cdev);
 			napi_schedule(&cdev->napi);
-		else if (m_can_rx_peripheral(dev, ir) < 0)
+		} else if (m_can_rx_peripheral(dev, ir) < 0) {
 			goto out_fail;
+		}
 	}
 
 	if (cdev->version == 30) {
-- 
2.39.0

