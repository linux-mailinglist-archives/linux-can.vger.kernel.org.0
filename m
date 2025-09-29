Return-Path: <linux-can+bounces-5053-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1891BA8FA2
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BE93A89E0
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FED2FFDF9;
	Mon, 29 Sep 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="1I7zxjdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vi/HcuRb"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC52FFDC8;
	Mon, 29 Sep 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144222; cv=none; b=FzcMS5wWwPrSM8LPCjjpNkpa+O8yRyc+FveLSQivr07sQtdzc5BnW8h0j3k3Nx86VSVmyNr6OqOwDckXiOYS80GXvo8MAMOzRe7EKmGwW4u88XZE2rASPmdQnrq1sPN7xFukv9M8Qs1R319eUxUkAFwlLc9CV6MmUYPOYsVfcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144222; c=relaxed/simple;
	bh=z8Pubv2oKesWDZrvQkDTYdVfcOTOhTuE/w7NoXH2FhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CiWt4o9ZalaBgGPsheHCz5dl1W9kbN+7wH8Ircipo0eBpDI7svEFcM3qublv9+Q/kOd4oyFKviHuktnpoJtSrsroVl/AjIheNQTmYtb2b8+q9MCEP+8i+BeXRnuaWjd+bDlSQplR0U3hDFS5MqKPITkvGtybSOXBm7FFqTK5nDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=1I7zxjdM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vi/HcuRb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A2D241D000D8;
	Mon, 29 Sep 2025 07:10:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 29 Sep 2025 07:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1759144218; x=1759230618; bh=aq9svj8Y0nvAncV781D6rHqliVlPhGom
	wa+/hx32DQE=; b=1I7zxjdMdnUsnRbwODD/zexpW3cZUWyJqZvd1WZAoiwkpq7d
	pknoVJiKyniruaRb/528QgR1cN9Ni/Y96RzMAgUImk48rKYp2tNa9tGD3wT1hHoN
	BQ88TlIO22GEM/ZE/UFXav+GTeA5V2ONu464vRB3AB638Qkbano4mPJLB/Gsuvo6
	32/OH6KYQrkhBZ6oy1vStfu7HkbyIZZQIq0miuMX4LBaRLuIGVvR5L05dO5Txjal
	ZLIUA9UT2yR+SRlRGMQShllGuj3Uyu31opA6g8ewKrFj6xYrXoe3e6XQCt5ofSVz
	scUy+M/TAuiEHWd2v83fQISPO+febkMMxFovvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759144218; x=1759230618; bh=aq9svj8Y0nvAncV781D6rHqliVlP
	hGomwa+/hx32DQE=; b=Vi/HcuRb27svSWXD9Ohx8XBOP7VuNh9M6mrVlrGrwuGe
	nC5XmNK5HBCYjaruM0KmKlxEeBlMSjfaz1goG8tybDZDJfW0PwZB5MDrfpiV1bmp
	D3louD8n1+ccfJjKxEJBCLxnk24zyAQE5VQnKu6kGptRooUNgWle5sKF7vsSeFNX
	p7/f+MAuD7fXV3p1b+h/Ux1SVOT5QOdYX8fhm1WyCspx1laKn0AayRYi//Ft2t/L
	qUh7G8HgPEPXM60aBtVHkn7naYyETXk4NlYrlCXVWzpg1lkzp32Xrq425HQ1Sw9J
	MmKnhaFJpvpgOU7bgMzM3WSRJ4uGnR6u+kBc/XDxaw==
X-ME-Sender: <xms:GWnaaMzXl_XtQLLcuo4z7SW0LXHNz7ZUKNnvLdrJ__ETgQ6SAHrHDQ>
    <xme:GWnaaFPfJOOmUecgLvGWTTb5J4LBnIdwck5PBbN7cKJOWaONL872gZjtuHdjVQHcu
    AGGK0aiODw_3w3TVOIza-5iyyjKfzNvJQBZSADhCMHZs2eeszpqVmY>
