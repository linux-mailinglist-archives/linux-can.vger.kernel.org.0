Return-Path: <linux-can+bounces-620-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C068C13E9
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961072825D0
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C253E00;
	Thu,  9 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="TGoe7vhl"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F33405E6;
	Thu,  9 May 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275183; cv=none; b=InSpsAunapvTFiD+BsfuIj+iX83eiSpZrveewGGXkqAkiJQqK3vh2WRN8rirG45aiUJd39U0LEycNn4Q/b2Vn5WXiRlIg/8eJNBApebhBYOyJcUTDXB0M/PaquWvFVFWqn7FDff45HekomkLxflG6N5oWDl2B8wuYSUrua/IBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275183; c=relaxed/simple;
	bh=ZNBkk0aVxeozKWnZIPacaJBiUOq1SU0PqpXC+vRKIgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTwnAWu12x6cDmBZ5ISiqiubrH+l+1vGe7FvkVjWYNEsbtHWuy70GtZYZ0TlyOOeKkSYk+2frrR/Lt1SMQsicZfk3PE5zwG2DlHIG0cVnwcw8TOgMESLrazP0pJwYJttf/sylKfgUx0f7Jv3Mv0gw7F1xi/dTeXSS5KPY5HHe78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=TGoe7vhl; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LKvHbOOcYtlKi3CDAlSJ+dKoq+VYqd8ks2SkT8czu3Q=; b=TGoe7vhlBbfSOv4krGbNumCiED
	xYLlPDFuyJ/3Ijar13BImQhzlK81zmreOGC4UQPTIREN1MsxzSyem+se5PQwOYhmtInAlshWuI/8T
	xxEEEDAyvCznqnQtn1NyTTfyy9YCvAj4nCSGI1BlyaX/tZ4QADRAA4XV4XV+I5xbb9BM=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QS-001jf8-1W;
	Thu, 09 May 2024 19:19:25 +0200
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
Subject: [PATCH v4 11/11] HID: hexLIN: Implement ability to update lin mode
Date: Thu,  9 May 2024 19:17:36 +0200
Message-Id: <20240509171736.2048414-12-christoph.fritz@hexdev.de>
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

Enhance the hexLIN driver by implementing the newly introduced
update_lin_mode() callback.  So that either commander or responder mode
can be configured on this hardware.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/hid/hid-hexdev-hexlin.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-hexdev-hexlin.c b/drivers/hid/hid-hexdev-hexlin.c
index a9ed080b3e33e..48fcb1e5b6e41 100644
--- a/drivers/hid/hid-hexdev-hexlin.c
+++ b/drivers/hid/hid-hexdev-hexlin.c
@@ -164,6 +164,8 @@ HEXLIN_GET_CMD(get_baudrate, HEXLIN_GET_BAUDRATE)
 	}
 
 HEXLIN_VAL_CMD(send_break, HEXLIN_SEND_BREAK, hexlin_val8_req, u8)
+HEXLIN_VAL_CMD(set_mode_controller, HEXLIN_SET_MODE_CONTROLLER, hexlin_val8_req,
+	       bool)
 
 static int hexlin_send_unconditional(struct hexlin_priv_data *priv,
 				     const struct hexlin_frame *hxf)
@@ -322,6 +324,14 @@ static int hexlin_ldo_tx(struct lin_device *ldev,
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
@@ -393,6 +403,7 @@ static const struct lin_device_ops hexlin_ldo = {
 	.ldo_open = hexlin_open,
 	.ldo_stop = hexlin_stop,
 	.ldo_tx = hexlin_ldo_tx,
+	.update_lin_mode = hexlin_update_lin_mode,
 	.update_bitrate = hexlin_update_bitrate,
 	.get_responder_answer = hexlin_get_responder_answer,
 	.update_responder_answer = hexlin_update_resp_answer,
-- 
2.39.2


