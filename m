Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E990B70D969
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjEWJpc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEWJp0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:26 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5154AE42
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:18 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2af316b4515so33481281fa.1
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835057; x=1687427057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+FLAxQv3u3Xregk4M66fqzDbMvpPYJNw1hFMyg5QMs=;
        b=Ga2Sxx7472k7Bmsy3usPYXZmoWY3g19kVijbMFqJEihSB1cRfwC+gE97K9QlBxJ9PP
         fOLj9BP9/yWZ5C03g/dRpat674R24lM3mbJJX009jYZTVajb0SJJ0vzsVm6K8biII9ub
         +ubaELLi341g7lfjlOMWpPTs2IPzIKy15+Mmvi3CeBGYioN4kTBwWUrbUP10Cix2FIEO
         uf3OMRbHg+86WatswUCd5xw6qv5Ir9vfhoDFNuvBYKLXuXf6m3DdKSD/mgeuGkXL19XA
         J17fqSKlADSMvRVfA4SZZTaB9p5dk3gZLa1ulOL4Io5RA9uV88crtx32UjzwVDXH3f5d
         eJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835057; x=1687427057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+FLAxQv3u3Xregk4M66fqzDbMvpPYJNw1hFMyg5QMs=;
        b=CKmqiIn0Ura5V+0jPqiJksLkkL1jGcLQSVgUtLLr2ruLF32RJ3SyNbNf9vZuSqcSxF
         q/jX5/3Ny1lw2Vj2E8wH/LFUqFpemar4KrSsTF1odGFJ9uwS5y+8OyEvBRU48qoWELo8
         LP56pban4AMDiWA4sjc2nZMa9MqWmUJpMdseY2qs9ky3AJCXhY87pQwfGvBtIf50KAom
         W4F3kIM5bZ/gg0/dQq0XMDQwo9trSXD/EBRZmndmnf8bPqI71OGaU+Ancl6eQxI2S9f9
         p5lPF7qQ5PVBGny/yoaUWXunH40qoSjaupY4ZzwGlDdeRBsGgBBgnhJWr7Uu87KxAbq2
         qJnQ==
X-Gm-Message-State: AC+VfDwo3GdtS7vErqvyyw7PcoT+Q3LmJqNd2kaINLMcfJUXCAIiTM0F
        7mUW+Pd5N3xXyIFAIS9cxmOhD2ZKqSmRqcZNI/s=
X-Google-Smtp-Source: ACHHUZ4KxOoIyxu6RWeYTBjBIBmZ6wDqf67ltcf83SrOp9LybuMLnsWImGEv4xZ/Jxz/BSadbvy2sw==
X-Received: by 2002:a2e:81ce:0:b0:2af:1807:9e6 with SMTP id s14-20020a2e81ce000000b002af180709e6mr4714163ljg.35.1684835056666;
        Tue, 23 May 2023 02:44:16 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:16 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Martin Jocic <majoc@kvaser.com>
Subject: [PATCH 3/3] can: kvaser_pciefd: Wrap register read and writes with macros
Date:   Tue, 23 May 2023 11:43:54 +0200
Message-Id: <20230523094354.83792-17-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Wrap register read and writes with macros, to simplify the code.

Co-developed-by: Martin Jocic <majoc@kvaser.com>
Signed-off-by: Martin Jocic <majoc@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 495 ++++++++++++++++++++------------
 1 file changed, 309 insertions(+), 186 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index ffe13a1a882a..c5a410141dfb 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -233,8 +233,196 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Kvaser KCAN_EPACK second word */
 #define KVASER_PCIEFD_EPACK_DIR_TX BIT(0)
 
+/* Macros for calculating addresses of registers */
 #define KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, block) \
 	((pcie)->reg_base + (pcie)->driver_data->address_offset->block)
