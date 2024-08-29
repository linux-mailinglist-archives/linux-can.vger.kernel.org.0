Return-Path: <linux-can+bounces-1216-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00396442F
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA08D1F25A68
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C847B1922F6;
	Thu, 29 Aug 2024 12:16:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBB190052
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933769; cv=none; b=ADKHhqz+4jKCGngXRxJmSF4hedneJ4xizP1E7EWCDo+C0mqODFbNjafJ2zIf08a3OtVQ/v8Ss0hsrH0SRw7FE81uyDAYgnUAd4DLn+midjITZmCO1P8lGOfACR0wDE4hRWzG2zbxv87faDPzza2gCQA6Egb7hYf9k5vrwb9B9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933769; c=relaxed/simple;
	bh=lqcUr4MJm2hvk/EY4v4jvIAhNwjYJ/QQpUPlaqd/X0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kd0FfaxENR/1rtoWG8iDvA1TaoIcQV1sccliEHvYTwiAhQADzvH0JA5b7zj406YZzzCRr0Bss8BKMcmN2fNsaXYQJmTZOVBkzPCtTUBRVMT7SXwGwv0ZnZTYxrEebom0kzaV1wORYeyoJDvoSR1jRWyj6/SjiAiJX6x0jVvfQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvgCG507bz1HHhW;
	Thu, 29 Aug 2024 20:12:42 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (unknown [7.185.36.76])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F6EB1400FD;
	Thu, 29 Aug 2024 20:16:03 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 20:16:03 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: <linux-can@vger.kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Robin van der
 Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next] net: can: j1939: use correct function name in comment
Date: Thu, 29 Aug 2024 20:48:23 +0800
Message-ID: <1724935703-44621-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500006.china.huawei.com (7.185.36.76)

The function j1939_cancel_all_active_sessions() was renamed to
j1939_cancel_active_session() but name in comment wasn't updated.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 net/can/j1939/transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de..319f47d 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1179,10 +1179,10 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		break;
 	case -ENETDOWN:
 		/* In this case we should get a netdev_event(), all active
-		 * sessions will be cleared by
-		 * j1939_cancel_all_active_sessions(). So handle this as an
-		 * error, but let j1939_cancel_all_active_sessions() do the
-		 * cleanup including propagation of the error to user space.
+		 * sessions will be cleared by j1939_cancel_active_session().
+		 * So handle this as an error, but let
+		 * j1939_cancel_active_session() do the cleanup including
+		 * propagation of the error to user space.
 		 */
 		break;
 	case -EOVERFLOW:
-- 
2.9.5


