Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F061372A64
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhEDMw3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhEDMw2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:52:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ECBC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:51:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so9299625wry.1
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDy+zWMKLz3rfdgr/dzocowb/t4WqmC4WKn98XRnIW8=;
        b=dQLiuLUFv7/t+PlFMADlsARejBhEMxMsFqNxeL/W/o9ock3I2RME8sRV5pEpNy5nAo
         8fJ6SVvGkKmjGWJep1UWZrqy8p1kcrPMOZbqWd2xSCNoKnUSslcQp5VffvdsChvZUIHY
         RWdCxBSi62JIEmyer6M4trthmmd7YcE5N8yoPBVV6OAmr4RiWVuzPVV1b485KNEJt6mv
         zQGI5XVzAvax56sKM+dee8eiXisPTO04RUCLRXfH0K/0PSmy5q+YM0y7bZZue4l1VayP
         1ksLPOssJEuDYo2uAEDIG4dRo/FWfmZNjtj21jp67Z7b2qzGqX8v5O++1jwfiqSW6+BG
         yDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDy+zWMKLz3rfdgr/dzocowb/t4WqmC4WKn98XRnIW8=;
        b=ZEHJj6SLysQZWJrXK1vDXGrdOMIVy98WqSo0mjRMPHod59CuTAvZfdN2IWm/pfGKU+
         rabHexAT5hLkvKeeKXv/Ynj+4b2F3bachmrbd+bsPnQUinQPbvsh3tK34EcYm2cMJUGB
         FITrEdVB1JBn0oAHGvTn8f6Hab3rKUHcrjpijtMbgG35mqe34la9g1ukfSeWnTlt1WmP
         CgOQCAMZ7VS8GKYq1V1qxe6xpljqO72Xhf7+XqVGR1N3s07J7twNBhOPphAbMPbf6YCc
         Vgni9XP+DFuZF3ITxH0/mtbOrYsg5PumXepPvHl0AH2TyhzEXIXJjR2MY8CV5PVkOTzy
         Nrfg==
X-Gm-Message-State: AOAM533LeheP/9CYDNelhAl/k5NyTdp6Asiq3BsbcELsnkzgzVPSXxJm
        zeKL3Ut8nsSGOAcVFC7pgeFUiKhBCkQu4s+R
X-Google-Smtp-Source: ABdhPJz3jgNr59orF8L9e0F2fd4Kz11Hhm8p6fW7ZF9iRa0kyGfocYKPF/saHKj7qiQyKqQA0Mm7pg==
X-Received: by 2002:a05:6000:511:: with SMTP id a17mr14259186wrf.351.1620132691355;
        Tue, 04 May 2021 05:51:31 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n5sm11679527wrx.31.2021.05.04.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:51:30 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 1/4] can: m_can: use bits.h macros for all regmasks
