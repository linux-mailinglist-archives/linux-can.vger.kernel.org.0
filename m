Return-Path: <linux-can+bounces-461-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036208AC507
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E401F21B8B
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886051C36;
	Mon, 22 Apr 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="Dogtz1uk"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CE48CE0;
	Mon, 22 Apr 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769951; cv=none; b=mOSHujPR2+1zJS4H35R7Q53S1du2eEFBqpyyuEA1YpuSLqCH4nZ2wYWnGBYC/IehHw90NC/Jff6WSBXsJbICS4xZ4wFFqlVoY6klTV7iwlpnzr1zouSMYEbCh3weGiT7oJbErn2IElNDqHywPd4+/k+KHczmer2WsOAXKbLB0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769951; c=relaxed/simple;
	bh=isr1JPW2xnItXxe3lTO8yPFq3SZLlfun2YSQgB1Fq5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tp3QJdZnWJ1NR3JbkzT+eeXGgai1ZpMtbHbZoU3rKboSFm3h2aVjialqqIHeIrmA6DP9LmPHfKKE5seaE7755j1mntr35lETnjEH25KRykKtDxxzWD4LPCBygbKuhTW/uoQpzQfDZKIAEvdGDmHQw4KOEeCwhu3BJzEzZQYrA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=Dogtz1uk; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=je8idoEl2Aq23Plr6/3Ik3IMq1PPiabZ49izB6tK9ZA=; b=Dogtz1ukfCiSr/aWS2o5J7a9en
	wwm8tOufqbnYTgECO/nyNe5lhLtnTLul2YeTtlyvAYIGBO4u1Ak0wl6Twtji2mMVWCLxZJnRcSNrv
	yl1rFKjPGaPswR1qyo6a7XPCARqkw9gTpqlkA8terQPhSX7Va0YCfdS1cfMlZfvi3r5w=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWr-001JRH-1i;
	Mon, 22 Apr 2024 08:51:53 +0200
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
Subject: [PATCH 11/11] HID: hexLIN: Implement ability to update lin mode
Date: Mon, 22 Apr 2024 08:51:14 +0200
Message-Id: <20240422065114.3185505-12-christoph.fritz@hexdev.de>
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

This patch enhances the hexLIN driver by implementing the newly
introduced update_lin_mode() callback.  So that either commander or
responder mode can be configured on this hardware.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/hid/hid-hexlin.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-hexlin.c b/drivers/hid/hid-hexlin.c
index e1a16d79e3259..4c523e4cdefab 100644
--- a/drivers/hid/hid-hexlin.c
+++ b/drivers/hid/hid-hexlin.c
@@ -171,6 +171,8 @@ HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
 	}
 
 HEXLIN_VAL_CMD(send_break, HEXLIN_SEND_BREAK, hexlin_val8_req, u8)
+HEXLIN_VAL_CMD(set_mode_controller, HEXLIN_SET_MODE_CONTROLLER, hexlin_val8_req,
+	       bool)
 
 static int hexlin_queue_frames_insert(struct hexlin_priv_data *priv,
 				      const u8 *raw_data, int sz)
@@ -312,6 +314,14 @@ static int hexlin_ldo_tx(struct lin_device *ldev,
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
@@ -377,6 +387,7 @@ static int hexlin_update_resp_answer(struct lin_device *ldev,
 
 static const struct lin_device_ops hexlin_ldo = {
 	.ldo_tx = hexlin_ldo_tx,
+	.update_lin_mode = hexlin_update_lin_mode,
 	.update_bitrate = hexlin_update_bitrate,
 	.get_responder_answer = hexlin_get_responder_answer,
 	.update_responder_answer = hexlin_update_resp_answer,
-- 
2.39.2