+#define KVASER_PCIEFD_PCI_IEN_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), pci_ien))
+#define KVASER_PCIEFD_PCI_IRQ_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), pci_irq))
+#define KVASER_PCIEFD_SERDES_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), serdes))
+#define KVASER_PCIEFD_SYSID_VERSION_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), sysid) + KVASER_PCIEFD_SYSID_VERSION_REG)
+#define KVASER_PCIEFD_SYSID_CANFREQ_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), sysid) + KVASER_PCIEFD_SYSID_CANFREQ_REG)
+#define KVASER_PCIEFD_SYSID_BUSFREQ_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), sysid) + KVASER_PCIEFD_SYSID_BUSFREQ_REG)
+#define KVASER_PCIEFD_SYSID_BUILD_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), sysid) + KVASER_PCIEFD_SYSID_BUILD_REG)
+#define KVASER_PCIEFD_SRB_FIFO_LAST_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb_fifo) + KVASER_PCIEFD_SRB_FIFO_LAST_REG)
+#define KVASER_PCIEFD_SRB_CMD_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb) + KVASER_PCIEFD_SRB_CMD_REG)
+#define KVASER_PCIEFD_SRB_IEN_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb) + KVASER_PCIEFD_SRB_IEN_REG)
+#define KVASER_PCIEFD_SRB_IRQ_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb) + KVASER_PCIEFD_SRB_IRQ_REG)
+#define KVASER_PCIEFD_SRB_STAT_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb) + KVASER_PCIEFD_SRB_STAT_REG)
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb) + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG)
+#define KVASER_PCIEFD_SRB_CTRL_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb) + KVASER_PCIEFD_SRB_CTRL_REG)
+#define KVASER_PCIEFD_KCAN_CH0_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_ch0))
+#define KVASER_PCIEFD_KCAN_CH1_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_ch1))
+
+/* Macros for calculating addresses of Kvaser KCAN registers */
+#define KVASER_PCIEFD_KCAN_FIFO_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG)
+#define KVASER_PCIEFD_KCAN_FIFO_LAST_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_FIFO_LAST_REG)
+#define KVASER_PCIEFD_KCAN_CTRL_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG)
+#define KVASER_PCIEFD_KCAN_CMD_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_CMD_REG)
+#define KVASER_PCIEFD_KCAN_IEN_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_IEN_REG)
+#define KVASER_PCIEFD_KCAN_IRQ_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG)
+#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG)
+#define KVASER_PCIEFD_KCAN_STAT_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_STAT_REG)
+#define KVASER_PCIEFD_KCAN_MODE_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_MODE_REG)
+#define KVASER_PCIEFD_KCAN_BTRN_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_BTRN_REG)
+#define KVASER_PCIEFD_KCAN_BUS_LOAD_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG)
+#define KVASER_PCIEFD_KCAN_BTRD_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_BTRD_REG)
+#define KVASER_PCIEFD_KCAN_PWM_ADDR(can) \
+	((can)->reg_base + KVASER_PCIEFD_KCAN_PWM_REG)
+
+/* Macros for reading and writing registers */
+#define KVASER_PCIEFD_PCI_IEN_SET(pcie, value) \
+	(iowrite32((value), KVASER_PCIEFD_PCI_IEN_ADDR((pcie))))
+#define KVASER_PCIEFD_PCI_IRQ_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR((pcie))))
+#define KVASER_PCIEFD_SYSID_VERSION_NR_CHANNELS_GET(pcie)      \
+	((ioread32(KVASER_PCIEFD_SYSID_VERSION_ADDR((pcie))) >> \
+	  KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_SHIFT) &          \
+	 0xff)
+#define KVASER_PCIEFD_SYSID_VERSION_MINOR_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_SYSID_VERSION_ADDR((pcie))) & 0xff)
+#define KVASER_PCIEFD_SYSID_VERSION_MAJOR_GET(pcie)             \
+	((ioread32(KVASER_PCIEFD_SYSID_VERSION_ADDR((pcie))) >> \
+	  KVASER_PCIEFD_SYSID_VERSION_MAJOR_SHIFT) &            \
+	 0xff)
+#define KVASER_PCIEFD_SYSID_CANFREQ_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_SYSID_CANFREQ_ADDR((pcie))))
+#define KVASER_PCIEFD_SYSID_BUSFREQ_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_SYSID_BUSFREQ_ADDR((pcie))))
+#define KVASER_PCIEFD_SYSID_BUILD_GET(pcie)                   \
+	((ioread32(KVASER_PCIEFD_SYSID_BUILD_ADDR((pcie))) >> \
+	  KVASER_PCIEFD_SYSID_BUILD_VERSION_SHIFT) &          \
+	 0x7fff)
+#define KVASER_PCIEFD_SRB_FIFO_LAST_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_SRB_FIFO_LAST_ADDR((pcie))))
+#define KVASER_PCIEFD_SRB_CMD_SET(pcie, value) \
+	(iowrite32((value), KVASER_PCIEFD_SRB_CMD_ADDR((pcie))))
+#define KVASER_PCIEFD_SRB_IEN_SET(pcie, value) \
+	(iowrite32((value), KVASER_PCIEFD_SRB_IEN_ADDR((pcie))))
+#define KVASER_PCIEFD_SRB_IRQ_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_SRB_IRQ_ADDR((pcie))))
+#define KVASER_PCIEFD_SRB_IRQ_SET(pcie, value) \
+	(iowrite32((value), KVASER_PCIEFD_SRB_IRQ_ADDR((pcie))))
+#define KVASER_PCIEFD_SRB_STAT_GET(pcie) \
+	(ioread32(KVASER_PCIEFD_SRB_STAT_ADDR((pcie))))
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_CURRENT_GET(pcie)         \
+	(ioread32(KVASER_PCIEFD_SRB_RX_NR_PACKETS_ADDR((pcie))) & \
+	 KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK)
+#define KVASER_PCIEFD_SRB_CTRL_SET(pcie, value) \
+	(iowrite32((value), KVASER_PCIEFD_SRB_CTRL_ADDR((pcie))))
+#define KVASER_PCIEFD_KCAN_FIFO_WRITE(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_FIFO_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_CTRL_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_CTRL_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_CMD_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_CMD_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_IEN_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_IEN_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_IRQ_GET(can) \
+	(ioread32(KVASER_PCIEFD_KCAN_IRQ_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_IRQ_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_IRQ_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_GET(can) \
+	(ioread32(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_ADDR((can))) & 0xff)
+#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_GET(can)               \
+	((ioread32(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_ADDR((can))) >> \
+	  KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_SHIFT) &             \
+	 0xff)
+#define KVASER_PCIEFD_KCAN_STAT_GET(can) \
+	(ioread32(KVASER_PCIEFD_KCAN_STAT_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_MODE_GET(can) \
+	(ioread32(KVASER_PCIEFD_KCAN_MODE_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_MODE_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_MODE_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_BTRN_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_BTRN_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_BTRD_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_BTRD_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_PWM_GET(can) \
+	(ioread32(KVASER_PCIEFD_KCAN_PWM_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_PWM_SET(can, value) \
+	(iowrite32((value), KVASER_PCIEFD_KCAN_PWM_ADDR((can))))
+
+#define KVASER_PCIEFD_PCI_IEN_DISABLE_ALL(pcie) \
+	(KVASER_PCIEFD_PCI_IEN_SET((pcie), 0))
+#define KVASER_PCIEFD_PCI_IEN_ENABLE_ALL(pcie) \
+	(KVASER_PCIEFD_PCI_IEN_SET((pcie), (pcie)->driver_data->irq_mask->all))
+
+#define KVASER_PCIEFD_SRB_DMA_DISABLE(pcie) (KVASER_PCIEFD_SRB_CTRL_SET((pcie), 0))
+#define KVASER_PCIEFD_SRB_DMA_ENABLE(pcie) \
+	(KVASER_PCIEFD_SRB_CTRL_SET((pcie), KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE))
+
+#define KVASER_PCIEFD_SRB_IEN_ENABLE_ALL(pcie)                          \
+	(KVASER_PCIEFD_SRB_IEN_SET((pcie),                              \
+				   KVASER_PCIEFD_SRB_IRQ_DPD0 |         \
+					   KVASER_PCIEFD_SRB_IRQ_DPD1 | \
+					   KVASER_PCIEFD_SRB_IRQ_DOF0 | \
+					   KVASER_PCIEFD_SRB_IRQ_DOF1 | \
+					   KVASER_PCIEFD_SRB_IRQ_DUF0 | \
+					   KVASER_PCIEFD_SRB_IRQ_DUF1))
+
+#define KVASER_PCIEFD_KCAN_IEN_DISABLE_ALL(can) \
+	(KVASER_PCIEFD_KCAN_IEN_SET((can), 0))
+#define KVASER_PCIEFD_KCAN_IEN_ENABLE_ALL(can)                            \
+	(KVASER_PCIEFD_KCAN_IEN_SET((can),                                \
+				    KVASER_PCIEFD_KCAN_IRQ_TOF |          \
+					    KVASER_PCIEFD_KCAN_IRQ_ABD |  \
+					    KVASER_PCIEFD_KCAN_IRQ_TAE |  \
+					    KVASER_PCIEFD_KCAN_IRQ_TAL |  \
+					    KVASER_PCIEFD_KCAN_IRQ_FDIC | \
+					    KVASER_PCIEFD_KCAN_IRQ_BPP |  \
+					    KVASER_PCIEFD_KCAN_IRQ_TAR))
+#define KVASER_PCIEFD_KCAN_IEN_ENABLE_ABD(can) \
+	(KVASER_PCIEFD_KCAN_IEN_SET((can), KVASER_PCIEFD_KCAN_IRQ_ABD))
+#define KVASER_PCIEFD_KCAN_IRQ_CLEAR_ALL(can) \
+	(KVASER_PCIEFD_KCAN_IRQ_SET((can), GENMASK(31, 0)))
+#define KVASER_PCIEFD_KCAN_BUS_LOAD_DISABLE(can) \
+	(iowrite32(0, KVASER_PCIEFD_KCAN_BUS_LOAD_ADDR((can))))
+#define KVASER_PCIEFD_KCAN_CHANNEL_SPAN(pcie) \
+	(KVASER_PCIEFD_KCAN_CH1_ADDR((pcie)) - KVASER_PCIEFD_KCAN_CH0_ADDR((pcie)))
+#define KVASER_PCIEFD_KCAN_CHX_ADDR(pcie, i) \
+	(KVASER_PCIEFD_KCAN_CH0_ADDR((pcie)) + (i) * KVASER_PCIEFD_KCAN_CHANNEL_SPAN((pcie)))
+
+#define KVASER_PCIEFD_LOOPBACK_DISABLE(pcie) \
+	(iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), loopback)))
+
+#define KVASER_PCIEFD_WRITE_DMA_MAP(pcie, addr, index) \
+	((pcie)->driver_data->ops->kvaser_pciefd_write_dma_map((pcie), (addr), (index)))
+
+#define KVASER_PCIEFD_PACKET_TYPE(packet) \
+	(((packet)->header[1] >> KVASER_PCIEFD_PACKET_TYPE_SHIFT) & KVASER_PCIEFD_PACKET_TYPE_MASK)
+
+#define KVASER_PCIEFD_SPACKET_TXERR_COUNT(packet) ((packet)->header[0] & 0xff)
+
+#define KVASER_PCIEFD_SPACKET_RXERR_COUNT(packet) \
+	(((packet)->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff)
 
 struct kvaser_pciefd;
 static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
@@ -427,13 +615,20 @@ static inline u8 kvaser_pciefd_rx_packet_get_ch_id(struct kvaser_pciefd_rx_packe
 	return (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & KVASER_PCIEFD_PACKET_CHID_MASK;
 }
 
-static void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
+static inline void kvaser_pciefd_send_kcan_cmd(struct kvaser_pciefd_can *can, u32 cmd)
 {
-	u32 cmd;
+	KVASER_PCIEFD_KCAN_CMD_SET(can,
+				   cmd | (++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT));
+}
 
-	cmd = KVASER_PCIEFD_KCAN_CMD_SRQ;
-	cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
-	iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
+static inline void kvaser_pciefd_kcan_abort_flush_reset(struct kvaser_pciefd_can *can)
+{
+	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
+}
+
+static inline void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
+{
+	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_SRQ);
 }
 
 static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
@@ -442,10 +637,10 @@ static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	mode = KVASER_PCIEFD_KCAN_MODE_GET(can);
 	if (!(mode & KVASER_PCIEFD_KCAN_MODE_EPEN)) {
 		mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;
-		iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+		KVASER_PCIEFD_KCAN_MODE_SET(can, mode);
 	}
 	spin_unlock_irqrestore(&can->lock, irq);
 }
@@ -456,25 +651,12 @@ static void kvaser_pciefd_disable_err_gen(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	mode = KVASER_PCIEFD_KCAN_MODE_GET(can);
 	mode &= ~KVASER_PCIEFD_KCAN_MODE_EPEN;
-	iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	KVASER_PCIEFD_KCAN_MODE_SET(can, mode);
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
-static void kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
-{
-	u32 msk;
-
-	msk = KVASER_PCIEFD_KCAN_IRQ_TE | KVASER_PCIEFD_KCAN_IRQ_ROF |
-	      KVASER_PCIEFD_KCAN_IRQ_TOF | KVASER_PCIEFD_KCAN_IRQ_ABD |
-	      KVASER_PCIEFD_KCAN_IRQ_TAE | KVASER_PCIEFD_KCAN_IRQ_TAL |
-	      KVASER_PCIEFD_KCAN_IRQ_FDIC | KVASER_PCIEFD_KCAN_IRQ_BPP |
-	      KVASER_PCIEFD_KCAN_IRQ_TAR;
-
-	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-}
-
 static inline void kvaser_pciefd_set_skb_timestamp(const struct kvaser_pciefd *pcie,
 						   struct sk_buff *skb, u64 timestamp)
 {
@@ -488,7 +670,7 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	mode = KVASER_PCIEFD_KCAN_MODE_GET(can);
 	if (can->can.ctrlmode & CAN_CTRLMODE_FD) {
 		mode &= ~KVASER_PCIEFD_KCAN_MODE_CCM;
 		if (can->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
@@ -509,7 +691,7 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 	/* Use ACK packet type */
 	mode &= ~KVASER_PCIEFD_KCAN_MODE_APT;
 	mode &= ~KVASER_PCIEFD_KCAN_MODE_RM;
-	iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	KVASER_PCIEFD_KCAN_MODE_SET(can, mode);
 
 	spin_unlock_irqrestore(&can->lock, irq);
 }
@@ -520,24 +702,19 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
-		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
+	KVASER_PCIEFD_KCAN_IRQ_CLEAR_ALL(can);
+	KVASER_PCIEFD_KCAN_IEN_ENABLE_ABD(can);
+	status = KVASER_PCIEFD_KCAN_STAT_GET(can);
 	if (status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
-		u32 cmd;
-
 		/* If controller is already idle, run abort, flush and reset */
-		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
-		cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
-		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
+		kvaser_pciefd_kcan_abort_flush_reset(can);
 	} else if (!(status & KVASER_PCIEFD_KCAN_STAT_RMR)) {
 		u32 mode;
 
 		/* Put controller in reset mode */
-		mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+		mode = KVASER_PCIEFD_KCAN_MODE_GET(can);
 		mode |= KVASER_PCIEFD_KCAN_MODE_RM;
-		iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+		KVASER_PCIEFD_KCAN_MODE_SET(can, mode);
 	}
 	spin_unlock_irqrestore(&can->lock, irq);
 }
@@ -558,13 +735,12 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	}
 
 	spin_lock_irqsave(&can->lock, irq);
-	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
-		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	KVASER_PCIEFD_KCAN_IEN_DISABLE_ALL(can);
+	KVASER_PCIEFD_KCAN_IRQ_CLEAR_ALL(can);
+	KVASER_PCIEFD_KCAN_IEN_ENABLE_ABD(can);
+	mode = KVASER_PCIEFD_KCAN_MODE_GET(can);
 	mode &= ~KVASER_PCIEFD_KCAN_MODE_RM;
-	iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	KVASER_PCIEFD_KCAN_MODE_SET(can, mode);
 	spin_unlock_irqrestore(&can->lock, irq);
 
 	if (!wait_for_completion_timeout(&can->start_comp,
@@ -573,10 +749,10 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 		return -ETIMEDOUT;
 	}
 	/* Reset interrupt handling */
-	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
+	KVASER_PCIEFD_KCAN_IEN_DISABLE_ALL(can);
+	KVASER_PCIEFD_KCAN_IRQ_CLEAR_ALL(can);
 
-	kvaser_pciefd_set_tx_irq(can);
+	KVASER_PCIEFD_KCAN_IEN_ENABLE_ALL(can);
 	kvaser_pciefd_setup_controller(can);
 	can->can.state = CAN_STATE_ERROR_ACTIVE;
 	netif_wake_queue(can->can.dev);
@@ -594,11 +770,11 @@ static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-	pwm_ctrl = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
+	pwm_ctrl = KVASER_PCIEFD_KCAN_PWM_GET(can);
 	top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;
 	/* Set duty cycle to zero */
 	pwm_ctrl |= top;
-	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
+	KVASER_PCIEFD_KCAN_PWM_SET(can, pwm_ctrl);
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
@@ -614,13 +790,13 @@ static void kvaser_pciefd_pwm_start(struct kvaser_pciefd_can *can)
 	top = can->kv_pcie->bus_freq / (2 * 500000) - 1;
 	pwm_ctrl = top & 0xff;
 	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
-	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
+	KVASER_PCIEFD_KCAN_PWM_SET(can, pwm_ctrl);
 
 	/* Set duty cycle to 95 */
 	trigger = (100 * top - 95 * (top + 1) + 50) / 100;
 	pwm_ctrl = trigger & 0xff;
 	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
-	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
+	KVASER_PCIEFD_KCAN_PWM_SET(can, pwm_ctrl);
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
@@ -656,7 +832,7 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		netdev_err(can->can.dev, "Timeout during stop\n");
 		ret = -ETIMEDOUT;
 	} else {
-		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+		KVASER_PCIEFD_KCAN_IEN_DISABLE_ALL(can);
 		del_timer(&can->bec_poll_timer);
 	}
 	can->can.state = CAN_STATE_STOPPED;
@@ -729,27 +905,22 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
 
 	/* Write header to fifo */
-	iowrite32(packet.header[0],
-		  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
-	iowrite32(packet.header[1],
-		  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
+	KVASER_PCIEFD_KCAN_FIFO_WRITE(can, packet.header[0]);
+	KVASER_PCIEFD_KCAN_FIFO_WRITE(can, packet.header[1]);
 
 	if (nr_words) {
 		u32 data_last = ((u32 *)packet.data)[nr_words - 1];
 
 		/* Write data to fifo, except last word */
-		iowrite32_rep(can->reg_base +
-			      KVASER_PCIEFD_KCAN_FIFO_REG, packet.data,
+		iowrite32_rep(KVASER_PCIEFD_KCAN_FIFO_ADDR(can), packet.data,
 			      nr_words - 1);
 		/* Write last word to end of fifo */
-		__raw_writel(data_last, can->reg_base +
-			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
+		__raw_writel(data_last, KVASER_PCIEFD_KCAN_FIFO_LAST_ADDR(can));
 	} else {
 		/* Complete write to fifo */
-		__raw_writel(0, can->reg_base +
-			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
+		__raw_writel(0, KVASER_PCIEFD_KCAN_FIFO_LAST_ADDR(can));
 	}
-	count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG);
+	count = KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_GET(can);
 	/* No room for a new message, stop the queue until at least one
 	 * successful transmit
 	 */
@@ -782,13 +953,12 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 	       ((bt->brp - 1) & KVASER_PCIEFD_KCAN_BTRN_BRP_MASK);
 
 	spin_lock_irqsave(&can->lock, irq_flags);
-	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	mode = KVASER_PCIEFD_KCAN_MODE_GET(can);
 	/* Put the circuit in reset mode */
-	iowrite32(mode | KVASER_PCIEFD_KCAN_MODE_RM,
-		  can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	KVASER_PCIEFD_KCAN_MODE_SET(can, mode | KVASER_PCIEFD_KCAN_MODE_RM);
 
 	/* Can only set bittiming if in reset mode */
-	ret = readl_poll_timeout(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG,
+	ret = readl_poll_timeout(KVASER_PCIEFD_KCAN_MODE_ADDR(can),
 				 test, test & KVASER_PCIEFD_KCAN_MODE_RM, 0, 10);
 	if (ret) {
 		spin_unlock_irqrestore(&can->lock, irq_flags);
@@ -796,11 +966,11 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 	}
 
 	if (data)
-		iowrite32(btrn, can->reg_base + KVASER_PCIEFD_KCAN_BTRD_REG);
+		KVASER_PCIEFD_KCAN_BTRD_SET(can, btrn);
 	else
-		iowrite32(btrn, can->reg_base + KVASER_PCIEFD_KCAN_BTRN_REG);
+		KVASER_PCIEFD_KCAN_BTRN_SET(can, btrn);
 	/* Restore previous reset mode status */
-	iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
+	KVASER_PCIEFD_KCAN_MODE_SET(can, mode);
 	spin_unlock_irqrestore(&can->lock, irq_flags);
 
 	return 0;
@@ -868,15 +1038,11 @@ static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 {
 	int i;
-	void __iomem *kcan_ch0_base;
-	u64 kcan_controller_span;
 
-	kcan_ch0_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_ch0);
-	kcan_controller_span = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_ch1) - kcan_ch0_base;
 	for (i = 0; i < pcie->nr_channels; i++) {
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
-		u32 status, tx_nr_packets, tx_nr_packets_max;
+		u32 status;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      KVASER_PCIEFD_CAN_TX_MAX_COUNT);
@@ -886,7 +1052,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can = netdev_priv(netdev);
 		netdev->netdev_ops = &kvaser_pciefd_netdev_ops;
 		netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
-		can->reg_base = kcan_ch0_base + i * kcan_controller_span;
+		can->reg_base = KVASER_PCIEFD_KCAN_CHX_ADDR(pcie, i);
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
@@ -898,14 +1064,12 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer, 0);
 
 		/* Disable Bus load reporting */
-		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
-
-		tx_nr_packets = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG);
-		tx_nr_packets_max =
-			(tx_nr_packets >> KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_SHIFT) & 0xff;
+		KVASER_PCIEFD_KCAN_BUS_LOAD_DISABLE(can);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
+		can->can.echo_skb_max =
+			min(KVASER_PCIEFD_CAN_TX_MAX_COUNT,
+			    KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_GET(can) - 1);
 		can->echo_idx = 0;
 		spin_lock_init(&can->echo_lock);
 		spin_lock_init(&can->lock);
@@ -921,7 +1085,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 					      CAN_CTRLMODE_FD_NON_ISO |
 					      CAN_CTRLMODE_CC_LEN8_DLC;
 
-		status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
+		status = KVASER_PCIEFD_KCAN_STAT_GET(can);
 		if (!(status & KVASER_PCIEFD_KCAN_STAT_FD)) {
 			dev_err(&pcie->pci->dev,
 				"CAN FD not supported as expected %d\n", i);
@@ -936,9 +1100,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		netdev->flags |= IFF_ECHO;
 		SET_NETDEV_DEV(netdev, &pcie->pci->dev);
 
-		iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
-			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+		KVASER_PCIEFD_KCAN_IRQ_CLEAR_ALL(can);
+		KVASER_PCIEFD_KCAN_IEN_ENABLE_ABD(can);
 
 		pcie->can[i] = can;
 		kvaser_pciefd_pwm_start(can);
@@ -980,7 +1143,7 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 	word1 = addr;
 	word2 = 0;
 #endif
-	serdes_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, serdes) + 0x8 * index;
+	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
 	iowrite32(word1, serdes_base);
 	iowrite32(word2, serdes_base + 0x4);
 }
@@ -995,23 +1158,19 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	msb = addr >> 32;
 #endif
-	serdes_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, serdes) + 0x10 * index;
+	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x10 * index;
 	iowrite32(lsb, serdes_base);
 	iowrite32(msb, serdes_base + 0x4);
 }
 
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
-	void __iomem *kcan_srb_base;
-	const struct kvaser_pciefd_dev_ops *dev_ops = pcie->driver_data->ops;
 	int i;
-	u32 srb_status;
 	u32 srb_packet_count;
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
-	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
 	/* Disable the DMA */
-	iowrite32(0, kcan_srb_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	KVASER_PCIEFD_SRB_DMA_DISABLE(pcie);
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
 							KVASER_PCIEFD_DMA_SIZE,
@@ -1023,69 +1182,55 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 				KVASER_PCIEFD_DMA_SIZE);
 			return -ENOMEM;
 		}
-		dev_ops->kvaser_pciefd_write_dma_map(pcie, dma_addr[i], i);
+		KVASER_PCIEFD_WRITE_DMA_MAP(pcie, dma_addr[i], i);
 	}
 
 	/* Reset Rx FIFO, and both DMA buffers */
-	iowrite32(KVASER_PCIEFD_SRB_CMD_FOR | KVASER_PCIEFD_SRB_CMD_RDB0 |
-		  KVASER_PCIEFD_SRB_CMD_RDB1,
-		  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
+	KVASER_PCIEFD_SRB_CMD_SET(pcie, KVASER_PCIEFD_SRB_CMD_FOR |
+						KVASER_PCIEFD_SRB_CMD_RDB0 |
+						KVASER_PCIEFD_SRB_CMD_RDB1);
+
 	/* Empty Rx FIFO */
-	srb_packet_count = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
-			   KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
+	srb_packet_count = KVASER_PCIEFD_SRB_RX_NR_PACKETS_CURRENT_GET(pcie);
 	while (srb_packet_count) {
 		/* Drop current packet in FIFO */
-		ioread32(KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb_fifo) +
-			 KVASER_PCIEFD_SRB_FIFO_LAST_REG);
+		KVASER_PCIEFD_SRB_FIFO_LAST_GET(pcie);
 		srb_packet_count--;
 	}
 
-	srb_status = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_STAT_REG);
-	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DI)) {
+	if (!(KVASER_PCIEFD_SRB_STAT_GET(pcie) & KVASER_PCIEFD_SRB_STAT_DI)) {
 		dev_err(&pcie->pci->dev, "DMA not idle before enabling\n");
 		return -EIO;
 	}
 
 	/* Enable the DMA */
-	iowrite32(KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE,
-		  kcan_srb_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	KVASER_PCIEFD_SRB_DMA_ENABLE(pcie);
 
 	return 0;
 }
 
 static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 {
-	void __iomem *kcan_srb_base;
-	void __iomem *sysid_base;
-	u32 version, srb_status, build;
-
-	sysid_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, sysid);
-	version = ioread32(sysid_base + KVASER_PCIEFD_SYSID_VERSION_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
-				((version >> KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_SHIFT) & 0xff));
+				KVASER_PCIEFD_SYSID_VERSION_NR_CHANNELS_GET(pcie));
 
-	build = ioread32(sysid_base + KVASER_PCIEFD_SYSID_BUILD_REG);
 	dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
-		(version >> KVASER_PCIEFD_SYSID_VERSION_MAJOR_SHIFT) & 0xff,
-		version & 0xff,
-		(build >> KVASER_PCIEFD_SYSID_BUILD_VERSION_SHIFT) & 0x7fff);
+		KVASER_PCIEFD_SYSID_VERSION_MAJOR_GET(pcie),
+		KVASER_PCIEFD_SYSID_VERSION_MINOR_GET(pcie),
+		KVASER_PCIEFD_SYSID_BUILD_GET(pcie));
 
