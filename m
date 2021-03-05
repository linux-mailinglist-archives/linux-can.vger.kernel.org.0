Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D536432F10C
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCERVu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCERVc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 12:21:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C76C061574
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 09:21:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d11so2911790wrj.7
        for <linux-can@vger.kernel.org>; Fri, 05 Mar 2021 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpnDtJcA9bj8waI+3svnc91FUe91K2daFVSXTcPdcz8=;
        b=iSdF/02CEyw+Xl0GatGsrHBecJJMeCAF9bkGP6UWVejUL1WUK4B0Y6YF0Ae5WdCIkX
         70P8fWy8Y5KI+0n6Hv430Y7B3xPe3GvNvXiTGs9xs3g7JYMui2LoSCpxh84LLn0j7ED8
         ENf0eu84AG+CYQG/RENO+D9+uIGcqQDiLvXGmbaTCMgNUC+zOcK5zlt2+X37aZrj+5zH
         +p7jvmw1vIRDavbDHZRg9c5jywVzlHk/Yc8zB1dM5w6kdfO7CaEntwBIEB8pFFZHSulI
         3POnm4JpuBu7/lQtBppZ+Kxl+b9N38I5KeCcN16PkFZ68Yq4MMaJFB0v0HYfWJHhIykJ
         QwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpnDtJcA9bj8waI+3svnc91FUe91K2daFVSXTcPdcz8=;
        b=c8O96YHeF+yRt5fmJ29GCsqsvZtVDGtCTn+YjZSwbQ8YIrp/lmCJ5MrPK2Z0HOKQ+K
         Gg6/lItzqJkuOf6Bs7iaREweKi0d5g465Mt7N17JxLf83+kMjMa2WNnQ19sKrsDHEgDk
         Y/uA7lX+qAgs9YIaDV/Wri0YqWXgMGAjwGUtie7lu2HIIb8YqbFTHCSoyEDD2wFtLG+a
         KBiT2tY5APnEhunoMkKp3csxxH+ISS8iK1yjWl1XUi3jsEd02HzOhYuUagKo7Ux6pTRG
         rxj53jBUzwchTCBZJuOLNiw2RxDCtlSY/aXvuj743XHlIbihl+0XwhoRpa7WUOeih3Tm
         qh6Q==
X-Gm-Message-State: AOAM530Ty+PeV9ZqdVS7xwTjLiI/krsaQVPP+XbqD+oaAR7nG1rQP72Y
        WcYU5QAtuCR55vvDBgaXmp1/MkoJiQgQrg==
X-Google-Smtp-Source: ABdhPJx3DlhiQ18ZoeYroAvLNbretXczqll5CdqrlRxX2fSpG948aOZ6hKDTV578DwMrvaI/18nxRg==
X-Received: by 2002:adf:a4d1:: with SMTP id h17mr10451184wrb.57.1614964890200;
        Fri, 05 Mar 2021 09:21:30 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.254])
        by smtp.gmail.com with ESMTPSA id c9sm5174926wmb.33.2021.03.05.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:21:29 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 1/3] can: m_can: add infrastructure for internal timestamps
Date:   Fri,  5 Mar 2021 17:20:13 +0000
Message-Id: <20210305172015.1506525-2-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305172015.1506525-1-torin@maxiluxsystems.com>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add infrastucture to allow internal timestamps from the M_CAN to be
configured and retrieved.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0c8d36bc668c..ea79cf0640a8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -148,6 +148,19 @@ enum m_can_reg {
 #define NBTP_NTSEG2_SHIFT	0
 #define NBTP_NTSEG2_MASK	(0x7f << NBTP_NTSEG2_SHIFT)
 
+/* Timestamp Counter Configuration Register (TSCC) */
+#define TSCC_TCP_SHIFT		16
+#define TSCC_TCP_MASK		(0xf << TSCC_TCP_SHIFT)
+#define TSCC_TSS_SHIFT		0
+#define TSCC_TSS_MASK		(0x3 << TSCC_TSS_SHIFT)
+#define TSCC_TSS_DISABLE	(0x0 << TSCC_TSS_SHIFT)
+#define TSCC_TSS_INTERNAL	(0x1 << TSCC_TSS_SHIFT)
+#define TSCC_TSS_EXTERNAL	(0x2 << TSCC_TSS_SHIFT)
+
+/* Timestamp Counter Value Register (TSCV) */
+#define TSCV_TSC_SHIFT		0
+#define TSCV_TSC_MASK		(0xffff << TSCV_TSC_SHIFT)
+
 /* Error Counter Register(ECR) */
 #define ECR_RP			BIT(15)
 #define ECR_REC_SHIFT		8
@@ -302,6 +315,8 @@ enum m_can_reg {
 #define RX_BUF_ANMF		BIT(31)
 #define RX_BUF_FDF		BIT(21)
 #define RX_BUF_BRS		BIT(20)
+#define RX_BUF_RXTS_SHIFT	0
+#define RX_BUF_RXTS_MASK	(0xffff << RX_BUF_RXTS_SHIFT)
 
 /* Tx Buffer Element */
 /* T0 */
@@ -319,6 +334,8 @@ enum m_can_reg {
 /* E1 */
 #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
 #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
+#define TX_EVENT_TXTS_SHIFT	0
+#define TX_EVENT_TXTS_MASK	(0xffff << TX_EVENT_TXTS_SHIFT)
 
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
@@ -413,6 +430,20 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
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
+	tsc = (tscv & TSCV_TSC_MASK) >> TSCV_TSC_SHIFT;
+
+	return (tsc << 16);
+}
+
 static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
-- 
2.30.1

