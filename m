Return-Path: <linux-can+bounces-6253-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBLjIxoTcmksawAAu9opvQ
	(envelope-from <linux-can+bounces-6253-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:07:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF6666AB
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF55A8EA2A8
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60453B8BA3;
	Thu, 22 Jan 2026 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="npJf/hem"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047D3904E5;
	Thu, 22 Jan 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082098; cv=none; b=i6FENIVs4dosASrTdDg4yQX3OwEuHoB3Fbc2y3ymUSO133UWwAmhsc9+JTQdhOhlbZrO0xSW7Cpb+c/bmocIPBcdGZ34waTO6g12q5pRy7MS+BhDaLJlHYFPvPnri3pnHl7aFiXML+47AVBgb7sVJGHbZEnEkLgmISfSgX6B9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082098; c=relaxed/simple;
	bh=lWZMjwKoeq0HFEQlrVHMea6HlTOQteyvPFu7QZOZdvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avoDiooqib5ApjvW9xhmR1yJVzRD7UwbafHYrtIICAHUMbxkz9L1vhUerVljYiPf6Ugw3ek956jzWNgFI86o5UTmowotMnybJDgyidooTn3iGoMUhPzwp5ZNBBRDU2RC+Ey3fFJIybZdLx/TWLfvaycFVmUf9xQ9lPN6+8BbgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=npJf/hem; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 319955f8c;
	Thu, 22 Jan 2026 19:41:30 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: mkl@pengutronix.de
Cc: mailhol@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] can: at91_can: Fix memory leak in at91_can_probe()
Date: Thu, 22 Jan 2026 11:41:28 +0000
Message-Id: <20260122114128.643752-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be582739403a1kunm22a3547a3b13e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx5IVh5KSh1JTk5KGUJJQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=npJf/hemX1thzYxiOB+VAPlxddqldeS6d0ZTBnusab3La1dE18h4F0DDauNmD4aDa6D1NxymlHR0Fy7R9HwE877WiosCGvKZa9wrVTJ3LHzWsi/Y5oXkDqtcQLtf3D6TdYClrDJYNuazgWpAOg4Ksw0xqxD04XxvBzjPk2kZwbg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=I/Dn0vsHTHCdxdOrBVltjyqem4g9MYlrJ05V6/yY8R8=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6253-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Queue-Id: 02AF6666AB
X-Rspamd-Action: no action

In at91_can_probe(), the dev structure is allocated via alloc_candev().
However, if the subsequent call to devm_phy_optional_get() fails, the
code jumps directly to exit_iounmap, missing the call to free_candev().
This results in a memory leak of the allocated net_device structure.

Fix this by jumping to the exit_free label instead, which ensures that
free_candev() is called to properly release the memory.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 3ecc09856afb ("can: at91_can: add CAN transceiver support")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/can/at91_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index c2a3a4eef5b2..58da323f14d7 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1099,7 +1099,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	if (IS_ERR(transceiver)) {
 		err = PTR_ERR(transceiver);
 		dev_err_probe(&pdev->dev, err, "failed to get phy\n");
-		goto exit_iounmap;
+		goto exit_free;
 	}
 
 	dev->netdev_ops	= &at91_netdev_ops;
-- 
2.34.1


