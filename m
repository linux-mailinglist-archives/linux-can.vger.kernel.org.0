Return-Path: <linux-can+bounces-551-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BA8BA087
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55D1281964
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8A19067A;
	Thu,  2 May 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="vnXQ9fsb"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CD181D09;
	Thu,  2 May 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674555; cv=none; b=bzPn42zd5YfjUxMOO7zTihtjomIBYIH/6IBGzAPxILnUsPDI2bv/STPX3B3qxNKJ7fjC20jgyLIu5/xjHQ8vSuTgttA9r+HzdEU7PYKkAGX/yTTTd5JYcYFxETeK01D7iBTl9OqdMq0/N8LJ3a8hli7OcnhXAyTOTphjHWAVGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674555; c=relaxed/simple;
	bh=bMBvt+Lny9gltUtFkgHUIDgYVSPlUfopJMIv+FezAFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQTM49sML4A2tNk9ZE8fj5akA9Jx6toLem/srBG8cIVWwy+OX1OSagh1kMwPJmkuLfm2FTdBdRxH0i6I6wUv4Xh4803pkMV4JriBZvUAivTny+Vs08MpPA59xOq0r1gThDhGFnXaQY5DRJuIQMULqzmMP4l93aoHmpkVxqvW+cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=vnXQ9fsb; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7E5q+Jclu2EnfpQbseAxE8rYQRfjMaRwwerkW79IgBU=; b=vnXQ9fsbyaYSGCfe9LMRKQ1jKF
	V57IwJD8gNhVezB5jBY21dzZu66qDGvTuvdJC9VS4Sg5RPIcDB6n6OYlS2N64+r3YRKbOAWFMdrNk
	lxNacJHg2A1a4wR9VyNIDFHCZab6wt8gL2t6ByYj6vbBeQTCWEbODojN8I/XpwYyvbFw=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2bB3-001ZbZ-33;
	Thu, 02 May 2024 20:29:06 +0200
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
Subject: [PATCH v3 11/11] HID: hexLIN: Implement ability to update lin mode
Date: Thu,  2 May 2024 20:28:04 +0200
Message-Id: <20240502182804.145926-12-christoph.fritz@hexdev.de>
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

This patch enhances the hexLIN driver by implementing the newly
introduced update_lin_mode() callback.  So that either commander or
responder mode can be configured on this hardware.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/hid/hid-hexdev-hexlin.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
index 1ddc1e00ab2da..1723b272138ba 100644
--- a/drivers/hid/hid-hexdev-hexlin.c
+++ b/drivers/hid/hid-hexdev-hexlin.c
@@ -180,6 +180,8 @@ HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
 	}
 
 HEXLIN_VAL_CMD(send_break, HEXLIN_SEND_BREAK, hexlin_val8_req, u8)
+HEXLIN_VAL_CMD(set_mode_controller, HEXLIN_SET_MODE_CONTROLLER, hexlin_val8_req,
+	       bool)
 
 static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
 				      const u8 *raw_data, int sz)
@@ -346,6 +348,14 @@ static int hexlin_ldo_tx(struct lin_device *ldev,
 	return ret;
 }
 
+static int  hexlin_update_lin_mode(struct lin_device *ldev, enum lin_mode lm)
+{
+	struct hid_device *hdev = to_hid_device(ldev->dev);
+	struct hexlin_priv_data *priv = hid_get_drvdata(hdev);
+
+	return hexlin_set_mode_controller(priv, lm == LINBUS_COMMANDER);
+}
+
 static int hexlin_update_bitrate(struct lin_device *ldev, u16 bitrate)
 {
 	struct hid_device *hdev = to_hid_device(ldev->dev);
@@ -417,6 +427,7 @@ static const struct lin_device_ops hexlin_ldo = {
 	.ldo_open = hexlin_open,
 	.ldo_stop = hexlin_stop,
 	.ldo_tx = hexlin_ldo_tx,
+	.update_lin_mode = hexlin_update_lin_mode,
 	.update_bitrate = hexlin_update_bitrate,
 	.get_responder_answer = hexlin_get_responder_answer,
 	.update_responder_answer = hexlin_update_resp_answer,
-- 
2.39.2