-	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
-	srb_status = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_STAT_REG);
-	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
+	if (!(KVASER_PCIEFD_SRB_STAT_GET(pcie) & KVASER_PCIEFD_SRB_STAT_DMA)) {
 		dev_err(&pcie->pci->dev, "Hardware without DMA is not supported\n");
 		return -ENODEV;
 	}
 
-	pcie->bus_freq = ioread32(sysid_base +
-				  KVASER_PCIEFD_SYSID_BUSFREQ_REG);
-	pcie->freq = ioread32(sysid_base + KVASER_PCIEFD_SYSID_CANFREQ_REG);
+	pcie->bus_freq = KVASER_PCIEFD_SYSID_BUSFREQ_GET(pcie);
+	pcie->freq = KVASER_PCIEFD_SYSID_CANFREQ_GET(pcie);
 	pcie->freq_to_ticks_div = pcie->freq / 1000000;
 	if (pcie->freq_to_ticks_div == 0)
 		pcie->freq_to_ticks_div = 1;
 	/* Turn off all loopback functionality */
-	iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, loopback));
-
+	KVASER_PCIEFD_LOOPBACK_DISABLE(pcie);
 	return 0;
 }
 
@@ -1202,8 +1347,8 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 
 	old_state = can->can.state;
 
-	bec.txerr = p->header[0] & 0xff;
-	bec.rxerr = (p->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff;
+	bec.txerr = KVASER_PCIEFD_SPACKET_TXERR_COUNT(p);
+	bec.rxerr = KVASER_PCIEFD_SPACKET_RXERR_COUNT(p);
 
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
 	skb = alloc_can_err_skb(ndev, &cf);
@@ -1271,8 +1416,8 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 
 	old_state = can->can.state;
 
-	bec.txerr = p->header[0] & 0xff;
-	bec.rxerr = (p->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff;
+	bec.txerr = KVASER_PCIEFD_SPACKET_TXERR_COUNT(p);
+	bec.rxerr = KVASER_PCIEFD_SPACKET_RXERR_COUNT(p);
 
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
 	if (new_state != old_state) {
@@ -1323,41 +1468,35 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 
 	can = pcie->can[ch_id];
 
-	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
-	cmdseq = (status >> KVASER_PCIEFD_KCAN_STAT_SEQNO_SHIFT) & 0xff;
+	status = KVASER_PCIEFD_KCAN_STAT_GET(can);
+	cmdseq = (status >> KVASER_PCIEFD_KCAN_STAT_SEQNO_SHIFT) & KVASER_PCIEFD_PACKET_SEQ_MASK;
 
 	/* Reset done, start abort and flush */
-	if (p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
-	    p->header[0] & KVASER_PCIEFD_SPACK_RMCD &&
-	    p->header[1] & KVASER_PCIEFD_SPACK_AUTO &&
-	    cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK) &&
-	    status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
-		u32 cmd;
-
-		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
-			  can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
-		cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
-		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
-	} else if (p->header[0] & KVASER_PCIEFD_SPACK_IDET &&
-		   p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
-		   cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK) &&
-		   status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
+	if ((p->header[0] & KVASER_PCIEFD_SPACK_IRM) &&
+	    (p->header[0] & KVASER_PCIEFD_SPACK_RMCD) &&
+	    (p->header[1] & KVASER_PCIEFD_SPACK_AUTO) &&
+	    (cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK)) &&
+	    (status & KVASER_PCIEFD_KCAN_STAT_IDLE)) {
+		KVASER_PCIEFD_KCAN_IRQ_SET(can, KVASER_PCIEFD_KCAN_IRQ_ABD);
+		kvaser_pciefd_kcan_abort_flush_reset(can);
+	} else if ((p->header[0] & KVASER_PCIEFD_SPACK_IDET) &&
+		   (p->header[0] & KVASER_PCIEFD_SPACK_IRM) &&
+		   (cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK)) &&
+		   (status & KVASER_PCIEFD_KCAN_STAT_IDLE)) {
 		/* Reset detected, send end of flush if no packet are in FIFO */
-		u8 count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG) & 0xff;
+		u8 count = KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_GET(can);
 
 		if (!count)
