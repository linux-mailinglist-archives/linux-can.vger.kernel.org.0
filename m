Return-Path: <linux-can+bounces-1250-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E2966997
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07111F25399
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09761BF32A;
	Fri, 30 Aug 2024 19:27:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333841BDA92
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046020; cv=none; b=JHhe/ko54Dzi3wuJBhA7Fr/It6cTnqLuO89pcapAfgbK8rp+nbo1NQt1ABzg9rlftiFdwm62d+0l3a32cp/qS496ef6d1r6ZTJXUGI6wcVs1HaGgAzo+PWSOScrebn081pycVLOgr+CNmgt651BhVgSIyoGPKWdm6gztzqKUjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046020; c=relaxed/simple;
	bh=Z2/rSBVvCjbhxs0pYxeQVcBmduuXSD43SrG/Ct/eh88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHq8sRhfL7VIHwkbQOCiWJIyvfEY3QfoUtqVXzUQJP1WEUV9T5x7AUWGU1s7aalStgmXTHg4a3RW/uVBt/wlE0Jk5FJ4IdvxGlAxjX+aDmAFMMayFqiGCTbBBwufLJ7ho2c/lKofY8qlnHvV/ZJM1OtSw8PzxtB+ozc6a5An/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gn-00068z-Rk
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:26:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gl-004Dey-2G
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:26:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BCC6632E15C
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:26:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5911332E0F3;
	Fri, 30 Aug 2024 19:26:46 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 22516864;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:01 +0200
Subject: [PATCH can-next v3 04/20] can: rockchip_canfd: add driver for
 Rockchip CAN-FD controller
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-4-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=46574; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Z2/rSBVvCjbhxs0pYxeQVcBmduuXSD43SrG/Ct/eh88=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzcZsHEbCzo6vUi6GhX3k74z9sXHKkbRZhuQ
 QfQraiRJN6JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc3AAKCRAoOKI+ei28
 byKQB/9vqQBqFoLtTb8CWBfVhTb3vIE5+ojGTKublEM1B/K4qaIkOLg3aUMBnbRaWsZnhI5IOF0
 Z836LoKBoxQijJtTB5/wGrnYh0Ut7OMj7ytb3LsLDlDlJfV5a3+BPE4M9/VA4K27MtRG6WslPrI
 VEEmfp3sjmrXKOS4AEWiOAxUVoMaD/r1/YrjIr2leKuv3/vLR/syqbTxW0DPmlQJvVBPXphCK1p
 b5LH5Eg2r0+f2R1LdoI29mVtOEX0ozTed376a3PEqhO8ZSHqzanJ5EoK1g7kSeaxq1+oXGUJX7k
 7IloX3TZ0X6a8+3A1A7zHQJu/FbEQnytevGYUhCJ/3aI5kFd
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add driver for the Rockchip CAN-FD controller.

The IP core on the rk3568v2 SoC has 12 documented errata. Corrections
for these errata will be added in the upcoming patches.

Since several workarounds are required for the TX path, only add the
base driver that only implements the RX path.

Although the RX path implements CAN-FD support, it's not activated in
ctrlmode_supported, as the IP core in the rk3568v2 has problems with
receiving or sending certain CAN-FD frames.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS                                        |   1 +
 drivers/net/can/Kconfig                            |   1 +
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/rockchip/Kconfig                   |   9 +
 drivers/net/can/rockchip/Makefile                  |   9 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 868 +++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 118 +++
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |  15 +
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  12 +
 drivers/net/can/rockchip/rockchip_canfd.h          | 361 +++++++++
 10 files changed, 1395 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 115307354f0b..01f129458838 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19736,6 +19736,7 @@ R:	kernel@pengutronix.de
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml
+F:	drivers/net/can/rockchip/
 
 ROCKCHIP CRYPTO DRIVERS
 M:	Corentin Labbe <clabbe@baylibre.com>
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 7f9b60a42d29..cf989bea9aa3 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -225,6 +225,7 @@ source "drivers/net/can/m_can/Kconfig"
 source "drivers/net/can/mscan/Kconfig"
 source "drivers/net/can/peak_canfd/Kconfig"
 source "drivers/net/can/rcar/Kconfig"
+source "drivers/net/can/rockchip/Kconfig"
 source "drivers/net/can/sja1000/Kconfig"
 source "drivers/net/can/softing/Kconfig"
 source "drivers/net/can/spi/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 4669cd51e7bf..a71db2cfe990 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 obj-y				+= dev/
 obj-y				+= esd/
 obj-y				+= rcar/
+obj-y				+= rockchip/
 obj-y				+= spi/
 obj-y				+= usb/
 obj-y				+= softing/
diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
new file mode 100644
index 000000000000..e029e2a3ca4b
--- /dev/null
+++ b/drivers/net/can/rockchip/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config CAN_ROCKCHIP_CANFD
+	tristate "Rockchip CAN-FD controller"
+	depends on OF || COMPILE_TEST
+	select CAN_RX_OFFLOAD
+	help
+	  Say Y here if you want to use CAN-FD controller found on
+	  Rockchip SoCs.
diff --git a/drivers/net/can/rockchip/Makefile b/drivers/net/can/rockchip/Makefile
new file mode 100644
index 000000000000..4eb7c50d8d5b
--- /dev/null
+++ b/drivers/net/can/rockchip/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CAN_ROCKCHIP_CANFD) += rockchip_canfd.o
+
+rockchip_canfd-objs :=
+rockchip_canfd-objs += rockchip_canfd-core.o
+rockchip_canfd-objs += rockchip_canfd-rx.o
+rockchip_canfd-objs += rockchip_canfd-timestamp.o
+rockchip_canfd-objs += rockchip_canfd-tx.o
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
new file mode 100644
index 000000000000..f1b2bad04bf4
--- /dev/null
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2023, 2024 Pengutronix,
+//               Marc Kleine-Budde <kernel@pengutronix.de>
+//
+// Based on:
+//
+// Rockchip CANFD driver
+//
+// Copyright (c) 2020 Rockchip Electronics Co. Ltd.
+//
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/string.h>
+
+#include "rockchip_canfd.h"
+
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
+	.model = RKCANFD_MODEL_RK3568V2,
+};
+
+static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
+{
+	switch (model) {
+	case RKCANFD_MODEL_RK3568V2:
+		return "rk3568v2";
+	}
+
+	return "<unknown>";
+}
+
+static inline const char *
+rkcanfd_get_model_str(const struct rkcanfd_priv *priv)
+{
+	return __rkcanfd_get_model_str(priv->devtype_data.model);
+}
+
+/* Note:
+ *
+ * The formula to calculate the CAN System Clock is:
+ *
+ * Tsclk = 2 x Tclk x (brp + 1)
+ *
+ * Double the data sheet's brp_min, brp_max and brp_inc values (both
+ * for the arbitration and data bit timing) to take the "2 x" into
+ * account.
+ */
+static const struct can_bittiming_const rkcanfd_bittiming_const = {
+	.name = DEVICE_NAME,
+	.tseg1_min = 1,
+	.tseg1_max = 256,
+	.tseg2_min = 1,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 2,	/* value from data sheet x2 */
+	.brp_max = 512,	/* value from data sheet x2 */
+	.brp_inc = 2,	/* value from data sheet x2 */
+};
+
+static const struct can_bittiming_const rkcanfd_data_bittiming_const = {
+	.name = DEVICE_NAME,
+	.tseg1_min = 1,
+	.tseg1_max = 32,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 2,	/* value from data sheet x2 */
+	.brp_max = 512,	/* value from data sheet x2 */
+	.brp_inc = 2,	/* value from data sheet x2 */
+};
+
+static void rkcanfd_chip_set_reset_mode(const struct rkcanfd_priv *priv)
+{
+	reset_control_assert(priv->reset);
+	udelay(2);
+	reset_control_deassert(priv->reset);
+
+	rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);
+}
+
+static void rkcanfd_chip_set_work_mode(const struct rkcanfd_priv *priv)
+{
+	rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);
+}
+
+static int rkcanfd_set_bittiming(struct rkcanfd_priv *priv)
+{
+	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	u32 reg_nbt, reg_dbt, reg_tdc;
+	u32 tdco;
+
+	reg_nbt = FIELD_PREP(RKCANFD_REG_FD_NOMINAL_BITTIMING_SJW,
+			     bt->sjw - 1) |
+		FIELD_PREP(RKCANFD_REG_FD_NOMINAL_BITTIMING_BRP,
+			   (bt->brp / 2) - 1) |
+		FIELD_PREP(RKCANFD_REG_FD_NOMINAL_BITTIMING_TSEG2,
+			   bt->phase_seg2 - 1) |
+		FIELD_PREP(RKCANFD_REG_FD_NOMINAL_BITTIMING_TSEG1,
+			   bt->prop_seg + bt->phase_seg1 - 1);
+
+	rkcanfd_write(priv, RKCANFD_REG_FD_NOMINAL_BITTIMING, reg_nbt);
+
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
+		return 0;
+
+	reg_dbt = FIELD_PREP(RKCANFD_REG_FD_DATA_BITTIMING_SJW,
+			     dbt->sjw - 1) |
+		FIELD_PREP(RKCANFD_REG_FD_DATA_BITTIMING_BRP,
+			   (dbt->brp / 2) - 1) |
+		FIELD_PREP(RKCANFD_REG_FD_DATA_BITTIMING_TSEG2,
+			   dbt->phase_seg2 - 1) |
+		FIELD_PREP(RKCANFD_REG_FD_DATA_BITTIMING_TSEG1,
+			   dbt->prop_seg + dbt->phase_seg1 - 1);
+
+	rkcanfd_write(priv, RKCANFD_REG_FD_DATA_BITTIMING, reg_dbt);
+
+	tdco = (priv->can.clock.freq / dbt->bitrate) * 2 / 3;
+	tdco = min(tdco, FIELD_MAX(RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_OFFSET));
+
+	reg_tdc = FIELD_PREP(RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_OFFSET, tdco) |
+		RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_ENABLE;
+	rkcanfd_write(priv, RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION,
+		      reg_tdc);
+
+	return 0;
+}
+
+static void rkcanfd_get_berr_counter_raw(struct rkcanfd_priv *priv,
+					 struct can_berr_counter *bec)
+{
+	bec->rxerr = rkcanfd_read(priv, RKCANFD_REG_RXERRORCNT);
+	bec->txerr = rkcanfd_read(priv, RKCANFD_REG_TXERRORCNT);
+}
+
+static int rkcanfd_get_berr_counter(const struct net_device *ndev,
+				    struct can_berr_counter *bec)
+{
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	int err;
+
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
+	if (err)
+		return err;
+
+	rkcanfd_get_berr_counter_raw(priv, bec);
+
+	pm_runtime_put(ndev->dev.parent);
+
+	return 0;
+}
+
+static void rkcanfd_chip_interrupts_enable(const struct rkcanfd_priv *priv)
+{
+	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, priv->reg_int_mask_default);
+
+	netdev_dbg(priv->ndev, "%s: reg_int_mask=0x%08x\n", __func__,
+		   rkcanfd_read(priv, RKCANFD_REG_INT_MASK));
+}
+
+static void rkcanfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
+{
+	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
+}
+
+static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
+{
+	u32 reg;
+
+	/* TXE FIFO */
+	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
+	rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
+
+	/* RX FIFO */
+	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
+	rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
+
+	WRITE_ONCE(priv->tx_head, 0);
+	WRITE_ONCE(priv->tx_tail, 0);
+	netdev_reset_queue(priv->ndev);
+}
+
+static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
+{
+	u32 reg;
+
+	rkcanfd_chip_set_reset_mode(priv);
+
+	/* Receiving Filter: accept all */
+	rkcanfd_write(priv, RKCANFD_REG_IDCODE, 0x0);
+	rkcanfd_write(priv, RKCANFD_REG_IDMASK, RKCANFD_REG_IDCODE_EXTENDED_FRAME_ID);
+
+	/* enable:
+	 * - CAN_FD: enable CAN-FD
+	 * - AUTO_RETX_MODE: auto retransmission on TX error
+	 * - COVER_MODE: RX-FIFO overwrite mode, do not send OVERLOAD frames
+	 * - WORK_MODE: transition from reset to working mode
+	 */
+	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
+	priv->reg_mode_default = reg |
+		RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
+		RKCANFD_REG_MODE_AUTO_RETX_MODE |
+		RKCANFD_REG_MODE_COVER_MODE |
+		RKCANFD_REG_MODE_WORK_MODE;
+
+	/* mask, i.e. ignore:
+	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interrupt
+	 * - TX_ARBIT_FAIL_INT - TX arbitration fail interrupt
+	 * - OVERLOAD_INT - CAN bus overload interrupt
+	 */
+	priv->reg_int_mask_default =
+		RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT |
+		RKCANFD_REG_INT_TX_ARBIT_FAIL_INT |
+		RKCANFD_REG_INT_OVERLOAD_INT;
+
+	rkcanfd_chip_fifo_setup(priv);
+	rkcanfd_timestamp_init(priv);
+	rkcanfd_set_bittiming(priv);
+
+	rkcanfd_chip_interrupts_disable(priv);
+	rkcanfd_chip_set_work_mode(priv);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	netdev_dbg(priv->ndev, "%s: reg_mode=0x%08x\n", __func__,
+		   rkcanfd_read(priv, RKCANFD_REG_MODE));
+}
+
+static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
+{
+	priv->can.state = state;
+
+	rkcanfd_chip_set_reset_mode(priv);
+	rkcanfd_chip_interrupts_disable(priv);
+}
+
+static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
+{
+	priv->can.state = state;
+
+	__rkcanfd_chip_stop(priv, state);
+}
+
+static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_state state)
+{
+	priv->can.state = state;
+
+	__rkcanfd_chip_stop(priv, state);
+}
+
+static int rkcanfd_set_mode(struct net_device *ndev,
+			    enum can_mode mode)
+{
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+
+	switch (mode) {
+	case CAN_MODE_START:
+		rkcanfd_chip_start(priv);
+		rkcanfd_chip_interrupts_enable(priv);
+		netif_wake_queue(ndev);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct sk_buff *
+rkcanfd_alloc_can_err_skb(struct rkcanfd_priv *priv,
+			  struct can_frame **cf, u32 *timestamp)
+{
+	struct sk_buff *skb;
+
+	*timestamp = rkcanfd_get_timestamp(priv);
+
+	skb = alloc_can_err_skb(priv->ndev, cf);
+
+	return skb;
+}
+
+static const char *rkcanfd_get_error_type_str(unsigned int type)
+{
+	switch (type) {
+	case RKCANFD_REG_ERROR_CODE_TYPE_BIT:
+		return "Bit";
+	case RKCANFD_REG_ERROR_CODE_TYPE_STUFF:
+		return "Stuff";
+	case RKCANFD_REG_ERROR_CODE_TYPE_FORM:
+		return "Form";
+	case RKCANFD_REG_ERROR_CODE_TYPE_ACK:
+		return "ACK";
+	case RKCANFD_REG_ERROR_CODE_TYPE_CRC:
+		return "CRC";
+	}
+
+	return "<unknown>";
+}
+
+#define RKCAN_ERROR_CODE(reg_ec, code) \
+	((reg_ec) & RKCANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
+
+static void
+rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
+				const u32 reg_ec)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	unsigned int type;
+	u32 reg_state, reg_cmd;
+
+	type = FIELD_GET(RKCANFD_REG_ERROR_CODE_TYPE, reg_ec);
+	reg_cmd = rkcanfd_read(priv, RKCANFD_REG_CMD);
+	reg_state = rkcanfd_read(priv, RKCANFD_REG_STATE);
+
+	netdev_dbg(priv->ndev, "%s Error in %s %s Phase: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s(0x%08x) CMD=%u RX=%u TX=%u Error-Warning=%u Bus-Off=%u\n",
+		   rkcanfd_get_error_type_str(type),
+		   reg_ec & RKCANFD_REG_ERROR_CODE_DIRECTION_RX ? "RX" : "TX",
+		   reg_ec & RKCANFD_REG_ERROR_CODE_PHASE ? "Data" : "Arbitration",
+		   RKCAN_ERROR_CODE(reg_ec, TX_OVERLOAD),
+		   RKCAN_ERROR_CODE(reg_ec, TX_ERROR),
+		   RKCAN_ERROR_CODE(reg_ec, TX_ACK),
+		   RKCAN_ERROR_CODE(reg_ec, TX_ACK_EOF),
+		   RKCAN_ERROR_CODE(reg_ec, TX_CRC),
+		   RKCAN_ERROR_CODE(reg_ec, TX_STUFF_COUNT),
+		   RKCAN_ERROR_CODE(reg_ec, TX_DATA),
+		   RKCAN_ERROR_CODE(reg_ec, TX_SOF_DLC),
+		   RKCAN_ERROR_CODE(reg_ec, TX_IDLE),
+		   RKCAN_ERROR_CODE(reg_ec, RX_BUF_INT),
+		   RKCAN_ERROR_CODE(reg_ec, RX_SPACE),
+		   RKCAN_ERROR_CODE(reg_ec, RX_EOF),
+		   RKCAN_ERROR_CODE(reg_ec, RX_ACK_LIM),
+		   RKCAN_ERROR_CODE(reg_ec, RX_ACK),
+		   RKCAN_ERROR_CODE(reg_ec, RX_CRC_LIM),
+		   RKCAN_ERROR_CODE(reg_ec, RX_CRC),
+		   RKCAN_ERROR_CODE(reg_ec, RX_STUFF_COUNT),
+		   RKCAN_ERROR_CODE(reg_ec, RX_DATA),
+		   RKCAN_ERROR_CODE(reg_ec, RX_DLC),
+		   RKCAN_ERROR_CODE(reg_ec, RX_BRS_ESI),
+		   RKCAN_ERROR_CODE(reg_ec, RX_RES),
+		   RKCAN_ERROR_CODE(reg_ec, RX_FDF),
+		   RKCAN_ERROR_CODE(reg_ec, RX_ID2_RTR),
+		   RKCAN_ERROR_CODE(reg_ec, RX_SOF_IDE),
+		   RKCAN_ERROR_CODE(reg_ec, RX_IDLE),
+		   reg_ec, reg_cmd,
+		   !!(reg_state & RKCANFD_REG_STATE_RX_PERIOD),
+		   !!(reg_state & RKCANFD_REG_STATE_TX_PERIOD),
+		   !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE),
+		   !!(reg_state & RKCANFD_REG_STATE_BUS_OFF_STATE));
+
+	priv->can.can_stats.bus_error++;
+
+	if (reg_ec & RKCANFD_REG_ERROR_CODE_DIRECTION_RX)
+		stats->rx_errors++;
+	else
+		stats->tx_errors++;
+
+	if (!cf)
+		return;
+
+	if (reg_ec & RKCANFD_REG_ERROR_CODE_DIRECTION_RX) {
+		if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_SOF_IDE)
+			cf->data[3] = CAN_ERR_PROT_LOC_SOF;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_ID2_RTR)
+			cf->data[3] = CAN_ERR_PROT_LOC_RTR;
+		/* RKCANFD_REG_ERROR_CODE_RX_FDF */
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_RES)
+			cf->data[3] = CAN_ERR_PROT_LOC_RES0;
+		/* RKCANFD_REG_ERROR_CODE_RX_BRS_ESI */
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_DLC)
+			cf->data[3] = CAN_ERR_PROT_LOC_DLC;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_DATA)
+			cf->data[3] = CAN_ERR_PROT_LOC_DATA;
+		/* RKCANFD_REG_ERROR_CODE_RX_STUFF_COUNT */
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_CRC)
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_CRC_LIM)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_ACK)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_ACK_LIM)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_EOF)
+			cf->data[3] = CAN_ERR_PROT_LOC_EOF;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_SPACE)
+			cf->data[3] = CAN_ERR_PROT_LOC_EOF;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_BUF_INT)
+			cf->data[3] = CAN_ERR_PROT_LOC_INTERM;
+	} else {
+		cf->data[2] |= CAN_ERR_PROT_TX;
+
+		if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_SOF_DLC)
+			cf->data[3] = CAN_ERR_PROT_LOC_SOF;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_DATA)
+			cf->data[3] = CAN_ERR_PROT_LOC_DATA;
+		/* RKCANFD_REG_ERROR_CODE_TX_STUFF_COUNT */
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_CRC)
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
+		/* RKCANFD_REG_ERROR_CODE_TX_ERROR */
+		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_OVERLOAD)
+			cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+	}
+
+	switch (reg_ec & RKCANFD_REG_ERROR_CODE_TYPE) {
+	case FIELD_PREP_CONST(RKCANFD_REG_ERROR_CODE_TYPE,
+			      RKCANFD_REG_ERROR_CODE_TYPE_BIT):
+
+		cf->data[2] |= CAN_ERR_PROT_BIT;
+		break;
+	case FIELD_PREP_CONST(RKCANFD_REG_ERROR_CODE_TYPE,
+			      RKCANFD_REG_ERROR_CODE_TYPE_STUFF):
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	case FIELD_PREP_CONST(RKCANFD_REG_ERROR_CODE_TYPE,
+			      RKCANFD_REG_ERROR_CODE_TYPE_FORM):
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case FIELD_PREP_CONST(RKCANFD_REG_ERROR_CODE_TYPE,
+			      RKCANFD_REG_ERROR_CODE_TYPE_ACK):
+		cf->can_id |= CAN_ERR_ACK;
+		break;
+	case FIELD_PREP_CONST(RKCANFD_REG_ERROR_CODE_TYPE,
+			      RKCANFD_REG_ERROR_CODE_TYPE_CRC):
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		break;
+	}
+}
+
+static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct can_frame *cf = NULL;
+	u32 reg_ec, timestamp;
+	struct sk_buff *skb;
+	int err;
+
+	reg_ec = rkcanfd_read(priv, RKCANFD_REG_ERROR_CODE);
+
+	if (!reg_ec)
+		return 0;
+
+	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	if (cf) {
+		struct can_berr_counter bec;
+
+		rkcanfd_get_berr_counter_raw(priv, &bec);
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+	}
+
+	rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
+
+	if (!cf)
+		return 0;
+
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
+static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	enum can_state new_state, rx_state, tx_state;
+	struct net_device *ndev = priv->ndev;
+	struct can_berr_counter bec;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb;
+	u32 timestamp;
+	int err;
+
+	rkcanfd_get_berr_counter_raw(priv, &bec);
+	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
+
+	new_state = max(tx_state, rx_state);
+	if (new_state == priv->can.state)
+		return 0;
+
+	/* The skb allocation might fail, but can_change_state()
+	 * handles cf == NULL.
+	 */
+	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	can_change_state(ndev, cf, tx_state, rx_state);
+
+	if (new_state == CAN_STATE_BUS_OFF) {
+		rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF);
+		can_bus_off(ndev);
+	}
+
+	if (!skb)
+		return 0;
+
+	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+	}
+
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
+static int
+rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct can_berr_counter bec;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb;
+	u32 timestamp;
+	int err;
+
+	stats->rx_over_errors++;
+	stats->rx_errors++;
+
+	netdev_dbg(priv->ndev, "RX-FIFO overflow\n");
+
+	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	if (skb)
+		return 0;
+
+	rkcanfd_get_berr_counter_raw(priv, &bec);
+
+	cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
+	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+	cf->data[6] = bec.txerr;
+	cf->data[7] = bec.rxerr;
+
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
+#define rkcanfd_handle(priv, irq, ...) \
+({ \
+	struct rkcanfd_priv *_priv = (priv); \
+	int err; \
+\
+	err = rkcanfd_handle_##irq(_priv, ## __VA_ARGS__); \
+	if (err) \
+		netdev_err(_priv->ndev, \
+			"IRQ handler rkcanfd_handle_%s() returned error: %pe\n", \
+			   __stringify(irq), ERR_PTR(err)); \
+	err; \
+})
+
+static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
+{
+	struct rkcanfd_priv *priv = dev_id;
+	u32 reg_int_unmasked, reg_int;
+
+	reg_int_unmasked = rkcanfd_read(priv, RKCANFD_REG_INT);
+	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
+
+	if (!reg_int)
+		return IRQ_NONE;
+
+	/* First ACK then handle, to avoid lost-IRQ race condition on
+	 * fast re-occurring interrupts.
+	 */
+	rkcanfd_write(priv, RKCANFD_REG_INT, reg_int);
+
+	if (reg_int & RKCANFD_REG_INT_RX_FINISH_INT)
+		rkcanfd_handle(priv, rx_int);
+
+	if (reg_int & RKCANFD_REG_INT_ERROR_INT)
+		rkcanfd_handle(priv, error_int);
+
+	if (reg_int & (RKCANFD_REG_INT_BUS_OFF_INT |
+		       RKCANFD_REG_INT_PASSIVE_ERROR_INT |
+		       RKCANFD_REG_INT_ERROR_WARNING_INT) ||
+	    priv->can.state > CAN_STATE_ERROR_ACTIVE)
+		rkcanfd_handle(priv, state_error_int);
+
+	if (reg_int & RKCANFD_REG_INT_RX_FIFO_OVERFLOW_INT)
+		rkcanfd_handle(priv, rx_fifo_overflow_int);
+
+	if (reg_int & ~(RKCANFD_REG_INT_ALL_ERROR |
+			RKCANFD_REG_INT_RX_FIFO_OVERFLOW_INT |
+			RKCANFD_REG_INT_RX_FINISH_INT))
+		netdev_err(priv->ndev, "%s: int=0x%08x\n", __func__, reg_int);
+
+	if (reg_int & RKCANFD_REG_INT_WAKEUP_INT)
+		netdev_info(priv->ndev, "%s: WAKEUP_INT\n", __func__);
+
+	if (reg_int & RKCANFD_REG_INT_TXE_FIFO_FULL_INT)
+		netdev_info(priv->ndev, "%s: TXE_FIFO_FULL_INT\n", __func__);
+
+	if (reg_int & RKCANFD_REG_INT_TXE_FIFO_OV_INT)
+		netdev_info(priv->ndev, "%s: TXE_FIFO_OV_INT\n", __func__);
+
+	if (reg_int & RKCANFD_REG_INT_BUS_OFF_RECOVERY_INT)
+		netdev_info(priv->ndev, "%s: BUS_OFF_RECOVERY_INT\n", __func__);
+
+	if (reg_int & RKCANFD_REG_INT_RX_FIFO_FULL_INT)
+		netdev_info(priv->ndev, "%s: RX_FIFO_FULL_INT\n", __func__);
+
+	if (reg_int & RKCANFD_REG_INT_OVERLOAD_INT)
+		netdev_info(priv->ndev, "%s: OVERLOAD_INT\n", __func__);
+
+	can_rx_offload_irq_finish(&priv->offload);
+
+	return IRQ_HANDLED;
+}
+
+static int rkcanfd_open(struct net_device *ndev)
+{
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	int err;
+
+	err = open_candev(ndev);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
+	if (err)
+		goto out_close_candev;
+
+	rkcanfd_chip_start(priv);
+	can_rx_offload_enable(&priv->offload);
+
+	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
+	if (err)
+		goto out_rkcanfd_chip_stop;
+
+	rkcanfd_chip_interrupts_enable(priv);
+
+	netif_start_queue(ndev);
+
+	return 0;
+
+out_rkcanfd_chip_stop:
+	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+	pm_runtime_put(ndev->dev.parent);
+out_close_candev:
+	close_candev(ndev);
+	return err;
+}
+
+static int rkcanfd_stop(struct net_device *ndev)
+{
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+
+	netif_stop_queue(ndev);
+
+	rkcanfd_chip_interrupts_disable(priv);
+	free_irq(ndev->irq, priv);
+	can_rx_offload_disable(&priv->offload);
+	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+	close_candev(ndev);
+
+	pm_runtime_put(ndev->dev.parent);
+
+	return 0;
+}
+
+static const struct net_device_ops rkcanfd_netdev_ops = {
+	.ndo_open = rkcanfd_open,
+	.ndo_stop = rkcanfd_stop,
+	.ndo_start_xmit = rkcanfd_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+static int __maybe_unused rkcanfd_runtime_suspend(struct device *dev)
+{
+	struct rkcanfd_priv *priv = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(priv->clks_num, priv->clks);
+
+	return 0;
+}
+
+static int __maybe_unused rkcanfd_runtime_resume(struct device *dev)
+{
+	struct rkcanfd_priv *priv = dev_get_drvdata(dev);
+
+	return clk_bulk_prepare_enable(priv->clks_num, priv->clks);
+}
+
+static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
+{
+	u32 dev_id;
+
+	dev_id = rkcanfd_read(priv, RKCANFD_REG_RTL_VERSION);
+
+	netdev_info(priv->ndev,
+		    "Rockchip-CANFD %s rev%lu.%lu found\n",
+		    rkcanfd_get_model_str(priv),
+		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MAJOR, dev_id),
+		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MINOR, dev_id));
+}
+
+static int rkcanfd_register(struct rkcanfd_priv *priv)
+{
+	struct net_device *ndev = priv->ndev;
+	int err;
+
+	pm_runtime_enable(ndev->dev.parent);
+
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
+	if (err)
+		goto out_pm_runtime_disable;
+
+	err = register_candev(ndev);
+	if (err)
+		goto out_pm_runtime_put_sync;
+
+	rkcanfd_register_done(priv);
+
+	pm_runtime_put(ndev->dev.parent);
+
+	return 0;
+
+out_pm_runtime_put_sync:
+	pm_runtime_put_sync(ndev->dev.parent);
+out_pm_runtime_disable:
+	pm_runtime_disable(ndev->dev.parent);
+
+	return err;
+}
+
+static inline void rkcanfd_unregister(struct rkcanfd_priv *priv)
+{
+	struct net_device *ndev	= priv->ndev;
+
+	unregister_candev(ndev);
+	pm_runtime_disable(ndev->dev.parent);
+}
+
+static const struct of_device_id rkcanfd_of_match[] = {
+	{
+		.compatible = "rockchip,rk3568v2-canfd",
+		.data = &rkcanfd_devtype_data_rk3568v2,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, rkcanfd_of_match);
+
+static int rkcanfd_probe(struct platform_device *pdev)
+{
+	struct rkcanfd_priv *priv;
+	struct net_device *ndev;
+	const void *match;
+	int err;
+
+	ndev = alloc_candev(sizeof(struct rkcanfd_priv), RKCANFD_TXFIFO_DEPTH);
+	if (!ndev)
+		return -ENOMEM;
+
+	priv = netdev_priv(ndev);
+
+	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0) {
+		err = ndev->irq;
+		goto out_free_candev;
+	}
+
+	priv->clks_num = devm_clk_bulk_get_all(&pdev->dev, &priv->clks);
+	if (priv->clks_num < 0) {
+		err = priv->clks_num;
+		goto out_free_candev;
+	}
+
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->regs)) {
+		err = PTR_ERR(priv->regs);
+		goto out_free_candev;
+	}
+
+	priv->reset = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(priv->reset)) {
+		err = dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
+				    "Failed to get reset line\n");
+		goto out_free_candev;
+	}
+
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	ndev->netdev_ops = &rkcanfd_netdev_ops;
+	ndev->flags |= IFF_ECHO;
+
+	platform_set_drvdata(pdev, priv);
+	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
+	priv->can.bittiming_const = &rkcanfd_bittiming_const;
+	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
+	priv->can.ctrlmode_supported = 0;
+	priv->can.do_set_mode = rkcanfd_set_mode;
+	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
+	priv->ndev = ndev;
+
+	match = device_get_match_data(&pdev->dev);
+	if (match)
+		priv->devtype_data = *(struct rkcanfd_devtype_data *)match;
+
+	err = can_rx_offload_add_manual(ndev, &priv->offload,
+					RKCANFD_NAPI_WEIGHT);
+	if (err)
+		goto out_free_candev;
+
+	err = rkcanfd_register(priv);
+	if (err)
+		goto out_can_rx_offload_del;
+
+	return 0;
+
+out_can_rx_offload_del:
+	can_rx_offload_del(&priv->offload);
+out_free_candev:
+	free_candev(ndev);
+
+	return err;
+}
+
+static void rkcanfd_remove(struct platform_device *pdev)
+{
+	struct rkcanfd_priv *priv = platform_get_drvdata(pdev);
+	struct net_device *ndev = priv->ndev;
+
+	can_rx_offload_del(&priv->offload);
+	rkcanfd_unregister(priv);
+	free_candev(ndev);
+}
+
+static const struct dev_pm_ops rkcanfd_pm_ops = {
+	SET_RUNTIME_PM_OPS(rkcanfd_runtime_suspend,
+			   rkcanfd_runtime_resume, NULL)
+};
+
+static struct platform_driver rkcanfd_driver = {
+	.driver = {
+		.name = DEVICE_NAME,
+		.pm = &rkcanfd_pm_ops,
+		.of_match_table = rkcanfd_of_match,
+	},
+	.probe = rkcanfd_probe,
+	.remove = rkcanfd_remove,
+};
+module_platform_driver(rkcanfd_driver);
+
+MODULE_AUTHOR("Marc Kleine-Budde <mkl@pengutronix.de>");
+MODULE_DESCRIPTION("Rockchip CAN-FD Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
new file mode 100644
index 000000000000..5398aff0d180
--- /dev/null
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2023, 2024 Pengutronix,
+//               Marc Kleine-Budde <kernel@pengutronix.de>
+//
+
+#include "rockchip_canfd.h"
+
+static unsigned int
+rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
+				  const struct rkcanfd_fifo_header *header,
+				  struct canfd_frame *cfd)
+{
+	unsigned int len = sizeof(*cfd) - sizeof(cfd->data);
+	u8 dlc;
+
+	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FRAME_FORMAT)
+		cfd->can_id = FIELD_GET(RKCANFD_REG_FD_ID_EFF, header->id) |
+			CAN_EFF_FLAG;
+	else
+		cfd->can_id = FIELD_GET(RKCANFD_REG_FD_ID_SFF, header->id);
+
+	dlc = FIELD_GET(RKCANFD_REG_FD_FRAMEINFO_DATA_LENGTH,
+			header->frameinfo);
+
+	/* CAN-FD */
+	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF) {
+		cfd->len = can_fd_dlc2len(dlc);
+
+		/* The cfd is not allocated by alloc_canfd_skb(), so
+		 * set CANFD_FDF here.
+		 */
+		cfd->flags |= CANFD_FDF;
+
+		if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_BRS)
+			cfd->flags |= CANFD_BRS;
+	} else {
+		cfd->len = can_cc_dlc2len(dlc);
+
+		if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_RTR) {
+			cfd->can_id |= CAN_RTR_FLAG;
+
+			return len;
+		}
+	}
+
+	return len + cfd->len;
+}
+
+static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct canfd_frame cfd[1] = { }, *skb_cfd;
+	struct rkcanfd_fifo_header header[1] = { };
+	struct sk_buff *skb;
+	unsigned int len;
+	int err;
+
+	/* read header into separate struct and convert it later */
+	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
+			 header, sizeof(*header));
+	/* read data directly into cfd */
+	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
+			 cfd->data, sizeof(cfd->data));
+
+	len = rkcanfd_fifo_header_to_cfd_header(priv, header, cfd);
+
+	/* Drop any received CAN-FD frames if CAN-FD mode is not
+	 * requested.
+	 */
+	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF &&
+	    !(priv->can.ctrlmode & CAN_CTRLMODE_FD)) {
+		stats->rx_dropped++;
+
+		return 0;
+	}
+
+	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF)
+		skb = alloc_canfd_skb(priv->ndev, &skb_cfd);
+	else
+		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&skb_cfd);
+
+	if (!skb) {
+		stats->rx_dropped++;
+
+		return 0;
+	}
+
+	memcpy(skb_cfd, cfd, len);
+
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, header->ts);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
+static inline unsigned int
+rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
+{
+	const u32 reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+
+	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
+}
+
+int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
+{
+	unsigned int len;
+	int err;
+
+	while ((len = rkcanfd_rx_fifo_get_len(priv))) {
+		err = rkcanfd_handle_rx_int_one(priv);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
new file mode 100644
index 000000000000..9301b3ceceb0
--- /dev/null
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2023, 2024 Pengutronix,
+//               Marc Kleine-Budde <kernel@pengutronix.de>
+//
+
+#include "rockchip_canfd.h"
+
+void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
+{
+	u32 reg;
+
+	reg = RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_ENABLE;
+	rkcanfd_write(priv, RKCANFD_REG_TIMESTAMP_CTRL, reg);
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
new file mode 100644
index 000000000000..89c65db3b2dc
--- /dev/null
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2023, 2024 Pengutronix,
+//               Marc Kleine-Budde <kernel@pengutronix.de>
+//
+
+#include "rockchip_canfd.h"
+
+int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	return NETDEV_TX_OK;
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
new file mode 100644
index 000000000000..0848b1900baa
--- /dev/null
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -0,0 +1,361 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2023, 2024 Pengutronix,
+ *               Marc Kleine-Budde <kernel@pengutronix.de>
+ */
+
+#ifndef _ROCKCHIP_CANFD_H
+#define _ROCKCHIP_CANFD_H
+
+#include <linux/bitfield.h>
+#include <linux/can/dev.h>
+#include <linux/can/rx-offload.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/netdevice.h>
+#include <linux/reset.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/u64_stats_sync.h>
+#include <linux/units.h>
+
+#define RKCANFD_REG_MODE 0x000
+#define RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE BIT(15)
+#define RKCANFD_REG_MODE_DPEE BIT(14)
+#define RKCANFD_REG_MODE_BRSD BIT(13)
+#define RKCANFD_REG_MODE_SPACE_RX_MODE BIT(12)
+#define RKCANFD_REG_MODE_AUTO_BUS_ON BIT(11)
+#define RKCANFD_REG_MODE_AUTO_RETX_MODE BIT(10)
+#define RKCANFD_REG_MODE_OVLD_MODE BIT(9)
+#define RKCANFD_REG_MODE_COVER_MODE BIT(8)
+#define RKCANFD_REG_MODE_RXSORT_MODE BIT(7)
+#define RKCANFD_REG_MODE_TXORDER_MODE BIT(6)
+#define RKCANFD_REG_MODE_RXSTX_MODE BIT(5)
+#define RKCANFD_REG_MODE_LBACK_MODE BIT(4)
+#define RKCANFD_REG_MODE_SILENT_MODE BIT(3)
+#define RKCANFD_REG_MODE_SELF_TEST BIT(2)
+#define RKCANFD_REG_MODE_SLEEP_MODE BIT(1)
+#define RKCANFD_REG_MODE_WORK_MODE BIT(0)
+
+#define RKCANFD_REG_CMD 0x004
+#define RKCANFD_REG_CMD_TX1_REQ BIT(1)
+#define RKCANFD_REG_CMD_TX0_REQ BIT(0)
+#define RKCANFD_REG_CMD_TX_REQ(i) (RKCANFD_REG_CMD_TX0_REQ << (i))
+
+#define RKCANFD_REG_STATE 0x008
+#define RKCANFD_REG_STATE_SLEEP_STATE BIT(6)
+#define RKCANFD_REG_STATE_BUS_OFF_STATE BIT(5)
+#define RKCANFD_REG_STATE_ERROR_WARNING_STATE BIT(4)
+#define RKCANFD_REG_STATE_TX_PERIOD BIT(3)
+#define RKCANFD_REG_STATE_RX_PERIOD BIT(2)
+#define RKCANFD_REG_STATE_TX_BUFFER_FULL BIT(1)
+#define RKCANFD_REG_STATE_RX_BUFFER_FULL BIT(0)
+
+#define RKCANFD_REG_INT 0x00c
+#define RKCANFD_REG_INT_WAKEUP_INT BIT(14)
+#define RKCANFD_REG_INT_TXE_FIFO_FULL_INT BIT(13)
+#define RKCANFD_REG_INT_TXE_FIFO_OV_INT BIT(12)
+#define RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT BIT(11)
+#define RKCANFD_REG_INT_BUS_OFF_RECOVERY_INT BIT(10)
+#define RKCANFD_REG_INT_BUS_OFF_INT BIT(9)
+#define RKCANFD_REG_INT_RX_FIFO_OVERFLOW_INT BIT(8)
+#define RKCANFD_REG_INT_RX_FIFO_FULL_INT BIT(7)
+#define RKCANFD_REG_INT_ERROR_INT BIT(6)
+#define RKCANFD_REG_INT_TX_ARBIT_FAIL_INT BIT(5)
+#define RKCANFD_REG_INT_PASSIVE_ERROR_INT BIT(4)
+#define RKCANFD_REG_INT_OVERLOAD_INT BIT(3)
+#define RKCANFD_REG_INT_ERROR_WARNING_INT BIT(2)
+#define RKCANFD_REG_INT_TX_FINISH_INT BIT(1)
+#define RKCANFD_REG_INT_RX_FINISH_INT BIT(0)
+
+#define RKCANFD_REG_INT_ALL \
+	(RKCANFD_REG_INT_WAKEUP_INT | \
+	 RKCANFD_REG_INT_TXE_FIFO_FULL_INT | \
+	 RKCANFD_REG_INT_TXE_FIFO_OV_INT | \
+	 RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT | \
+	 RKCANFD_REG_INT_BUS_OFF_RECOVERY_INT | \
+	 RKCANFD_REG_INT_BUS_OFF_INT | \
+	 RKCANFD_REG_INT_RX_FIFO_OVERFLOW_INT | \
+	 RKCANFD_REG_INT_RX_FIFO_FULL_INT | \
+	 RKCANFD_REG_INT_ERROR_INT | \
+	 RKCANFD_REG_INT_TX_ARBIT_FAIL_INT | \
+	 RKCANFD_REG_INT_PASSIVE_ERROR_INT | \
+	 RKCANFD_REG_INT_OVERLOAD_INT | \
+	 RKCANFD_REG_INT_ERROR_WARNING_INT | \
+	 RKCANFD_REG_INT_TX_FINISH_INT | \
+	 RKCANFD_REG_INT_RX_FINISH_INT)
+
+#define RKCANFD_REG_INT_ALL_ERROR \
+	(RKCANFD_REG_INT_BUS_OFF_INT | \
+	 RKCANFD_REG_INT_ERROR_INT | \
+	 RKCANFD_REG_INT_PASSIVE_ERROR_INT | \
+	 RKCANFD_REG_INT_ERROR_WARNING_INT)
+
+#define RKCANFD_REG_INT_MASK 0x010
+
+#define RKCANFD_REG_DMA_CTL 0x014
+#define RKCANFD_REG_DMA_CTL_DMA_RX_MODE BIT(1)
+#define RKCANFD_REG_DMA_CTL_DMA_TX_MODE BIT(9)
+
+#define RKCANFD_REG_BITTIMING 0x018
+#define RKCANFD_REG_BITTIMING_SAMPLE_MODE BIT(16)
+#define RKCANFD_REG_BITTIMING_SJW GENMASK(15, 14)
+#define RKCANFD_REG_BITTIMING_BRP GENMASK(13, 8)
+#define RKCANFD_REG_BITTIMING_TSEG2 GENMASK(6, 4)
+#define RKCANFD_REG_BITTIMING_TSEG1 GENMASK(3, 0)
+
+#define RKCANFD_REG_ARBITFAIL 0x028
+#define RKCANFD_REG_ARBITFAIL_ARBIT_FAIL_CODE GENMASK(6, 0)
+
+/* Register seems to be clear or read */
+#define RKCANFD_REG_ERROR_CODE 0x02c
+#define RKCANFD_REG_ERROR_CODE_PHASE BIT(29)
+#define RKCANFD_REG_ERROR_CODE_TYPE GENMASK(28, 26)
+#define RKCANFD_REG_ERROR_CODE_TYPE_BIT 0x0
+#define RKCANFD_REG_ERROR_CODE_TYPE_STUFF 0x1
+#define RKCANFD_REG_ERROR_CODE_TYPE_FORM 0x2
+#define RKCANFD_REG_ERROR_CODE_TYPE_ACK 0x3
+#define RKCANFD_REG_ERROR_CODE_TYPE_CRC 0x4
+#define RKCANFD_REG_ERROR_CODE_DIRECTION_RX BIT(25)
+#define RKCANFD_REG_ERROR_CODE_TX GENMASK(24, 16)
+#define RKCANFD_REG_ERROR_CODE_TX_OVERLOAD BIT(24)
+#define RKCANFD_REG_ERROR_CODE_TX_ERROR BIT(23)
+#define RKCANFD_REG_ERROR_CODE_TX_ACK BIT(22)
+#define RKCANFD_REG_ERROR_CODE_TX_ACK_EOF BIT(21)
+#define RKCANFD_REG_ERROR_CODE_TX_CRC BIT(20)
+#define RKCANFD_REG_ERROR_CODE_TX_STUFF_COUNT BIT(19)
+#define RKCANFD_REG_ERROR_CODE_TX_DATA BIT(18)
+#define RKCANFD_REG_ERROR_CODE_TX_SOF_DLC BIT(17)
+#define RKCANFD_REG_ERROR_CODE_TX_IDLE BIT(16)
+#define RKCANFD_REG_ERROR_CODE_RX GENMASK(15, 0)
+#define RKCANFD_REG_ERROR_CODE_RX_BUF_INT BIT(15)
+#define RKCANFD_REG_ERROR_CODE_RX_SPACE BIT(14)
+#define RKCANFD_REG_ERROR_CODE_RX_EOF BIT(13)
+#define RKCANFD_REG_ERROR_CODE_RX_ACK_LIM BIT(12)
+#define RKCANFD_REG_ERROR_CODE_RX_ACK BIT(11)
+#define RKCANFD_REG_ERROR_CODE_RX_CRC_LIM BIT(10)
+#define RKCANFD_REG_ERROR_CODE_RX_CRC BIT(9)
+#define RKCANFD_REG_ERROR_CODE_RX_STUFF_COUNT BIT(8)
+#define RKCANFD_REG_ERROR_CODE_RX_DATA BIT(7)
+#define RKCANFD_REG_ERROR_CODE_RX_DLC BIT(6)
+#define RKCANFD_REG_ERROR_CODE_RX_BRS_ESI BIT(5)
+#define RKCANFD_REG_ERROR_CODE_RX_RES BIT(4)
+#define RKCANFD_REG_ERROR_CODE_RX_FDF BIT(3)
+#define RKCANFD_REG_ERROR_CODE_RX_ID2_RTR BIT(2)
+#define RKCANFD_REG_ERROR_CODE_RX_SOF_IDE BIT(1)
+#define RKCANFD_REG_ERROR_CODE_RX_IDLE BIT(0)
+
+#define RKCANFD_REG_ERROR_CODE_NOACK \
+	(FIELD_PREP(RKCANFD_REG_ERROR_CODE_TYPE, \
+		    RKCANFD_REG_ERROR_CODE_TYPE_ACK) | \
+	 RKCANFD_REG_ERROR_CODE_TX_ACK_EOF | \
+	 RKCANFD_REG_ERROR_CODE_RX_ACK)
+
+#define RKCANFD_REG_RXERRORCNT 0x034
+#define RKCANFD_REG_RXERRORCNT_RX_ERR_CNT GENMASK(7, 0)
+
+#define RKCANFD_REG_TXERRORCNT 0x038
+#define RKCANFD_REG_TXERRORCNT_TX_ERR_CNT GENMASK(8, 0)
+
+#define RKCANFD_REG_IDCODE 0x03c
+#define RKCANFD_REG_IDCODE_STANDARD_FRAME_ID GENMASK(10, 0)
+#define RKCANFD_REG_IDCODE_EXTENDED_FRAME_ID GENMASK(28, 0)
+
+#define RKCANFD_REG_IDMASK 0x040
+
+#define RKCANFD_REG_TXFRAMEINFO 0x050
+#define RKCANFD_REG_FRAMEINFO_FRAME_FORMAT BIT(7)
+#define RKCANFD_REG_FRAMEINFO_RTR BIT(6)
+#define RKCANFD_REG_FRAMEINFO_DATA_LENGTH GENMASK(3, 0)
+
+#define RKCANFD_REG_TXID 0x054
+#define RKCANFD_REG_TXID_TX_ID GENMASK(28, 0)
+
+#define RKCANFD_REG_TXDATA0 0x058
+#define RKCANFD_REG_TXDATA1 0x05C
+#define RKCANFD_REG_RXFRAMEINFO 0x060
+#define RKCANFD_REG_RXID 0x064
+#define RKCANFD_REG_RXDATA0 0x068
+#define RKCANFD_REG_RXDATA1 0x06c
+
+#define RKCANFD_REG_RTL_VERSION 0x070
+#define RKCANFD_REG_RTL_VERSION_MAJOR GENMASK(7, 4)
+#define RKCANFD_REG_RTL_VERSION_MINOR GENMASK(3, 0)
+
+#define RKCANFD_REG_FD_NOMINAL_BITTIMING 0x100
+#define RKCANFD_REG_FD_NOMINAL_BITTIMING_SAMPLE_MODE BIT(31)
+#define RKCANFD_REG_FD_NOMINAL_BITTIMING_SJW GENMASK(30, 24)
+#define RKCANFD_REG_FD_NOMINAL_BITTIMING_BRP GENMASK(23, 16)
+#define RKCANFD_REG_FD_NOMINAL_BITTIMING_TSEG2 GENMASK(14, 8)
+#define RKCANFD_REG_FD_NOMINAL_BITTIMING_TSEG1 GENMASK(7, 0)
+
+#define RKCANFD_REG_FD_DATA_BITTIMING 0x104
+#define RKCANFD_REG_FD_DATA_BITTIMING_SAMPLE_MODE BIT(21)
+#define RKCANFD_REG_FD_DATA_BITTIMING_SJW GENMASK(20, 17)
+#define RKCANFD_REG_FD_DATA_BITTIMING_BRP GENMASK(16, 9)
+#define RKCANFD_REG_FD_DATA_BITTIMING_TSEG2 GENMASK(8, 5)
+#define RKCANFD_REG_FD_DATA_BITTIMING_TSEG1 GENMASK(4, 0)
+
+#define RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION 0x108
+#define RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_OFFSET GENMASK(6, 1)
+#define RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_ENABLE BIT(0)
+
+#define RKCANFD_REG_TIMESTAMP_CTRL 0x10c
+/* datasheet says 6:1, which is wrong */
+#define RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_PRESCALE GENMASK(5, 1)
+#define RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_ENABLE BIT(0)
+
+#define RKCANFD_REG_TIMESTAMP 0x110
+
+#define RKCANFD_REG_TXEVENT_FIFO_CTRL 0x114
+#define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_CNT GENMASK(8, 5)
+#define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_WATERMARK GENMASK(4, 1)
+#define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_ENABLE BIT(0)
+
+#define RKCANFD_REG_RX_FIFO_CTRL 0x118
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT GENMASK(6, 4)
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_FULL_WATERMARK GENMASK(3, 1)
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE BIT(0)
+
+#define RKCANFD_REG_AFC_CTRL 0x11c
+#define RKCANFD_REG_AFC_CTRL_UAF5 BIT(4)
+#define RKCANFD_REG_AFC_CTRL_UAF4 BIT(3)
+#define RKCANFD_REG_AFC_CTRL_UAF3 BIT(2)
+#define RKCANFD_REG_AFC_CTRL_UAF2 BIT(1)
+#define RKCANFD_REG_AFC_CTRL_UAF1 BIT(0)
+
+#define RKCANFD_REG_IDCODE0 0x120
+#define RKCANFD_REG_IDMASK0 0x124
+#define RKCANFD_REG_IDCODE1 0x128
+#define RKCANFD_REG_IDMASK1 0x12c
+#define RKCANFD_REG_IDCODE2 0x130
+#define RKCANFD_REG_IDMASK2 0x134
+#define RKCANFD_REG_IDCODE3 0x138
+#define RKCANFD_REG_IDMASK3 0x13c
+#define RKCANFD_REG_IDCODE4 0x140
+#define RKCANFD_REG_IDMASK4 0x144
+
+#define RKCANFD_REG_FD_TXFRAMEINFO 0x200
+#define RKCANFD_REG_FD_FRAMEINFO_FRAME_FORMAT BIT(7)
+#define RKCANFD_REG_FD_FRAMEINFO_RTR BIT(6)
+#define RKCANFD_REG_FD_FRAMEINFO_FDF BIT(5)
+#define RKCANFD_REG_FD_FRAMEINFO_BRS BIT(4)
+#define RKCANFD_REG_FD_FRAMEINFO_DATA_LENGTH GENMASK(3, 0)
+
+#define RKCANFD_REG_FD_TXID 0x204
+#define RKCANFD_REG_FD_ID_EFF GENMASK(28, 0)
+#define RKCANFD_REG_FD_ID_SFF GENMASK(11, 0)
+
+#define RKCANFD_REG_FD_TXDATA0 0x208
+#define RKCANFD_REG_FD_TXDATA1 0x20c
+#define RKCANFD_REG_FD_TXDATA2 0x210
+#define RKCANFD_REG_FD_TXDATA3 0x214
+#define RKCANFD_REG_FD_TXDATA4 0x218
+#define RKCANFD_REG_FD_TXDATA5 0x21c
+#define RKCANFD_REG_FD_TXDATA6 0x220
+#define RKCANFD_REG_FD_TXDATA7 0x224
+#define RKCANFD_REG_FD_TXDATA8 0x228
+#define RKCANFD_REG_FD_TXDATA9 0x22c
+#define RKCANFD_REG_FD_TXDATA10 0x230
+#define RKCANFD_REG_FD_TXDATA11 0x234
+#define RKCANFD_REG_FD_TXDATA12 0x238
+#define RKCANFD_REG_FD_TXDATA13 0x23c
+#define RKCANFD_REG_FD_TXDATA14 0x240
+#define RKCANFD_REG_FD_TXDATA15 0x244
+
+#define RKCANFD_REG_FD_RXFRAMEINFO 0x300
+#define RKCANFD_REG_FD_RXID 0x304
+#define RKCANFD_REG_FD_RXTIMESTAMP 0x308
+#define RKCANFD_REG_FD_RXDATA0 0x30c
+#define RKCANFD_REG_FD_RXDATA1 0x310
+#define RKCANFD_REG_FD_RXDATA2 0x314
+#define RKCANFD_REG_FD_RXDATA3 0x318
+#define RKCANFD_REG_FD_RXDATA4 0x31c
+#define RKCANFD_REG_FD_RXDATA5 0x320
+#define RKCANFD_REG_FD_RXDATA6 0x320
+#define RKCANFD_REG_FD_RXDATA7 0x328
+#define RKCANFD_REG_FD_RXDATA8 0x32c
+#define RKCANFD_REG_FD_RXDATA9 0x330
+#define RKCANFD_REG_FD_RXDATA10 0x334
+#define RKCANFD_REG_FD_RXDATA11 0x338
+#define RKCANFD_REG_FD_RXDATA12 0x33c
+#define RKCANFD_REG_FD_RXDATA13 0x340
+#define RKCANFD_REG_FD_RXDATA14 0x344
+#define RKCANFD_REG_FD_RXDATA15 0x348
+
+#define RKCANFD_REG_RX_FIFO_RDATA 0x400
+#define RKCANFD_REG_TXE_FIFO_RDATA 0x500
+
+#define DEVICE_NAME "rockchip_canfd"
+#define RKCANFD_NAPI_WEIGHT 32
+#define RKCANFD_TXFIFO_DEPTH 1
+#define RKCANFD_TX_STOP_THRESHOLD 1
+#define RKCANFD_TX_START_THRESHOLD 1
+
+#define RKCANFD_TIMESTAMP_WORK_MAX_DELAY_SEC 60
+#define RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN (300 * MEGA)
+
+enum rkcanfd_model {
+	RKCANFD_MODEL_RK3568V2 = 0x35682,
+};
+
+struct rkcanfd_devtype_data {
+	enum rkcanfd_model model;
+};
+
+struct rkcanfd_fifo_header {
+	u32 frameinfo;
+	u32 id;
+	u32 ts;
+};
+
+struct rkcanfd_priv {
+	struct can_priv can;
+	struct can_rx_offload offload;
+	struct net_device *ndev;
+
+	void __iomem *regs;
+	unsigned int tx_head;
+	unsigned int tx_tail;
+
+	u32 reg_mode_default;
+	u32 reg_int_mask_default;
+	struct rkcanfd_devtype_data devtype_data;
+
+	struct reset_control *reset;
+	struct clk_bulk_data *clks;
+	int clks_num;
+};
+
+static inline u32
+rkcanfd_read(const struct rkcanfd_priv *priv, u32 reg)
+{
+	return readl(priv->regs + reg);
+}
+
+static inline void
+rkcanfd_read_rep(const struct rkcanfd_priv *priv, u32 reg,
+		 void *buf, unsigned int len)
+{
+	readsl(priv->regs + reg, buf, len / sizeof(u32));
+}
+
+static inline void
+rkcanfd_write(const struct rkcanfd_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->regs + reg);
+}
+
+static inline u32
+rkcanfd_get_timestamp(const struct rkcanfd_priv *priv)
+{
+	return rkcanfd_read(priv, RKCANFD_REG_TIMESTAMP);
+}
+
+int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
+
+void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
+
+int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+
+#endif

-- 
2.45.2