Date:   Tue,  4 May 2021 13:51:20 +0100
Message-Id: <20210504125123.500553-2-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504125123.500553-1-torin@maxiluxsystems.com>
References: <20210504125123.500553-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This updates m_can.c to exclusively use GENMASK, FIELD_GET, FIELD_PREP
and FIELD_MAX for regmask ops, as is convention in the current kernel
(far less error-prone, far more concise).

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 199 +++++++++++++++-------------------
 1 file changed, 86 insertions(+), 113 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 34073cd077e4..60f361a5f95a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -83,41 +83,30 @@ enum m_can_reg {
 #define MRAM_CFG_LEN	8
 
 /* Core Release Register (CREL) */
-#define CREL_REL_SHIFT		28
-#define CREL_REL_MASK		(0xF << CREL_REL_SHIFT)
-#define CREL_STEP_SHIFT		24
-#define CREL_STEP_MASK		(0xF << CREL_STEP_SHIFT)
-#define CREL_SUBSTEP_SHIFT	20
-#define CREL_SUBSTEP_MASK	(0xF << CREL_SUBSTEP_SHIFT)
+#define CREL_REL_MASK		GENMASK(31, 28)
+#define CREL_STEP_MASK		GENMASK(27, 24)
+#define CREL_SUBSTEP_MASK	GENMASK(23, 20)
 
 /* Data Bit Timing & Prescaler Register (DBTP) */
 #define DBTP_TDC		BIT(23)
-#define DBTP_DBRP_SHIFT		16
-#define DBTP_DBRP_MASK		(0x1f << DBTP_DBRP_SHIFT)
-#define DBTP_DTSEG1_SHIFT	8
-#define DBTP_DTSEG1_MASK	(0x1f << DBTP_DTSEG1_SHIFT)
-#define DBTP_DTSEG2_SHIFT	4
-#define DBTP_DTSEG2_MASK	(0xf << DBTP_DTSEG2_SHIFT)
-#define DBTP_DSJW_SHIFT		0
-#define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
+#define DBTP_DBRP_MASK		GENMASK(20, 16)
+#define DBTP_DTSEG1_MASK	GENMASK(12, 8)
+#define DBTP_DTSEG2_MASK	GENMASK(7, 4)
+#define DBTP_DSJW_MASK		GENMASK(3, 0)
 
 /* Transmitter Delay Compensation Register (TDCR) */
-#define TDCR_TDCO_SHIFT		8
-#define TDCR_TDCO_MASK		(0x7F << TDCR_TDCO_SHIFT)
-#define TDCR_TDCF_SHIFT		0
-#define TDCR_TDCF_MASK		(0x7F << TDCR_TDCF_SHIFT)
+#define TDCR_TDCO_MASK		GENMASK(14, 8)
+#define TDCR_TDCF_MASK		GENMASK(6, 0)
 
 /* Test Register (TEST) */
 #define TEST_LBCK		BIT(4)
 
 /* CC Control Register(CCCR) */
-#define CCCR_CMR_MASK		0x3
-#define CCCR_CMR_SHIFT		10
+#define CCCR_CMR_MASK		GENMASK(11, 10)
 #define CCCR_CMR_CANFD		0x1
 #define CCCR_CMR_CANFD_BRS	0x2
 #define CCCR_CMR_CAN		0x3
-#define CCCR_CME_MASK		0x3
-#define CCCR_CME_SHIFT		8
+#define CCCR_CME_MASK		GENMASK(9, 8)
 #define CCCR_CME_CAN		0
 #define CCCR_CME_CANFD		0x1
 #define CCCR_CME_CANFD_BRS	0x2
@@ -130,7 +119,7 @@ enum m_can_reg {
 #define CCCR_ASM		BIT(2)
 #define CCCR_CCE		BIT(1)
 #define CCCR_INIT		BIT(0)
-#define CCCR_CANFD		0x10
+#define CCCR_CANFD		BIT(4)
 /* for version >=3.1.x */
 #define CCCR_EFBI		BIT(13)
 #define CCCR_PXHD		BIT(12)
@@ -140,14 +129,10 @@ enum m_can_reg {
 #define CCCR_NISO		BIT(15)
 
 /* Nominal Bit Timing & Prescaler Register (NBTP) */
-#define NBTP_NSJW_SHIFT		25
-#define NBTP_NSJW_MASK		(0x7f << NBTP_NSJW_SHIFT)
-#define NBTP_NBRP_SHIFT		16
-#define NBTP_NBRP_MASK		(0x1ff << NBTP_NBRP_SHIFT)
-#define NBTP_NTSEG1_SHIFT	8
-#define NBTP_NTSEG1_MASK	(0xff << NBTP_NTSEG1_SHIFT)
-#define NBTP_NTSEG2_SHIFT	0
-#define NBTP_NTSEG2_MASK	(0x7f << NBTP_NTSEG2_SHIFT)
+#define NBTP_NSJW_MASK		GENMASK(31, 25)
+#define NBTP_NBRP_MASK		GENMASK(24, 16)
+#define NBTP_NTSEG1_MASK	GENMASK(15, 8)
+#define NBTP_NTSEG2_MASK	GENMASK(6, 0)
 
 /* Timestamp Counter Configuration Register (TSCC) */
 #define TSCC_TCP_MASK		GENMASK(19, 16)
@@ -161,16 +146,14 @@ enum m_can_reg {
 
 /* Error Counter Register(ECR) */
 #define ECR_RP			BIT(15)
-#define ECR_REC_SHIFT		8
-#define ECR_REC_MASK		(0x7f << ECR_REC_SHIFT)
-#define ECR_TEC_SHIFT		0
-#define ECR_TEC_MASK		0xff
+#define ECR_REC_MASK		GENMASK(14, 8)
+#define ECR_TEC_MASK		GENMASK(7, 0)
 
 /* Protocol Status Register(PSR) */
 #define PSR_BO		BIT(7)
 #define PSR_EW		BIT(6)
 #define PSR_EP		BIT(5)
-#define PSR_LEC_MASK	0x7
+#define PSR_LEC_MASK	GENMASK(2, 0)
 
 /* Interrupt Register(IR) */
 #define IR_ALL_INT	0xffffffff
@@ -221,6 +204,7 @@ enum m_can_reg {
 			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
 			 IR_RF1L | IR_RF0L)
 #define IR_ERR_ALL_30X	(IR_ERR_STATE | IR_ERR_BUS_30X)
+
 /* Interrupts for version >= 3.1.x */
 #define IR_ERR_LEC_31X	(IR_PED | IR_PEA)
 #define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_ELO | IR_BEU | \
@@ -237,58 +221,45 @@ enum m_can_reg {
 #define ILE_EINT0	BIT(0)
 
 /* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
-#define RXFC_FWM_SHIFT	24
-#define RXFC_FWM_MASK	(0x7f << RXFC_FWM_SHIFT)
-#define RXFC_FS_SHIFT	16
-#define RXFC_FS_MASK	(0x7f << RXFC_FS_SHIFT)
+#define RXFC_FWM_MASK	GENMASK(30, 24)
+#define RXFC_FS_MASK	GENMASK(22, 16)
 
 /* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
 #define RXFS_RFL	BIT(25)
 #define RXFS_FF		BIT(24)
-#define RXFS_FPI_SHIFT	16
-#define RXFS_FPI_MASK	0x3f0000
-#define RXFS_FGI_SHIFT	8
-#define RXFS_FGI_MASK	0x3f00
-#define RXFS_FFL_MASK	0x7f
+#define RXFS_FPI_MASK	GENMASK(21, 16)
+#define RXFS_FGI_MASK	GENMASK(13, 8)
+#define RXFS_FFL_MASK	GENMASK(6, 0)
 
 /* Rx Buffer / FIFO Element Size Configuration (RXESC) */
 #define M_CAN_RXESC_8BYTES	0x0
 #define M_CAN_RXESC_64BYTES	0x777
 
-/* Tx Buffer Configuration(TXBC) */
-#define TXBC_NDTB_SHIFT		16
-#define TXBC_NDTB_MASK		(0x3f << TXBC_NDTB_SHIFT)
-#define TXBC_TFQS_SHIFT		24
-#define TXBC_TFQS_MASK		(0x3f << TXBC_TFQS_SHIFT)
+/* Tx Buffer Configuration (TXBC) */
+#define TXBC_TFQS_MASK		GENMASK(29, 24)
+#define TXBC_NDTB_MASK		GENMASK(21, 16)
 
 /* Tx FIFO/Queue Status (TXFQS) */
 #define TXFQS_TFQF		BIT(21)
-#define TXFQS_TFQPI_SHIFT	16
-#define TXFQS_TFQPI_MASK	(0x1f << TXFQS_TFQPI_SHIFT)
-#define TXFQS_TFGI_SHIFT	8
-#define TXFQS_TFGI_MASK		(0x1f << TXFQS_TFGI_SHIFT)
-#define TXFQS_TFFL_SHIFT	0
-#define TXFQS_TFFL_MASK		(0x3f << TXFQS_TFFL_SHIFT)
+#define TXFQS_TFQPI_MASK	GENMASK(20, 16)
+#define TXFQS_TFGI_MASK		GENMASK(12, 8)
+#define TXFQS_TFFL_MASK		GENMASK(5, 0)
 
 /* Tx Buffer Element Size Configuration(TXESC) */
 #define TXESC_TBDS_8BYTES	0x0
 #define TXESC_TBDS_64BYTES	0x7
 
 /* Tx Event FIFO Configuration (TXEFC) */
-#define TXEFC_EFS_SHIFT		16
-#define TXEFC_EFS_MASK		(0x3f << TXEFC_EFS_SHIFT)
+#define TXEFC_EFS_MASK		GENMASK(21, 16)
 
 /* Tx Event FIFO Status (TXEFS) */
 #define TXEFS_TEFL		BIT(25)
 #define TXEFS_EFF		BIT(24)
-#define TXEFS_EFGI_SHIFT	8
-#define	TXEFS_EFGI_MASK		(0x1f << TXEFS_EFGI_SHIFT)
-#define TXEFS_EFFL_SHIFT	0
-#define TXEFS_EFFL_MASK		(0x3f << TXEFS_EFFL_SHIFT)
+#define TXEFS_EFGI_MASK		GENMASK(12, 8)
+#define TXEFS_EFFL_MASK		GENMASK(5, 0)
 
 /* Tx Event FIFO Acknowledge (TXEFA) */
-#define TXEFA_EFAI_SHIFT	0
-#define TXEFA_EFAI_MASK		(0x1f << TXEFA_EFAI_SHIFT)
+#define TXEFA_EFAI_MASK		GENMASK(4, 0)
 
 /* Message RAM Configuration (in bytes) */
 #define SIDF_ELEMENT_SIZE	4
@@ -324,13 +295,12 @@ enum m_can_reg {
 #define TX_BUF_EFC		BIT(23)
 #define TX_BUF_FDF		BIT(21)
 #define TX_BUF_BRS		BIT(20)
-#define TX_BUF_MM_SHIFT		24
-#define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
+#define TX_BUF_MM_MASK		GENMASK(31, 24)
+#define TX_BUF_DLC_MASK		GENMASK(19, 16)
 
 /* Tx event FIFO Element */
 /* E1 */
-#define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
-#define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
+#define TX_EVENT_MM_MASK	GENMASK(31, 24)
 #define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
 
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
@@ -449,8 +419,8 @@ static void m_can_clean(struct net_device *net)
 
 		net->stats.tx_errors++;
 		if (cdev->version > 30)
-			putidx = ((m_can_read(cdev, M_CAN_TXFQS) &
-				   TXFQS_TFQPI_MASK) >> TXFQS_TFQPI_SHIFT);
+			putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+					   m_can_read(cdev, M_CAN_TXFQS));
 
 		can_free_echo_skb(cdev->net, putidx, NULL);
 		cdev->tx_skb = NULL;
@@ -490,7 +460,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	int i;
 
 	/* calculate the fifo get index for where to read data */
-	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_SHIFT;
+	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
 	dlc = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC);
 	if (dlc & RX_BUF_FDF)
 		skb = alloc_canfd_skb(dev, &cf);
@@ -663,8 +633,8 @@ static int __m_can_get_berr_counter(const struct net_device *dev,
 	unsigned int ecr;
 
 	ecr = m_can_read(cdev, M_CAN_ECR);
-	bec->rxerr = (ecr & ECR_REC_MASK) >> ECR_REC_SHIFT;
-	bec->txerr = (ecr & ECR_TEC_MASK) >> ECR_TEC_SHIFT;
+	bec->rxerr = FIELD_GET(ECR_REC_MASK, ecr);
+	bec->txerr = FIELD_GET(ECR_TEC_MASK, ecr);
 
 	return 0;
 }
@@ -1004,24 +974,23 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	m_can_txefs = m_can_read(cdev, M_CAN_TXEFS);
 
 	/* Get Tx Event fifo element count */
-	txe_count = (m_can_txefs & TXEFS_EFFL_MASK) >> TXEFS_EFFL_SHIFT;
+	txe_count = FIELD_GET(TXEFS_EFFL_MASK, m_can_txefs);
 
 	/* Get and process all sent elements */
 	for (i = 0; i < txe_count; i++) {
 		u32 txe, timestamp = 0;
 
 		/* retrieve get index */
-		fgi = (m_can_read(cdev, M_CAN_TXEFS) & TXEFS_EFGI_MASK) >>
-			TXEFS_EFGI_SHIFT;
+		fgi = FIELD_GET(TXEFS_EFGI_MASK, m_can_read(cdev, M_CAN_TXEFS));
 
 		/* get message marker, timestamp */
 		txe = m_can_txe_fifo_read(cdev, fgi, 4);
-		msg_mark = (txe & TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
+		msg_mark = FIELD_GET(TX_EVENT_MM_MASK, txe);
 		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe);
 
 		/* ack txe element */
-		m_can_write(cdev, M_CAN_TXEFA, (TXEFA_EFAI_MASK &
-						(fgi << TXEFA_EFAI_SHIFT)));
+		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
+							  fgi));
 
 		/* update stats */
 		m_can_tx_update_stats(cdev, msg_mark, timestamp);
@@ -1147,8 +1116,10 @@ static int m_can_set_bittiming(struct net_device *dev)
 	sjw = bt->sjw - 1;
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
-	reg_btp = (brp << NBTP_NBRP_SHIFT) | (sjw << NBTP_NSJW_SHIFT) |
-		(tseg1 << NBTP_NTSEG1_SHIFT) | (tseg2 << NBTP_NTSEG2_SHIFT);
+	reg_btp = FIELD_PREP(NBTP_NBRP_MASK, brp) |
+		  FIELD_PREP(NBTP_NSJW_MASK, sjw) |
+		  FIELD_PREP(NBTP_NTSEG1_MASK, tseg1) |
+		  FIELD_PREP(NBTP_NTSEG2_MASK, tseg2);
 	m_can_write(cdev, M_CAN_NBTP, reg_btp);
 
 	if (cdev->can.ctrlmode & CAN_CTRLMODE_FD) {
@@ -1185,13 +1156,13 @@ static int m_can_set_bittiming(struct net_device *dev)
 
 			reg_btp |= DBTP_TDC;
 			m_can_write(cdev, M_CAN_TDCR,
-				    tdco << TDCR_TDCO_SHIFT);
+				    FIELD_PREP(TDCR_TDCO_MASK, tdco));
 		}
 
-		reg_btp |= (brp << DBTP_DBRP_SHIFT) |
-			(sjw << DBTP_DSJW_SHIFT) |
-			(tseg1 << DBTP_DTSEG1_SHIFT) |
-			(tseg2 << DBTP_DTSEG2_SHIFT);
+		reg_btp = FIELD_PREP(NBTP_NBRP_MASK, brp) |
+			  FIELD_PREP(NBTP_NSJW_MASK, sjw) |
+			  FIELD_PREP(NBTP_NTSEG1_MASK, tseg1) |
+			  FIELD_PREP(NBTP_NTSEG2_MASK, tseg2);
 
 		m_can_write(cdev, M_CAN_DBTP, reg_btp);
 	}
@@ -1224,13 +1195,14 @@ static void m_can_chip_config(struct net_device *dev)
 
 	if (cdev->version == 30) {
 		/* only support one Tx Buffer currently */
-		m_can_write(cdev, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
+		m_can_write(cdev, M_CAN_TXBC, FIELD_PREP(TXBC_NDTB_MASK, 1) |
 			    cdev->mcfg[MRAM_TXB].off);
 	} else {
 		/* TX FIFO is used for newer IP Core versions */
 		m_can_write(cdev, M_CAN_TXBC,
-			    (cdev->mcfg[MRAM_TXB].num << TXBC_TFQS_SHIFT) |
-			    (cdev->mcfg[MRAM_TXB].off));
+			    FIELD_PREP(TXBC_TFQS_MASK,
+				       cdev->mcfg[MRAM_TXB].num) |
+			    cdev->mcfg[MRAM_TXB].off);
 	}
 
 	/* support 64 bytes payload */
@@ -1238,23 +1210,24 @@ static void m_can_chip_config(struct net_device *dev)
 
 	/* TX Event FIFO */
 	if (cdev->version == 30) {
-		m_can_write(cdev, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
+		m_can_write(cdev, M_CAN_TXEFC,
+			    FIELD_PREP(TXEFC_EFS_MASK, 1) |
 			    cdev->mcfg[MRAM_TXE].off);
 	} else {
 		/* Full TX Event FIFO is used */
 		m_can_write(cdev, M_CAN_TXEFC,
-			    ((cdev->mcfg[MRAM_TXE].num << TXEFC_EFS_SHIFT)
-			     & TXEFC_EFS_MASK) |
+			    FIELD_PREP(TXEFC_EFS_MASK,
+				       cdev->mcfg[MRAM_TXE].num) |
 			    cdev->mcfg[MRAM_TXE].off);
 	}
 
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(cdev, M_CAN_RXF0C,
-		    (cdev->mcfg[MRAM_RXF0].num << RXFC_FS_SHIFT) |
+		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF0].num) |
 		    cdev->mcfg[MRAM_RXF0].off);
 
 	m_can_write(cdev, M_CAN_RXF1C,
-		    (cdev->mcfg[MRAM_RXF1].num << RXFC_FS_SHIFT) |
+		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF1].num) |
 		    cdev->mcfg[MRAM_RXF1].off);
 
 	cccr = m_can_read(cdev, M_CAN_CCCR);