-			iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
-				  can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
+			KVASER_PCIEFD_KCAN_CTRL_SET(can, KVASER_PCIEFD_KCAN_CTRL_EFLUSH);
 	} else if (!(p->header[1] & KVASER_PCIEFD_SPACK_AUTO) &&
-		   cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK)) {
+		   (cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK))) {
 		/* Response to status request received */
 		kvaser_pciefd_handle_status_resp(can, p);
 		if (can->can.state != CAN_STATE_BUS_OFF &&
 		    can->can.state != CAN_STATE_ERROR_ACTIVE) {
 			mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
 		}
-	} else if (p->header[0] & KVASER_PCIEFD_SPACK_RMCD &&
+	} else if ((p->header[0] & KVASER_PCIEFD_SPACK_RMCD) &&
 		   !(status & KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MASK)) {
 		/* Reset to bus on detected */
 		if (!completion_done(&can->start_comp))
@@ -1425,7 +1564,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		if (skb)
 			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG) & 0xff;
+		count = KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_GET(can);
 
 		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
 			netif_wake_queue(can->can.dev);
@@ -1482,7 +1621,7 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 	pos += 2;
 	p->timestamp = le64_to_cpu(timestamp);
 
-	type = (p->header[1] >> KVASER_PCIEFD_PACKET_TYPE_SHIFT) & KVASER_PCIEFD_PACKET_TYPE_MASK;
+	type = KVASER_PCIEFD_PACKET_TYPE(p);
 	switch (type) {
 	case KVASER_PCIEFD_PACK_TYPE_DATA:
 		ret = kvaser_pciefd_handle_data_packet(pcie, p, &buffer[pos]);
@@ -1554,23 +1693,18 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 
 static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
-	void __iomem *kcan_srb_base;
-	u32 irq;
+	u32 irq = KVASER_PCIEFD_SRB_IRQ_GET(pcie);
 
-	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
-	irq = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_IRQ_REG);
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
 		kvaser_pciefd_read_buffer(pcie, 0);
 		/* Reset DMA buffer 0 */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
