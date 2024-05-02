Return-Path: <linux-can+bounces-521-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DD8B95D0
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15F31C21167
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6521C4778C;
	Thu,  2 May 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="wnDz3TzV"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7733CFC;
	Thu,  2 May 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636611; cv=none; b=FrEtSHwcTDhtSsIDC2XqauRI+/aTO8tpAj1wwLcye6j7XDf8O3AZNCJWiUJPF20VI+lnej2gQiAMTdpet4Yr8ObAICy/EvIpIIS/RFLCHxGdFMhm3VDhAWJlv7cs1SYmSiVxFHcOlKYoemhCcJwJ3oVpbAgwmLOvFWNYFIzbiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636611; c=relaxed/simple;
	bh=0C3hVHADKleL+xH8Etg55tcmjzDkaqrNc4T+f2Ny/Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqp9fInEy5qfZ0isCrLbi5pe2bIlzvyEnLT7WLXlc28wx79ycD+YHXS7AvaJwid9UV01u1Ndqp4PZBoO9CcJbM/QPmYcb+2JS5/rEP2hgnMECp+JGYQTFYNgMZJRezRmb9NTVRIriIt/tGShO2wHVAAnia30OcPIP4/APJQfZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=wnDz3TzV; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LopWCCJvbmY6iL0+SJB5tqGLqyWd9kUah2zsix2RxWk=; b=wnDz3TzVkFPO8IRVvwmGRwykdk
	fnjcSVsUjd07mBClHoO3j25YgPewlsOCx7ZILIO7EuhwenYHmJDDUxlBy/fwhYQFN8xoyb9K8oYUg
	WdaYzZ/FCLRGbDEdL+ZiN9QCJnU7eGHqrg4dQ4LSjt+VXQ5igs/S+LEH8liUMg/DouEI=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RIt-001Yg7-2j;
	Thu, 02 May 2024 09:56:32 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
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
Subject: [PATCH v2 01/12] can: Add LIN bus as CAN abstraction
Date: Thu,  2 May 2024 09:55:23 +0200
Message-Id: <20240502075534.882628-2-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502075534.882628-1-christoph.fritz@hexdev.de>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a LIN (local interconnect network) bus abstraction on
top of CAN.  It is a glue driver adapting CAN on one side while offering
LIN abstraction on the other side. So that upcoming LIN device drivers
can make use of it.

Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/Kconfig          |  10 +
 drivers/net/can/Makefile         |   1 +
 drivers/net/can/lin.c            | 495 +++++++++++++++++++++++++++++++
 include/net/lin.h                |  91 ++++++
 include/uapi/linux/can/netlink.h |   1 +
 5 files changed, 598 insertions(+)
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
index 0000000000000..95906003666fb
--- /dev/null
+++ b/drivers/net/can/lin.c
@@ -0,0 +1,495 @@
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
+static ssize_t lin_identifier_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	struct lin_attr *lin_attr = container_of(attr, struct lin_attr, attr);
+	struct lin_device *ldev = lin_attr->ldev;
+	ssize_t count = 0;
+	struct lin_responder_answer answ;
+	int k, ret;
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
+	count += scnprintf(buf + count, PAGE_SIZE - count,
+			   "%-6s %-11s %-9s %-9s %-2s %-24s %-6s\n",
+			   "state", "cksum-mode", "is_event", "event_id",
+			   "n", "data", "cksum");
+
+	ret = ldev->ldev_ops->get_responder_answer(ldev, id, &answ);
+	if (ret)
+		return ret;
+
+	count += scnprintf(buf + count, PAGE_SIZE - count,
+			   "%-6s %-11s %-9s %-9u %-2u ",
+			   answ.is_active ? "active" : "off",
+			   answ.lf.checksum_mode ? "enhanced" : "classic",
+			   answ.is_event_frame ? "yes" : "no",
+			   answ.event_associated_id,
+			   answ.lf.len);
+
+	for (k = 0; k < answ.lf.len; k++)
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "%02x ", answ.lf.data[k]);
+	for (; k < 8; k++)
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "   ");
+	if (answ.lf.len)
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   " %02x", answ.lf.checksum);
+
+	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
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
+static ssize_t lin_identifier_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct lin_attr *lin_attr = container_of(attr, struct lin_attr, attr);
+	struct lin_device *ldev = lin_attr->ldev;
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
+static int lin_create_sysfs_id_files(struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+	struct kobj_attribute *attr;
+	int ret;
+
+	for (int id = 0; id < LIN_NUM_IDS; id++) {
+		ldev->sysfs_entries[id].ldev = ldev;
+		attr = &ldev->sysfs_entries[id].attr;
+		attr->attr.name = kasprintf(GFP_KERNEL, "%02x", id);
+		if (!attr->attr.name)
+			return -ENOMEM;
+		attr->attr.mode = 0644;
+		attr->show = lin_identifier_show;
+		attr->store = lin_identifier_store;
+
+		sysfs_attr_init(&attr->attr);
+		ret = sysfs_create_file(ldev->lin_ids_kobj, &attr->attr);
+		if (ret) {
+			kfree(attr->attr.name);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void lin_remove_sysfs_id_files(struct net_device *ndev)
+{
+	struct lin_device *ldev = netdev_priv(ndev);
+	struct kobj_attribute *attr;
+
+	for (int id = 0; id < LIN_NUM_IDS; id++) {
+		attr = &ldev->sysfs_entries[id].attr;
+		sysfs_remove_file(ldev->lin_ids_kobj, &attr->attr);
+		kfree(attr->attr.name);
+	}
+}
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
+		netdev_err(ndev, "missing mandatory lin_device_ops\n");
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
+	ldev->lin_ids_kobj = kobject_create_and_add("lin_ids", &ndev->dev.kobj);
+	if (!ldev->lin_ids_kobj) {
+		netdev_err(ndev, "Failed to create sysfs directory\n");
+		ret = -ENOMEM;
+		goto exit_unreg;
+	}
+
+	ret = lin_create_sysfs_id_files(ndev);
+	if (ret) {
+		netdev_err(ndev, "Failed to create sysfs entry: %d\n", ret);
+		goto exit_kobj_put;
+	}
+
+	/* Using workqueue as tx over USB/SPI/... may sleep */
+	ldev->wq = alloc_workqueue(dev_name(dev), WQ_FREEZABLE | WQ_MEM_RECLAIM,
+				   0);
+	if (!ldev->wq)
+		goto exit_rm_files;
+
+	INIT_WORK(&ldev->tx_work, lin_tx_work_handler);
+
+	netdev_info(ndev, "LIN initialized.\n");
+
+	return ldev;
+
+exit_rm_files:
+	lin_remove_sysfs_id_files(ndev);
+exit_kobj_put:
+	kobject_put(ldev->lin_ids_kobj);
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
+	lin_remove_sysfs_id_files(ndev);
+	kobject_put(ldev->lin_ids_kobj);
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
index 0000000000000..944e775c40e79
--- /dev/null
+++ b/include/net/lin.h
@@ -0,0 +1,91 @@
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
+#define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
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
+	struct kobject *lin_ids_kobj;
+	struct lin_attr sysfs_entries[LIN_NUM_IDS];
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
index 02ec32d694742..51b0e2a7624e4 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -103,6 +103,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_LIN		0x800	/* LIN bus mode */
 
 /*
  * CAN device statistics
-- 
2.39.2


