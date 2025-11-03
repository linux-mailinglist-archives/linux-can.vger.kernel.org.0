Return-Path: <linux-can+bounces-5304-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4CC2A620
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 08:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB03AB7DE
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996C2C027C;
	Mon,  3 Nov 2025 07:42:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BF232395;
	Mon,  3 Nov 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155725; cv=none; b=fQrYeVPAlxb8hwMj5QcRKsaDqS+nIcoyOiJnHCC1EzoNqnVG71fVrU6uX1Nm5trSbCWLWSjD5kuQO6GLV8QGB1kenziBfF1xftu7CmckfUUXEwqAVTAh1RKOo3sppbOLsxkUYxwSd2JWOad3/NS9/pUwGROios0UYwtONyJ2VY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155725; c=relaxed/simple;
	bh=8jVk7in61RXpS246U2Z4bBDD2OdJJ6KiqtiqI6EDdLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ALxwcwhb4o+n1s3ywlCQe0KjKss34vCVS8nZcZtGC6uVUPGwna+cuJlNuM2AFHkmLVA5U+2qYPyMB/bV7KSleYJXp+4ppFAuPjRRH+ECSJ14QgCR0L5/k0l+58Eljp9Aui1aQbxCBcYSXfNO4qnsoe2nWHfaV8Oz/PE+6wTFkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202511031541519835;
        Mon, 03 Nov 2025 15:41:51 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 15:41:52 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 15:41:52 +0800
Received: from localhost.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDwEPm+XAhpt8MJAA--.13981S4;
	Mon, 03 Nov 2025 15:41:52 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
	<mailhol@kernel.org>
CC: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH] can: bxcan: Fix a typo error for assign
Date: Mon, 3 Nov 2025 15:40:09 +0800
Message-ID: <20251103074009.4708-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDwEPm+XAhpt8MJAA--.13981S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy7JrWrtFyfAF1kAryrWFg_yoWxtwb_Gr
	sYkw42qa4qkr12kw47Ka17ZryYyF4UXFn3WrnaqrWaqF4UAr1Fkrs29r17t3Z8GrW8G3s3
	WwsIyr1Fk34UKjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUU
	U==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?2wxDSZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KXEmPGh6ji6U83mB7njQLXcQ/51zyjXsDLAUWvI3FwgIcOVfIRTp3KBrfCkATJcLCgwx
	0O7vqPzoo6RFZjxdDsk=
Content-Type: text/plain
tUid: 202511031541514f60e46379bf04c2a9b023f060d66907
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