+		KVASER_PCIEFD_SRB_CMD_SET(pcie, KVASER_PCIEFD_SRB_CMD_RDB0);
 	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
 		/* Reset DMA buffer 1 */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
+		KVASER_PCIEFD_SRB_CMD_SET(pcie, KVASER_PCIEFD_SRB_CMD_RDB1);
 	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
@@ -1579,12 +1713,12 @@ static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 	    irq & KVASER_PCIEFD_SRB_IRQ_DUF1)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
-	iowrite32(irq, kcan_srb_base + KVASER_PCIEFD_SRB_IRQ_REG);
+	KVASER_PCIEFD_SRB_IRQ_SET(pcie, irq);
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 {
-	u32 irq = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
+	u32 irq = KVASER_PCIEFD_KCAN_IRQ_GET(can);
 
 	if (irq & KVASER_PCIEFD_KCAN_IRQ_TOF)
 		netdev_err(can->can.dev, "Tx FIFO overflow\n");
@@ -1599,18 +1733,16 @@ static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 	if (irq & KVASER_PCIEFD_KCAN_IRQ_ROF)
 		netdev_err(can->can.dev, "Rx FIFO overflow\n");
 
-	iowrite32(irq, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
+	KVASER_PCIEFD_KCAN_IRQ_SET(can, irq);
 }
 
 static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 {
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
-	u32 board_irq;
+	u32 board_irq = KVASER_PCIEFD_PCI_IRQ_GET(pcie);
 	int i;
 
-	board_irq = ioread32(KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, pci_irq));
-
 	if (!(board_irq & irq_mask->all))
 		return IRQ_NONE;
 
@@ -1640,7 +1772,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 		struct kvaser_pciefd_can *can = pcie->can[i];
 
 		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+			KVASER_PCIEFD_KCAN_IEN_DISABLE_ALL(can);
 			kvaser_pciefd_pwm_stop(can);
 			free_candev(can->can.dev);
 		}
