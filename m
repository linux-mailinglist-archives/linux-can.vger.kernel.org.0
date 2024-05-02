Return-Path: <linux-can+bounces-525-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBE88B95E5
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29E628115C
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C450A75;
	Thu,  2 May 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="aji8x1hI"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968224205;
	Thu,  2 May 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636612; cv=none; b=aDziSAhc/6WKUbs+kV+y5mXjVjIPyVL+mJWYCHC/V6l166QTxBlzWaUhFmEdaWvXDj39X+wIgmpvRoBxAkW4nL8xFOaJpcWkljxqAJAUJO7d8lKxDerxFUTZi3XhKvgvclhvhRhbeNuTotuAnHotDpfhu3cBnrDA8pieeDqPcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636612; c=relaxed/simple;
	bh=GSulo82rKnPvXyP3RQsoy6rgLW6KWucKAnbWqMbp1f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJ/Fp2gCSb688oG7GmxHwrnP4C2zk7VNXPPPjkV3oJumf78AUAf3uQLr3DAHDrHlQJfy/dCiX9qly50h6Od672m45jJgApS5DUSB+vY7KwQjq5znECm/PQHc4heY5BLzlscyg5XeVs0Hi9ryo2DvUoVmAKAmmidfw8FNT6TvnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=aji8x1hI; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v2goQZydtQiYmy2+LR80/ACY6cQ1Zev0nahvSPqVvHU=; b=aji8x1hI8HOI2IoWVdBiQhMo/Z
	vUus8nS7OJlbv5qhBYJFerWfMToP/RJwQ4EOl1qlzQMk3R9wZpjC4Imm3crpOMuobA6rWcVZcMtmR
	rVMhFwUvLkJhG3eQSrN0g/Juu9BfzUqd6JkgD/tPW6znbJSs+USg2bsq7BV3FoEJsnME=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RJ5-001Yg7-2I;
	Thu, 02 May 2024 09:56:44 +0200
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
Subject: [PATCH v2 10/12] can: lin: Handle rx offload config frames
Date: Thu,  2 May 2024 09:55:32 +0200
Message-Id: <20240502075534.882628-11-christoph.fritz@hexdev.de>
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

The CAN Broadcast Manager now has the capability to dispatch CANFD
frames marked with the id LINBUS_RXOFFLOAD_ID. This patch introduces
functionality to interpret these specific frames, enabling the
configuration of RX offloading within the LIN driver.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/lin.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
index 95906003666fb..ee2ebea2c865f 100644
--- a/drivers/net/can/lin.c
+++ b/drivers/net/can/lin.c
@@ -194,6 +194,27 @@ static void lin_remove_sysfs_id_files(struct net_device *ndev)
 	}
 }
 
+static int lin_setup_rxoffload(struct lin_device *ldev,
+			       struct canfd_frame *cfd)
+{
+	struct lin_responder_answer answ;
+
+	if (!(cfd->flags & CANFD_FDF))
+		return -EMSGSIZE;
+
+	BUILD_BUG_ON(sizeof(struct lin_responder_answer) > sizeof(cfd->data));
+	memcpy(&answ, cfd->data, sizeof(struct lin_responder_answer));
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
@@ -206,6 +227,14 @@ static void lin_tx_work_handler(struct work_struct *ws)
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


