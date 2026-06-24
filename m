Return-Path: <linux-can+bounces-7890-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tBVhCQlwO2pgXwgAu9opvQ
	(envelope-from <linux-can+bounces-7890-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 07:50:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498A6BB94C
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 07:50:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7890-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7890-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04783036614
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 05:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E07324B1E;
	Wed, 24 Jun 2026 05:49:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F633242CA;
	Wed, 24 Jun 2026 05:49:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280176; cv=none; b=U/DLiTRwUm1dvaVkOsYnRvITgwbu3Ijlt2mcMoMgKRh4K9UnYFbAl2gXhQ1nNlZvWfy1DS9PnzS4UyTStZeRM7AHdlCK3ktlv85YFt4UMZxGS/wgeEw5oXC05DAUzTpR6e/mbGhv72Z5treRypk0ltfNMqfgDGZFJSPwFRsDe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280176; c=relaxed/simple;
	bh=TDhK/eBP0YNhZA8cfkNoeq2nrBGULXAD7jgm2yOnMOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KopKucr3vlZZdTVNXhrgTtTcPwfAitQkotZOG0fD/1pYbfQNuhKmlbiq3B0vP0JT94hVfvYKX2NpUS0umHPwpsUuR/zErkCNH3tE/9Nk3cY9KC0UUIj+ZirpKk5ekzlSiD54poNVqhHG5degSq8dCAIWnJ+Fg+QW0ClvcbRMenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAH5pznbztqHQatFQ--.22990S2;
	Wed, 24 Jun 2026 13:49:27 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: c_can: Use platform id data when OF data is absent
Date: Wed, 24 Jun 2026 13:49:27 +0800
Message-ID: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAH5pznbztqHQatFQ--.22990S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aryfuw4xAFW5Jw15Gw1Dtrb_yoW8GFW8pa
	yUZFWSkr1UWr4Y9w17J3WUZFy3u3WFya17KryUua1fu3s3Wr98Xry8WFyIyFsrtFW5G3Wa
	qF4jyry8uFs8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-PUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:pengpeng@iscas.ac.cn,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7890-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6498A6BB94C

The platform driver keeps controller metadata in both the OF match table
and the platform id table.  Probe reads the metadata with
device_get_match_data(), which does not fall back to platform id-table
driver_data.

When the device is matched through the platform id table, drvdata can
therefore be NULL before it is dereferenced for msg_obj_num and the
controller type.  Fall back to platform_get_device_id() when firmware
match data is not available.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 19c86b94a40e..564c9e5b4c2c 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -263,9 +263,17 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	int irq;
 	struct clk *clk;
 	const struct c_can_driver_data *drvdata;
+	const struct platform_device_id *id;
 	struct device_node *np = pdev->dev.of_node;
 
 	drvdata = device_get_match_data(&pdev->dev);
+	if (!drvdata) {
+		id = platform_get_device_id(pdev);
+		if (!id)
+			return -ENODEV;
+
+		drvdata = (const struct c_can_driver_data *)id->driver_data;
+	}
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.50.1 (Apple Git-155)


