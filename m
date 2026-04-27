Return-Path: <linux-can+bounces-7405-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAXjDiMO72l25AAAu9opvQ
	(envelope-from <linux-can+bounces-7405-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:20:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295A46E40D
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E5213002B47
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B60362130;
	Mon, 27 Apr 2026 07:19:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B5347500
	for <linux-can@vger.kernel.org>; Mon, 27 Apr 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274398; cv=none; b=P4/teqc6g+YMsOxEl+NK6FysYsioDokxoNrGTOpB9QeA5PWZonCD9EYu864xf5mK9ApcUrYepNNzIsAjV4nYA4le3QJhPmt/P7wta+6vBhTgX/XzD3PUEoch8ja2/Gc9kDh7LKXyOXA2bMUAPzzQ7+I3jOeGhFb/q/E/5YwvPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274398; c=relaxed/simple;
	bh=2Tw11ihDxJEWbn7SAVFYL6g8zX7psIPiVNwQdESDMhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIo+7XC0LbGgqo49DRCsaw9RzfBTyY/jeh6cbGDBX6EeqUpVUZXix19fe75w5RSL7TFoTBdYJ2dy2fQYvCAI0eumJUucL83OUyGN4aFXL2Mrv+gXJ/haQzW/AJ60tUH8DiAH72I7jDqTEB2qHyCTJg80EY8Ygfi15ej5g3sIUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8AxFem0De9pckMEAA--.8542S3;
	Mon, 27 Apr 2026 15:18:12 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJCxWeCvDe9p0pJ1AA--.27085S3;
	Mon, 27 Apr 2026 15:18:09 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bingxiong Li <libingxiong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-can@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 1/2] can: Add Loongson CAN-FD controller support
Date: Mon, 27 Apr 2026 15:17:59 +0800
Message-ID: <d7b19f6c1e634ffe4454809e73fb03058e7a1a9d.1777273055.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1777273055.git.zhoubinbin@loongson.cn>
References: <cover.1777273055.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeCvDe9p0pJ1AA--.27085S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGnu+tAB-gAAsQ
X-Coremail-Antispam: 1Uk129KBj9fXoWDGFWrJr4xGF4DAFykWr1UXFc_yoW7uF1rCo
	WUWFZIgw4ruw1xC34DKw43Xr42vr1DAw1qyrWaya48K343ZF1DGrZ8K3yfZr15JayjgF4f
	ur95XFs3G3ySvrs3l-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==
X-Rspamd-Queue-Id: 0295A46E40D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7405-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add driver for the CAN-FD controller integrated into Loongson CPUs. The
controller supports:

- Classic CAN and CAN FD (ISO/non-ISO)
- Data rates up to 5 Mbps (nominal) and 10 Mbps (data)
- 8 independent TX buffers
- Hardware TX retransmission limit and one-shot mode
- Error counters, bus error reporting, arbitration lost capture
- NAPI-based RX path
- Loopback and listen-only modes

