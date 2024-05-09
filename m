Return-Path: <linux-can+bounces-610-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385D38C13B4
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2891C21A52
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C141401E;
	Thu,  9 May 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="PF4251sK"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC3DF6B;
	Thu,  9 May 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275164; cv=none; b=OdrGOvx4NovYgpxJPOhq6qdf8o5ANX1BUKFlqVaAPz582PY5P3OlbjHq/XTChtlizNrA/gu0fcgIucjePjY66ygJ7RsWy9XCrsQ+pNGT540t4mcyh9eCzc4/asHrtz4tp2SO4kBgax0gT4r75eZikNEcua9hf9kZUPa98Q/JF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275164; c=relaxed/simple;
	bh=PzqKlGDClOV67iT+B78kHUyaR4/u3aGBn0W7MXQ5KzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntnun9qqmph72dzP3/+LqUUnomdDi7C4auwSczjFv8mHe5H4gaye1yI+Yno+2MSe9bi8226VbSba72LgDmHX2h7xyA83+aeuj33DnZX+083HOqvQ1CrTzg9dcINMuHUbistK4cd6cK7bxE/4IG39V6kshQL+S0Hz2Rd3Unlgevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=PF4251sK; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jHadZ9l8cmr144TWkJ8VpvQdFZPLPCAHUmqrQYHd0gA=; b=PF4251sKYt+JWk5HCd8laZyiRR
	Dox2X/SmUloYd9ugd+/UKhu8CScE4cZx0zYkRMht4azljx3ov5ITnVtKeciby+KmSpYcz6FytGKNK
	d1tObGXb8kwz/L6z8NYtaB8QX03WpDHUdUPqJI9B5/5pKP8TU9MBqmopebBexwhJq6qo=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57Q5-001jf8-1v;
	Thu, 09 May 2024 19:19:03 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 01/11] can: Add LIN bus as CAN abstraction
Date: Thu,  9 May 2024 19:17:26 +0200
Message-Id: <20240509171736.2048414-2-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a LIN (local interconnect network) abstraction on top of CAN.
This is a glue driver adapting CAN on one side while offering LIN
abstraction on the other side. So that upcoming LIN device drivers can
make use of it.

Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/Kconfig          |  10 +
 drivers/net/can/Makefile         |   1 +
 drivers/net/can/lin.c            | 470 +++++++++++++++++++++++++++++++
 include/net/lin.h                |  90 ++++++
 include/uapi/linux/can/netlink.h |   1 +
 5 files changed, 572 insertions(+)
 create mode 100644 drivers/net/can/lin.c
 create mode 100644 include/net/lin.h

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 2e31db55d9278..0934bbf8d03b2 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -171,6 +171,16 @@ config CAN_KVASER_PCIEFD
 	    Kvaser M.2 PCIe 4xCAN
 	    Kvaser PCIe 8xCAN
 
+config CAN_LIN
+	tristate "LIN mode support"
+	help
+	  This is a glue driver for LIN-BUS support.
+
+	  The local interconnect (LIN) bus is a simple bus with a feature
+	  subset of CAN. It is often combined with CAN for simple controls.
+
+	  Actual device drivers need to be enabled too.
+
 config CAN_SLCAN
 	tristate "Serial / USB serial CAN Adaptors (slcan)"
 	depends on TTY
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 4669cd51e7bf5..0093ee9219ca8 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
+obj-$(CONFIG_CAN_LIN)		+= lin.o
 obj-$(CONFIG_CAN_MSCAN)		+= mscan/
 obj-$(CONFIG_CAN_M_CAN)		+= m_can/
 obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
