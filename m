Return-Path: <linux-can+bounces-1582-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F998AB9A
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EC31C20EB0
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA3199252;
	Mon, 30 Sep 2024 18:03:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5520192D97
	for <linux-can@vger.kernel.org>; Mon, 30 Sep 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719436; cv=none; b=dOuRgvaymU6MPYV2ZjHHQBTSSkmYjS5Q1lUTX99GrYrEtzz1s8F43+te1FOfKKoITyy4WhAaNQvA1YGCgtgpp73L/qy82xrZJhCSIlcYDPRoYlv13S0nxQiX92L8GfNdmvOme1MMfHFzAnjkGQMuJEoPTbzliDoBN1TJqBQ7tDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719436; c=relaxed/simple;
	bh=bHrj5XU1WNzRAcUZhM6zhztuPGa/+td5l0FMRUYbbrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LN4V1xTbQtitsc0kpew9/Ejj1TKTVB16WyEbBwiWi09SHysYETGoFZD2zTSG+X7RY/WA/jvK/H+8k9HEln5r/RiN4qSGPJnR3hyKUQ2g0aHu4KX6xLNUYUDvk817HxHnNbIRditLhC/AfXjkjYoryCQfQewMdIZMmXhFhkIMbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svKkS-0000Fg-9f
	for linux-can@vger.kernel.org; Mon, 30 Sep 2024 20:03:52 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svKkR-002gbE-Sq
	for linux-can@vger.kernel.org; Mon, 30 Sep 2024 20:03:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8C35F346EEB
	for <linux-can@vger.kernel.org>; Mon, 30 Sep 2024 18:03:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6D796346EE2;
	Mon, 30 Sep 2024 18:03:49 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ba283306;
	Mon, 30 Sep 2024 18:03:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 30 Sep 2024 20:03:46 +0200
Subject: [PATCH can-next] can: mcan: m_can_open(): simplify condition to
 call free_irq()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-m_can-simplify-v1-1-43312571c028@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAHo+mYC/x2M7QpAMBRAX0X3t9X1uXgVScwdtxhtEi3vbvw8d
 c7x4MgyOagjD5ZOdryZAEkcgZp7M5HgMTCkmOZYZSjWTvVGOF73hfUtdIGyRCkLnQ0Qot2S5us
 fNvCZhq4D2ud5AUj4UShqAAAA
X-Change-ID: 20240930-m_can-simplify-f50760775f3b
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=bHrj5XU1WNzRAcUZhM6zhztuPGa/+td5l0FMRUYbbrg=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm+ugCHKCkPGOqDDsaOfFGV/0XKrT13Nx/vade6
 GF/kd5k2umJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZvroAgAKCRAoOKI+ei28
 b8ykB/9BzThpl4+t7d0D6bw9vO4GHbbbxC8najj8MZm/ds8yS1e9clrD98uoi1jpoDQoRw1przq
 NKqDJU4nArMumTxcWR59gPiDz5FV4zKNcfXNspwRu9WHLIdn6QYanjkiXS4An0jqo4MRN/aLrnw
 00PYP/gI0EUqh94uBxKRXjszUICRFti9z4bs7zny1rYZb/qgtyrBMQTFKgy5Es3zMD1AGTVi7m+
 T7oG9OJ/lMAtZM4tLP+1xo71R4OE7iR3kueUMnQ8JaSxnapa5sKuBMqBSp41K8YRzSeq561N2eQ
 0napL+AgSu5z0SbiTQhU5P3q6uDdj/2K2KLqY5oY5W+LVJuT
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The condition to call free_irq() in the error cleanup path of
m_can_open() can be simplified. The "is_peripheral" case also has a
"dev->irq != 0".

Simplify the condition, call free_irq() if "dev->irq != 0", i.e. the
device has an interrupt.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1e1e8273216ff330ab789d0fd6d51..66a8673e51eab8c901434de16c640045f7d0dd70 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2070,7 +2070,7 @@ static int m_can_open(struct net_device *dev)
 	return 0;
 
 exit_start_fail:
-	if (cdev->is_peripheral || dev->irq)
+	if (dev->irq)
 		free_irq(dev->irq, dev);
 exit_irq_fail:
 	if (cdev->is_peripheral)

---
base-commit: c824deb1a89755f70156b5cdaf569fca80698719
change-id: 20240930-m_can-simplify-f50760775f3b

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



