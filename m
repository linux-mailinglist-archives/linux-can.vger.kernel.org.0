Return-Path: <linux-can+bounces-7895-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qhl0KK6/PGocrQgAu9opvQ
	(envelope-from <linux-can+bounces-7895-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 07:42:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE56C2D20
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 07:42:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7895-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7895-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D991302BA75
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 05:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0152D876A;
	Thu, 25 Jun 2026 05:42:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B22750E6;
	Thu, 25 Jun 2026 05:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366120; cv=none; b=YAz5dKRE6oNhir+vCWg4MeVOhvcVkPtG2+Oc153W7sgb8vjuvGo/XaHxVH500s0MI30+mQvuxa2SA9exLxmn+jV5Kx8cBW3DlujQCK/nbsgyvx8BKwzpDNsJdHC9MFZX5tUCfW7X4BmGqfQGc7RhYP/fZssBV1JJz7r++HYbsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366120; c=relaxed/simple;
	bh=xhQWUSV8bRj449s/C2U7QBHZOKxGOeQJeq0nB3HB2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro4gGuPpMHiSFN55qGjTwVlpquzLN36RlHIf9sXUoq0+JNermwqmIa7W8267kebAyarjNKRe1nIuXEB1NZGzSgnrca9pC+kQgOm5RcbxRx8T2ONUSEDgx+5DIvdto+Q0zYsCdzxDLsiuAqGppPb1pRez7/rt/oa9RwwAkMECEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhGivzxqToUnFQ--.8562S2;
	Thu, 25 Jun 2026 13:41:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rob Herring <robh@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] can: c_can: Use platform id data when OF data is absent
Date: Thu, 25 Jun 2026 13:41:52 +0800
Message-ID: <20260625054152.68413-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhGivzxqToUnFQ--.8562S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aryfuw4xAFW5Jw15Gw1Dtrb_yoW8WFW8p3
	yUZFWSkr18Wr4jkw17G3W8ZFy3ua1ay3y7Kryj9a1ru3s3Wr1DXry8WFyxZFsrta98G3Wa
	qF4qqr93uFZ8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73P
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7895-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:pengpeng@iscas.ac.cn,m:robh@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12AE56C2D20

The platform driver keeps controller metadata in both the OF match table
and the platform id table. Probe reads the metadata with
device_get_match_data(), which does not fall back to platform id-table
driver_data.

When the device is matched through the platform id table, drvdata can
therefore be NULL before it is dereferenced for msg_obj_num and the
controller type. Fall back to platform_get_device_id() when firmware
match data is not available.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes in v2:
- Add the Fixes tag requested by Vincent.
- Scope the platform id variable inside the fallback block.
- Carry Vincent's Reviewed-by for the requested v2 shape.

 drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 19c86b94a40e..8a0c88839d24 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -267,6 +267,14 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 
 	drvdata = device_get_match_data(&pdev->dev);
+	if (!drvdata) {
+		const struct platform_device_id *id;
+
+		id = platform_get_device_id(pdev);
+		if (!id)
+			return -ENODEV;
+		drvdata = (const struct c_can_driver_data *)id->driver_data;
+	}
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.50.1