X-ME-Received: <xmr:GWnaaCnYWzPQD1oKqHMPyiobPxpDexWrVGfQg74Et33JI6IFXKjD2sbJVmARCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejjeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvegvlhgvshhtvgcu
    nfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpeekfeevtedvhefghfeggfduveefkeevvdejgeehgffgjefhjeffhfduledutdfg
    veenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhn
    rghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehr
    uhhntghhvghnghdrlhhusehhphhmihgtrhhordgtohhmpdhrtghpthhtohepmhgrihhlhh
    holhdrvhhinhgtvghnthesfigrnhgrughoohdrfhhrpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhklhesph
    gvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuhifuhestghovghlrggtrghnthhh
    uhhsrdhnrghmvgdprhgtphhtthhopehmrgigsehstghhnhgvihguvghrshhofhhtrdhnvg
    htpdhrtghpthhtohepfihgsehgrhgrnhguvghgghgvrhdrtghomhdprhgtphhtthhopehh
    vghnrhhikhessghrihigrghnuggvrhhsvghnrdgukh
X-ME-Proxy: <xmx:GWnaaKSVvUeos3JggvUZ3UdIumnlAcvh0yNm8FyJLNUZ4MHCl_qNTA>
    <xmx:GWnaaBULYdRMPUrOFWK5f3OEpxAHugF1crROZMZGa5hvUs0p34l6lA>
    <xmx:GWnaaOJ8boJn37-PzVDHfriWSOsztNLiZ7L09spN_t3_NrLfhIzZ-g>
    <xmx:GWnaaB1xPF0THSkxuUS02nSWE5IH_HQVTaaA7LmQ4Gst9w2fDnv-iw>
    <xmx:GmnaaG5ECBDeyUHk6f_mUCi5WXleU3SCYPEHtrIly0iSzZCVvnGdwnsG>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 07:10:16 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Mon, 29 Sep 2025 19:10:01 +0800
Subject: [PATCH] net/can/gs_usb: increase max interface to 255
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIAAhp2mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNL3fRi3dLiJN3cxArdzDTdRGMDk2QLYyMT41RTJaCegqLUtMwKsHn
 RsbW1AGwQ5yVfAAAA
X-Change-ID: 20250929-gs-usb-max-if-a304c83243e5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Maximilian Schneider <max@schneidersoft.net>, 
 Henrik Brix Andersen <henrik@brixandersen.dk>, 
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>, 
 Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=z8Pubv2oKesWDZrvQkDTYdVfcOTOhTuE/w7NoXH2FhA=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjFuZovtFT4VoLdMVaG1PXZX66KqzWd6TjRr3bCq47
 +62fmVjtL2jlIVBjItBVkyRJa+E5SfnpbPdezu2d8HMYWUCGcLAxSkAE/FXZvifvusw14WQ22vM
 uvVarEIZUu/5TRTjavdSj2re1qQgLWnF8D/iVewGyUdSwfH+8b84d1ru23+w7gGLd13CnVtrp24
 PFWcHAAhcRjs=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
converter[1]. The original developers may have only 3 intefaces device to
test so they write 3 here and wait for future change.

During the HSCanT development, we actually used 4 interfaces, so the
limitation of 3 is not enough now. But just increase one is not
future-proofed. Since the channel type in gs_host_frame is u8, use 255
as max interface number should be safe.

[1]: https://github.com/cherry-embedded/HSCanT-hardware

Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..35fc257c19e57c1f33e03e7c86ea908d22400254 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -290,9 +290,9 @@ struct gs_host_frame {
 #define GS_NAPI_WEIGHT 32
 
 /* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
+ * The channel number type of gs_host_frame is u8, so max interfaces can be 255.
  */
-#define GS_MAX_INTF 3
+#define GS_MAX_INTF 255
 
 struct gs_tx_context {
 	struct gs_can *dev;

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250929-gs-usb-max-if-a304c83243e5

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


