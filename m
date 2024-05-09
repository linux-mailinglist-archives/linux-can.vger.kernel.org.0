Return-Path: <linux-can+bounces-615-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE218C13D2
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EFAB22148
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D91E29CFD;
	Thu,  9 May 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="u1Q3W2nT"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7210A1D;
	Thu,  9 May 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275177; cv=none; b=CfsxWZnYsw88Jg1q7k8/uIvxzEbJtv+l09gkEZMlZMTnI2hGxzMiz7flVsS4KXvD8FlmJZI3LRCYh0+aDyx+F7Tn7reekFykmW9+PKhWSiIqQENB93BvQgasnk75FBWYSRWtJEQxVDhIE2tkW25IFuUPd7oJQflTplZk/Y25Dyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275177; c=relaxed/simple;
	bh=hbzdar6uDYp8LFv2vP4TCnUrxQbuGY4y4ZeT1MWWx4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EL8ZLOqjdWdOnvoqq1rvji64xGxnIEGcqxjnc0ibhAgl4YAkjPNyIDdx70SnZMdwwy6/Phaw1sgeNXTlKKDBcZzs9JybRHGSpMv6dDmKHpIHrDSE0y6Hy4T0hVAOx4MuEI0jZKx8/Fb8nSskOMFt90IHInso4fjq08eKEk+pOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=u1Q3W2nT; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9vkV9UGg4DGedALEXnhKw20+Zc2Z65ZKqW42pkKLwb8=; b=u1Q3W2nTp/RnaCnXWXZWGC/ZVr
	eM3yHKwPogtbXCKNr1J8BWguVHG8LxEAvtDeIPzSkixLWk1CmHUx+IXZbfvfzv8/iA07R2kl8PN0M
	DnUycRxa0lZc5RoPSuL4bVY2OsUpxrZIOSBAw63a+te9cI3pQngtdD07fDoqKDu/zFok=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QQ-001jf8-0h;
	Thu, 09 May 2024 19:19:22 +0200
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
Subject: [PATCH v4 09/11] can: lin: Handle rx offload config frames
Date: Thu,  9 May 2024 19:17:34 +0200
Message-Id: <20240509171736.2048414-10-christoph.fritz@hexdev.de>
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

The CAN Broadcast Manager now has the capability to dispatch CANFD
frames marked with the id LINBUS_RXOFFLOAD_ID.

Introduce functionality to interpret these specific frames, enabling the
configuration of RX offloading within the LIN driver.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/lin.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
index a22768c17e3f8..f77abd7d7d21c 100644
--- a/drivers/net/can/lin.c
+++ b/drivers/net/can/lin.c
@@ -185,6 +185,27 @@ static const struct attribute_group lin_sysfs_group = {
 	.attrs = lin_sysfs_attrs,
 };
 
+static int lin_setup_rxoffload(struct lin_device *ldev,
+			       struct canfd_frame *cfd)
+{
+	struct lin_responder_answer answ;
+
+	if (!(cfd->flags & CANFD_FDF))
+		return -EINVAL;
+
+	BUILD_BUG_ON(sizeof(answ) > sizeof(cfd->data));
+	memcpy(&answ, cfd->data, sizeof(answ));
+
+	answ.lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
+			LINBUS_ENHANCED : LINBUS_CLASSIC;
+
+	if (answ.lf.lin_id > LIN_ID_MASK ||
+	    answ.event_associated_id > LIN_ID_MASK)
+		return -EINVAL;
+
+	return ldev->ldev_ops->update_responder_answer(ldev, &answ);
+}
+
 static void lin_tx_work_handler(struct work_struct *ws)
 {
 	struct lin_device *ldev = container_of(ws, struct lin_device,
@@ -197,6 +218,14 @@ static void lin_tx_work_handler(struct work_struct *ws)
 	ldev->tx_busy = true;
 
 	cfd = (struct canfd_frame *)ldev->tx_skb->data;
+
+	if (cfd->can_id & LIN_RXOFFLOAD_DATA_FLAG) {
+		ret = lin_setup_rxoffload(ldev, cfd);
+		if (ret < 0)
+			netdev_err(ndev, "setting up rx failed %d\n", ret);
+		goto lin_tx_out;
+	}
+
 	lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
 			   LINBUS_ENHANCED : LINBUS_CLASSIC;
 	lf.lin_id = cfd->can_id & LIN_ID_MASK;
-- 
2.39.2


