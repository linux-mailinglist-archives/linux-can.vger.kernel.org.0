Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CC39A315
	for <lists+linux-can@lfdr.de>; Thu,  3 Jun 2021 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFCO0o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Jun 2021 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhFCO0o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Jun 2021 10:26:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884F9C06174A
        for <linux-can@vger.kernel.org>; Thu,  3 Jun 2021 07:24:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i67so6072090qkc.4
        for <linux-can@vger.kernel.org>; Thu, 03 Jun 2021 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP59I0JjAAzAi5Kr7DDx4sIfqPNVECDcPZLJXqMtNWs=;
        b=WZdb6vB2UZNJg81cUcf5d1BfPtT35vbiO3ut4/qqkVqMIyCG0770eWDcnHf+gio2WS
         hMYkwBs4i6NvrF7jgxIVpCco5GTrd1MqwnPhUL7ODrdUxoK4IsMoyFQA8CcIyqVtw+XM
         6BsW6eTLASGGkKzrQqv0MAMtXmd2i8i7G6lU2Ml7e80X8cS9Clg5+ITOvqVA1NcrBfkS
         VpNYUwGBm0PQnAaGOmYLBO5rsd8ix2ldvHzhYTu+dXvqX7yNTe4rnerb/4lZMyQfZJYS
         MHtZESGr6hve7LhJY+ZEWcW3EWGeCz1wnanG7x4Mxkx45Eo4fdJvcHtmfJ7YtHSnS5IZ
         YcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP59I0JjAAzAi5Kr7DDx4sIfqPNVECDcPZLJXqMtNWs=;
        b=I8A3jB5RkBHeNOT08H4LJol9lKSy9udjDyv4GZ+Rs5jncrmgS537E6N1W2ejL8oBTg
         ySAPcoVD0xG2tmyNp8m5qhrTuw1kJKUCWSFFLgKtg10jz98OtLYRParvzcnShs3UU+1C
         BjwEl0bGwz+9oI/sgRQRoCWucARkyfd2eWdvBw9a6p5elE3WEfhKdYk7VCGfmZ/PrL1t
         CfiNcud5smZwIbe/ivxcfOC/Rz+Oa2Bgkey4Atft0XkfTO7jO4q2tHcQGKBn4QQRVFeC
         IohKYG2J8sjxYsoj5sFj1mCDZ7V/nOiBqv/cxLxBOLL6t+fYcuwvg7MEer0RmJ6zxqS+
         t7Fg==
X-Gm-Message-State: AOAM5310+1D42G1hNDQRPQlBfo26fzAwcJSRAJ80OtLjN5i5Fvwzv/9i
        rSTPP/qwsLTR38wdT/AsOBk=
X-Google-Smtp-Source: ABdhPJxVYmky+OsFYaEclhdz5XB79xZXqmfV1F3wVmNGBEakgHvnIM20265doNn8nRZMcU07ZFqYsQ==
X-Received: by 2002:a05:620a:675:: with SMTP id a21mr32088907qkh.333.1622730298327;
        Thu, 03 Jun 2021 07:24:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:504a:1fe8:47aa:9548:352c])
        by smtp.gmail.com with ESMTPSA id c6sm2038332qke.83.2021.06.03.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:24:57 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] can: mcp251xfd: Align the table of comments
Date:   Thu,  3 Jun 2021 11:24:50 -0300
Message-Id: <20210603142450.2221703-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Align the table of comments for better readability.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 47c3f408a799..db07dd112603 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2957,14 +2957,14 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	 *
 	 * Known good combinations are:
 	 *
-	 * MCP	ext-clk	SoC			SPI			SPI-clk		max-clk	parent-clk	config
+	 * MCP		ext-clk SoC			SPI			SPI-clk	max-clk	parent-clk	config
 	 *
-	 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	 8333333 Hz	 83.33%	600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
-	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	16666667 Hz	 83.33%	600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
-	 * 2517	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	default
-	 * 2518	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	default
-	 * 2518	40 MHz	fsl,imx6dl		fsl,imx51-ecspi		15000000 Hz	 75.00%	 30000000 Hz	default
-	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 8333333 Hz	 83.33%	 16666667 Hz	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
+	 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	8333333 Hz	83.33%		600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
+	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	16666667 Hz	83.33%		600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
+	 * 2517	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	82.00%		82000000 Hz	default
+	 * 2518	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	82.00%		82000000 Hz	default
+	 * 2518	40 MHz	fsl,imx6dl		fsl,imx51-ecspi	15000000 Hz	75.00%		30000000 Hz	default
+	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi	8333333 Hz	83.33%		16666667 Hz	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
 	 *
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
-- 
2.25.1

