Return-Path: <linux-can+bounces-5303-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D2C2A3B2
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 07:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A318D3B1C00
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4041D416E;
	Mon,  3 Nov 2025 06:51:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6820E702;
	Mon,  3 Nov 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152669; cv=none; b=amfW4HfvddAGBf5MjiO3vPWTNWywD9aYT3VmudK46CBtA4d7CZh30jPHsScMUrewmrTcZjBivRi1cABnkgwpGzHQH+ZOV6bpS+5g/3ggwfARwnD/tF+WZIzp3hwl2BnfAzlm8YjzMKGLGihFFibJdqLVjSHO/UFj7WuWtyOWEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152669; c=relaxed/simple;
	bh=7VM+qiAufbHBKdj/jfxUp+gQD1abUDYAwZcHZtfAHWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SyNV91Jrf/asNfcNapJGnXSxDaCRPgMXjY6QdximoYOTeuI7aH+ghf2rlMtWFWLS3AviQLKtof2o+IDn2+HJLbTwAWcmaJtCCQfMGUtA5aQ0QjQGJH1IbFlKy9z82uCylrtEf+rLfN+BLYWuSLmP7uqaOvtgFf4opKgT0x2jx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202511031450586091;
        Mon, 03 Nov 2025 14:50:58 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 14:50:59 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 14:50:59 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDw3fjRUAhpz74JAA--.11977S4;
	Mon, 03 Nov 2025 14:50:59 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <mkl@pengutronix.de>, <mailhol@kernel.org>
CC: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH] can: janz-ican3: Fix a typo error for DESC_INVALID
Date: Mon, 3 Nov 2025 14:49:34 +0800
Message-ID: <20251103064934.4611-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDw3fjRUAhpz74JAA--.11977S4
X-Coremail-Antispam: 1UD129KBjvJXoWrtr18tw48KFyftr4DGrykKrg_yoW8JrykpF
	45WrWq9F1DAF4rJ3W0qr1rZay5J3WkJFyv93yq9w4kZr1ay3WxGrWUWa4DtF1UZFs5Wr15
	XrWqv3W7WF95Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbVOJ7UUUU
	U==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?j3CWspRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KdFQyiXLhRFzXuW51lpyNb3U+vTWs0UaMZjN3SDVnrRYIC0NwmiUxgZcFrmVIO1Z6v4I
	ftteRGRAzb4AZN7FB5g=
Content-Type: text/plain
tUid: 20251103145058746b320818ec9fba6853085455d35348
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The macro definition DESC_IVALID should be DESC_INVALID, as there is a
spelling error here.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/can/janz-ican3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1efdd1fd8caa..7ae1f4ba4627 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -62,7 +62,7 @@
 #define DESC_VALID		0x80
 #define DESC_WRAP		0x40
 #define DESC_INTERRUPT		0x20
-#define DESC_IVALID		0x10
+#define DESC_INVALID		0x10
 #define DESC_LEN(len)		(len)
 
 /* Janz ICAN3 Firmware Messages */
@@ -1723,11 +1723,11 @@ static netdev_tx_t ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	ican3_put_echo_skb(mod, skb);
 
 	/*
-	 * the programming manual says that you must set the IVALID bit, then
+	 * the programming manual says that you must set the INVALID bit, then
 	 * interrupt, then set the valid bit. Quite weird, but it seems to be
 	 * required for this to work
 	 */
-	desc.control |= DESC_IVALID;
+	desc.control |= DESC_INVALID;
 	memcpy_toio(desc_addr, &desc, sizeof(desc));
 
 	/* generate a MODULbus interrupt to the microcontroller */
-- 
2.43.7


