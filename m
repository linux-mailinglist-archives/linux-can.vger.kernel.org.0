Return-Path: <linux-can+bounces-7370-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id r0X4KzY35GmMSgEAu9opvQ
	(envelope-from <linux-can+bounces-7370-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 04:00:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BDA422DD9
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04EE5300B188
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 02:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3C2727F3;
	Sun, 19 Apr 2026 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="I3PvY/og";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AaOVMGZH"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FD63CB;
	Sun, 19 Apr 2026 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776564019; cv=none; b=CCn+Gyq80RMEKxar2yHuTul3Rs7rre9cath0UqYDFgbG3GXRWO7TIQs/DcVGFXFAgpyeu10aM073m9x81raCr5LvFjLsFRwPkPueJ/fG7B78kBMhn7U4WaSZkGIneuoOA3mI5Dam+znC+vjjD7P7nL8cqjLnV2GX4wijlIuYy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776564019; c=relaxed/simple;
	bh=9PI04kGBc6uuhBljNKSsMKlnOew9+2vCEYDTnyF3vfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VQ3TteAEELntZ8I3qCH6FimhRwhuUpWZZGYTJTo/AySEPvu6qulZmQI3f4Xg2/KmVsYyAWpt4f5GrCByUNaXtDuZvv60Ml8GQFjmqyb2buow8hWbNU6XdrPAg4e8HxK31AUvqWOv6w1OEJjAtmcI2x10BjxAq2UPJM9XLGraHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=I3PvY/og; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AaOVMGZH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56CFD7A013F;
	Sat, 18 Apr 2026 22:00:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 18 Apr 2026 22:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	ethancedwards.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1776564015; x=1776650415; bh=zcoSt4sGkk4hEuSPgPZ9SW6gByCYln4j
	rUh5vDOeI3s=; b=I3PvY/ogtelm+p/oHIoEoQBWbZ3BvaWaDCyB5vltQ8D+pEXk
	AikE0mGpURAPa6fsjFMQTwoCrnCpUSuC42o57U2/sGZkQzQiyc7wz160z+TdOAk7
	LUFZpypiNcM5UgWBgYBOE1KQXHlbBq7KiRrM9LV3PZ+eTFF1aVdTQ95/PIw9/kB+
	MG7Gs1bVKIsZzPFFJ4lRXrVkTigxS5ig0SA1V1aE9foj7XiK6lIqXcT3aKHAPOtj
	EBJaPamwCeC9JUMagQoAOSJ2AHMPOX+jnYFGkjkqaVB69IXYAzXfIbFd0KhtRmAt
	tTWhGibM6LDpncKkYDhazOdDsWCUTBtGEe4rTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776564015; x=1776650415; bh=zcoSt4sGkk4hEuSPgPZ9SW6gByCY
	ln4jrUh5vDOeI3s=; b=AaOVMGZHWK8Xrtu/5nQtAKNYDttpvJZ66HCVAW1wViIR
	kuP2B8v1K5d5G4nHxpj+96QhwZU9fEnMJ+uj+7PApRSTKShZ7YWoR18MkQXQ9ALp
	IoqXEWbHWIcWS6xwOzWKS2qP36Ar10Vm/LPk4oodZaNPJOdSEUc9Ixl9I55nf3cq
	HndL+RWCJ9Al2JoP7HDHgFlG7kp8w+2VLPqOcjPIXbcMAm6EkQRciAXb/qbbisAe
	VvD65UO2c4tKQsM3cAEyUUIzx3CkKv+uuuNsZtrHyk6a8p/pIkBllPZ6vCNbKkdk
	/gi7R3r46b7faCwNmauCl5bxnxQ3l7Uo/t3E1dxMlA==
X-ME-Sender: <xms:LjfkaWMvqOeQS2YqNhBQIdlI1mEoDoMALTvQodVI9ROx40zZifq4yw>
    <xme:LjfkaUAa3NTKutDMeyU4Ig4a0h9hJnCwehxAHd8d26mdmngyGmgei4Tnwe3brakV3
    yX0F34VYCko3ho8fxX6GEfahbvXgNDRTH-LmUe7QEAVzYsv8VSYH7PI>
X-ME-Received: <xmr:LjfkaTdr2aenW2XxdJI33Ty6YgnXcrJVDYMLy-ERv91PSrbZ0Kr1oF02Wn18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepgfhthhgrnhcuvegr
    rhhtvghrucfgugifrghrughsuceovghthhgrnhesvghthhgrnhgtvggufigrrhgushdrtg
    homheqnecuggftrfgrthhtvghrnhepfeevuefgfeffhfdvleejhfetudelledugffgleel
    leelleeihfetieffgfethfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvthhhrghnsegv
    thhhrghntggvugifrghrughsrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtrghnsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgrrhguvghnihhnghesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsohgtkhgvthgtrghnsehhrghrthhkohhpphdr
    nhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvghthhgrnhesvghthhgrnhgtvggufigrrhgush
    drtghomhdprhgtphhtthhopehmkhhlsehpvghnghhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:LjfkaTMug8v7k_2Ubz2P9hh_ZPH5_9vAwRHsYO3yhyxdDgFbWHU1vg>
    <xmx:LjfkaTIMn3t1aOGb4K9hyq4aahvHPmo8NRjAuwMj8q-45OS4u_iU7A>
    <xmx:LjfkaTIbfQI4i6KF_BzbdInpKqbXX-PPG8y9qBHNqhLMi9xIDsKzqw>
    <xmx:Ljfkad7QjmZ5KhDKPasq52n6jbx9S02RcjcImG_f0vfuGAQuB6XJIg>
    <xmx:LzfkaVtHeq82Q0ZmiguwuQolMaU76cfATAACwuojW87r3J4Wh078jPHl>
Feedback-ID: ibf9e487c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 22:00:14 -0400 (EDT)
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 18 Apr 2026 22:00:13 -0400
Subject: [PATCH] can: bcm: Replace strcpy() with strscpy(), simplify call
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-can-bcm-strscpy-v1-1-993eb8de9f77@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIACw35GkC/x3MMQqAMAxA0atIZgOxaBGvIg61Rs1glUZEkd7d4
 viG/19QjsIKXfFC5EtU9pBRlQX41YWFUaZsMGQs1VWL3gUc/YZ6RvXHg411xDUZZy1Bro7Is9z
 /sR9S+gDzvTDNYQAAAA==
X-Change-ID: 20260418-can-bcm-strscpy-56a0e402a660
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=9PI04kGBc6uuhBljNKSsMKlnOew9+2vCEYDTnyF3vfo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpENHgxODJmZXlqcW5ZekZ0N2E0RHFQOVN3TzBwc3VZClorNlp2L25TWDR1R25MNWdE
 YUdPVWhZR01TNEdXVEZGbHY4NXlta1BOV2NvN1B6cjBnUXpoNVVKWkFnREY2Y0EKVE1SaEh5UER
 6eDN0eXlyT0ppMDZJRlhTN25pQmZmM3ZxazJsSEorWnY2dm0xS2N2NWt1d1pQakpXUEt6OVhxVw
 p5UTFHZ1pVVFh5NWY5MWVtdG1mYjI2empVZ3NQT2Z5MUt6Rm1BUUFzdUUxUwo9K0ErdAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ethancedwards.com,none];
	R_DKIM_ALLOW(-0.20)[ethancedwards.com:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ethancedwards.com:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7370-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan@ethancedwards.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethancedwards.com:email,ethancedwards.com:dkim,ethancedwards.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 06BDA422DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

strcpy() is deprecated; use the safer strscpy() instead.

While the src is char array at bcm_proc_getifname's call sites, the src
is passed to the function as a char*. Including the IFNAMSIZ length
makes the call safer.

Use turnary over if/else to simplify code.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 net/can/bcm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..c133dab1202e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -196,10 +196,7 @@ static char *bcm_proc_getifname(struct net *net, char *result, int ifindex)
 
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(net, ifindex);
-	if (dev)
-		strcpy(result, dev->name);
-	else
-		strcpy(result, "???");
+	strscpy(result, dev ? dev->name : "???", IFNAMSIZ);
 	rcu_read_unlock();
 
 	return result;

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260418-can-bcm-strscpy-56a0e402a660

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