@@ -1653,8 +1785,6 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	int err;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *kcan_srb_base;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1689,7 +1819,6 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
 	err = kvaser_pciefd_setup_can_ctrls(pcie);
 	if (err)
 		goto err_teardown_can_ctrls;
@@ -1699,22 +1828,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_teardown_can_ctrls;
 
-	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
-		  kcan_srb_base + KVASER_PCIEFD_SRB_IRQ_REG);
-
-	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1 |
-		  KVASER_PCIEFD_SRB_IRQ_DOF0 | KVASER_PCIEFD_SRB_IRQ_DOF1 |
-		  KVASER_PCIEFD_SRB_IRQ_DUF0 | KVASER_PCIEFD_SRB_IRQ_DUF1,
-		  kcan_srb_base + KVASER_PCIEFD_SRB_IEN_REG);
+	/* Enable shared receive buffer interrupts */
+	KVASER_PCIEFD_SRB_IRQ_SET(pcie, KVASER_PCIEFD_SRB_IRQ_DPD0 |
+						KVASER_PCIEFD_SRB_IRQ_DPD1);
+	KVASER_PCIEFD_SRB_IEN_ENABLE_ALL(pcie);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, pci_ien);
-	iowrite32(irq_mask->all, irq_en_base);
+	KVASER_PCIEFD_PCI_IEN_ENABLE_ALL(pcie);
 	/* Ready the DMA buffers */
