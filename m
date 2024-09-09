Return-Path: <linux-can+bounces-1450-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13F971C8B
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA301C22707
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2471BA883;
	Mon,  9 Sep 2024 14:29:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20267146D75
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892193; cv=none; b=VhyXrXrCRCe8wxKjtZjePcyxbBLhtuPdxK0mmYf1m0kVC4u+OBuCSeC96MpETzY2kw6q2ASSXzzkg3hcAjwecVEnRlVdjPJAKWtiwobtoeunri9RA+f1f8zH3lXrMrXsSBbiIGd31C1Z76jhgyYn0R8UOUXe9XzCcI+i04iI2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892193; c=relaxed/simple;
	bh=fnuxskNVBbwCBy3d4j1pvS+K39JeOMdEJlru22mlufM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MzjjTWydO5OPm1oA2Ean61oMJX1TXGdEtjo+qFUOMk2xKw+6iFwljPwb5kaXLqeh/ObEbYmy8tMOe3XsQewXwfERvT7ublqTjHQdR/7WY9tqav/bG7JCMq1xNKnfzPIa+ul+GDgtOHOBa224di1rHkyxOLglsryOZ5kWYf3thyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snfOm-00026t-Ff
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 16:29:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snfOm-006g3K-04
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 16:29:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A888E336B30
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 14:29:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EB4E8336B0F;
	Mon, 09 Sep 2024 14:29:44 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8ec233f4;
	Mon, 9 Sep 2024 14:29:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can v2 0/2] can: m_can: fix struct
 net_device_ops::{open,stop} callbacks under high bus load
Date: Mon, 09 Sep 2024 16:29:34 +0200
Message-Id: <20240909-can-m_can-fix-ifup-v2-0-2b35e624a089@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8G32YC/1WMTQuCMBzGv0r8z022ubR1ypjehOgaEWPOHLVNp
 kYgfveWty4P/J63GQYdjB7gsJkh6LcZjHcR6HYDqpPuoZFpIgPFlGGOOVLSIXv/aWs+yLRTj/I
 cpzhTkkklIQ77oGO2nl4hNuEWzTZ4i8YuaLn+iXp/vhBWn3aUEsGFSIu8oiTFZUUyUlR5WfGSH
 v9qiZO2Dw1hSR98k/hpfHn/TJS3sCxfPC2qKMoAAAA=
X-Change-ID: 20240909-can-m_can-fix-ifup-770306ca4aca
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=fnuxskNVBbwCBy3d4j1pvS+K39JeOMdEJlru22mlufM=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm3wZQT6oe7UnBnmkctE95HAGMkQ2uGwT7zqGp0
 uZM1YLV/YiJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZt8GUAAKCRAoOKI+ei28
 b+aPB/4+N4ZznWRrDyOiNy44MUGyOXvRza3Yw2S+Ls+S2/uBovO0Eb5z/oB7bLTuMFEnlEVZTSe
 Zfis4lEm2JTMxG4yfsOm04pUuHP3hc3NEXrzYn8dtKN3ICkR0ZTtGilIIfqvbeyKd1q1COd/zB+
 Hi6jLOaNA3e5w/VQ5s0eu2NxvNc5UFkeHo2t+nv+okCkKKc8Q1F2ky97gjiUM3lfr/zLK+vIrYX
 +N+tzNNbXCj74Ou1svJi3JLftlrZPkQ4qJKxv3eb8cNjz25FE9sPN+KMK/BNEhul868M8S6duJC
 qgby1DRV1JNjk+v4JDaVTLNAbjB7E3NUJwPdDpcoKfWnKbod
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Under high CAN-bus load the struct net_device_ops::{open,stop}
callbacks (m_can_open(), m_can_close()) don't properly start and
shutdown the device.

Fix the problems by re-arranging the order of functions in
m_can_open() and m_can_close().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I've taken Jake's patch and split the timestamp wraparound changes
into separate patch. For now, I've added a Not-Signed-off-by, until
Jake gives the S-o-b.

regards,
Marc

Changes in v2:
- 1/1 split timestamp wraparound changes into separate patch
- 1/1 added "Not-Signed-off-by: Hamby, Jake (US) <Jake.Hamby@Teledyne.com>"
- 2/2 new patch: fix order of clock shutdown
- Link to v1: https://patch.msgid.link/DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com

---
Hamby, Jake (US) (1):
      can: m_can: enable NAPI before enabling interrupts

Marc Kleine-Budde (1):
      can: m_can: m_can_close(): stop clocks after device has been shut down

 drivers/net/can/m_can/m_can.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
---
base-commit: d759ee240d3c0c4a19f4d984eb21c36da76bc6ce
change-id: 20240909-can-m_can-fix-ifup-770306ca4aca

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



