Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10042C9715
	for <lists+linux-can@lfdr.de>; Tue,  1 Dec 2020 06:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLAFlL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Dec 2020 00:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAFlK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Dec 2020 00:41:10 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90695C0613CF
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 21:40:30 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b12so548851pjl.0
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 21:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9RwzgqxqiFX2PhVulgXOzxS/wCoBJB+FuJtADD7Te14=;
        b=hwzGNgyJUsA5AaaHJnOGZJ6MluG609UU4cLDkRryyCgPlh4Ur7T120/z1Kcft0+Aoc
         ImKJkDTHIGpIz5RVLHBVBcyBefmtxb8go3SO5prK3qjEDiYnA3iRJOO5JX0zmLQF6NGD
         kDDjU0gneCQpI1pbd1lMHFbQVcXDr7NUy/0XXo/DUbw+mzFfnJRqbVTbTet8URGH0Dz9
         kVUd7jIK164pG5UtN95k9wJ0Lu5z19T+bKXwHGB8GExjuUuitlXSE6WWQgdMUGL5rLPS
         3dRtnqqhy28Ac4EzZLNU915IW4ORjA8UJ/MLi72+dydcdXNDWTCMYNUAV4u85ChvzSGi
         dvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9RwzgqxqiFX2PhVulgXOzxS/wCoBJB+FuJtADD7Te14=;
        b=jlxhd8q3DWZ8h+lFJi40WIKxuz+rr8V6gzasT/sOQBnegM8EsE437+BDSxomc/SWVC
         Gz6b/5b4z6/MQg3375CJO3dQoT7l1wNQRDErX+OiLWMG+SuYqHfgPu3gORBHTr2xlR/D
         ceA6qZB7tKSl0ao8dGDP43qJ3DkI+dB0/Sr4kxCwu+Bj+qwTzmPZOk+yJYxrckKLCi+C
         xQgOqzV723v/8EQzdRE+dHVvs2C2wJqUcP5q/92w/G+Y98StSyT1i6Gw+FEzTCH2f8tH
         P2rSUhquRi3XNq3xTlTH3DZqfZE/xrWMyEDysiy5jAzehU82sjhbOOxL89LK7rHZQHSU
         up6w==
X-Gm-Message-State: AOAM532nA1z0CLt97FniO/swucGPqMxyUMdVxFVGfKOV8BJ0IupNHtX4
        1y1NqdYY4hoQ5xrGu/n+Za4o4fnlVCge
X-Google-Smtp-Source: ABdhPJxKHIoa4eVUGCYjdOPJY/flhPUYhRqSFAwcXLAfbNTEbg7xIBsjWI9VQAHQK+vfTLmPMgZqOw==
X-Received: by 2002:a17:90a:2e8c:: with SMTP id r12mr1049344pjd.101.1606801229815;
        Mon, 30 Nov 2020 21:40:29 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id e21sm950531pfd.107.2020.11.30.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 21:40:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, thomas.kopp@microchip.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] can: mcp251xfd: Add support for internal loopback mode
Date:   Tue,  1 Dec 2020 11:10:19 +0530
Message-Id: <20201201054019.11012-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

MCP251xFD supports internal loopback mode which can be used to verify
CAN functionality in the absence of a real CAN device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Sorted ctrl modes as per the value

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3297eb7ecc9c..d9ef4cbcb8cd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -932,6 +932,8 @@ static u8 mcp251xfd_get_normal_mode(const struct mcp251xfd_priv *priv)
 		mode = MCP251XFD_REG_CON_MODE_LISTENONLY;
 	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		mode = MCP251XFD_REG_CON_MODE_MIXED;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		mode = MCP251XFD_REG_CON_MODE_INT_LOOPBACK;
 	else
 		mode = MCP251XFD_REG_CON_MODE_CAN2_0;
 
@@ -2799,9 +2801,9 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
-		CAN_CTRLMODE_FD_NON_ISO;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
+		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO;
 	priv->ndev = ndev;
 	priv->spi = spi;
 	priv->rx_int = rx_int;
-- 
2.25.1