@@ -1264,11 +1237,11 @@ static void m_can_chip_config(struct net_device *dev)
 		/* Version 3.0.x */
 
 		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_DAR |
-			  (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
-			  (CCCR_CME_MASK << CCCR_CME_SHIFT));
+			  FIELD_PREP(CCCR_CMR_MASK, FIELD_MAX(CCCR_CMR_MASK)) |
+			  FIELD_PREP(CCCR_CME_MASK, FIELD_MAX(CCCR_CME_MASK)));
 
 		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD)
-			cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
+			cccr |= FIELD_PREP(CCCR_CME_MASK, CCCR_CME_CANFD_BRS);
 
 	} else {
 		/* Version 3.1.x or 3.2.x */
@@ -1372,8 +1345,8 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
 	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
 	 */
 	crel_reg = m_can_read(cdev, M_CAN_CREL);
-	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
-	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
+	rel = (u8)FIELD_GET(CREL_REL_MASK, crel_reg);
+	step = (u8)FIELD_GET(CREL_STEP_MASK, crel_reg);
 
 	if (rel == 3) {
 		/* M_CAN v3.x.y: create return value */
@@ -1591,16 +1564,16 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD) {
 			cccr = m_can_read(cdev, M_CAN_CCCR);
-			cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
+			cccr &= ~CCCR_CMR_MASK;
 			if (can_is_canfd_skb(skb)) {
 				if (cf->flags & CANFD_BRS)
-					cccr |= CCCR_CMR_CANFD_BRS <<
-						CCCR_CMR_SHIFT;
+					cccr |= FIELD_PREP(CCCR_CMR_MASK,
+							   CCCR_CMR_CANFD_BRS);
 				else
-					cccr |= CCCR_CMR_CANFD <<
-						CCCR_CMR_SHIFT;
+					cccr |= FIELD_PREP(CCCR_CMR_MASK,
+							   CCCR_CMR_CANFD);
 			} else {
-				cccr |= CCCR_CMR_CAN << CCCR_CMR_SHIFT;
+				cccr |= FIELD_PREP(CCCR_CMR_MASK, CCCR_CMR_CAN);
 			}
 			m_can_write(cdev, M_CAN_CCCR, cccr);
 		}
@@ -1627,8 +1600,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		}
 
 		/* get put index for frame */
