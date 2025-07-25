Return-Path: <linux-can+bounces-4175-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0871B121AB
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B730A7B811E
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011D2F1FF7;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78742EF9C0
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460027; cv=none; b=V+h2WnQRUj8hctqIdhgGt4s6gYR5fl9uurKJB+GssLj94j6AaXRLyyLbee11b57VKL2K046YX3TK4dlW/LKiRmd2XcZHHzBWtUbYfI0hRIePNdgF51V1rgUasWfj7lnHc171R2VCLYjNF8MrpBlLxMr4DyhzcDM0/xe2yQnjyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460027; c=relaxed/simple;
	bh=zvEspbrOqFn9RSWIcczY3/lJWo6eKJMva8gmyhKadKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp0MSp57YGGR5y+xIHk5zQH+iqvaSzJaEXSsaJzG09h3ucZlYFxKQKtT1hzw4QAt44bLlyn2W6Hz6VZ5DPXn7hFjwTNjnstVl+dwH+HK62aa/yHoTdXHelT/bSOIS8bXYJinokaSTByAtHVUm0psMtdUUF2+Qaaq9V+DTYMldL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006jk-Ct
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFcU-2b
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4A5814498DE
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B90BA449846;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 71103d78;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/27] can: kvaser_usb: Expose device information via devlink info_get()
Date: Fri, 25 Jul 2025 18:05:35 +0200
Message-ID: <20250725161327.4165174-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Expose device information via devlink info_get():
  * Serial number
  * Firmware version
  * Hardware revision
  * EAN (product number)

Example output:
  $ devlink dev
  usb/1-1.2:1.0

  $ devlink dev info
  usb/1-1.2:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-10-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index dbe7fa64558a..aa06bd1fa125 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -7,5 +7,56 @@
 
 #include <net/devlink.h>
 
+#define KVASER_USB_EAN_MSB 0x00073301
+
+static int kvaser_usb_devlink_info_get(struct devlink *devlink,
+				       struct devlink_info_req *req,
+				       struct netlink_ext_ack *extack)
+{
+	struct kvaser_usb *dev = devlink_priv(devlink);
+	char buf[] = "73301XXXXXXXXXX";
+	int ret;
+
+	if (dev->serial_number) {
+		snprintf(buf, sizeof(buf), "%u", dev->serial_number);
+		ret = devlink_info_serial_number_put(req, buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 dev->fw_version.major,
+			 dev->fw_version.minor,
+			 dev->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->hw_revision) {
+		snprintf(buf, sizeof(buf), "%u", dev->hw_revision);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->ean[1] == KVASER_USB_EAN_MSB) {
+		snprintf(buf, sizeof(buf), "%x%08x", dev->ean[1], dev->ean[0]);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_usb_devlink_ops = {
+	.info_get = kvaser_usb_devlink_info_get,
 };
-- 
2.47.2