The driver is implemented as a standard Linux CAN network driver using
the CAN framework APIs.

Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                                   |    7 +
 drivers/net/can/Kconfig                       |    1 +
 drivers/net/can/Makefile                      |    1 +
 drivers/net/can/loongson_canfd/Kconfig        |   16 +
 drivers/net/can/loongson_canfd/Makefile       |    6 +
 .../net/can/loongson_canfd/loongson_canfd.c   | 1159 +++++++++++++++++
 .../loongson_canfd/loongson_canfd_kframe.h    |  142 ++
 .../can/loongson_canfd/loongson_canfd_kregs.h |  315 +++++
 8 files changed, 1647 insertions(+)
 create mode 100644 drivers/net/can/loongson_canfd/Kconfig
 create mode 100644 drivers/net/can/loongson_canfd/Makefile
 create mode 100644 drivers/net/can/loongson_canfd/loongson_canfd.c
 create mode 100644 drivers/net/can/loongson_canfd/loongson_canfd_kframe.h
 create mode 100644 drivers/net/can/loongson_canfd/loongson_canfd_kregs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..5534db894cdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14935,6 +14935,13 @@ F:	arch/loongarch/
 F:	drivers/*/*loongarch*
 F:	drivers/cpufreq/loongson3_cpufreq.c
 
+LOONGSON CAN FD DRIVER
+M:	Bingxiong Li <libingxiong@loongson.cn>
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/loongson_canfd/
+
 LOONGSON GPIO DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e15e320db476..1306d2d80197 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -242,6 +242,7 @@ source "drivers/net/can/ifi_canfd/Kconfig"
 source "drivers/net/can/m_can/Kconfig"
 source "drivers/net/can/mscan/Kconfig"
 source "drivers/net/can/peak_canfd/Kconfig"
+source "drivers/net/can/loongson_canfd/Kconfig"
 source "drivers/net/can/rcar/Kconfig"
 source "drivers/net/can/rockchip/Kconfig"
 source "drivers/net/can/sja1000/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index d7bc10a6b8ea..a39e26727060 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd/
 obj-$(CONFIG_CAN_MSCAN)		+= mscan/
 obj-$(CONFIG_CAN_M_CAN)		+= m_can/
 obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
+obj-$(CONFIG_CAN_LOONGSON_CANFD)	+= loongson_canfd/
 obj-$(CONFIG_CAN_SJA1000)	+= sja1000/
 obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
diff --git a/drivers/net/can/loongson_canfd/Kconfig b/drivers/net/can/loongson_canfd/Kconfig
new file mode 100644
index 000000000000..5a2540bb5410
--- /dev/null
+++ b/drivers/net/can/loongson_canfd/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Loongson canfd drivers
+#
+#
+config CAN_LOONGSON_CANFD
+	tristate "Loongson CAN-FD driver"
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	help
+	  This is a canfd driver switch for the Loongson platform,
+	  integrated with the Loongson-2K series.
+
+          You can choose yes or no here.For detailed information about
+          the user manual, please log in to the Loongson official
+          website.(https://loongson.cn/)
diff --git a/drivers/net/can/loongson_canfd/Makefile b/drivers/net/can/loongson_canfd/Makefile
new file mode 100644
index 000000000000..38d1f91bd0b8
--- /dev/null
+++ b/drivers/net/can/loongson_canfd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#  Makefile for the Loongson CAN-FD controller drivers.
+#
+
+obj-$(CONFIG_CAN_LOONGSON_CANFD) += loongson_canfd.o
diff --git a/drivers/net/can/loongson_canfd/loongson_canfd.c b/drivers/net/can/loongson_canfd/loongson_canfd.c
new file mode 100644
index 000000000000..20ac95dc528d
--- /dev/null
+++ b/drivers/net/can/loongson_canfd/loongson_canfd.c
@@ -0,0 +1,1159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * LOONGSON CANFD controller
+ *
+ * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "loongson_canfd_kframe.h"
+#include "loongson_canfd_kregs.h"
+
+#define DEV_NAME			"loongson_canfd"
+#define LOONGSON_CANFD_TXBUF_NUM	8
+#define LOONGSON_CANFD_ID		0xBABE
+
+struct loongson_canfd_priv {
+	struct can_priv		can;		/* must be first member! */
+	struct napi_struct	napi;
+	struct regmap		*regmap;
+	struct resource		*res;
+	spinlock_t		tx_lock;	/* protect the sending queue */
+};
+
+enum loongson_canfd_tx_bs {
+	TX_BS_IDLE	= 0x0,
+	TX_BS_VALID	= 0x1,
+	TX_BS_FAIL	= 0x2,
+	TX_BS_CANCEL	= 0x3
+};
+
+enum loongson_canfd_txtb_command {
+	TXT_CMD_SET_ADD		= 0x01,
+	TXT_CMD_SET_CANCEL	= 0x02
+};
+
+static const struct can_bittiming_const loongson_canfd_bit_timing_max = {
+	.name		= DEV_NAME,
+	.tseg1_min	= 2,
+	.tseg1_max	= 190,
+	.tseg2_min	= 2,
+	.tseg2_max	= 63,
+	.sjw_max	= 31,
+	.brp_min	= 1,
+	.brp_max	= 15,
+	.brp_inc	= 1,
+};
+
+static const struct can_bittiming_const loongson_canfd_bit_timing_data_max = {
+	.name		= DEV_NAME,
+	.tseg1_min	= 2,
+	.tseg1_max	= 190,
+	.tseg2_min	= 2,
+	.tseg2_max	= 63,
+	.sjw_max	= 31,
+	.brp_min	= 1,
+	.brp_max	= 255,
+	.brp_inc	= 1,
+};
+
+static bool loongson_canfd_enabled(struct loongson_canfd_priv *priv)
+{
+	u32 conf;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_CONF, &conf);
+
+	return !!FIELD_GET(REG_CONF_ENA, conf);
+}
+
+static bool loongson_canfd_txtnf(struct loongson_canfd_priv *priv)
+{
+	u32 sts;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &sts);
+
+	return FIELD_GET(REG_TX_STAT_BRP, sts) != 0xff;
+}
+
+static inline enum loongson_canfd_tx_bs
+loongson_canfd_get_bs(struct loongson_canfd_priv *priv, u8 bs_id)
+{
+	u32 sts, bs;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &sts);
+	bs = FIELD_GET(REG_TX_STAT_BS, sts);
+
+	return FIELD_GET(GENMASK(1, 0), (bs >> (bs_id * 2)));
+}
+
+static unsigned int loongson_canfd_get_tx_id(struct loongson_canfd_priv *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < LOONGSON_CANFD_TXBUF_NUM; i++)
+		if (loongson_canfd_get_bs(priv, i))
+			break;
+
+	return i;
+}
+
+static bool loongson_canfd_txbuf_writable(struct loongson_canfd_priv *priv, u8 buf_id)
+{
+	enum loongson_canfd_tx_bs bs;
+	u32 sts;
+
+	bs = loongson_canfd_get_bs(priv, buf_id);
+	if (bs)
+		return false;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &sts);
+	if (FIELD_GET(BIT(0), sts >> buf_id))
+		return false;
+
+	return true;
+}
+
+static int loongson_canfd_reset(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+
+	regmap_write(priv->regmap, LOONGSON_CANFD_MODE, REG_MODE_RST);
+	regmap_write(priv->regmap, LOONGSON_CANFD_MODE, REG_MODE_RXBAM | REG_MODE_BUFM);
+
+	return 0;
+}
+
+static int loongson_canfd_set_btr(struct net_device *ndev, struct can_bittiming *bt, bool nominal)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	u32 phase_seg1 = bt->phase_seg1;
+	u32 prop_seg = bt->prop_seg;
+	int max_ph1_len = 31;
+	u32 btr = 0;
+
+	if (loongson_canfd_enabled(priv)) {
+		netdev_err(ndev, "BUG! Cannot set bittiming - CAN is enabled\n");
+		return -EPERM;
+	}
+
+	if (nominal)
+		max_ph1_len = 63;
+
+	/*
+	 * The timing calculation functions have only constraints on tseg1,
+	 * which is prop_seg + phase1_seg combined.
+	 * tseg1 is then split in half and stored into prog_seg and phase_seg1.
+	 * In Loongson CAN-FD, PROP is 6/7 bits wide but PH1 only 6/5, so we must
+	 * re-distribute the values here.
+	 */
+	if (phase_seg1 > max_ph1_len) {
+		prop_seg += phase_seg1 - max_ph1_len;
+		phase_seg1 = max_ph1_len;
+		bt->prop_seg = prop_seg;
+		bt->phase_seg1 = phase_seg1;
+	}
+
+	if (nominal) {
+		btr = FIELD_PREP(REG_BTR_PROP, prop_seg) |
+		      FIELD_PREP(REG_BTR_PH1, phase_seg1) |
+		      FIELD_PREP(REG_BTR_PH2, bt->phase_seg2) |
+		      FIELD_PREP(REG_BTR_BRP, bt->brp) |
+		      FIELD_PREP(REG_BTR_SJW, bt->sjw);
+
+		regmap_write(priv->regmap, LOONGSON_CANFD_BTR_NORM, btr);
+	} else {
+		btr = FIELD_PREP(REG_BTR_FD_PROP, prop_seg) |
+		      FIELD_PREP(REG_BTR_FD_PH1, phase_seg1) |
+		      FIELD_PREP(REG_BTR_FD_PH2, bt->phase_seg2) |
+		      FIELD_PREP(REG_BTR_FD_BRP, bt->brp) |
+		      FIELD_PREP(REG_BTR_FD_SJW, bt->sjw);
+
+		regmap_write(priv->regmap, LOONGSON_CANFD_BTR_FD, btr);
+	}
+
+	return 0;
+}
+
+static int loongson_canfd_set_bittiming(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct can_bittiming *bt = &priv->can.bittiming;
+
+	/* Note that bt may be modified here */
+	return loongson_canfd_set_btr(ndev, bt, true);
+}
+
+static int loongson_canfd_set_data_bittiming(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
+
+	/* Note that dbt may be modified here */
+	return loongson_canfd_set_btr(ndev, dbt, false);
+}
+
+static int loongson_canfd_set_secondary_sample_point(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
+	int ssp_offset = 0;
+	u32 ssp_cfg = 0; /* No SSP by default */
+
+	if (loongson_canfd_enabled(priv)) {
+		netdev_err(ndev, "BUG! Cannot set SSP - CAN is enabled\n");
+		return -EPERM;
+	}
+
+	/* Use SSP for bit-rates above 1 Mbits/s */
+	if (dbt->bitrate > 1000000) {
+		/* Calculate SSP in minimal time quanta */
+		ssp_offset = (priv->can.clock.freq / 1000) * dbt->sample_point / dbt->bitrate;
+		if (ssp_offset > 127) {
+			netdev_warn(ndev, "SSP offset saturated to 127\n");
+			ssp_offset = 127;
+		}
+
+		ssp_cfg = FIELD_PREP(REG_SSP_CFG_OFF, ssp_offset) |
+			  FIELD_PREP(REG_SSP_CFG_SRC, 0x0);
+	} else {
+		ssp_cfg |= FIELD_PREP(REG_SSP_CFG_SRC, 0x1);
+	}
+
+	regmap_write(priv->regmap, LOONGSON_CANFD_SSP_CFG, ssp_cfg);
+
+	return 0;
+}
+
+static void loongson_canfd_set_mode(struct loongson_canfd_priv *priv,
+				    const struct can_ctrlmode *ctrlmode)
+{
+	u32 mode, conf;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_MODE, &mode);
+
+	mode = (ctrlmode->flags & CAN_CTRLMODE_LISTENONLY) ?
+	       (mode | REG_MODE_BMM) : (mode & ~REG_MODE_BMM);
+
+	mode = (ctrlmode->flags & CAN_CTRLMODE_FD) ?
+	       (mode | REG_MODE_FDE) : (mode & ~REG_MODE_FDE);
+
+	mode = (ctrlmode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
+	       (mode | REG_MODE_ACF) : (mode & ~REG_MODE_ACF);
+
+	/*
+	 * Some bits fixed:
+	 * TSTM - Off, User shall not be able to change REC/TEC by hand
+	 * during operation
+	 */
+	mode &= ~REG_MODE_TSTM;
+	regmap_write(priv->regmap, LOONGSON_CANFD_MODE, mode);
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_CONF, &conf);
+
+	conf = (ctrlmode->flags & CAN_CTRLMODE_LOOPBACK) ?
+	       (conf | REG_CONF_ILBP) : (conf & ~REG_CONF_ILBP);
+
+	conf = (ctrlmode->flags & CAN_CTRLMODE_FD_NON_ISO) ?
+	       (conf | REG_CONF_NISOFD) : (conf & ~REG_CONF_NISOFD);
+
+	/* One shot mode supported indirectly via Retransmit limit */
+	conf &= ~FIELD_PREP(REG_CONF_RTRTH, 0xF);
+	conf = (ctrlmode->flags & CAN_CTRLMODE_ONE_SHOT) ?
+	       (conf | REG_CONF_RTRLE) :
+	       (conf | REG_CONF_RTRLE | FIELD_PREP(REG_CONF_RTRTH, 0xF));
+
+	regmap_write(priv->regmap, LOONGSON_CANFD_CONF, conf);
+}
+
+static int loongson_canfd_chip_start(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct can_ctrlmode mode;
+	u16 int_ena, int_msk;
+	int ret;
+
+	/* Configure bit-rates and ssp */
+	ret = loongson_canfd_set_bittiming(ndev);
+	if (ret < 0)
+		return ret;
+
+	ret = loongson_canfd_set_data_bittiming(ndev);
+	if (ret < 0)
+		return ret;
+
+	ret = loongson_canfd_set_secondary_sample_point(ndev);
+	if (ret < 0)
+		return ret;
+
+	/* Configure modes */
+	mode.flags = priv->can.ctrlmode;
+	mode.mask = 0xFFFFFFFF;
+	loongson_canfd_set_mode(priv, &mode);
+
+	/* Bus error reporting */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		int_ena |= REG_INT_STAT_ALI | REG_INT_STAT_BEI;
+
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_RBNEI;
+	int_msk = ~int_ena; /* Mask all disabled interrupts */
+
+	/* It's after reset, so there is no need to clear anything */
+	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, int_msk);
+	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, int_ena);
+
+	/* Controller enters ERROR_ACTIVE on initial FCSI */
+	priv->can.state = CAN_STATE_STOPPED;
+
+	/* Enable the controller */
+	regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA, REG_CONF_ENA);
+
+	return 0;
+}
+
+static int loongson_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		ret = loongson_canfd_reset(ndev);
+		if (ret < 0)
+			return ret;
+
+		ret = loongson_canfd_chip_start(ndev);
+		if (ret < 0) {
+			netdev_err(ndev, "loongson_canfd_chip_start failed!\n");
+			return ret;
+		}
+
+		netif_wake_queue(ndev);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static bool loongson_canfd_insert_frame(struct loongson_canfd_priv *priv,
+					const struct canfd_frame *cf, u8 buf, bool isfdf)
+{
+	u32 meta0, meta1;
+
+	if (buf >= LOONGSON_CANFD_TXBUF_NUM)
+		return false;
+
+	if (!loongson_canfd_txbuf_writable(priv, buf))
+		return false;
+
+	/* Prepare identifier */
+	if (cf->can_id & CAN_EFF_FLAG) {
+		meta0 = cf->can_id & CAN_EFF_MASK;
+		meta0 |= REG_FRAME_FORMAT_W_XDT;
+	} else {
+		meta0 = FIELD_PREP(REG_IDENTIFIER_W_IDENTIFIER_BASE, cf->can_id & CAN_SFF_MASK);
+	}
+
+	/* Prepare Frame format */
+	if (cf->can_id & CAN_RTR_FLAG)
+		meta0 |= REG_FRAME_FORMAT_W_RTR;
+
+	if (isfdf) {
+		meta1 = REG_FRAME_FORMAT_W_FDF;
+
+		if (cf->flags & CANFD_BRS)
+			meta1 |= REG_FRAME_FORMAT_W_BRS;
+	}
+
+	meta1 |= FIELD_PREP(REG_FRAME_FORMAT_W_DLC, can_fd_len2dlc(cf->len));
+
+	/* TXT buffer select */
+	regmap_write(priv->regmap, LOONGSON_CANFD_TX_SEL, buf);
+
+	/* Write ID, Frame format */
+	regmap_write(priv->regmap, LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_META0, meta0);
+	regmap_write(priv->regmap, LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_META1, meta1);
+
+	/* Write Data payload */
+	if (!(cf->can_id & CAN_RTR_FLAG)) {
+		for (unsigned int i = 0; i < cf->len; i += 4) {
+			regmap_write(priv->regmap,
+				     LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_DATA_1_4_W + i,
+				     le32_to_cpu(*(__le32 *)(cf->data + i)));
+		}
+	}
+
+	return true;
+}
+
+static void loongson_canfd_give_txtb_cmd(struct loongson_canfd_priv *priv,
+					 enum loongson_canfd_txtb_command cmd, u8 buf)
+{
+	u32 tx_cmd = (((cmd >> 1) << 8) | (cmd % 2)) << buf;
+
+	regmap_write(priv->regmap, LOONGSON_CANFD_TX_CMD, tx_cmd);
+}
+
+static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	u32 txtb_id, tx_stat;
+	unsigned long flags;
+	u16 tx_bs;
+	u8 tx_brp;
+	bool ok;
+
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
+	if (unlikely(!loongson_canfd_txtnf(priv))) {
+		netif_stop_queue(ndev);
+		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &tx_stat);
+	tx_brp = FIELD_GET(REG_TX_STAT_BRP, tx_stat);
+	tx_bs = FIELD_GET(REG_TX_STAT_BS, tx_stat);
+
+	for (unsigned int i = 0; i < LOONGSON_CANFD_TXBUF_NUM; i++) {
+		if ((((tx_brp >> i) & 0x1) == 0) &&
+		    ((tx_bs >> (i * 2) & 0x3) == 0)) {
+			txtb_id = i;
+			break;
+		}
+	}
+
+	ok = loongson_canfd_insert_frame(priv, cf, txtb_id, can_is_canfd_skb(skb));
+	if (!ok) {
+		netdev_err(ndev, "BUG! TXNF set but cannot insert frame into TXTB! HW Bug?");
+		kfree_skb(skb);
+		ndev->stats.tx_dropped++;
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+		return NETDEV_TX_OK;
+	}
+
+	can_put_echo_skb(skb, ndev, txtb_id, 0);
+
+	if (!(cf->can_id & CAN_RTR_FLAG))
+		stats->tx_bytes += cf->len;
+
+	loongson_canfd_give_txtb_cmd(priv, TXT_CMD_SET_ADD, txtb_id);
+
+	/* Check if all TX buffers are full */
+	if (!loongson_canfd_txtnf(priv))
+		netif_stop_queue(ndev);
+
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
+	return NETDEV_TX_OK;
+}
+
+static void loongson_canfd_read_rx_frame(struct loongson_canfd_priv *priv, struct canfd_frame *cf,
+					 u32 meta0, u32 meta1)
+{
+	u32 data, i, wc, len;
+
+	/* Extended Identifier Type */
+	if (FIELD_GET(REG_FRAME_FORMAT_W_XDT, meta0))
+		cf->can_id = (meta0 & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	else
+		cf->can_id = FIELD_GET(REG_IDENTIFIER_W_IDENTIFIER_BASE, meta0) & CAN_SFF_MASK;
+
+	/* BRS, ESI, RTR Flags */
+	cf->flags = 0;
+
+	if (FIELD_GET(REG_FRAME_FORMAT_W_FDF, meta1)) {
+		if (FIELD_GET(REG_FRAME_FORMAT_W_BRS, meta1))
+			cf->flags |= CANFD_BRS;
+
+		if (FIELD_GET(REG_FRAME_FORMAT_W_ESI_RSV, meta0))
+			cf->flags |= CANFD_ESI;
+	} else if (FIELD_GET(REG_FRAME_FORMAT_W_RTR, meta0)) {
+		cf->can_id |= CAN_RTR_FLAG;
+	}
+
+	/* Timesamp */
+	cf->__res0 = meta1;
+	cf->__res1 = meta1 >> 8;
+
+	wc = FIELD_GET(REG_FRAME_FORMAT_W_RWCNT, meta1) - 2;
+
+	/* Data Length Code */
+	if (FIELD_GET(REG_FRAME_FORMAT_W_DLC, meta1) <= 8) {
+		len = FIELD_GET(REG_FRAME_FORMAT_W_DLC, meta1);
+	} else {
+		if (FIELD_GET(REG_FRAME_FORMAT_W_FDF, meta1))
+			len = wc << 2;
+		else
+			len = 8;
+	}
+
+	cf->len = len;
+	if (unlikely(len > wc * 4))
+		len = wc * 4;
+
+	/* Data */
+	for (i = 0; i < len; i += 4) {
+		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		*(__le32 *)(cf->data + i) = cpu_to_le32(data);
+	}
+
+	while (unlikely(i < wc * 4)) {
+		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		i += 4;
+	}
+}
+
+static int loongson_canfd_rx(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	struct canfd_frame *cf;
+	struct sk_buff *skb;
+	u32 meta0, meta1;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
+
+	/* Number of characters received */
+	if (!FIELD_GET(REG_FRAME_FORMAT_W_RWCNT, meta1))
+		return -EAGAIN;
+
+	/* Flexible Data-rate Format */
+	if (FIELD_GET(REG_FRAME_FORMAT_W_FDF, meta1))
+		skb = alloc_canfd_skb(ndev, &cf);
+	else
+		skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
+
+	loongson_canfd_read_rx_frame(priv, cf, meta0, meta1);
+
+	stats->rx_bytes += cf->len;
+	stats->rx_packets++;
+	netif_receive_skb(skb);
+
+	return 1;
+}
+
+static enum can_state loongson_canfd_read_fault_state(struct loongson_canfd_priv *priv)
+{
+	u32 fs, erl, rec_tec, ewl;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_ERL, &erl);
+	regmap_read(priv->regmap, LOONGSON_CANFD_FSTAT, &fs);
+	regmap_read(priv->regmap, LOONGSON_CANFD_ERC, &rec_tec);
+
+	ewl = FIELD_GET(REG_ERL_EW, erl);
+
+	if (FIELD_GET(REG_FSTAT_ERA, fs)) {
+		if (ewl > FIELD_GET(REG_ERC_REC, rec_tec) &&
+		    ewl > FIELD_GET(REG_ERC_REC, rec_tec))
+			return CAN_STATE_ERROR_ACTIVE;
+		else
+			return CAN_STATE_ERROR_WARNING;
+	} else if (FIELD_GET(REG_FSTAT_ERP, fs)) {
+		return CAN_STATE_ERROR_PASSIVE;
+	} else if (FIELD_GET(REG_FSTAT_BOF, fs)) {
+		return CAN_STATE_BUS_OFF;
+	}
+
+	WARN(true, "Invalid error state");
+	return CAN_STATE_ERROR_PASSIVE;
+}
+
+static void loongson_canfd_get_bec(struct loongson_canfd_priv *priv, struct can_berr_counter *bec)
+{
+	u32 erc;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_ERC, &erc);
+	bec->rxerr = FIELD_GET(REG_ERC_REC, erc);
+	bec->txerr = FIELD_GET(REG_ERC_REC, erc);
+}
+
+static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 isr)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	struct can_berr_counter bec;
+	enum can_state state;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u32 err_capt, alc;
+	int dologerr = net_ratelimit();
+
+	loongson_canfd_get_bec(priv, &bec);
+
+	state = loongson_canfd_read_fault_state(priv);
+	regmap_read(priv->regmap, LOONGSON_CANFD_ERR_CAPT, &err_capt);
+	regmap_read(priv->regmap, LOONGSON_CANFD_ALC, &alc);
+
+	if (dologerr)
+		netdev_info(ndev, "%s: ISR 0x%08x, rxerr %d, txerr %d, error type %lu, pos %lu, ALC id_field %lu, bit %lu\n",
+			    __func__, isr, bec.rxerr, bec.txerr,
+			    FIELD_GET(REG_ERR_CAPT_TYPE, err_capt),
+			    FIELD_GET(REG_ERR_CAPT_POS, err_capt),
+			    FIELD_GET(REG_ALC_ID_FIELD, alc),
+			    FIELD_GET(REG_ALC_BIT_POS, alc));
+
+	skb = alloc_can_err_skb(ndev, &cf);
+
+	/*
+	 * EWLI: error warning limit condition met
+	 * FCSI: fault confinement state changed
+	 * ALI:  arbitration lost (just informative)
+	 * BEI:  bus error interrupt
+	 */
+	if (FIELD_GET(REG_INT_STAT_FCSI, isr) || FIELD_GET(REG_INT_STAT_EWLI, isr)) {
+		netdev_info(ndev, "state changes from %s to %s\n",
+			    can_get_state_str(priv->can.state), can_get_state_str(state));
+
+		if (priv->can.state == state)
+			netdev_warn(ndev, "cur and pre state is the same!(miss intr?)\n");
+
+		isr = REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
+		priv->can.state = state;
+		switch (state) {
+		case CAN_STATE_BUS_OFF:
+			priv->can.can_stats.bus_off++;
+			if (priv->can.restart_ms)
+				regmap_write(priv->regmap, LOONGSON_CANFD_CMD,
+					     REG_CMD_ERCRST);
+
+			can_bus_off(ndev);
+			if (skb)
+				cf->can_id |= CAN_ERR_BUSOFF;
+			break;
+		case CAN_STATE_ERROR_PASSIVE:
+			priv->can.can_stats.error_passive++;
+			if (skb) {
+				cf->can_id |= CAN_ERR_CRTL;
+				cf->data[1] = (bec.rxerr > 127) ?
+					      CAN_ERR_CRTL_RX_PASSIVE : CAN_ERR_CRTL_TX_PASSIVE;
+				cf->data[6] = bec.txerr;
+				cf->data[7] = bec.rxerr;
+			}
+			break;
+		case CAN_STATE_ERROR_WARNING:
+			priv->can.can_stats.error_warning++;
+			if (skb) {
+				cf->can_id |= CAN_ERR_CRTL;
+				cf->data[1] |= (bec.txerr > bec.rxerr) ?
+					       CAN_ERR_CRTL_TX_WARNING : CAN_ERR_CRTL_RX_WARNING;
+				cf->data[6] = bec.txerr;
+				cf->data[7] = bec.rxerr;
+			}
+			break;
+		case CAN_STATE_ERROR_ACTIVE:
+			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+			cf->data[6] = bec.txerr;
+			cf->data[7] = bec.rxerr;
+			break;
+		default:
+			netdev_warn(ndev, "error state (%d:%s)!\n", state,
+				    can_get_state_str(state));
+			break;
+		}
+	}
+
+	/* Check for Arbitration Lost interrupt */
+	if (FIELD_GET(REG_INT_STAT_ALI, isr)) {
+		isr = REG_INT_STAT_ALI;
+
+		if (dologerr)
+			netdev_info(ndev, "arbitration lost\n");
+
+		priv->can.can_stats.arbitration_lost++;
+
+		if (skb) {
+			cf->can_id |= CAN_ERR_LOSTARB;
+			cf->data[0] = CAN_ERR_LOSTARB_UNSPEC;
+		}
+	}
+
+	/* Check for Bus Error interrupt */
+	if (FIELD_GET(REG_INT_STAT_BEI, isr)) {
+		isr = REG_INT_STAT_BEI;
+		netdev_info(ndev, "bus error\n");
+		priv->can.can_stats.bus_error++;
+		stats->rx_errors++;
+
+		if (skb) {
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+			cf->data[2] = CAN_ERR_PROT_UNSPEC;
+			cf->data[3] = CAN_ERR_PROT_LOC_UNSPEC;
+		}
+	}
+
+	if (skb) {
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		netif_rx(skb);
+	}
+
+	regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, isr);
+	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, isr << 16);
+}
+
+static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
+{
+	struct net_device *ndev = napi->dev;
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	int work_done = 0, res = 1;
+	u32 sts, rx_frc, rx_sts;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
+	rx_frc = FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
+
+	while (rx_frc && work_done < quota && res > 0) {
+		res = loongson_canfd_rx(ndev);
+		work_done++;
+		regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
+		rx_frc = FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
+	}
+
+	/* Check for RX FIFO Overflow */
+	regmap_read(priv->regmap, LOONGSON_CANFD_STAT, &sts);
+	if (FIELD_GET(REG_STAT_DOR, sts)) {
+		struct net_device_stats *stats = &ndev->stats;
+		struct can_frame *cf;
+		struct sk_buff *skb;
+
+		netdev_info(ndev, "rx_poll: rx fifo overflow\n");
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
+		skb = alloc_can_err_skb(ndev, &cf);
+		if (skb) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+			stats->rx_packets++;
+			stats->rx_bytes += cf->can_dlc;
+			netif_rx(skb);
+		}
+
+		/* Clear Data Overrun */
+		regmap_write(priv->regmap, LOONGSON_CANFD_CMD, REG_CMD_CDO);
+	}
+
+	if (!rx_frc && res != 0) {
+		if (napi_complete_done(napi, work_done)) {
+			/*
+			 * Clear and enable RBNEI. It is level-triggered, so
+			 * there is no race condition.
+			 */
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
+				     REG_INT_STAT_RBNEI);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
+				     (REG_INT_STAT_RBNEI << 16));
+		}
+	}
+
+	return work_done;
+}
+
+static void loongson_canfd_tx_interrupt(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	enum loongson_canfd_tx_bs txtb_sts;
+	bool some_buffers_processed;
+	unsigned long flags;
+	u32 txtb_id, ctr;
+
+	do {
+		spin_lock_irqsave(&priv->tx_lock, flags);
+
+		some_buffers_processed = false;
+
+		while ((txtb_id = loongson_canfd_get_tx_id(priv)) < 8) {
+			txtb_sts = loongson_canfd_get_bs(priv, txtb_id);
+
+			switch (txtb_sts) {
+			case TX_BS_VALID:
+				stats->tx_bytes += can_get_echo_skb(ndev, txtb_id, NULL);
+				stats->tx_packets++;
+				break;
+			case TX_BS_FAIL:
+				/*
+				 * This indicated that retransmit limit has been reached.
+				 * Obviously we should not echo the frame, but also not
+				 * indicate any kind of error.
+				 * If desired, it was already reported (possible multiple
+				 * times) on each arbitration lost.
+				 */
+				regmap_read(priv->regmap, LOONGSON_CANFD_TX_FR_CNT, &ctr);
+				netdev_warn(ndev, "TX_BS_FAIL txcnt=%x\n", ctr);
+				can_free_echo_skb(ndev, txtb_id, NULL);
+				stats->tx_dropped++;
+				break;
+			case TX_BS_CANCEL:
+				/*
+				 * Same as for TX_BS_CANCEL, only with different cause.
+				 * We *could* re-queue the frame, but multiqueue/abort is
+				 * not supported yet anyway.
+				 */
+				netdev_warn(ndev, "TX_BS_CANCEL\n");
+				can_free_echo_skb(ndev, txtb_id, NULL);
+				stats->tx_dropped++;
+				break;
+			case TX_BS_IDLE:
+				netdev_warn(ndev, "TX_BS_IDLE\n");
+				break;
+			}
+
+			regmap_write(priv->regmap, LOONGSON_CANFD_TX_CMD,
+				     0x1 << (txtb_id + 16));
+			some_buffers_processed = true;
+		}
+
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+
+		/*
+		 * If no buffers were processed this time, we cannot clear - that would
+		 * introduce a race condition.
+		 */
+		if (some_buffers_processed) {
+			/*
+			 * Clear the interrupt again. We do not want to receive again interrupt
+			 * for the buffer already handled. If it is the last finished one then
+			 * it would cause log of spurious interrupt.
+			 */
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_TXBHCI);
+		}
+	} while (some_buffers_processed);
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
+	/* Check if at least one TX buffer is free */
+	if (loongson_canfd_txtnf(priv))
+		netif_wake_queue(ndev);
+
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+}
+
+static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
+{
+	struct net_device *ndev = (struct net_device *)dev_id;
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	int irq_loops;
+	u32 isr;
+	u16 icr;
+
+	for (irq_loops = 0; irq_loops < 10000; irq_loops++) {
+		/* Get the interrupt sts */
+		regmap_read(priv->regmap, LOONGSON_CANFD_INT_STAT, &isr);
+		if (!isr)
+			return irq_loops ? IRQ_HANDLED : IRQ_NONE;
+
+		/* Receive Buffer Not Empty Interrupt */
+		if (FIELD_GET(REG_INT_STAT_RBNEI, isr)) {
+			/*
+			 * Mask RXBNEI the first, then clear interrupt and schedule NAPI.
+			 * Even if another IRQ fires, RBNEI will always be 0 (masked).
+			 */
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_STAT_RBNEI);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
+			napi_schedule(&priv->napi);
+		}
+
+		/* TXT Buffer HW Command Interrupt */
+		if (FIELD_GET(REG_INT_STAT_TXBHCI, isr))
+			loongson_canfd_tx_interrupt(ndev);
+
+		/* Error interrupts */
+		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
+		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
+		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
+			icr = isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_ALI);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, icr);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, icr);
+			loongson_canfd_err_interrupt(ndev, isr);
+		}
+
+		/* Ignore RI, TI, LFI, RFI, BSI */
+	}
+
+	netdev_err(ndev, "Error:isr<0x%08x>\n", isr);
+
+	if (FIELD_GET(REG_INT_STAT_TXBHCI, isr)) {
+		for (unsigned int i = 0; i < LOONGSON_CANFD_TXBUF_NUM; i++) {
+			enum loongson_canfd_tx_bs txtb_sts = loongson_canfd_get_bs(priv, i);
+
+			netdev_err(ndev, "txb[%d]txbstatus=0x%01x\n", i, txtb_sts);
+		}
+	}
+
+	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_ENA, REG_INT_ENA_CLR, REG_INT_ENA_CLR);
+	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_MASK,
+			   REG_INT_MASK_SET, REG_INT_MASK_SET);
+
+	return IRQ_HANDLED;
+}
+
+static void loongson_canfd_chip_stop(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+
+	/* Disable interrupts and disable CAN */
+	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_ENA, REG_INT_ENA_CLR, REG_INT_ENA_CLR);
+	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_MASK,
+			   REG_INT_MASK_SET, REG_INT_MASK_SET);
+	regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA, 0);
+
+	priv->can.state = CAN_STATE_STOPPED;
+}
+
+static int loongson_canfd_open(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	ret = loongson_canfd_reset(ndev);
+	if (ret < 0)
+		return ret;
+
+	/* Common open */
+	ret = open_candev(ndev);
+	if (ret) {
+		netdev_warn(ndev, "open_candev failed!\n");
+		return ret;
+	}
+
+	ret = request_irq(ndev->irq, loongson_canfd_interrupt, IRQF_SHARED, ndev->name, ndev);
+	if (ret < 0) {
+		netdev_err(ndev, "irq allocation for CAN failed\n");
+		goto err_irq;
+	}
+
+	ret = loongson_canfd_chip_start(ndev);
+	if (ret < 0) {
+		netdev_err(ndev, "loongson_canfd_chip_start failed!\n");
+		goto err_chip_start;
+	}
+
+	netdev_info(ndev, "loongson_canfd_device registered\n");
+	napi_enable(&priv->napi);
+	netif_start_queue(ndev);
+
+	return 0;
+
+err_chip_start:
+	free_irq(ndev->irq, ndev);
+err_irq:
+	close_candev(ndev);
+	return ret;
+}
+
+static int loongson_canfd_close(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+
+	netif_stop_queue(ndev);
+	napi_disable(&priv->napi);
+	loongson_canfd_chip_stop(ndev);
+	free_irq(ndev->irq, ndev);
+	close_candev(ndev);
+
+	return 0;
+}
+
+static const struct net_device_ops loongson_canfd_netdev_ops = {
+	.ndo_open       = loongson_canfd_open,
+	.ndo_stop       = loongson_canfd_close,
+	.ndo_start_xmit = loongson_canfd_start_xmit,
+};
+
+static int loongson_canfd_get_berr_counter(const struct net_device *ndev,
+					   struct can_berr_counter *bec)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+
+	loongson_canfd_get_bec(priv, bec);
+	return 0;
+}
+
+static const struct regmap_range loongson_canfd_reg_table_wr_range[] = {
+	regmap_reg_range(LOONGSON_CANFD_DEVICE_ID, LOONGSON_CANFD_CONF),
+	regmap_reg_range(LOONGSON_CANFD_CMD, LOONGSON_CANFD_CMD),
+	regmap_reg_range(LOONGSON_CANFD_INT_STAT, LOONGSON_CANFD_ERL),
+	regmap_reg_range(LOONGSON_CANFD_CTR_PRES, LOONGSON_CANFD_CTR_PRES),
+	regmap_reg_range(LOONGSON_CANFD_SSP_CFG, LOONGSON_CANFD_SSP_CFG),
+	regmap_reg_range(LOONGSON_CANFD_TS, LOONGSON_CANFD_FLT_CTRL),
+	regmap_reg_range(LOONGSON_CANFD_TX_CMD, LOONGSON_CANFD_TX_DATA_18),
+};
+
+static const struct regmap_range loongson_canfd_reg_table_rd_range[] = {
+	regmap_reg_range(LOONGSON_CANFD_DEVICE_ID, LOONGSON_CANFD_STAT),
+	regmap_reg_range(LOONGSON_CANFD_INT_STAT, LOONGSON_CANFD_BRE),
+	regmap_reg_range(LOONGSON_CANFD_ERR_CAPT, LOONGSON_CANFD_TX_STAT),
+	regmap_reg_range(LOONGSON_CANFD_TX_SEL, LOONGSON_CANFD_TX_DATA_18),
+};
+
+static const struct regmap_access_table loongson_canfd_reg_table_wr = {
+	.yes_ranges = loongson_canfd_reg_table_wr_range,
+	.n_yes_ranges = ARRAY_SIZE(loongson_canfd_reg_table_wr_range),
+};
+
+static const struct regmap_access_table loongson_canfd_reg_table_rd = {
+	.yes_ranges = loongson_canfd_reg_table_rd_range,
+	.n_yes_ranges = ARRAY_SIZE(loongson_canfd_reg_table_rd_range),
+};
+
+static bool loongson_canfd_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LOONGSON_CANFD_MODE:
+	case LOONGSON_CANFD_CONF:
+	case LOONGSON_CANFD_STAT:
+	case LOONGSON_CANFD_INT_STAT:
+	case LOONGSON_CANFD_INT_ENA:
+	case LOONGSON_CANFD_INT_MASK:
+	case LOONGSON_CANFD_ERL:
+	case LOONGSON_CANFD_FSTAT:
+	case LOONGSON_CANFD_ERC:
+	case LOONGSON_CANFD_ERR_CAPT:
+	case LOONGSON_CANFD_ALC:
+	case LOONGSON_CANFD_TX_FR_CNT:
+	case LOONGSON_CANFD_RX_STAT:
+	case LOONGSON_CANFD_RX_DATA:
+	case LOONGSON_CANFD_TX_STAT:
+	case LOONGSON_CANFD_TX_SEL:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config loongson_cangfd_regmap = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.wr_table	= &loongson_canfd_reg_table_wr,
+	.rd_table	= &loongson_canfd_reg_table_rd,
+	.volatile_reg	= loongson_canfd_volatile_reg,
+	.max_register	= LOONGSON_CANFD_TX_DATA_18,
+	.cache_type	= REGCACHE_MAPLE,
+};
+
+static int loongson_canfd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct loongson_canfd_priv *priv;
+	struct net_device *ndev;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+	u32 clk_rate;
+	int ret, irq;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &loongson_cangfd_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	device_property_read_u32(dev, "clock-frequency", &clk_rate);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	/* Create a CAN device instance */
+	ndev = alloc_candev(sizeof(*priv), LOONGSON_CANFD_TXBUF_NUM);
+	if (!ndev)
+		return -ENOMEM;
+
+	priv = netdev_priv(ndev);
+	spin_lock_init(&priv->tx_lock);
+	priv->regmap = regmap;
+	priv->res = res;
+
+	priv->can.clock.freq = clk_rate;
+	priv->can.bittiming_const = &loongson_canfd_bit_timing_max;
+	priv->can.fd.data_bittiming_const = &loongson_canfd_bit_timing_data_max;
+	priv->can.do_set_mode = loongson_canfd_do_set_mode;
+	priv->can.do_set_bittiming = loongson_canfd_set_bittiming;
+	priv->can.fd.do_set_data_bittiming = loongson_canfd_set_data_bittiming;
+	priv->can.do_get_berr_counter = loongson_canfd_get_berr_counter;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY |
+				       CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_ONE_SHOT |
+				       CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
+				       CAN_CTRLMODE_PRESUME_ACK | CAN_CTRLMODE_FD_NON_ISO;
+
+	ndev->irq = irq;
+	ndev->flags |= IFF_ECHO;	/* We support local echo */
+	platform_set_drvdata(pdev, ndev);
+	ndev->netdev_ops = &loongson_canfd_netdev_ops;
+	SET_NETDEV_DEV(ndev, dev);
+
+	ret = loongson_canfd_reset(ndev);
+	if (ret < 0)
+		goto err_candev_free;
+
+	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
+
+	ret = register_candev(ndev);
+	if (ret) {
+		dev_err(dev, "fail to register failed (err=%d)\n", ret);
+		goto err_candev_free;
+	}
+
+	return 0;
+
+err_candev_free:
+	free_candev(ndev);
+	return ret;
+}
+
+static void loongson_canfd_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+
+	netdev_dbg(ndev, "loongson_canfd_remove");
+
+	unregister_candev(ndev);
+	netif_napi_del(&priv->napi);
+	free_candev(ndev);
+}
+
+static const struct acpi_device_id loongson_canfd_acpi_match[] = {
+	{ "LOON0015" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, loongson_canfd_acpi_match);
+
+static struct platform_driver loongson_canfd_driver = {
+	.probe  = loongson_canfd_probe,
+	.remove = loongson_canfd_remove,
+	.driver = {
+		.name = DEV_NAME,
+		.acpi_match_table = loongson_canfd_acpi_match,
+	},
+};
+module_platform_driver(loongson_canfd_driver);
+
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/can/loongson_canfd/loongson_canfd_kframe.h b/drivers/net/can/loongson_canfd/loongson_canfd_kframe.h
new file mode 100644
index 000000000000..d3517a7ff4a3
--- /dev/null
+++ b/drivers/net/can/loongson_canfd/loongson_canfd_kframe.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __LOONGSON_CANFD_KFRAME_H
+#define __LOONGSON_CANFD_KFRAME_H
+
+/* CAN_Frame_format memory map */
+#define LOONGSON_CANFD_META0		0x0
+#define LOONGSON_CANFD_META1		0x4
+#define LOONGSON_CANFD_DATA_1_4_W	0x8
+#define LOONGSON_CANFD_DATA_5_8_W	0xc
+#define LOONGSON_CANFD_DATA_9_12_W	0x10
+#define LOONGSON_CANFD_DATA_13_16_W	0x14
+#define LOONGSON_CANFD_DATA_17_20_W	0x18
+#define LOONGSON_CANFD_DATA_21_24_W	0x1c
+#define LOONGSON_CANFD_DATA_25_28_W	0x20
+#define LOONGSON_CANFD_DATA_29_32_W	0x24
+#define LOONGSON_CANFD_DATA_33_36_W	0x28
+#define LOONGSON_CANFD_DATA_37_40_W	0x2c
+#define LOONGSON_CANFD_DATA_41_44_W	0x30
+#define LOONGSON_CANFD_DATA_45_48_W	0x34
+#define LOONGSON_CANFD_DATA_49_52_W	0x38
+#define LOONGSON_CANFD_DATA_53_56_W	0x3c
+#define LOONGSON_CANFD_DATA_57_60_W	0x40
+#define LOONGSON_CANFD_DATA_61_64_W	0x44
+
+/* FRAME_META0 registers */
+#define REG_IDENTIFIER_W_IDENTIFIER_EXT		GENMASK(17, 0)
+#define REG_IDENTIFIER_W_IDENTIFIER_BASE	GENMASK(28, 18)
+#define REG_FRAME_FORMAT_W_RTR			BIT(29)
+#define REG_FRAME_FORMAT_W_XDT			BIT(30)
+#define REG_FRAME_FORMAT_W_ESI_RSV		BIT(31)
+
+/*  FRAME_META1 registers */
+#define REG_META1_W_TIMESTAMP			GENMASK(15, 0)
+#define REG_FRAME_FORMAT_W_DLC			GENMASK(19, 16)
+#define REG_FRAME_FORMAT_W_BRS			BIT(20)
+#define REG_FRAME_FORMAT_W_FDF			BIT(21)
+#define REG_FRAME_FORMAT_W_RWCNT		GENMASK(28, 24)
+
+/*  DATA_1_4_W registers */
+#define REG_DATA_1_4_W_DATA_1			GENMASK(7, 0)
+#define REG_DATA_1_4_W_DATA_2			GENMASK(15, 8)
+#define REG_DATA_1_4_W_DATA_3			GENMASK(23, 16)
+#define REG_DATA_1_4_W_DATA_4			GENMASK(31, 24)
+
+/*  DATA_5_8_W registers */
+#define REG_DATA_5_8_W_DATA_5			GENMASK(7, 0)
+#define REG_DATA_5_8_W_DATA_6			GENMASK(15, 8)
+#define REG_DATA_5_8_W_DATA_7			GENMASK(23, 16)
+#define REG_DATA_5_8_W_DATA_8			GENMASK(31, 24)
+
+/*  DATA_9_12_W registers */
+#define REG_DATA_9_12_W_DATA_9			GENMASK(7, 0)
+#define REG_DATA_9_12_W_DATA_10			GENMASK(15, 8)
+#define REG_DATA_9_12_W_DATA_11			GENMASK(23, 16)
+#define REG_DATA_9_12_W_DATA_12			GENMASK(31, 24)
+
+/*  DATA_13_16_W registers */
+#define REG_DATA_13_16_W_DATA_13		GENMASK(7, 0)
+#define REG_DATA_13_16_W_DATA_14		GENMASK(15, 8)
+#define REG_DATA_13_16_W_DATA_15		GENMASK(23, 16)
+#define REG_DATA_13_16_W_DATA_16		GENMASK(31, 24)
+
+/*  DATA_17_20_W registers */
+#define REG_DATA_17_20_W_DATA_17		GENMASK(7, 0)
+#define REG_DATA_17_20_W_DATA_18		GENMASK(15, 8)
+#define REG_DATA_17_20_W_DATA_19		GENMASK(23, 16)
+#define REG_DATA_17_20_W_DATA_20		GENMASK(31, 24)
+
+/*  DATA_21_24_W registers */
+#define REG_DATA_21_24_W_DATA_21		GENMASK(7, 0)
+#define REG_DATA_21_24_W_DATA_22		GENMASK(15, 8)
+#define REG_DATA_21_24_W_DATA_23		GENMASK(23, 16)
+#define REG_DATA_21_24_W_DATA_24		GENMASK(31, 24)
+
+/*  DATA_25_28_W registers */
+#define REG_DATA_25_28_W_DATA_25		GENMASK(7, 0)
+#define REG_DATA_25_28_W_DATA_26		GENMASK(15, 8)
+#define REG_DATA_25_28_W_DATA_27		GENMASK(23, 16)
+#define REG_DATA_25_28_W_DATA_28		GENMASK(31, 24)
+
+/*  DATA_29_32_W registers */
+#define REG_DATA_29_32_W_DATA_29		GENMASK(7, 0)
+#define REG_DATA_29_32_W_DATA_30		GENMASK(15, 8)
+#define REG_DATA_29_32_W_DATA_31		GENMASK(23, 16)
+#define REG_DATA_29_32_W_DATA_32		GENMASK(31, 24)
+
+/*  DATA_33_36_W registers */
+#define REG_DATA_33_36_W_DATA_33		GENMASK(7, 0)
+#define REG_DATA_33_36_W_DATA_34		GENMASK(15, 8)
+#define REG_DATA_33_36_W_DATA_35		GENMASK(23, 16)
+#define REG_DATA_33_36_W_DATA_36		GENMASK(31, 24)
+
+/*  DATA_37_40_W registers */
+#define REG_DATA_37_40_W_DATA_37		GENMASK(7, 0)
+#define REG_DATA_37_40_W_DATA_38		GENMASK(15, 8)
+#define REG_DATA_37_40_W_DATA_39		GENMASK(23, 16)
+#define REG_DATA_37_40_W_DATA_40		GENMASK(31, 24)
+
+/*  DATA_41_44_W registers */
+#define REG_DATA_41_44_W_DATA_41		GENMASK(7, 0)
+#define REG_DATA_41_44_W_DATA_42		GENMASK(15, 8)
+#define REG_DATA_41_44_W_DATA_43		GENMASK(23, 16)
+#define REG_DATA_41_44_W_DATA_44		GENMASK(31, 24)
+
+/*  DATA_45_48_W registers */
+#define REG_DATA_45_48_W_DATA_45		GENMASK(7, 0)
+#define REG_DATA_45_48_W_DATA_46		GENMASK(15, 8)
+#define REG_DATA_45_48_W_DATA_47		GENMASK(23, 16)
+#define REG_DATA_45_48_W_DATA_48		GENMASK(31, 24)
+
+/*  DATA_49_52_W registers */
+#define REG_DATA_49_52_W_DATA_49		GENMASK(7, 0)
+#define REG_DATA_49_52_W_DATA_50		GENMASK(15, 8)
+#define REG_DATA_49_52_W_DATA_51		GENMASK(23, 16)
+#define REG_DATA_49_52_W_DATA_52		GENMASK(31, 24)
+
+/*  DATA_53_56_W registers */
+#define REG_DATA_53_56_W_DATA_53		GENMASK(7, 0)
+#define REG_DATA_53_56_W_DATA_56		GENMASK(15, 8)
+#define REG_DATA_53_56_W_DATA_55		GENMASK(23, 16)
+#define REG_DATA_53_56_W_DATA_54		GENMASK(31, 24)
+
+/*  DATA_57_60_W registers */
+#define REG_DATA_57_60_W_DATA_57		GENMASK(7, 0)
+#define REG_DATA_57_60_W_DATA_58		GENMASK(15, 8)
+#define REG_DATA_57_60_W_DATA_59		GENMASK(23, 16)
+#define REG_DATA_57_60_W_DATA_60		GENMASK(31, 24)
+
+/*  DATA_61_64_W registers */
+#define REG_DATA_61_64_W_DATA_61		GENMASK(7, 0)
+#define REG_DATA_61_64_W_DATA_62		GENMASK(15, 8)
+#define REG_DATA_61_64_W_DATA_63		GENMASK(23, 16)
+#define REG_DATA_61_64_W_DATA_64		GENMASK(31, 24)
+
+/*  FRAME_TEST_W registers */
+#define REG_FRAME_TEST_W_FSTC			BIT(0)
+#define REG_FRAME_TEST_W_FCRC			BIT(1)
+#define REG_FRAME_TEST_W_SDLC			BIT(2)
+#define REG_FRAME_TEST_W_TPRM			GENMASK(12, 8)
+
+#endif
diff --git a/drivers/net/can/loongson_canfd/loongson_canfd_kregs.h b/drivers/net/can/loongson_canfd/loongson_canfd_kregs.h
new file mode 100644
index 000000000000..5e8889e3a924
--- /dev/null
+++ b/drivers/net/can/loongson_canfd/loongson_canfd_kregs.h
@@ -0,0 +1,315 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _LOONGSON_CANFD_KREGS_H
+#define _LOONGSON_CANFD_KREGS_H
+
+#define LOONGSON_CANFD_DEVICE_ID	0x0	/* CANFD controller ID Register */
+#define LOONGSON_CANFD_MODE		0x4	/* Mode Configuration Register */
+#define LOONGSON_CANFD_CONF		0x8	/* Configure Register */
+#define LOONGSON_CANFD_STAT		0xc	/* Status Register */
+#define LOONGSON_CANFD_CMD		0x10	/* Command Register */
+#define LOONGSON_CANFD_INT_STAT		0x14	/* Interrupt Status Register */
+#define LOONGSON_CANFD_INT_ENA		0x18	/* Interrupt Enable Register */
+#define LOONGSON_CANFD_INT_MASK		0x1c	/* Interrupt Mask Register */
+#define LOONGSON_CANFD_BTR_NORM		0x20	/* Normal Rate Configuration Register */
+#define LOONGSON_CANFD_BTR_FD		0x24	/* FD Data Rate Configuration Register */
+#define LOONGSON_CANFD_ERL		0x28	/* Error Threshold Configuration Register */
+#define LOONGSON_CANFD_FSTAT		0x2c	/* Error Status Register */
+#define LOONGSON_CANFD_ERC		0x30	/* Error Count Register */
+#define LOONGSON_CANFD_BRE		0x34	/* Rate Error Count Register */
+#define LOONGSON_CANFD_CTR_PRES		0x38	/* Error Count Debug Register */
+#define LOONGSON_CANFD_ERR_CAPT		0x3c	/* Error Capture Status Register */
+#define LOONGSON_CANFD_RETX_CNT		0x40	/* Retransmission Count Register */
+#define LOONGSON_CANFD_ALC		0x44	/* Lost Arbitration Capture Register */
+#define LOONGSON_CANFD_TRV_DLY		0x48	/* Transmission Delay Measurement Register */
+#define LOONGSON_CANFD_SSP_CFG		0x4c	/* Second Sampling Point Configuration Register */
+#define LOONGSON_CANFD_RX_FR_CNT	0x50	/* Receive Message Count Register */
+#define LOONGSON_CANFD_TX_FR_CNT	0x54	/* Transmit Message Count Register */
+#define LOONGSON_CANFD_DEBUG		0x58	/* Debug Register */
+#define LOONGSON_CANFD_TS		0x5c	/* Timestamp Register */
+#define LOONGSON_CANFD_TX_FRM_TST	0x60	/* Transmit Message Debug Register */
+#define LOONGSON_CANFD_FRC_DIV		0x64	/* Fractional Divider Ratio Register */
+#define LOONGSON_CANFD_FLT_A_MASK	0x68	/* Filter A Mask Register */
+#define LOONGSON_CANFD_FLT_A_VAL	0x6c	/* Filter A value Register */
+#define LOONGSON_CANFD_FLT_B_MASK	0x70	/* Filter B Mask Register */
+#define LOONGSON_CANFD_FLT_B_VAL	0x74	/* Filter B value Register */
+#define LOONGSON_CANFD_FLT_C_MASK	0x78	/* Filter C Mask Register */
+#define LOONGSON_CANFD_FLT_C_VAL	0x7c	/* Filter C value Register */
+#define LOONGSON_CANFD_FLT_R_LOW	0x80	/* Range Filter Low Threshold Register */
+#define LOONGSON_CANFD_FLT_R_HI		0x84	/* Range Filter High Threshold Register */
+#define LOONGSON_CANFD_FLT_CTRL		0x88	/* Filter Control Register */
+#define LOONGSON_CANFD_RX_MEM_INFO	0x8c	/* Receive Buffer Information Register */
+#define LOONGSON_CANFD_RX_PRT		0x90	/* Receive Buffer Pointer Register */
+#define LOONGSON_CANFD_RX_STAT		0x94	/* Receive Buffer Status Register */
+#define LOONGSON_CANFD_RX_DATA		0x98	/* Receive Data Register */
+#define LOONGSON_CANFD_TX_STAT		0x9c	/* Transmit Buffer Status Register */
+#define LOONGSON_CANFD_TX_CMD		0xa0	/* Transmit Command Register */
+#define LOONGSON_CANFD_TX_SEL		0xa4	/* Transmit Buffer Selection Register */
+#define LOONGSON_CANFD_TX_DATA_1	0xb0
+#define LOONGSON_CANFD_TX_DATA_2	0xb4
+#define LOONGSON_CANFD_TX_DATA_3	0xb8
+#define LOONGSON_CANFD_TX_DATA_4	0xbc
+#define LOONGSON_CANFD_TX_DATA_5	0xc0
+#define LOONGSON_CANFD_TX_DATA_6	0xc4
+#define LOONGSON_CANFD_TX_DATA_7	0xc8
+#define LOONGSON_CANFD_TX_DATA_8	0xcc
+#define LOONGSON_CANFD_TX_DATA_9	0xd0
+#define LOONGSON_CANFD_TX_DATA_10	0xd4
+#define LOONGSON_CANFD_TX_DATA_11	0xd8
+#define LOONGSON_CANFD_TX_DATA_12	0xdc
+#define LOONGSON_CANFD_TX_DATA_13	0xe0
+#define LOONGSON_CANFD_TX_DATA_14	0xe4
+#define LOONGSON_CANFD_TX_DATA_15	0xe8
+#define LOONGSON_CANFD_TX_DATA_16	0xec
+#define LOONGSON_CANFD_TX_DATA_17	0xf0
+#define LOONGSON_CANFD_TX_DATA_18	0xf4
+
+/* Bitfields of CANFD controller ID register */
+#define REG_ID_ID			GENMASK(15, 0)
+#define REG_ID_VER_MIN			GENMASK(23, 16)
+#define REG_ID_VER_MAJ			GENMASK(31, 24)
+
+/* Bitfields of Mode Configuration register */
+#define REG_MODE_RST			BIT(0)
+#define REG_MODE_BMM			BIT(1)
+#define REG_MODE_STM			BIT(2)
+#define REG_MODE_AFM			BIT(3)
+#define REG_MODE_FDE			BIT(4)
+#define REG_MODE_TTTM			BIT(5)
+#define REG_MODE_ROM			BIT(6)
+#define REG_MODE_ACF			BIT(7)
+#define REG_MODE_TSTM			BIT(8)
+#define REG_MODE_RXBAM			BIT(9)
+#define REG_MODE_ITSM			BIT(10)
+#define REG_MODE_RTSOP			BIT(12)
+#define REG_MODE_BUFM			BIT(13)
+
+/* Bitfields of Configure register */
+#define REG_CONF_RTRLE			BIT(0)
+#define REG_CONF_RTRTH			GENMASK(4, 1)
+#define REG_CONF_ILBP			BIT(5)
+#define REG_CONF_ENA			BIT(6)
+#define REG_CONF_NISOFD			BIT(7)
+#define REG_CONF_PEX			BIT(8)
+#define REG_CONF_FDRF			BIT(10)
+
+/* Bitfields of Status register */
+#define REG_STAT_RXNE			BIT(0)
+#define REG_STAT_DOR			BIT(1)
+#define REG_STAT_TXNF			BIT(2)
+#define REG_STAT_EFT			BIT(3)
+#define REG_STAT_RXS			BIT(4)
+#define REG_STAT_TXS			BIT(5)
+#define REG_STAT_EWL			BIT(6)
+#define REG_STAT_IDLE			BIT(7)
+#define REG_STAT_PEXS			BIT(8)
+#define REG_STAT_STCNT			BIT(16)
+
+/* Bitfields of Command register */
+#define REG_CMD_RXRPMV			BIT(1)
+#define REG_CMD_RRB			BIT(2)
+#define REG_CMD_CDO			BIT(3)
+#define REG_CMD_ERCRST			BIT(4)
+#define REG_CMD_RXFCRST			BIT(5)
+#define REG_CMD_TXFCRST			BIT(6)
+#define REG_CMD_CPEXS			BIT(7)
+
+/* Bitfields of Interrupt Status register */
+#define REG_INT_STAT_RXI		BIT(0)
+#define REG_INT_STAT_TXI		BIT(1)
+#define REG_INT_STAT_EWLI		BIT(2)
+#define REG_INT_STAT_DOI		BIT(3)
+#define REG_INT_STAT_FCSI		BIT(4)
+#define REG_INT_STAT_ALI		BIT(5)
+#define REG_INT_STAT_BEI		BIT(6)
+#define REG_INT_STAT_RXFI		BIT(7)
+#define REG_INT_STAT_BSI		BIT(8)
+#define REG_INT_STAT_RBNEI		BIT(9)
+#define REG_INT_STAT_TXBHCI		BIT(10)
+#define REG_INT_STAT_OFI		BIT(11)
+#define REG_INT_STAT_DMADI		BIT(12)
+
+#define REG_INT_STAT_ERRORI	(REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_ALI)
+
+/* Bitfields of Interrupt Enable register */
+#define REG_INT_ENA_CLR			GENMASK(28, 16)
+#define REG_INT_ENA_SET			GENMASK(12, 0)
+
+/* Bitfields of Interrupt Mask register */
+#define REG_INT_MASK_SET		GENMASK(12, 0)
+#define REG_INT_MASK_CLR		GENMASK(28, 16)
+
+/* Bitfields of Normal Rate Configuration register */
+#define REG_BTR_PROP			GENMASK(6, 0)
+#define REG_BTR_PH1			GENMASK(12, 7)
+#define REG_BTR_PH2			GENMASK(18, 13)
+#define REG_BTR_BRP			GENMASK(22, 19)
+#define REG_BTR_SJW			GENMASK(31, 27)
+
+/* Bitfields of FD Data Rate Configuration register */
+#define REG_BTR_FD_PROP			GENMASK(6, 0)
+#define REG_BTR_FD_PH1			GENMASK(11, 7)
+#define REG_BTR_FD_PH2			GENMASK(17, 13)
+#define REG_BTR_FD_BRP			GENMASK(26, 19)
+#define REG_BTR_FD_SJW			GENMASK(31, 27)
+
+/* Bitfields of Error Threshold Configuration register */
+#define REG_ERL_ERP			GENMASK(7, 0)
+#define REG_ERL_EW			GENMASK(23, 16)
+
+/* Bitfields of Error Status register */
+#define REG_FSTAT_ERA			BIT(0)
+#define REG_FSTAT_ERP			BIT(1)
+#define REG_FSTAT_BOF			BIT(2)
+
+/* Bitfields of Error Count register */
+#define REG_ERC_TEC			GENMASK(8, 0)
+#define REG_ERC_REC			GENMASK(24, 16)
+
+/* Bitfields of Rate Error Count register */
+#define REG_BRE_NORM			GENMASK(15, 0)
+#define REG_BRE_FD_DATA			GENMASK(31, 16)
+
+/* Bitfields of Error Count Debug register */
+#define REG_CTR_PRES_CTPV		GENMASK(8, 0)
+#define REG_CTR_PRES_PTX		BIT(9)
+#define REG_CTR_PRES_PRX		BIT(10)
+
+/* Bitfields of Error Capture Status register */
+#define REG_ERR_CAPT_POS		GENMASK(4, 0)
+#define REG_ERR_CAPT_TYPE		GENMASK(7, 5)
+
+/* Bitfields of Retransmission Count register */
+#define REG_RETX_CNT_VAL		GENMASK(3, 0)
+
+/* Bitfields of Lost Arbitration Capture register */
+#define REG_ALC_BIT_POS			GENMASK(4, 0)
+#define REG_ALC_ID_FIELD		GENMASK(7, 5)
+
+/* Bitfields of Transmission Delay Measurement register */
+#define REG_TRV_DLY_VAL			GENMASK(6, 0)
+
+/* Bitfields of Second Sampling Point Configuration register */
+#define REG_SSP_CFG_OFF			GENMASK(7, 0)
+#define REG_SSP_CFG_SRC			GENMASK(9, 8)
+#define REG_SSP_CFG_SAT			BIT(10)
+
+/* Bitfields of Receive Message Count register */
+#define REG_RX_FR_CNT_VAL		GENMASK(31, 0)
+
+/* Bitfields of Transmit Message Count register */
+#define REG_TX_FR_CNT_VAL		GENMASK(31, 0)
+
+/* Bitfields of Debug register */
+#define REG_DEBUG_STF_CNT		GENMASK(2, 0)
+#define REG_DEBUG_DSTF_CNT		GENMASK(5, 3)
+#define REG_DEBUG_PC_ARB		BIT(6)
+#define REG_DEBUG_PC_CON		BIT(7)
+#define REG_DEBUG_PC_DAT		BIT(8)
+#define REG_DEBUG_PC_STC		BIT(9)
+#define REG_DEBUG_PC_CRC		BIT(10)
+#define REG_DEBUG_PC_CRCD		BIT(11)
+#define REG_DEBUG_PC_ACK		BIT(12)
+#define REG_DEBUG_PC_ACKD		BIT(13)
+#define REG_DEBUG_PC_EOF		BIT(14)
+#define REG_DEBUG_PC_INT		BIT(15)
+#define REG_DEBUG_PC_SUSP		BIT(16)
+#define REG_DEBUG_PC_OVR		BIT(17)
+#define REG_DEBUG_PC_SOF		BIT(18)
+
+/* Bitfields of Timestamp register */
+#define REG_TS_TIMESTAMP		GENMASK(15, 0)
+#define REG_TS_PSC			GENMASK(24, 16)
+
+/* Bitfields of Fractional Divider Ratio register */
+#define REG_FRC_FRC_DBT			GENMASK(15, 8)
+#define REG_FRC_FRC_NBT			GENMASK(7, 0)
+
+/* Bitfields of Filter A Mask register */
+#define REG_FIL_A_MASK			GENMASK(28, 0)
+
+/* Bitfields of Filter A value register */
+#define REG_FIL_A_VAL			GENMASK(28, 0)
+
+/* Bitfields of Filter B Mask register */
+#define REG_FIL_B_MASK			GENMASK(28, 0)
+
+/* Bitfields of Filter B value register */
+#define REG_FIL_B_VAL			GENMASK(28, 0)
+
+/* Bitfields of Filter C Mask register */
+#define REG_FIL_C_MASK			GENMASK(28, 0)
+
+/* Bitfields of Filter C value register */
+#define REG_FIL_C_VAL			GENMASK(28, 0)
+
+/* Bitfields of Range Filter Low Threshold register */
+#define REG_FIL_R_LOW_VAL		GENMASK(28, 0)
+
+/* Bitfields of Range Filter High Threshold register */
+#define REG_FIL_R_HI_VAL		GENMASK(28, 0)
+
+/* Bitfields of Filter Control register */
+#define REG_FIL_CTRL_FANB		BIT(0)
+#define REG_FIL_CTRL_FANE		BIT(1)
+#define REG_FIL_CTRL_FAFB		BIT(2)
+#define REG_FIL_CTRL_FAFE		BIT(3)
+#define REG_FIL_CTRL_FBNB		BIT(4)
+#define REG_FIL_CTRL_FBNE		BIT(5)
+#define REG_FIL_CTRL_FBFB		BIT(6)
+#define REG_FIL_CTRL_FBFE		BIT(7)
+#define REG_FIL_CTRL_FCNB		BIT(8)
+#define REG_FIL_CTRL_FCNE		BIT(9)
+#define REG_FIL_CTRL_FCFB		BIT(10)
+#define REG_FIL_CTRL_FCFE		BIT(11)
+#define REG_FIL_CTRL_FRNB		BIT(12)
+#define REG_FIL_CTRL_FRNE		BIT(13)
+#define REG_FIL_CTRL_FRFB		BIT(14)
+#define REG_FIL_CTRL_FRFE		BIT(15)
+#define REG_FIL_CTRL_SFA		BIT(16)
+#define REG_FIL_CTRL_SFB		BIT(17)
+#define REG_FIL_CTRL_SFC		BIT(18)
+#define REG_FIL_CTRL_SFR		BIT(19)
+
+/* Bitfields of Receive Buffer Information register */
+#define REG_RX_MEM_INFO_BUFF_SIZE	GENMASK(12, 0)
+#define REG_RX_MEM_INFO_MEM_FREE	GENMASK(28, 16)
+
+/* Bitfields of Receive Buffer Pointer register */
+#define REG_RX_PTR_WPP			GENMASK(11, 0)
+#define REG_RX_PTR_RPP			GENMASK(27, 16)
+
+/* Bitfields of Receive Buffer Status register */
+#define REG_RX_STAT_RXE			BIT(0)
+#define REG_RX_STAT_RXF			BIT(1)
+#define REG_RX_STAT_RXMOF		BIT(2)
+#define REG_RX_STAT_RXFRC		GENMASK(14, 4)
+#define REG_RX_STAT_RTSOP		BIT(16)
+
+/* Bitfields of Receive Data register */
+#define REG_RX_DATA_VAL			GENMASK(31, 0)
+
+/* Bitfields of Transmit Buffer Status register */
+#define REG_TX_STAT_BRP			GENMASK(7, 0)
+#define REG_TX_STAT_TXS			GENMASK(10, 8)
+#define REG_TX_STAT_BS			GENMASK(31, 16)
+
+#define REG_TX_STAT_BS_TX1		GENMASK(17, 16)
+#define REG_TX_STAT_BS_TX2		GENMASK(19, 18)
+#define REG_TX_STAT_BS_TX3		GENMASK(21, 20)
+#define REG_TX_STAT_BS_TX4		GENMASK(23, 22)
+#define REG_TX_STAT_BS_TX5		GENMASK(25, 24)
+#define REG_TX_STAT_BS_TX6		GENMASK(27, 26)
+#define REG_TX_STAT_BS_TX7		GENMASK(29, 28)
+#define REG_TX_STAT_BS_TX8		GENMASK(31, 30)
+
+/* Bitfields of Transmit Command register */
+#define REG_TX_CMD_BAR			GENMASK(7, 0)
+#define REG_TX_CMD_BCR			GENMASK(15, 8)
+#define REG_TX_CMD_BSC			GENMASK(23, 16)
+
+/* Bitfields of Transmit Buffer Selection register */
+#define REG_TX_SEL_BUF_SEL		GENMASK(3, 0)
+#define REG_TX_SEL_BUF_CNT		GENMASK(7, 4)
+
+#endif
-- 
2.52.0


