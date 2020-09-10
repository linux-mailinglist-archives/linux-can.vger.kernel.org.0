Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB1265375
	for <lists+linux-can@lfdr.de>; Thu, 10 Sep 2020 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIJVfZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Sep 2020 17:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgIJNkV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2020 09:40:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17584C06179F
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so4267989pgl.4
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0UJlMMYS97ZEd1pzZy1E70sLlZzGqr7O+AUirQ/jf8=;
        b=JWLt/K0QwNvzoj6nxqKPcWAMMXsRyj3oN5+4omDOjxwKh6VeMqT0tOggHi3F5AYIbt
         hyxo5lP35yLC+r5RRZWsGyW9UD6G6hm5mW+ADILi1Dx59pSfOnkl9/xG79xybquIlCoH
         DyvTbrQzw43bvNGC6PdmN3nZHYQSm/Xd0bIqyFoCceAhDa5mfOugjvUD8i8vrGipBWg+
         lrW5SQU3A/CUOJncDK5n26xHziFS7caOipKAve2w4lQ5me4Pe3f0dwnvCJTbfJyXp414
         AhmAVU5GTrcKuNrA3ZaUk+yiBVryOa4cmozrqoePAqtkn7dyg53KoTrqedbYX86jouPV
         yNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0UJlMMYS97ZEd1pzZy1E70sLlZzGqr7O+AUirQ/jf8=;
        b=qsv9jyjhTzl+eaFDMyCXoQP9DW7CqWICeQahFFBgesIhXby+U9Ot4NpM4wXSfNkcdr
         Ca6P9dI6+IZKYepoHf3L8HPVTQsue9H3QOKubdxAwILl2qqhNw6n6ClGDLJ9+wwLnC//
         P1MoHj+4oPT5uRsIKj6I5DdF/As6X1FmDTB4Q4ZApHRRI4NNDIyyTXR1lT9P1iEr/SRa
         CMsbBrM6LlXVvLnvSOCIJjFvAOdNjXi2NFNR6wie1Oio2SALAhB6vmgygUxNQ3moGC4Z
         tiwe/EI0EXPPjHBegOAOQf++pQBRsuCSgttt16wSZqRWF++F4IPiUuHxKt5bvVdd4bzk
         dfrg==
X-Gm-Message-State: AOAM532cEqja2Vpbic/Sqn6XY3mNfuNTK3J9HE+rJHD4W4y0LPXQI3Ly
        Gii8uGi0qBatlnpGv+9QJ6rd
X-Google-Smtp-Source: ABdhPJzqI5xjENQcYNVIlYz3X+XwkhIeEHTTbg43DOqqVs41K+m+0e9zySQ0dINzjL9/TNZ774pDzQ==
X-Received: by 2002:a62:19c2:: with SMTP id 185mr5497347pfz.1.1599745115588;
        Thu, 10 Sep 2020 06:38:35 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id o30sm5603801pgc.45.2020.09.10.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:38:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        o.rempel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/6] can: mcp25xxfd: add listen-only mode
Date:   Thu, 10 Sep 2020 19:08:05 +0530
Message-Id: <20200910133806.25077-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This commit enables listen-only mode, which works internally like CANFD mode.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index eea3ef69f585..905ea98448cd 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -392,7 +392,8 @@ static int mcp25xxfd_ring_alloc(struct mcp25xxfd_priv *priv)
 	int ram_free, i;
 
 	tef_obj_size = sizeof(struct mcp25xxfd_hw_tef_obj);
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+	/* listen-only mode works like FD mode */
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD)) {
 		tx_obj_num = MCP25XXFD_TX_OBJ_NUM_CANFD;
 		tx_obj_size = sizeof(struct mcp25xxfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp25xxfd_hw_rx_obj_canfd);
@@ -807,7 +808,7 @@ mcp25xxfd_chip_rx_fifo_init_one(const struct mcp25xxfd_priv *priv,
 		MCP25XXFD_REG_FIFOCON_RXOVIE |
 		MCP25XXFD_REG_FIFOCON_TFNRFNIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD))
 		fifo_con |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				       MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -857,7 +858,7 @@ static int mcp25xxfd_chip_fifo_init(const struct mcp25xxfd_priv *priv)
 		MCP25XXFD_REG_FIFOCON_TXEN |
 		MCP25XXFD_REG_FIFOCON_TXATIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD))
 		val |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				  MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -930,7 +931,9 @@ static u8 mcp25xxfd_get_normal_mode(const struct mcp25xxfd_priv *priv)
 {
 	u8 mode;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		mode = MCP25XXFD_REG_CON_MODE_LISTENONLY;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		mode = MCP25XXFD_REG_CON_MODE_MIXED;
 	else
 		mode = MCP25XXFD_REG_CON_MODE_CAN2_0;
@@ -2767,8 +2770,9 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp25xxfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp25xxfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp25xxfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
-		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
+		CAN_CTRLMODE_FD_NON_ISO;
 	priv->ndev = ndev;
 	priv->spi = spi;
 	priv->rx_int = rx_int;
-- 
2.17.1

