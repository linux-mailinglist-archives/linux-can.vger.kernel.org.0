Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17A67E5A5
	for <lists+linux-can@lfdr.de>; Fri, 27 Jan 2023 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjA0Mn2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 27 Jan 2023 07:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjA0Mn1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 27 Jan 2023 07:43:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A3344AA
        for <linux-can@vger.kernel.org>; Fri, 27 Jan 2023 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674823383; x=1706359383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q4SaEovnqMGDqrzfHSH65vskG4bqNg/7W598Odq2q1s=;
  b=n/9NxD55oq6ho288LlznSc+Wqr6OHLYCt+6k0CkJB00xxaRHqY1t1yav
   b1twIF+eNvqUgFaoSCmn0KckzVkxnjqJonNAm6QIXCo4f7WbBmaA0r9gk
   rdndUOR7r2GCyiwXrq3xN0/FmMM/I5ehD41BDYGxAOcAu4E+B1XQ7jXgX
   7y/+oOhmRGT+M4uKtf4K19bFjv3B9OBNtVd/iAfAe3I6Qqf8/Z/WWBSbq
   Hi+EkjesXPDwys7MCnpauOURVb2NO1/ZMVcX11NeiuKuFb+GgYBaEPR0d
   ISXq1JnAnIknVf21v79+81vIVUEznO/LhHKWlecNVAp1qUatVKU0E2Srn
   A==;
X-IronPort-AV: E=Sophos;i="5.97,251,1669100400"; 
   d="scan'208";a="198283086"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2023 05:42:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 05:42:57 -0700
Received: from HNO-LT-M43677A.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 05:42:56 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-can@vger.kernel.org>, <mkl@pengutronix.de>
CC:     <mani@kernel.org>, <thomas.kopp@microchip.com>
Subject: [PATCH] can: mcp251xfd: optimizing transfer size for CRC transfers size 1
Date:   Fri, 27 Jan 2023 13:42:58 +0100
Message-ID: <20230127124258.2764-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For CRC transfers with size 1 it is more efficient to use the write_safe command instead of the write_crc command. This saves the length byte on the SPI transfer.

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 31 ++++++++++++-------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 26 +++++++++++++---
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index f69d5fc8c9afd..3c3bc9be1f295 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -30,22 +30,31 @@ mcp251xfd_cmd_prepare_write_reg(const struct mcp251xfd_priv *priv,
 	last_byte = mcp251xfd_last_byte_set(mask);
 	len = last_byte - first_byte + 1;
 
-	data = mcp251xfd_spi_cmd_write(priv, write_reg_buf, reg + first_byte);
+	data = mcp251xfd_spi_cmd_write(priv, write_reg_buf, reg + first_byte, len);
 	val_le32 = cpu_to_le32(val >> BITS_PER_BYTE * first_byte);
 	memcpy(data, &val_le32, len);
 
 	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_CRC_REG) {
 		u16 crc;
-
-		mcp251xfd_spi_cmd_crc_set_len_in_reg(&write_reg_buf->crc.cmd,
-						     len);
-		/* CRC */
-		len += sizeof(write_reg_buf->crc.cmd);
-		crc = mcp251xfd_crc16_compute(&write_reg_buf->crc, len);
-		put_unaligned_be16(crc, (void *)write_reg_buf + len);
-
-		/* Total length */
-		len += sizeof(write_reg_buf->crc.crc);
+		if (len == 1) {
+			/* CRC */
+			len += sizeof(write_reg_buf->safe.cmd);
+			crc = mcp251xfd_crc16_compute(&write_reg_buf->safe, len);
+			put_unaligned_be16(crc, (void *)write_reg_buf + len);
+
+			/* Total length */
+			len += sizeof(write_reg_buf->safe.crc);
+		} else {
+			mcp251xfd_spi_cmd_crc_set_len_in_reg(&write_reg_buf->crc.cmd,
+							     len);
+			/* CRC */
+			len += sizeof(write_reg_buf->crc.cmd);
+			crc = mcp251xfd_crc16_compute(&write_reg_buf->crc, len);
+			put_unaligned_be16(crc, (void *)write_reg_buf + len);
+
+			/* Total length */
+			len += sizeof(write_reg_buf->crc.crc);
+		}
 	} else {
 		len += sizeof(write_reg_buf->nocrc.cmd);
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 6008d38810e98..5d82eb2676182 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -504,6 +504,11 @@ union mcp251xfd_write_reg_buf {
 		u8 data[4];
 		__be16 crc;
 	} crc;
+	struct __packed {
+		struct mcp251xfd_buf_cmd cmd;
+		u8 data[1];
+		__be16 crc;
+	} safe;
 } ____cacheline_aligned;
 
 struct mcp251xfd_tx_obj {
@@ -762,6 +767,13 @@ mcp251xfd_spi_cmd_write_crc_set_addr(struct mcp251xfd_buf_cmd_crc *cmd,
 	cmd->cmd = cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_WRITE_CRC | addr);
 }
 
+static inline void
+mcp251xfd_spi_cmd_write_safe_set_addr(struct mcp251xfd_buf_cmd *cmd,
+				     u16 addr)
+{
+	cmd->cmd = cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_WRITE_CRC_SAFE | addr);
+}
+
 static inline void
 mcp251xfd_spi_cmd_write_crc(struct mcp251xfd_buf_cmd_crc *cmd,
 			    u16 addr, u16 len)
@@ -773,14 +785,20 @@ mcp251xfd_spi_cmd_write_crc(struct mcp251xfd_buf_cmd_crc *cmd,
 static inline u8 *
 mcp251xfd_spi_cmd_write(const struct mcp251xfd_priv *priv,
 			union mcp251xfd_write_reg_buf *write_reg_buf,
-			u16 addr)
+			u16 addr, u8 len)
 {
 	u8 *data;
 
 	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_CRC_REG) {
-		mcp251xfd_spi_cmd_write_crc_set_addr(&write_reg_buf->crc.cmd,
-						     addr);
-		data = write_reg_buf->crc.data;
+		if (len == 1) {
+			mcp251xfd_spi_cmd_write_safe_set_addr(&write_reg_buf->safe.cmd,
+							     addr);
+			data = write_reg_buf->safe.data;
+		} else {
+			mcp251xfd_spi_cmd_write_crc_set_addr(&write_reg_buf->crc.cmd,
+							     addr);
+			data = write_reg_buf->crc.data;
+		}
 	} else {
 		mcp251xfd_spi_cmd_write_nocrc(&write_reg_buf->nocrc.cmd,
 					      addr);
-- 
2.34.1

