Return-Path: <linux-can+bounces-611-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E18C13BA
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A672D282259
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DC168DD;
	Thu,  9 May 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="diNhpDz9"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A2F4EB;
	Thu,  9 May 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275165; cv=none; b=CpkIZXA6j7bm/WmA9iX4WRxBJ/s+AezotKfmqREnWVWTal0HgF3CltAaYVeMyu4ww4BxKfQ/8CW7adxBRfOhoVg8JJVx/6N97RcD8VVeYq4bKq+oTBU//O0avhgLySMARnx4zi43ecIS0wL3yJTkGJrPLcNtniutK2nA/c2LzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275165; c=relaxed/simple;
	bh=zbTfWQh4KvF4pAEyag4/J9qk/8sZNX3BxNzUdgdzUrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXtaSoHkUe4HgTxc+mSBp/YsTr1eSemxhZCIPK2PaY+H3Cva9EXV6Sg0RieXl46iaR6efcs7HB6tyCj+RjJ9Qlkb4xq7HBQoE63q531oGdKsiawJfa9PDb6jxTugRotlyeyVaMUT8FdcYS5Jqiz2xu50l+oDIyRnq6GzN89+8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=diNhpDz9; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=A79fzqeUdzxBYJv79o7z3H3qzY+MLMozeu/HWB7jHhc=; b=diNhpDz9iaaXLQ/qucPD7KsN8t
	wk9zgoZVY4zq5svf03qdDRPTc+gPLaPmkiHZaSlzIuKCJYen7c5ah5u3tms0qmtgkqZt5PInqXP47
	5Bz+HjIMSvYwcUfYmXiwp/htfepT/LpxKbWFlwKExCQOHq2iTS3UeRrB8W183jhCjNpQ=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QB-001jf8-1t;
	Thu, 09 May 2024 19:19:08 +0200
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
Subject: [PATCH v4 04/11] tty: serdev: Add method to enable break flags
Date: Thu,  9 May 2024 19:17:29 +0200
Message-Id: <20240509171736.2048414-5-christoph.fritz@hexdev.de>
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

The recently introduced callback function receive_buf_fp() brings flags
buffer support. To allow signaling of TTY_BREAK flags, this patch
introduces serdev_device_set_break_detection() and an implementation for
ttyport. This enables serdev devices to configure their underlying tty
port to signal or ignore break conditions.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/tty/serdev/core.c           | 11 +++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 17 +++++++++++++++++
 include/linux/serdev.h              |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 613cb356b918d..23a1e76cb553b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -339,6 +339,17 @@ unsigned int serdev_device_set_baudrate(struct serdev_device *serdev, unsigned i
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_baudrate);
 
+void serdev_device_set_break_detection(struct serdev_device *serdev, bool enable)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_break_detection)
+		return;
+
+	ctrl->ops->set_break_detection(ctrl, enable);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_break_detection);
+
 void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index bb47691afdb21..e928bf4175c6f 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -192,6 +192,22 @@ static void ttyport_set_flow_control(struct serdev_controller *ctrl, bool enable
 	tty_set_termios(tty, &ktermios);
 }
 
+static void ttyport_set_break_detection(struct serdev_controller *ctrl, bool enable)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	ktermios.c_iflag &= ~(IGNBRK | BRKINT);
+
+	if (enable)
+		ktermios.c_iflag |= BRKINT;
+	else
+		ktermios.c_iflag |= IGNBRK;
+
+	tty_set_termios(tty, &ktermios);
+}
+
 static int ttyport_set_parity(struct serdev_controller *ctrl,
 			      enum serdev_parity parity)
 {
@@ -263,6 +279,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.open = ttyport_open,
 	.close = ttyport_close,
 	.set_flow_control = ttyport_set_flow_control,
+	.set_break_detection = ttyport_set_break_detection,
 	.set_parity = ttyport_set_parity,
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 94fc81a1de933..84805762a67cc 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -91,6 +91,7 @@ struct serdev_controller_ops {
 	int (*open)(struct serdev_controller *);
 	void (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
+	void (*set_break_detection)(struct serdev_controller *, bool);
 	int (*set_parity)(struct serdev_controller *, enum serdev_parity);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
@@ -208,6 +209,7 @@ void serdev_device_close(struct serdev_device *);
 int devm_serdev_device_open(struct device *, struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
+void serdev_device_set_break_detection(struct serdev_device *, bool);
 int serdev_device_write_buf(struct serdev_device *, const u8 *, size_t);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
-- 
2.39.2


