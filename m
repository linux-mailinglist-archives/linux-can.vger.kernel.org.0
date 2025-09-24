Return-Path: <linux-can+bounces-4952-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E450B98D66
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3184C31E7
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B1296BD6;
	Wed, 24 Sep 2025 08:21:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C9288C0E
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702116; cv=none; b=R1ZEXqbSoBtn+tsFzeE/5L0a0daPlfRrLdKv7zvO74pXaCG30LP43ZWy0LhtKso0ykl6XNEwg6qBzQBk0R9fofVy+56HmYBQk+CffvnKXXltAgukPsV2uboV6jrXT0SrkdfeGOio88RQNq6JbGTGcXRXfmYZ8Iopar8dh3shk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702116; c=relaxed/simple;
	bh=jASTsnIK7OTgRD4LiCCD2seVMSpdQs0xI3XkrxGHFZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0FWTw+xkg3SmE4UU2rJrIO2LkLZPUqC9n/k2zSt0HLUHgqCL8gHMY/bSPipAQDrqClzOK/bkgPszYuiMgyiXinj6dK7Qq7VvkaF5PudPrB2GCzxPDx268E5xgl7TicSkeEKE7BaRuGWbZtQXlV7YQ3OoSoMTPdUbMK2qM9Aei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GN-7f; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dwc-1j;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E4F55478866;
	Wed, 24 Sep 2025 08:21:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/48] MAINTAINERS: update Vincent Mailhol's email address
Date: Wed, 24 Sep 2025 10:06:19 +0200
Message-ID: <20250924082104.595459-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Now that I have received my kernel.org account, I am changing my email
address from mailhol.vincent@wanadoo.fr to mailhol@kernel.org. The
wanadoo.fr address was my first email which I created when I was a kid
and has a special meaning to me, but it is restricted to a maximum of
50 messages per hour which starts to be problematic on threads where
many people are CC-ed.

Update all the MAINTAINERS entries accordingly and map the old address
to the new one.

I remain reachable from my old address. The different copyright
notices mentioning my old address are kept as-is for the moment. I
will update those one at a time only if I need to touch those files.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250826105255.35501-2-mailhol@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index aa09e792017f..4a5f2c8deeff 100644
--- a/.mailmap
+++ b/.mailmap
@@ -816,6 +816,7 @@ Veera Sundaram Sankaran <quic_veeras@quicinc.com> <veeras@codeaurora.org>
 Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com> <vbadigan@codeaurora.org>
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com> <vnaralas@codeaurora.org>
 Vikash Garodia <quic_vgarodia@quicinc.com> <vgarodia@codeaurora.org>
+Vincent Mailhol <mailhol@kernel.org> <mailhol.vincent@wanadoo.fr>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index c930a961435e..65c0addba48a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5417,7 +5417,7 @@ F:	net/sched/sch_cake.c
 
 CAN NETWORK DRIVERS
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
-M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+M:	Vincent Mailhol <mailhol@kernel.org>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 W:	https://github.com/linux-can
@@ -9080,7 +9080,7 @@ S:	Odd Fixes
 F:	drivers/net/ethernet/agere/
 
 ETAS ES58X CAN/USB DRIVER
-M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+M:	Vincent Mailhol <mailhol@kernel.org>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/devlink/etas_es58x.rst
-- 
2.51.0