-		putidx = ((m_can_read(cdev, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
-			  >> TXFQS_TFQPI_SHIFT);
+		putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+				   m_can_read(cdev, M_CAN_TXFQS));
 		/* Write ID Field to FIFO Element */
 		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id);
 
@@ -1646,9 +1619,9 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		 * sending the correct echo frame
 		 */
 		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC,
-				 ((putidx << TX_BUF_MM_SHIFT) &
-				  TX_BUF_MM_MASK) |
-				 (can_fd_len2dlc(cf->len) << 16) |
+				 FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+				 FIELD_PREP(TX_BUF_DLC_MASK,
+					    can_fd_len2dlc(cf->len)) |
 				 fdflags | TX_BUF_EFC);
 
 		for (i = 0; i < cf->len; i += 4)
@@ -1809,11 +1782,11 @@ static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 	cdev->mcfg[MRAM_RXF0].off = cdev->mcfg[MRAM_XIDF].off +
 		cdev->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
 	cdev->mcfg[MRAM_RXF0].num = mram_config_vals[3] &
-		(RXFC_FS_MASK >> RXFC_FS_SHIFT);
+		FIELD_MAX(RXFC_FS_MASK);
 	cdev->mcfg[MRAM_RXF1].off = cdev->mcfg[MRAM_RXF0].off +
 		cdev->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
 	cdev->mcfg[MRAM_RXF1].num = mram_config_vals[4] &
-		(RXFC_FS_MASK >> RXFC_FS_SHIFT);
+		FIELD_MAX(RXFC_FS_MASK);
 	cdev->mcfg[MRAM_RXB].off = cdev->mcfg[MRAM_RXF1].off +
 		cdev->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
 	cdev->mcfg[MRAM_RXB].num = mram_config_vals[5];
@@ -1823,7 +1796,7 @@ static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 	cdev->mcfg[MRAM_TXB].off = cdev->mcfg[MRAM_TXE].off +
 		cdev->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
 	cdev->mcfg[MRAM_TXB].num = mram_config_vals[7] &
-		(TXBC_NDTB_MASK >> TXBC_NDTB_SHIFT);
+		FIELD_MAX(TXBC_NDTB_MASK);
 
 	dev_dbg(cdev->dev,
 		"sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
-- 
2.30.2