-	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-		  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
-	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-		  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
+	KVASER_PCIEFD_SRB_CMD_SET(pcie, KVASER_PCIEFD_SRB_CMD_RDB0);
+	KVASER_PCIEFD_SRB_CMD_SET(pcie, KVASER_PCIEFD_SRB_CMD_RDB1);
 
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
@@ -1724,12 +1847,12 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 err_free_irq:
 	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	KVASER_PCIEFD_PCI_IEN_DISABLE_ALL(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_teardown_can_ctrls:
 	kvaser_pciefd_teardown_can_ctrls(pcie);
-	iowrite32(0, kcan_srb_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	KVASER_PCIEFD_SRB_DMA_DISABLE(pcie);
 	pci_clear_master(pdev);
 
 err_pci_iounmap:
@@ -1752,7 +1875,7 @@ static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
 		struct kvaser_pciefd_can *can = pcie->can[i];
 
 		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+			KVASER_PCIEFD_KCAN_IEN_DISABLE_ALL(can);
 			unregister_candev(can->can.dev);
 			del_timer(&can->bec_poll_timer);
 			kvaser_pciefd_pwm_stop(can);
@@ -1768,8 +1891,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	kvaser_pciefd_remove_all_ctrls(pcie);
 
 	/* Disable interrupts */
-	iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb) + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, pci_ien));
+	KVASER_PCIEFD_SRB_DMA_DISABLE(pcie);
+	KVASER_PCIEFD_PCI_IEN_DISABLE_ALL(pcie);
 
 	free_irq(pcie->pci->irq, pcie);
 
-- 
2.40.0

