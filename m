Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E684372980
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhEDLV4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhEDLVz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:21:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D6C0613ED
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:20:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g65so5150823wmg.2
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAwBbYzvWD7oIUAO1sUhohUXvBfbHjObsY39o0c6Ua8=;
        b=J9D9jFg2jMWxFkY2kFAK+k1Jo5hmTgEBU+jSjDW8MRCUEfu24hG/D5zpYmmXePj5mJ
         OuUZUYRREuERu3+d5nAkbPWCGTyJjVUMKruIcPqXm9RN09kldujMfYMLqtze7I9pz2D7
         imMhBrvqgWmFjBRUmHrj4LkGrDNNNp7tsDBKhedDvEoxc+vxUCJmZgLjOg+eKXtk9+Ep
         TP9YMpMvtrodlkjGZ1/X4FLvgfEtK99ErA89/03vBwYd9GRJLfp/aQkzm0oDN2fAwZ7d
         6FXU5LBanLPJyvXeg+82DtDfOfTHzAVB3hJ0wDnsI8phE91GUoMhW9SE3JRZpckCKw4M
         T7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAwBbYzvWD7oIUAO1sUhohUXvBfbHjObsY39o0c6Ua8=;
        b=cFpItKuqyOz7bEq63NR5ZxlAVTv1sptylAYT8Nkh6KZoikqcrheWTLF5dE6sAk9D00
         HkOrtTUuhsO/LsNLHkR9Jvwd/2PYRP4L8j+D99EVB9uaFVjp4bctv3Hjr+2S8FqO9rU6
         hQoEX8UEpSC/SnjSam3aF2kDIJbQdmub3EKEvlBZ4XfPJP3x0V5a1OPB4kbFTHuI8DnZ
         gYgnL7QudrA1soeBjKRn/2NAoWwaJNmsBKMMiqQ2xFlC5YS2a0NbXnWCAVH4cSFmNcqO
         R28FNsSaEoDyzuCTG/sNR+PJ5bcJTOTYLq4ef1TlFrnO63KZepNrPljP9nfS8jGFXwUE
         WRpA==
X-Gm-Message-State: AOAM531wpkltGj4BRgf4XitmkMw5//+iXH7/Q7SlGuJKKcQcJT7WN9qs
        DVdq+vK6eTUfdtcBCIDzlLoCgSb7qtZrmz5u
X-Google-Smtp-Source: ABdhPJy8e6brJlwhmXyyGt/itKepOiWiUtAhw9LQE1HBBoOifZfrhqYd2WdG4SZ+KgmD12OhUoJelQ==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr26426833wmb.129.1620127257046;
        Tue, 04 May 2021 04:20:57 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id a21sm2222022wmj.34.2021.05.04.04.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:20:56 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 3/4] can: m_can: make TXESC, RXESC config more explicit
Date:   Tue,  4 May 2021 12:20:34 +0100
Message-Id: <20210504112035.336424-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504112035.336424-1-torin@maxiluxsystems.com>
References: <20210504112035.336424-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Introduce masks for the three RXESC fields (RBDS, F1DS, F0DS) and the
one TXESC field (TBDS). Update m_can_chip_config() to explicitly set all
four fields to the 64-byte option (0x7) (and these defs are renamed to
be more concise).

This is an improvement in maintainability, and also makes it easier to
implement more flexible configuration of the M_CAN buffers in the
future.
---
 drivers/net/can/m_can/m_can.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c85f064de4a0..e3b15b74fdc9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -235,8 +235,10 @@ enum m_can_reg {
 #define RXFS_FFL_MASK	GENMASK(6, 0)
 
 /* Rx Buffer / FIFO Element Size Configuration (RXESC) */
-#define M_CAN_RXESC_8BYTES	0x0
-#define M_CAN_RXESC_64BYTES	0x777
+#define RXESC_RBDS_MASK		GENMASK(10, 8)
+#define RXESC_F1DS_MASK		GENMASK(6, 4)
+#define RXESC_F0DS_MASK		GENMASK(2, 0)
+#define RXESC_64B		0x7
 
 /* Tx Buffer Configuration (TXBC) */
 #define TXBC_TFQS_MASK		GENMASK(29, 24)
@@ -249,8 +251,8 @@ enum m_can_reg {
 #define TXFQS_TFFL_MASK		GENMASK(5, 0)
 
 /* Tx Buffer Element Size Configuration(TXESC) */
-#define TXESC_TBDS_8BYTES	0x0
-#define TXESC_TBDS_64BYTES	0x7
+#define TXESC_TBDS_MASK		GENMASK(2, 0)
+#define TXESC_TBDS_64B		0x7
 
 /* Tx Event FIFO Configuration (TXEFC) */
 #define TXEFC_EFS_MASK		GENMASK(21, 16)
@@ -1191,7 +1193,10 @@ static void m_can_chip_config(struct net_device *dev)
 	m_can_config_endisable(cdev, true);
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
-	m_can_write(cdev, M_CAN_RXESC, M_CAN_RXESC_64BYTES);
+	m_can_write(cdev, M_CAN_RXESC,
+		    FIELD_PREP(RXESC_RBDS_MASK, RXESC_64B) |
+		    FIELD_PREP(RXESC_F1DS_MASK, RXESC_64B) |
+		    FIELD_PREP(RXESC_F0DS_MASK, RXESC_64B));
 
 	/* Accept Non-matching Frames Into FIFO 0 */
 	m_can_write(cdev, M_CAN_GFC, 0x0);
@@ -1209,7 +1214,8 @@ static void m_can_chip_config(struct net_device *dev)
 	}
 
 	/* support 64 bytes payload */
-	m_can_write(cdev, M_CAN_TXESC, TXESC_TBDS_64BYTES);
+	m_can_write(cdev, M_CAN_TXESC,
+		    FIELD_PREP(TXESC_TBDS_MASK, TXESC_TBDS_64B));
 
 	/* TX Event FIFO */
 	if (cdev->version == 30) {
-- 
2.30.2

