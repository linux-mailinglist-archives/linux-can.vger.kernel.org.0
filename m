Return-Path: <linux-can+bounces-6295-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJGdOHgJdmnKKwEAu9opvQ
	(envelope-from <linux-can+bounces-6295-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 13:15:52 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA698078E
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 13:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FC99300425F
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CF22756A;
	Sun, 25 Jan 2026 12:15:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600458834;
	Sun, 25 Jan 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343349; cv=none; b=bnJMKWnA4ELPkg5SuTpL/C2jWzvRge0U5/a392VaP/4DNlA5uL96Rwk/zdW9TkbG1AA7idzD0xnp/0NTRsfKRar+BRgyGLBpOeW2JOaenpPYIy9zUVny9BoVsu12AQAsZi4gt7Bq3faIW81onQxpB5qxcJyBS+0nu75pLqjqKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343349; c=relaxed/simple;
	bh=6Mm5+tV/nMuur0bLKcTbkNA0cTam9M2K3LtP1Ujsdnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o0Sc+VzGw6wirEmZ4NPiP+N5V5A4pNEZqdAyhnxnJ6gJKqM1ZU7165gUCr2HlSTeWbIajQILWBgvttecAO2SlDc2+TDjLBng1+I728mpRo8rzlzwnys8KeLbd+4e0RwIRTrElqrhjHQLrLKN/ReaJB6jxXvHTV7rLWNsWxU3E+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowAB3424NCHZp+PIqBg--.53936S2;
	Sun, 25 Jan 2026 20:09:49 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] can: at91_can: fix an error handle in at91_can_probe()
Date: Sun, 25 Jan 2026 20:09:47 +0800
Message-Id: <20260125120947.1997682-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3424NCHZp+PIqBg--.53936S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw18tr15AryfCF15GrWruFg_yoWfWwb_Ka
	1IyFZ2vFWUKrn093WrurZIyFyakFyUZF1kWFyqg3yagrW3Aw18XrWFvFn3Wr1DWrs2kr15
	Kw12vF18u34S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAcRE2l038QMtAABs2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-can];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.991];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6295-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,isrc.iscas.ac.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EA698078E
X-Rspamd-Action: no action

In at91_can_probe(), if devm_phy_optional_get() fails,
the memory allocated by alloc_candev() should be freed.
Modify the goto label to do so.

Fixes: 3ecc09856afb ("can: at91_can: add CAN transceiver support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
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
2.25.1


