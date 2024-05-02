Return-Path: <linux-can+bounces-548-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A498BA078
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8743DB21DA4
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B90181BAB;
	Thu,  2 May 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="xXJPPhle"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D5181324;
	Thu,  2 May 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674552; cv=none; b=imSZGKlGkFe9fvTaaJBRB2wQHa94dso0Wus7I6Qzs288DfLPJG0deQXr1nVr7uQJoC/AZS8i/JE1ePxs1Ynyn2sk9Fe2ykDahQJxjlg5tvT3uYrceCZSSMiNxzwj/KCHA2OwJPLHUReUkmt9TZoCHdD0buncPyb9q4TpLd688iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674552; c=relaxed/simple;
	bh=GSulo82rKnPvXyP3RQsoy6rgLW6KWucKAnbWqMbp1f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLvqwDEM1Qq3cGu33BMy08vI2Zi10dpGAdRfR+ca2heXhscierR8OCUBXcKH/oBR399IcHZWq5sKcM0F8OWN4ECidW0RIMWQA/qHyJ9fEiIjZMD0bwThxRgta0HM/5Y5eSMs9EZsMC7vhFFmKqOffukKPOqCD9BQj2TFSO56Pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=xXJPPhle; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v2goQZydtQiYmy2+LR80/ACY6cQ1Zev0nahvSPqVvHU=; b=xXJPPhlekkQAaOgnvax3yUoGul
	ixvrneTkzjbiJK5kbt/4hl5HrMv3QfQs9vWRWqT0obnK5lonXY84ZyFOnrFsni1WA9lxbu9VUDXzO
	L+Q9M9+RmgXiEL49O2QI+XocmS1rt+AHdHDAWYWStRL7p2i10CBUnbnBG/Wa05obG750=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2bB1-001ZbZ-1l;
	Thu, 02 May 2024 20:29:04 +0200
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
Subject: [PATCH v3 09/11] can: lin: Handle rx offload config frames
Date: Thu,  2 May 2024 20:28:02 +0200
Message-Id: <20240502182804.145926-10-christoph.fritz@hexdev.de>
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