new file mode 100644
index 0000000000000..a22768c17e3f8
--- /dev/null
+++ b/drivers/net/can/lin.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
+
+#include <linux/can/core.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <net/lin.h>
+
+static const u8 lin_id_parity_tbl[] = {
+	0x80, 0xC0, 0x40, 0x00, 0xC0, 0x80, 0x00, 0x40,
+	0x00, 0x40, 0xC0, 0x80, 0x40, 0x00, 0x80, 0xC0,
+	0x40, 0x00, 0x80, 0xC0, 0x00, 0x40, 0xC0, 0x80,
+	0xC0, 0x80, 0x00, 0x40, 0x80, 0xC0, 0x40, 0x00,
+	0x00, 0x40, 0xC0, 0x80, 0x40, 0x00, 0x80, 0xC0,
+	0x80, 0xC0, 0x40, 0x00, 0xC0, 0x80, 0x00, 0x40,
+	0xC0, 0x80, 0x00, 0x40, 0x80, 0xC0, 0x40, 0x00,
+	0x40, 0x00, 0x80, 0xC0, 0x00, 0x40, 0xC0, 0x80,
+};
+
+u8 lin_get_id_parity(u8 id)
+{
+	return lin_id_parity_tbl[id];
+}
+EXPORT_SYMBOL(lin_get_id_parity);
+
+static ssize_t lin_identifier_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct lin_device *ldev = netdev_priv(to_net_dev(dev));
+	struct lin_responder_answer answ;
+	int k, count, ret;
+	long id;
+
+	if (!ldev->ldev_ops->get_responder_answer)
+		return -EOPNOTSUPP;
+
+	ret = kstrtol(attr->attr.name, 16, &id);
+	if (ret)
+		return ret;
+	if (id < 0 || id >= LIN_NUM_IDS)
+		return -EINVAL;
+
+	count = sysfs_emit(buf, "%-6s %-11s %-9s %-9s %-2s %-24s %-6s\n",
+			   "state", "cksum-mode", "is_event", "event_id",
+			   "n", "data", "cksum");
+
+	ret = ldev->ldev_ops->get_responder_answer(ldev, id, &answ);
+	if (ret)
+		return ret;
+
+	count += sysfs_emit_at(buf, count, "%-6s %-11s %-9s %-9u %-2u ",
+			       answ.is_active ? "active" : "off",
+			       answ.lf.checksum_mode ? "enhanced" : "classic",
+			       answ.is_event_frame ? "yes" : "no",
+			       answ.event_associated_id,
+			       answ.lf.len);
+
+	for (k = 0; k < answ.lf.len; k++)
+		count += sysfs_emit_at(buf, count, "%02x ", answ.lf.data[k]);
+	for (; k < 8; k++)
+		count += sysfs_emit_at(buf, count, "   ");
+	if (answ.lf.len)
+		count += sysfs_emit_at(buf, count, " %02x", answ.lf.checksum);
+
+	count += sysfs_emit_at(buf, count, "\n");
+
+	return count;
+}
+
+static const char *parse_and_advance(const char *buf, long *result,
+				     unsigned int base)
+{
+	char num_str[5] = {0};
+	int num_len = 0;
+
+	while (*buf && isspace(*buf))
+		buf++;
+	while (*buf && isalnum(*buf) && num_len < sizeof(num_str) - 1)
+		num_str[num_len++] = *buf++;
+	if (kstrtol(num_str, base, result))
+		return NULL;
+
+	return buf;
+}
+
+static ssize_t lin_identifier_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct lin_device *ldev = netdev_priv(to_net_dev(dev));
+	struct lin_responder_answer answ = { 0 };
+	const char *ptr = buf;
+	int ret;
+	long v;
+
+	if (!ldev->ldev_ops->update_responder_answer)
+		return -EOPNOTSUPP;
+
+	ret = kstrtol(attr->attr.name, 16, &v);
+	if (ret)
+		return ret;
+	if (v < 0 || v >= LIN_NUM_IDS)
+		return -EINVAL;
+	answ.lf.lin_id = v;
+
+	ptr = parse_and_advance(ptr, &v, 2);
+	if (!ptr)
+		return -EINVAL;
+	answ.is_active = v != 0;
+
+	ptr = parse_and_advance(ptr, &v, 2);
+	if (!ptr)
+		return -EINVAL;
+	answ.lf.checksum_mode = v != 0;
+
+	ptr = parse_and_advance(ptr, &v, 2);
+	if (!ptr)
+		return -EINVAL;
+	answ.is_event_frame = v != 0;
+
+	ptr = parse_and_advance(ptr, &v, 16);
+	if (!ptr || v > LIN_ID_MASK)
+		return -EINVAL;
+	answ.event_associated_id = v;
+
+	ptr = parse_and_advance(ptr, &v, 16);
+	if (!ptr || v > LIN_MAX_DLEN)
+		return -EINVAL;
+	answ.lf.len = v;
+
+	for (int i = 0; i < answ.lf.len; i++) {
+		ptr = parse_and_advance(ptr, &v, 16);
+		if (!ptr)
+			return -EINVAL;
+		answ.lf.data[i] = v;
+	}
+
+	ret = ldev->ldev_ops->update_responder_answer(ldev, &answ);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+#define LID(_name) \
+	struct device_attribute linid_##_name = __ATTR(_name, 0644, \
+	lin_identifier_show, lin_identifier_store)
+
+LID(00); LID(01); LID(02); LID(03); LID(04); LID(05); LID(06); LID(07);
+LID(08); LID(09); LID(0a); LID(0b); LID(0c); LID(0d); LID(0e); LID(0f);
+LID(10); LID(11); LID(12); LID(13); LID(14); LID(15); LID(16); LID(17);
+LID(18); LID(19); LID(1a); LID(1b); LID(1c); LID(1d); LID(1e); LID(1f);
+LID(20); LID(21); LID(22); LID(23); LID(24); LID(25); LID(26); LID(27);
+LID(28); LID(29); LID(2a); LID(2b); LID(2c); LID(2d); LID(2e); LID(2f);
+LID(30); LID(31); LID(32); LID(33); LID(34); LID(35); LID(36); LID(37);
+LID(38); LID(39); LID(3a); LID(3b); LID(3c); LID(3d); LID(3e); LID(3f);
+
+static struct attribute *lin_sysfs_attrs[] = {
+	&linid_00.attr, &linid_01.attr, &linid_02.attr, &linid_03.attr,
+	&linid_04.attr, &linid_05.attr, &linid_06.attr, &linid_07.attr,
+	&linid_08.attr, &linid_09.attr, &linid_0a.attr, &linid_0b.attr,
+	&linid_0c.attr, &linid_0d.attr, &linid_0e.attr, &linid_0f.attr,
+	&linid_10.attr, &linid_11.attr, &linid_12.attr, &linid_13.attr,
+	&linid_14.attr, &linid_15.attr, &linid_16.attr, &linid_17.attr,
+	&linid_18.attr, &linid_19.attr, &linid_1a.attr, &linid_1b.attr,
+	&linid_1c.attr, &linid_1d.attr, &linid_1e.attr, &linid_1f.attr,
+	&linid_20.attr, &linid_21.attr, &linid_22.attr, &linid_23.attr,
+	&linid_24.attr, &linid_25.attr, &linid_26.attr, &linid_27.attr,
+	&linid_28.attr, &linid_29.attr, &linid_2a.attr, &linid_2b.attr,
+	&linid_2c.attr, &linid_2d.attr, &linid_2e.attr, &linid_2f.attr,
+	&linid_30.attr, &linid_31.attr, &linid_32.attr, &linid_33.attr,
+	&linid_34.attr, &linid_35.attr, &linid_36.attr, &linid_37.attr,
+	&linid_38.attr, &linid_39.attr, &linid_3a.attr, &linid_3b.attr,
+	&linid_3c.attr, &linid_3d.attr, &linid_3e.attr, &linid_3f.attr,
+	NULL
+};
+
+static const struct attribute_group lin_sysfs_group = {
+	.name = "lin_ids",
+	.attrs = lin_sysfs_attrs,
+};
+
+static void lin_tx_work_handler(struct work_struct *ws)
+{
+	struct lin_device *ldev = container_of(ws, struct lin_device,
+					       tx_work);
+	struct net_device *ndev = ldev->ndev;
+	struct canfd_frame *cfd;
+	struct lin_frame lf;
+	int ret;
+
+	ldev->tx_busy = true;
+
+	cfd = (struct canfd_frame *)ldev->tx_skb->data;
+	lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
+			   LINBUS_ENHANCED : LINBUS_CLASSIC;
+	lf.lin_id = cfd->can_id & LIN_ID_MASK;
+	lf.len = min(cfd->len, LIN_MAX_DLEN);
+	memcpy(lf.data, cfd->data, lf.len);
+
+	ret = ldev->ldev_ops->ldo_tx(ldev, &lf);
+	if (ret) {
+		DEV_STATS_INC(ndev, tx_dropped);
+		netdev_err_once(ndev, "transmission failure %d\n", ret);
+		goto lin_tx_out;
+	}
+
+	DEV_STATS_INC(ndev, tx_packets);
+	DEV_STATS_ADD(ndev, tx_bytes, lf.len);
+
+lin_tx_out:
+	ldev->tx_busy = false;
+	netif_wake_queue(ndev);
+}
+
+static netdev_tx_t lin_start_xmit(struct sk_buff *skb,
+				  struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+
+	if (ldev->tx_busy)
+		return NETDEV_TX_BUSY;
+
+	netif_stop_queue(ndev);
+	ldev->tx_skb = skb;
+	queue_work(ldev->wq, &ldev->tx_work);
+
+	return NETDEV_TX_OK;
+}
+
+static int lin_open(struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+	int ret;
+
+	ldev->tx_busy = false;
+
+	ret = open_candev(ndev);
+	if (ret)
+		return ret;
+
+	netif_wake_queue(ndev);
+
+	ldev->can.state = CAN_STATE_ERROR_ACTIVE;
+	ndev->mtu = CANFD_MTU;
+
+	return ldev->ldev_ops->ldo_open(ldev);
+}
+
+static int lin_stop(struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+
+	close_candev(ndev);
+
+	flush_work(&ldev->tx_work);
+
+	ldev->can.state = CAN_STATE_STOPPED;
+
+	return ldev->ldev_ops->ldo_stop(ldev);
+}
+
+static const struct net_device_ops lin_netdev_ops = {
+	.ndo_open = lin_open,
+	.ndo_stop = lin_stop,
+	.ndo_start_xmit = lin_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+u8 lin_get_checksum(u8 pid, u8 n_of_bytes, const u8 *bytes,
+		    enum lin_checksum_mode cm)
+{
+	unsigned int csum = 0;
+	int i;
+
+	if (cm == LINBUS_ENHANCED)
+		csum += pid;
+
+	for (i = 0; i < n_of_bytes; i++) {
+		csum += bytes[i];
+		if (csum > 255)
+			csum -= 255;
+	}
+
+	return (~csum & 0xff);
+}
+EXPORT_SYMBOL_GPL(lin_get_checksum);
+
+static int lin_bump_rx_err(struct lin_device *ldev, const struct lin_frame *lf)
+{
+	struct net_device *ndev = ldev->ndev;
+	struct can_frame cf = {0 };
+
+	if (lf->lin_id > LIN_ID_MASK) {
+		netdev_dbg(ndev, "id exceeds LIN max id\n");
+		cf.can_id = CAN_ERR_FLAG | CAN_ERR_PROT;
+		cf.data[3] = CAN_ERR_PROT_LOC_ID12_05;
+	}
+
+	if (lf->len > LIN_MAX_DLEN) {
+		netdev_dbg(ndev, "frame exceeds number of bytes\n");
+		cf.can_id = CAN_ERR_FLAG | CAN_ERR_PROT;
+		cf.data[3] = CAN_ERR_PROT_LOC_DLC;
+	}
+
+	if (lf->len) {
+		u8 checksum = lin_get_checksum(LIN_FORM_PID(lf->lin_id),
+					       lf->len, lf->data,
+					       lf->checksum_mode);
+
+		if (checksum != lf->checksum) {
+			netdev_dbg(ndev, "expected cksm: 0x%02x got: 0x%02x\n",
+				   checksum, lf->checksum);
+			cf.can_id = CAN_ERR_FLAG | CAN_ERR_PROT;
+			cf.data[2] = CAN_ERR_PROT_FORM;
+		}
+	}
+
+	if (cf.can_id & CAN_ERR_FLAG) {
+		struct can_frame *err_cf;
+		struct sk_buff *skb = alloc_can_err_skb(ndev, &err_cf);
+
+		if (unlikely(!skb))
+			return -ENOMEM;
+
+		err_cf->can_id |= cf.can_id;
+		memcpy(err_cf->data, cf.data, CAN_MAX_DLEN);
+
+		netif_rx(skb);
+
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+int lin_rx(struct lin_device *ldev, const struct lin_frame *lf)
+{
+	struct net_device *ndev = ldev->ndev;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	int ret;
+
+	if (ldev->can.state == CAN_STATE_STOPPED)
+		return 0;
+
+	netdev_dbg(ndev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
+		   lf->lin_id, lf->len, lf->len, lf->data, lf->checksum,
+		   lf->checksum_mode ? "enhanced" : "classic");
+
+	ret = lin_bump_rx_err(ldev, lf);
+	if (ret) {
+		DEV_STATS_INC(ndev, rx_dropped);
+		return ret;
+	}
+
+	skb = alloc_can_skb(ndev, &cf);
+	if (unlikely(!skb)) {
+		DEV_STATS_INC(ndev, rx_dropped);
+		return -ENOMEM;
+	}
+
+	cf->can_id = lf->lin_id;
+	cf->len = min(lf->len, LIN_MAX_DLEN);
+	memcpy(cf->data, lf->data, cf->len);
+
+	DEV_STATS_INC(ndev, rx_packets);
+	DEV_STATS_ADD(ndev, rx_bytes, cf->len);
+
+	netif_receive_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lin_rx);
+
+static int lin_set_bittiming(struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+	unsigned int bitrate = ldev->can.bittiming.bitrate;
+
+	return ldev->ldev_ops->update_bitrate(ldev, bitrate);
+}
+
+static const u32 lin_bitrate[] = { 1200, 2400, 4800, 9600, 19200 };
+
+struct lin_device *register_lin(struct device *dev,
+				const struct lin_device_ops *ldops)
+{
+	struct net_device *ndev;
+	struct lin_device *ldev;
+	int ret;
+
+	if (!ldops || !ldops->ldo_tx || !ldops->update_bitrate  ||
+	    !ldops->ldo_open || !ldops->ldo_stop) {
+		dev_err(dev, "missing mandatory lin_device_ops\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ndev = alloc_candev(sizeof(struct lin_device), 1);
+	if (!ndev)
+		return ERR_PTR(-ENOMEM);
+
+	ldev = netdev_priv(ndev);
+
+	ldev->ldev_ops = ldops;
+	ndev->netdev_ops = &lin_netdev_ops;
+	ndev->flags |= IFF_ECHO;
+	ndev->mtu = CANFD_MTU;
+	ndev->sysfs_groups[0] = &lin_sysfs_group;
+	ldev->can.bittiming.bitrate = LIN_DEFAULT_BAUDRATE;
+	ldev->can.ctrlmode = CAN_CTRLMODE_LIN;
+	ldev->can.ctrlmode_supported = 0;
+	ldev->can.bitrate_const = lin_bitrate;
+	ldev->can.bitrate_const_cnt = ARRAY_SIZE(lin_bitrate);
+	ldev->can.do_set_bittiming = lin_set_bittiming;
+	ldev->ndev = ndev;
+	ldev->dev = dev;
+
+	SET_NETDEV_DEV(ndev, dev);
+
+	ret = lin_set_bittiming(ndev);
+	if (ret) {
+		netdev_err(ndev, "set bittiming failed\n");
+		goto exit_candev;
+	}
+
+	ret = register_candev(ndev);
+	if (ret)
+		goto exit_candev;
+
+	/* Using workqueue as tx over USB/SPI/... may sleep */
+	ldev->wq = alloc_workqueue(dev_name(dev), WQ_FREEZABLE | WQ_MEM_RECLAIM,
+				   0);
+	if (!ldev->wq) {
+		ret = -ENOMEM;
+		goto exit_unreg;
+	}
+
+	INIT_WORK(&ldev->tx_work, lin_tx_work_handler);
+
+	netdev_info(ndev, "LIN initialized\n");
+
+	return ldev;
+
+exit_unreg:
+	unregister_candev(ndev);
+exit_candev:
+	free_candev(ndev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(register_lin);
+
+void unregister_lin(struct lin_device *ldev)
+{
+	struct net_device *ndev = ldev->ndev;
+
+	unregister_candev(ndev);
+	destroy_workqueue(ldev->wq);
+	free_candev(ndev);
+}
+EXPORT_SYMBOL_GPL(unregister_lin);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christoph Fritz <christoph.fritz@hexdev.de>");
+MODULE_DESCRIPTION("LIN bus to CAN glue driver");
diff --git a/include/net/lin.h b/include/net/lin.h
new file mode 100644
index 0000000000000..31bb0feefd188
--- /dev/null
+++ b/include/net/lin.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2024 hexDEV GmbH - https://hexdev.de */
+
+#ifndef _NET_LIN_H_
+#define _NET_LIN_H_
+
+#include <linux/bitfield.h>
+#include <linux/can/dev.h>
+#include <linux/device.h>
+
+#define LIN_NUM_IDS		64
+#define LIN_HEADER_SIZE		3
+#define LIN_MAX_DLEN		8
+
+#define LIN_MAX_BAUDRATE	20000
+#define LIN_MIN_BAUDRATE	1000
+#define LIN_DEFAULT_BAUDRATE	9600
+#define LIN_SYNC_BYTE		0x55
+
+#define LIN_ID_MASK		GENMASK(5, 0)
+/* special ID descriptions for LIN */
+#define LIN_RXOFFLOAD_DATA_FLAG	BIT(9)
+#define LIN_ENHANCED_CKSUM_FLAG	BIT(8)
+
+extern u8 lin_get_id_parity(u8 id);
+
+#define LIN_GET_ID(PID)		FIELD_GET(LIN_ID_MASK, PID)
+#define LIN_FORM_PID(ID)	(LIN_GET_ID(ID) | \
+					lin_get_id_parity(LIN_GET_ID(ID)))
+#define LIN_GET_PARITY(PID)	((PID) & ~LIN_ID_MASK)
+#define LIN_CHECK_PID(PID)	(LIN_GET_PARITY(PID) == \
+					LIN_GET_PARITY(LIN_FORM_PID(PID)))
+
+struct lin_attr {
+	struct kobj_attribute attr;
+	struct lin_device *ldev;
+};
+
+struct lin_device {
+	struct can_priv can;  /* must be the first member */
+	struct net_device *ndev;
+	struct device *dev;
+	const struct lin_device_ops *ldev_ops;
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	bool tx_busy;
+	struct sk_buff *tx_skb;
+};
+
+enum lin_checksum_mode {
+	LINBUS_CLASSIC = 0,
+	LINBUS_ENHANCED,
+};
+
+struct lin_frame {
+	u8 lin_id;
+	u8 len;
+	u8 data[LIN_MAX_DLEN];
+	u8 checksum;
+	enum lin_checksum_mode checksum_mode;
+};
+
+struct lin_responder_answer {
+	bool is_active;
+	bool is_event_frame;
+	u8 event_associated_id;
+	struct lin_frame lf;
+};
+
+struct lin_device_ops {
+	int (*ldo_open)(struct lin_device *ldev);
+	int (*ldo_stop)(struct lin_device *ldev);
+	int (*ldo_tx)(struct lin_device *ldev, const struct lin_frame *frame);
+	int (*update_bitrate)(struct lin_device *ldev, u16 bitrate);
+	int (*update_responder_answer)(struct lin_device *ldev,
+				       const struct lin_responder_answer *answ);
+	int (*get_responder_answer)(struct lin_device *ldev, u8 id,
+				    struct lin_responder_answer *answ);
+};
+
+int lin_rx(struct lin_device *ldev, const struct lin_frame *lf);
+
+u8 lin_get_checksum(u8 pid, u8 n_of_bytes, const u8 *bytes,
+		    enum lin_checksum_mode cm);
+
+struct lin_device *register_lin(struct device *dev,
+				const struct lin_device_ops *ldops);
+void unregister_lin(struct lin_device *ldev);
+
+#endif /* _NET_LIN_H_ */
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d694742..a37f56d86c5f2 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -103,6 +103,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_LIN		BIT(11)	/* LIN bus mode */
 
 /*
  * CAN device statistics
-- 
2.39.2


