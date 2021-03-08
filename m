Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29164330B1B
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCHK31 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 05:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhCHK3D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 05:29:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307BC06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 02:29:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso3455759wma.4
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntjz99eGbcCmBF9YbK3dqesU05y6VpRY2bKNWtXqwvY=;
        b=zWjM8G7rJOvm2XLRS4Y92/ckN798w0+i0e/J8l223p2kYzfqJwDVrEfpKth33yJToa
         v9zQspyvB+XwH0m47/Qa9l7ZzrjydD4AeFrg0Iyt4e9gumyNYwV6X4CbtAtiq5bwdoM2
         g+LtxoIoyTunLrOsVnMD/hXF3227luyHEp8lq4cgNfng0o0DnI1DVmc5GlqmDXES5Y4k
         +7b1NxeNhlqvNvWLFssdVNeA8KZgJZ9hw5lAhtZVMNWmjNkZC564WdHdLa2zjlI97OP4
         nHkszC8mX+oHxq9XWqlSwmBigF9mOC6haPdTHmEfaB2AQq9gLH0c4MktveioPoTl0Tlz
         1PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntjz99eGbcCmBF9YbK3dqesU05y6VpRY2bKNWtXqwvY=;
        b=tRAS1i4NOemNeyqm2qCF8loSj0iri04q1cUojaX1msqwHyOOuJBSDCgokLy+a3Eq/e
         3XmnzKmr/DFIgiqy/R3sUFmQqrHgdRxS9qXAalHrWBRwU2T3xiukpyJ9hSewEaFkpiol
         tsGWqep1s3mUKiiVd10iF2AfVz9CK1NDcqfHXCKWmJ3c8WMHFG8Kqz2701BJ4rn/1k7+
         AcMBNt0nmM/hJ9kcN+MJq7pB2uApMAprvLo20IoHpGYcSNBR3/NhzHZeUd5xp6PzjINq
         0SmsOAbRxwnm3Xf+qplBc41Yw1HaGs4Fc/Rt7ARNrnqqp8O7TODeLvY/Diq9iB9L0rcP
         ZFLA==
X-Gm-Message-State: AOAM533Rrih3XdLJBW6RD/tnYCGbvEkYFyrrvsDDxV4PDz66s7kUPlIv
        FHk/yy8RqccWX4e8HccMX2H92kTiJbG786Zy
X-Google-Smtp-Source: ABdhPJyYaB+D3DDjwjFvoeIg0wSk7bv8M9JvhcbexglOtFCODZlAk6dx/kJp40tPF9B7veIzJ0745w==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr22056731wmk.89.1615199341456;
        Mon, 08 Mar 2021 02:29:01 -0800 (PST)
Received: from localhost.localdomain (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id i17sm6416455wrp.77.2021.03.08.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:29:01 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 1/3] can: m_can: add infrastructure for internal timestamps
Date:   Mon,  8 Mar 2021 10:24:26 +0000
Message-Id: <20210308102427.63916-2-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308102427.63916-1-torin@maxiluxsystems.com>
References: <20210308102427.63916-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add infrastucture to allow internal timestamps from the M_CAN to be
configured and retrieved.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3752520a7d4b..ce1fef95d34b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -8,6 +8,7 @@
  * https://github.com/linux-can/can-doc/tree/master/m_can
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -148,6 +149,16 @@ enum m_can_reg {
 #define NBTP_NTSEG2_SHIFT	0
 #define NBTP_NTSEG2_MASK	(0x7f << NBTP_NTSEG2_SHIFT)
 
+/* Timestamp Counter Configuration Register (TSCC) */
+#define TSCC_TCP_MASK		GENMASK(19, 16)
+#define TSCC_TSS_MASK		GENMASK(1, 0)
+#define TSCC_TSS_DISABLE	0x0
+#define TSCC_TSS_INTERNAL	0x1
+#define TSCC_TSS_EXTERNAL	0x2
+
+/* Timestamp Counter Value Register (TSCV) */
+#define TSCV_TSC_MASK		GENMASK(15, 0)
+
 /* Error Counter Register(ECR) */
 #define ECR_RP			BIT(15)
 #define ECR_REC_SHIFT		8
@@ -302,6 +313,7 @@ enum m_can_reg {
 #define RX_BUF_ANMF		BIT(31)
 #define RX_BUF_FDF		BIT(21)
 #define RX_BUF_BRS		BIT(20)
+#define RX_BUF_RXTS_MASK	GENMASK(15, 0)
 
 /* Tx Buffer Element */
 /* T0 */
@@ -319,6 +331,7 @@ enum m_can_reg {
 /* E1 */
 #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
 #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
+#define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
 
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
@@ -413,6 +426,20 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 	m_can_write(cdev, M_CAN_ILE, 0x0);
 }
 
+/* Retrieve internal timestamp counter from TSCV.TSC, and shift it to 32-bit
+ * width.
+ */
+static u32 m_can_get_timestamp(struct m_can_classdev *cdev)
+{
+	u32 tscv;
+	u32 tsc;
+
+	tscv = m_can_read(cdev, M_CAN_TSCV);
+	tsc = FIELD_GET(TSCV_TSC_MASK, tscv);
+
+	return (tsc << 16);
+}
+
 static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
-- 
2.30.1

