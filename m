Return-Path: <linux-can+bounces-460-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD58AC501
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BC21F2216F
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8E5102B;
	Mon, 22 Apr 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="bJi0uusC"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C16487BE;
	Mon, 22 Apr 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769946; cv=none; b=CFobBtJ+GZpH5+CYzWqX3lD9kIgcYVC4ceYG0O4i0LGXxeaDfbj/8YpxcYZVKEisz7LEx2f6KpbwW/FCSDU9J/w8DdsLmoEuh26BapcFakAELWCCAhfRv7fLZ+5eo3WKgfjFqf7Jqt5C4SAwb1QPKEPs86PzG556CYOYEdJw3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769946; c=relaxed/simple;
	bh=CTIrEa2rmGwqVNpfbry2rBHxc3B2ib4sFmkFx9XDrAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2opxCggaug5qkvZWjMwoJ3zCDyCJXdCev0ksJVQzYtFxTTBKSA+v2ecUZ4qKxh5eoLBVsb8nhLWRp5Uit+r9IGz0xqvOBnb+BiIOyHbEHjlw+lklWxm9mH+5H7WP+KpJwcoRi4p7CjBIJztTIcWYIm3WElMppaW8Hsy62P85eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=bJi0uusC; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8clKTwDXSLEjCrNz3ZWsEXXoYtAWWeGjOsCM1EwODUc=; b=bJi0uusC3FaLSBrscCWDlzp6QG
	M0KRp3Xuid92xasazyJJdhDazfsFBZceEYxXSAbPNBR15SEalGj0DHPY1xv63mEUdKdBmlztBDoVo
	AjKzqs6VhZZ9wtsioyH5OltS1hbavvvrvVCJ4bb1s/8UWdvdmpEqRZlcK6maVFPH12zY=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWp-001JRH-1M;
	Mon, 22 Apr 2024 08:51:51 +0200
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
Subject: [PATCH 09/11] can: lin: Handle rx offload config frames
Date: Mon, 22 Apr 2024 08:51:12 +0200
Message-Id: <20240422065114.3185505-10-christoph.fritz@hexdev.de>
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

The CAN Broadcast Manager now has the capability to dispatch CANFD
frames marked with the id LINBUS_RXOFFLOAD_ID. This patch introduces
functionality to interpret these specific frames, enabling the
configuration of RX offloading within the LIN driver.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/net/can/lin.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
index a9b5d76708879..56492952c8588 100644
--- a/drivers/net/can/lin.c
+++ b/drivers/net/can/lin.c
@@ -177,6 +177,27 @@ static void lin_remove_sysfs_id_files(struct net_device *ndev)
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
@@ -184,10 +205,19 @@ static void lin_tx_work_handler(struct work_struct *ws)
 	struct net_device *ndev = ldev->ndev;
 	struct canfd_frame *cfd;
 	struct lin_frame lf;
+	int ret;
 
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
 	lf.lin_id = (u8)(cfd->can_id & LIN_ID_MASK);
@@ -203,6 +233,8 @@ static void lin_tx_work_handler(struct work_struct *ws)
 
 	DEV_STATS_INC(ndev, tx_packets);
 	DEV_STATS_ADD(ndev, tx_bytes, lf.len);
+
+lin_tx_out:
 	ldev->tx_busy = false;
 	netif_wake_queue(ndev);
 }
-- 
2.39.2


