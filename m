Return-Path: <linux-can+bounces-804-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469BA911E02
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C5928244F
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A09170857;
	Fri, 21 Jun 2024 08:02:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DF170838
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956930; cv=none; b=QWtc7hoJ5rfNzvyau/5k/2W8L3ZiYipCHSWep0Pu7sdY0Aq9ndldiRkAOHYBIV23xrWgd2y7jXM9gKxqi7lgzp2pqCfwpiymDh4t//Ryre2bZFbHKeKpZ+ERLcLmetDfWN8qiuQIvM+wiLIzrcWb6rpO1GXGyB8vSbW5f4ZZKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956930; c=relaxed/simple;
	bh=QPfEkGkwIiToZu9ptGVvf63ZO+1iJZuAvE2NyaUDdhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOWj+odR7lvaaO8Huc836x8Z+oUKuEwPnca6YkG1qS6JOmd0za2/XRJXmJUC+CVUt/oIY/SrOfHqa4O1pPIbb3uIC67CptU5zDrtZXvXcds9lU0miBDms1A4SaeqJvhXQ6xavWhyCQq5Vz0fzPhI1ZJcHVSS47ecsken4rlkbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDh-0003xF-Cy
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDg-003tG8-JI
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 48F702EE3BF
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D05402EE390;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8e9c3dd6;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Mans Rullgard <mans@mansr.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/24] can: Kconfig: remove obsolete help text for slcan
Date: Fri, 21 Jun 2024 09:48:23 +0200
Message-ID: <20240621080201.305471-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: Mans Rullgard <mans@mansr.com>

Commit cfcb4465e992 ("can: slcan: remove legacy infrastructure")
removed the 10-device limit.  Update the Kconfig help text accordingly.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240427152648.25434-1-mans@mansr.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 2e31db55d927..7f9b60a42d29 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -187,9 +187,8 @@ config CAN_SLCAN
 	  slcand) can be found in the can-utils at the linux-can project, see
 	  https://github.com/linux-can/can-utils for details.
 
-	  The slcan driver supports up to 10 CAN netdevices by default which
-	  can be changed by the 'maxdev=xx' module option. This driver can
-	  also be built as a module. If so, the module will be called slcan.
+	  This driver can also be built as a module. If so, the module
+	  will be called slcan.
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-- 
2.43.0



