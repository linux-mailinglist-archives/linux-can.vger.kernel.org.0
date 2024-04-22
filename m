Return-Path: <linux-can+bounces-462-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4938AC50C
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1492827FE
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521B5029C;
	Mon, 22 Apr 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="JpdmvU/q"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6F50299;
	Mon, 22 Apr 2024 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769957; cv=none; b=ZK8KYb8bU3b2IEg7ukBcIBCh9wmmSR9B1GJy6jZNFcLqgXjLlDxkrlK2VGLh0iQfsM3JNYd8ihOLlIT100oZ2r7FwYs3/rweBlhigbSvZ78A2w0FI1ePiNyQA7AvVzOxk2F562SCZv5rFCZyFH/SaztscPLhSt6y3jAb9IlJi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769957; c=relaxed/simple;
	bh=ZrFdSLcIMeL0Gw5YEaKUCGUEp/+XyImajt9Wq1/xfjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JO/adC4CVLqcK4OV5bqTx7Tpo0oe5IO8pQSu2kc4qCL6qCYqbBbQjvLRWjrs/sEfkR29ugZOMBzuL9NUWgCNbooIDAvdciKWS9k3xP8dfnS/7DOAfM9R7CfX6ER6MluWypwQSTWj47OltksQV+bicuIcbIGE1KBT8INeYbvAlcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=JpdmvU/q; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ekCjuw1duvOWVggYCKKNCs0aIF99UZrHoS1CtHiTWfg=; b=JpdmvU/qd7PgXlY4Q1U7Fpl3Yv
	owu2F6yIZ5qkQVBX9hkPeRKgRnSztdViaAtLFm+gjcVzU4hMUUALRYuIuTLKwfzDq4nE/vx0KHkAz
	yNJCg3oNkp0Ugxjc4B9y1pvZnhu2iFtbvaecM+mDyB0lD0oFf7U/ZsDm8YXfLID3kO3Q=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWj-001JRH-0L;
	Mon, 22 Apr 2024 08:51:45 +0200
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
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 03/11] tty: serdev: Add flag buffer aware receive_buf_fp()
Date: Mon, 22 Apr 2024 08:51:06 +0200
Message-Id: <20240422065114.3185505-4-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
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


