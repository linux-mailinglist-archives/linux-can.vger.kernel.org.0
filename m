Return-Path: <linux-can+bounces-542-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788598BA057
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE91F228A3
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBEB178CC0;
	Thu,  2 May 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="jfJxtVeq"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509317167B;
	Thu,  2 May 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674546; cv=none; b=rOPgpovkcZ75ibkDQEL5XV+QOg2WoTqbTt6tEVRpXJvHUe9chgqfR7B+1hq61KHAbuDA5wALlXgZRZ5/fQMqqv4Q/B/rOBbegocuqpbBlbMZlOu5dhi1VYzzRdI0sUFFTpJxKUPHUlesPkq0xuz0GqF1p/81lncXJdWqp6mFBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674546; c=relaxed/simple;
	bh=ZrFdSLcIMeL0Gw5YEaKUCGUEp/+XyImajt9Wq1/xfjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdPFbPpzToMH2+KSzQ5adpx9CGzMcbD2YSoj7VNRMgjk7w9GocBlLEH2z4ykMm/5S5iXI3XIEFkImOP2YhRJkvl1wuXIbF5tbzBOk/lt4GOlWfthFCuwPowyVSCy9PJEk3gQWWoW0vlvOzrcXLb7oOIBJXaUJDSaBBdvovtBWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=jfJxtVeq; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ekCjuw1duvOWVggYCKKNCs0aIF99UZrHoS1CtHiTWfg=; b=jfJxtVeq2SxD+2lNekY07f9QAL
	ylvXuVNQyvjAv3l5js0UkficH9FdjxeOewdgah5EzToiwFITNg26HkOCjwVmya6gnZqXGTAfBc06p
	x2Njvb3nY/Bu198yrn+ghg8xudC/Hwra9koDVhfwEuD86YrjVmalUFOFVthLasmRK9ts=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2bAu-001ZbZ-1h;
	Thu, 02 May 2024 20:28:57 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Jiri Slaby <jirislaby@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
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
Subject: [PATCH v3 03/11] tty: serdev: Add flag buffer aware receive_buf_fp()
Date: Thu,  2 May 2024 20:27:56 +0200
Message-Id: <20240502182804.145926-4-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502182804.145926-1-christoph.fritz@hexdev.de>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces an additional receive buffer callback variation
besides the already existing receive_buf(). This new callback function
also passes the flag buffer (TTY_NORMAL, TTY_BREAK, and friends).

If defined, this function gets prioritized and called instead of the
standard receive_buf().

An alternative approach could have been to enhance the receive_buf()
function and update all drivers that use it.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/tty/serdev/serdev-ttyport.c |  2 +-
 include/linux/serdev.h              | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 3d7ae7fa50186..bb47691afdb21 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -32,7 +32,7 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
-	ret = serdev_controller_receive_buf(ctrl, cp, count);
+	ret = serdev_controller_receive_buf(ctrl, cp, fp, count);
 
 	dev_WARN_ONCE(&ctrl->dev, ret > count,
 				"receive_buf returns %zu (count = %zu)\n",
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ff78efc1f60df..c6ef5a8988e07 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -23,11 +23,17 @@ struct serdev_device;
  * struct serdev_device_ops - Callback operations for a serdev device
  * @receive_buf:	Function called with data received from device;
  *			returns number of bytes accepted; may sleep.
+ * @receive_buf_fp:	Function called with data and flag buffer received
+ *			from device; If defined, this function gets called
+ *			instead of @receive_buf;
+ *			returns number of bytes accepted; may sleep.
  * @write_wakeup:	Function called when ready to transmit more data; must
  *			not sleep.
  */
 struct serdev_device_ops {
 	size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);
+	ssize_t (*receive_buf_fp)(struct serdev_device *, const u8 *,
+				  const u8 *, size_t);
 	void (*write_wakeup)(struct serdev_device *);
 };
 
@@ -186,15 +192,20 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
 }
 
 static inline size_t serdev_controller_receive_buf(struct serdev_controller *ctrl,
-						   const u8 *data,
+						   const u8 *data, const u8 *fp,
 						   size_t count)
 {
 	struct serdev_device *serdev = ctrl->serdev;
 
-	if (!serdev || !serdev->ops->receive_buf)
+	if (!serdev || !serdev->ops)
 		return 0;
 
-	return serdev->ops->receive_buf(serdev, data, count);
+	if (serdev->ops->receive_buf_fp)
+		return serdev->ops->receive_buf_fp(serdev, data, fp, count);
+	else if (serdev->ops->receive_buf)
+		return serdev->ops->receive_buf(serdev, data, count);
+
+	return 0;
 }
 
 #if IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
-- 
2.39.2


