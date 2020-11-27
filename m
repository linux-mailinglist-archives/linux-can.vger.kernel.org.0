Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354D72C6A70
	for <lists+linux-can@lfdr.de>; Fri, 27 Nov 2020 18:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgK0RNJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 27 Nov 2020 12:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbgK0RNJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 27 Nov 2020 12:13:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15491C0613D1
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2020 09:13:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id k11so4817745pgq.2
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2020 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn11WTc6kb2VuxzT0TlUqdlna9y4XWGRb8BSebw/zIE=;
        b=Y9E7KZwNYgu+UtKmQEKvej+l8R73YAobvzahlqlDDMMUXzwHDgAAXQ4tMmXT4Q6zFh
         q1JLmt7vqegui8FFlMbE4LZcn1AxFgYOp5IymZ+lhA9zDozyfNTSUztJ7Vd4JP47JjjQ
         neXr3w74M/QJtWHokUbLsOtbHkSeRyvY/4c4hn8OIZ3wEtXD8ICyjnHHS5IG48cm9z7k
         D9N1mrao8gSHQKA+sH/i7ttMBMqcj9WroV3YvrLxTyeI9St6WjRA9YpDccTrFbqA7/VH
         PZ5TE998wxZMH48YUm3mK0I/BkwMRwV55AqiNTelNzkSXkNargLQeghplLJ4rbC8UY0R
         o1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn11WTc6kb2VuxzT0TlUqdlna9y4XWGRb8BSebw/zIE=;
        b=CYHlJiTkmvkPfqFcYgT83oB4Il88oTH9w4NlqjhLQbNJQTkkAfKcLoHnQmVndOQ0TA
         kw3cjxZAve79PJg/1hM3EZuBNPcgjSFW4mhC7fsa96w8vIqrazDnZ16QxLsIJxUZq+fs
         r6KDAm12Kxz4Y/CWUdDt2kR9E4gTWX1asx6emjKtQ9eYFDeMJK+h5K/8x7G00iJNdkkM
         WJZeWh4LYhKbNxCovNH+xy6tPKoLcy1uTG5PRLDXR4mnOhtIi5iq6xFPkpNwIy/jc5su
         pWDrrK9Xm6GDTGS47luU7wK+vZTpcYvlpr+4Kb7MY621AU1zevpR/rk2GAdsIAEIxN2B
         Mgnw==
X-Gm-Message-State: AOAM5327uqXvwHgJoClPHJJqa7/KrNBgzJHdUtSFEwDpw6INsTGpa7Ip
        MxNdCz0esbRoyJ+P8MUf+Vxk8OIKmZzj
X-Google-Smtp-Source: ABdhPJzK+IBpTOBVyErsotds+JFXeXYfAKEwvbw7DB0fvJEBS4uvbMeXeuSZUI8UC8wl889eouB2eg==
X-Received: by 2002:a17:90a:d58e:: with SMTP id v14mr11163782pju.191.1606497188446;
        Fri, 27 Nov 2020 09:13:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:88d:6f0d:1941:b53e:6208:a8c9])
        by smtp.gmail.com with ESMTPSA id 17sm8559823pfu.180.2020.11.27.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:13:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, thomas.kopp@microchip.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] can: mcp251xfd: Add support for internal loopback mode
Date:   Fri, 27 Nov 2020 22:42:57 +0530
Message-Id: <20201127171257.46040-1-manivannan.sadhasivam@linaro.org>
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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3297eb7ecc9c..7715b8b14f29 100644
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
 
@@ -2801,7 +2803,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
-		CAN_CTRLMODE_FD_NON_ISO;
+		CAN_CTRLMODE_FD_NON_ISO | CAN_CTRLMODE_LOOPBACK;
 	priv->ndev = ndev;
 	priv->spi = spi;
 	priv->rx_int = rx_int;
-- 
2.25.1

