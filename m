Return-Path: <linux-can+bounces-5064-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7784BABB53
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 08:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710ED162817
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F026FA53;
	Tue, 30 Sep 2025 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="Wwm3h4TL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9kq53Fg"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343427E1B1;
	Tue, 30 Sep 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215228; cv=none; b=ILYCN4Jj0xmlv5+MpDOkRG8HdgWhhOd2POPb+snRHNvNKtYJCDSkZ6Szqyel85aQFCJ9REH1kZjQ2NxQtiLwRp4bXtKMz+X+SHT//YoRADkdcZ5SS9ApmVN4Sq0W05t30PfygZF0pOz22W41FA7jaOISs2bmA+HuMBZ+8DcgKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215228; c=relaxed/simple;
	bh=USG8lenE4OmXYzm1tUnfdT2zeBwOkzOgEoVpjZDEcHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KcM3IkpvsIcXQtsRYlBx40gON5TyFoj9TEC88WnNdTn1t74q7TD66BaIQaXVu9t8Tip8+wsElAMLz4rIadluzNpFJA3QSloHPZVHmoxyHTLqSF48+vwggXs0VcyMv9YT/zeNQ9vJcjSCZd7ewl7lACyP9nzCill2SAcsRndoYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=Wwm3h4TL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9kq53Fg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EAFF1D000A3;
	Tue, 30 Sep 2025 02:53:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Sep 2025 02:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1759215225; x=1759301625; bh=EMtFpG+Bb1tLZ/pMnCpLyyl10Wvnkg0U
	0h/ZqbI05EY=; b=Wwm3h4TLnCWzfr2Uf5RWbsb3RZOCS7WFYPAZ8LmwQlpQOBbD
	EbpoVRQcZ6gOtNcLRSza4gzpA0wTU70Sue0n0OzChM80PwmP7eEhowZA8oILdDDy
	leomtSg58S77D1wirkp+CUmcu7MvtFhIoSRdLnGYlF0XSf1qaOyx4GABN21VNeay
	0vEYykUJ9bj9GEzOiVXgTTqnCL3wUr6eGK5WNJHo7ShT6D4Sc4qwkB1B9+Fw47LK
	IOTtlwpTPKRgavMwSAsQzo1zWqZkgfKaMWCrJw7HzYh77D+32NjgEtpqIleQizK6
	IAK98eRvR4re9mMAYyNALSsjUWulRTbdOUCYKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759215225; x=1759301625; bh=EMtFpG+Bb1tLZ/pMnCpLyyl10Wvn
	kg0U0h/ZqbI05EY=; b=p9kq53Fg02uxrNOFTSm88uYA3bLcw3KULnlArq79OR9f
	13HKnPO9iM6vUsvIEuDls+0O3M+K3u1Lh1pt+zhVDahckD3sMLd48UYmO3woPQGg
	KJrHFbKfPsUwxjotUs66eNpNuJJ/XCnHFfC8Hd8AHkzLNX8Ie++vhNjGIcznEx//
	lQ63mbCwmZqYNcWrFfJ1dYMBEvMS/dagRECjxYsLstK16K2GaZraHh7DcgrwD1kE
	r2MxBOCn/DdadCnyqGH3VlVhksOeCLNFQ9QW9bfUT6AGTU14n7o9hr16+zHX8Pf+
	7ZkBB9NbFc01Z9RvRJQTfVdKaXahArJu0cQPx+yiKw==
X-ME-Sender: <xms:eH7baJJGuveAd2e2htkwwdqI77YK8qK4dvr4bE6woA7C1QXya7MV8A>
    <xme:eH7baPOXnNIBSRc0tSdGrcoi99bRrU1rKQC1e8i-W7sIRrui9exKhPIRkQtLCQTxU
    e3ueacDmbSV8ydzbeMV1ofC9UK_dNtKcVDaBH1n0iaqwoTy9JJhq1Q>
X-ME-Received: <xmr:eH7baBlgD59ysbGa_LM5Ns_oLbZ_hjtvyutMXcb7jJVnTN7GuXDJZa6XOI9qag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvegvlhgvshhtvgcu
    nfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpeefteegleevudeiteefheetfffgtedugffgjeeigfejffduhedugffgkeeufeev
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufi
    husegtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghilhhhohhlrdhvihhntggvnhhtseifrghnrgguoh
    hordhfrhdprhgtphhtthhopehlihhnuhigqdgtrghnsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgrgiesshgthhhnvghiuggvrhhsohhfthdrnhgvthdprhgtph
    htthhopehmkhhlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgv
X-ME-Proxy: <xmx:eH7baL5bV11s4NXn-Mhs7J8ajMzNZBayZag7kQ8G-3saGMQb0YdDbw>
    <xmx:eH7baN2BUyXnFyqSNobakIstYZ64nJYWVuXEc0Ly-yXMibc46dL94g>
    <xmx:eH7baOH2371aKz-m9CiwFbjGPtdAI4r56NOhDaLgANqCnsRmlFQNYA>
    <xmx:eH7baEjS1O0EPAya3Tl1C3w66r3LPbMWWnnj8vFbN8YyS-RURBOT_g>
    <xmx:eH7baPaZxgEQG0YJww2BBnUEtuCBL7zZ0Jj6DuFW4lB7l67dB7j51SCs>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 02:53:43 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 30 Sep 2025 14:53:39 +0800
Subject: [PATCH] net/can/gs_usb: populate net_device->dev_port
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-gs-usb-populate-net_device-dev_port-v1-1-68a065de6937@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIAHJ+22gC/x2NQQqDMBBFryKz7kASK5hepRSxyWgHShIyUQri3
 Tu4erzF+/8Aocok8OgOqLSzcE4q9tZB+MxpJeSoDs64wfje4Cq4yRtLLtt3boSJ2hQ1DISKqeT
 a0N/t4qIN/Th60KVSaeHf9fJ8necf8HILjXUAAAA=
X-Change-ID: 20250930-gs-usb-populate-net_device-dev_port-941f2d1c3889
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Maximilian Schneider <max@schneidersoft.net>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=USG8lenE4OmXYzm1tUnfdT2zeBwOkzOgEoVpjZDEcHg=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjNt1JVNErWQ1lleJ+zMbrdz+0O6FmaS103rJ9ux50
 /kPx/V7RnSUsjCIcTHIiimy5JWw/OS8dLZ7b8f2Lpg5rEwgQxi4OAXgJksy/OHlaW9T2vHxUrBa
 RePZQuNalvNsDW7Z1oJG8w/G6ppMrGb4Z97f6xf+s7x2+V2Nu1s+72HdvTD7bt3sL/LTPJbcv+B
 szw8A4hRF9w==
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The gs_usb driver supports USB devices with more than 1 CAN channel. In
old kernel before 3.15, it uses net_device->dev_id to distinguish
different channel in userspace, which was done in commit
acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id").
But since 3.15, the correct way is populating net_device->dev_port. And
according to documentation, if network device support multiple interface,
lack of net_device->dev_port SHALL be treated as a bug.

Fixes: acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id")
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 drivers/net/can/usb/gs_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..7ee68b47b569a142ffed3981edcaa9a1943ef0c2 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1249,6 +1249,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	/* dev setup */
 	strcpy(dev->bt_const.name, KBUILD_MODNAME);

---
base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
change-id: 20250930-gs-usb-populate-net_device-dev_port-941f2d1c3889

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


