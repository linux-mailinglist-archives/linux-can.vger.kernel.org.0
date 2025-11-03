Return-Path: <linux-can+bounces-5302-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F18C2A2F5
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 07:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1BB3A7440
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDF292918;
	Mon,  3 Nov 2025 06:29:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31525291C33;
	Mon,  3 Nov 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151350; cv=none; b=YjXXy6ZUmetSgoIkkTUzHLAd2iQMH/PiMwwIUtmTp8ah4shgdqu5bItFXq22pHDfqtQZwQTDiv5BATRDcknkaRPcxYGqEadG3lDiMoE4Hqrva0be7y8FV46Bk/7RCLh9UM3pjK7kns2bJ7JlBGxBQhnnJMOoQSuOJcqyaJUCOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151350; c=relaxed/simple;
	bh=8jVk7in61RXpS246U2Z4bBDD2OdJJ6KiqtiqI6EDdLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXyo+hL3Qv0rUFZV9J4dAA6PLU7bp3HmII6vlW6VoBvIb9G2/KLFp0tl200PjQvkKF1AGYA5NLj0n2eYWALRH1ywEBYVXWPefrExKrZ2Gv1II2rZIXgrUXIhCX6e0gpiWalw1sXwWSaJMFb96eiWUVDUB/nV8zL790YxupSZ2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202511031428596615;
        Mon, 03 Nov 2025 14:28:59 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 14:29:00 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 14:29:00 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDw3fisSwhpm7wJAA--.11974S4;
	Mon, 03 Nov 2025 14:29:00 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <"dario.binacchi@amarulasolutions.commkl@pengutronix.demailhol"@kernel.org>
CC: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH] can: bxcan: Fix a typo error for assign
Date: Mon, 3 Nov 2025 14:27:46 +0800
Message-ID: <20251103062746.4212-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDw3fisSwhpm7wJAA--.11974S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy7JrWrtFyfAF1kAryrWFg_yoWxtwb_Gr
	sYkw42qa4qkr12kw47Ka17ZryYyF4UXFn3WrnaqrWaqF4UAr1Fkrs29r17t3Z8GrW8G3s3
	WwsIyr1Fk34UKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAKzI0EY4vE52x0
	82I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjnNVDUUUU
	U==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?YEPbipRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+Kfazu9iKXuQF24Xl6m1qs5nU+vTWs0UaMZjN3SDVnrRYG49jBlNTzDl+diXDBjRnugDY
	cc5eMvHHNB//UOanGao=
Content-Type: text/plain
tUid: 20251103142859d5068511d85d887aecdaa579b34e7dba
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix the spelling error of "assign".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/can/bxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 0b579e7bb3b6..baf494d20bef 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -227,7 +227,7 @@ static void bxcan_enable_filters(struct bxcan_priv *priv, enum bxcan_cfg cfg)
 	 * mask mode with 32 bits width.
 	 */
 
-	/* Enter filter initialization mode and assing filters to CAN
+	/* Enter filter initialization mode and assign filters to CAN
 	 * controllers.
 	 */
 	regmap_update_bits(priv->gcan, BXCAN_FMR_REG,
-- 
2.43.7


