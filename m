Return-Path: <linux-can+bounces-5058-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF19BAB1FE
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 05:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE71C4503
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 03:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89D153BE9;
	Tue, 30 Sep 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="fLmyKftQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oNP5pFOx"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A671E1E04;
	Tue, 30 Sep 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201613; cv=none; b=t0fap2kSXpJm4QqaNZOa7C29V1PGQX6FMcR0sBrfjf7QqIiWV8Q75AhqMn0oLcUYFdc2Swip1620wfp3Zd+YbG/LVDJPSOxJ20d+YS+ZkxgagD7dkAtp7gsqemZHh+GZmK48+Hbm8g695ZrY+YKikg3I0v0tk4yJfIICxicbVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201613; c=relaxed/simple;
	bh=YzKh5KM25egSgCIkXs8XfZcXIc8x3hlfCi9KXBW5mfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DUNL7/UnozJvTWJdkrqZiciRN+Zqq9eVppStbQMhW+EPm8A4+jNSN3YPkK0+SeA8FKmpDQoGfYhJXQROyhkM3KJW+cadXJYtV2aEGhzKi3YctVH6MqF5fO8y4m+9tYTmGmu7EQ1jGcGwYvXeRiM7Xb067mWb+pj2WBs2xTucchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=fLmyKftQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oNP5pFOx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E1AF7A008A;
	Mon, 29 Sep 2025 23:06:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 29 Sep 2025 23:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1759201610; x=1759288010; bh=X7ptXVOpVacXocranNPRCzZZZfkTHOiR
	nzQURHJQe98=; b=fLmyKftQLkkF0gP5ectm9hS1dYxQUKZtaPeRxdXfh1PLuK9S
	b5mBbykF4BxR+7Dnk4aWIAmtUmuf2zaQZSWCtL6dIwi4E/ID5hYqoRbx87J98LPS
	bPppQ8tRCd5dii9KKkrsAkZnWF5Rc8TQggwKlMZtC4XGbKrgDh2W1tNlttPoOa4X
	gbsulXeZr8i5Dv3ABTXiJu98hbEInkD+ftSzic1Rx7fLhNSW/KIEdnIuZbLSeVCL
	Sl0T8zgs55z32DOUB38Otr+U+xIFkWIZQ0V70XrK3RT4mVaPcuCFExruLgIr2Ccv
	dG0Pb/zmazvBEVvdS1RcI1RIzae7Lm6QBhTQ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759201610; x=1759288010; bh=X7ptXVOpVacXocranNPRCzZZZfkT
	HOiRnzQURHJQe98=; b=oNP5pFOxBeKQcZ1SS6nSE+uGpRNe3T7R1BvnMOrofNNy
	UXhPzoHZ5LhpGiN+XYokWFpYu4yzqbWp2d1VLUaGThBBAjSRBluz7amFccTOkkAA
	qIHJ40qlbiT1my/CGTY3h9e9CdENt2syl5fKgl5YLTlElOHTRyKAiLXvp17/oJWw
	LXra6hv9q5P2gl9+732nViDHunUKTME92+QyJnvdxWnKQWat6x27J6GT+4HpeZjN
	F6gBq3lYKEBMkU4ev2/yCgIxt8urLI5YdiLStteRoEkvP+iesdGm+GpYQch0LnmH
	DQWDYXv0Cy1vJhFuyMKhWVjCrzCKoGTL9zYfIDTpTQ==
X-ME-Sender: <xms:SUnbaFlFFuXoENBozvoWT4vi9Nv6LzJ3RHIfzwqzDk8qFjLad93Ljg>
    <xme:SUnbaI9O1NNRyw55lzilePRXX7CeRZ6D9bwZoSLpsAWsx43kkIbHc_vOOHQFWbxZH
    I9_iHkghkY7BDZFkuxnznEdNsQ1ZKiyXVL1TCT_tZi5KpBZpQHGjC0>
X-ME-Received: <xmr:SUnbaLL6Zidc6IbE9oD7HZpt1Rs0tL5a_gdWtpYCfJ1f01naLYlvj2120pAgJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvegvlhgvshhtvgcu
    nfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpedtgfehkeeuveekvdeuueeiteehgfeitdekudekgeeiteduudeufeelheejgeei
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegtohgv
    lhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhushhtrghvohgrrhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmrghilhhhohhlrdhvihhntggvnhhtseifrghnrgguohhordhfrhdprhgtphhtth
    hopehhvghnrhhikhessghrihigrghnuggvrhhsvghnrdgukhdprhgtphhtthhopehmkhhl
    sehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhhunhgthhgvnhhgrdhluheshhhpmhhitghrohdrtghomhdp
    rhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgv
X-ME-Proxy: <xmx:SUnbaFgolxaHB-FluZvHZ2_4cfMBYP4jiiKn0avrr2t2koYn5dxgsg>
    <xmx:SUnbaP9eq2qz6etDplOedMT0mKjuc53pjz8F2nJDlAV_JVq7cuDyQA>
    <xmx:SUnbaCMs0nzj1Jr1yyIT9GyMWW_ITBK7F2tCHcuqKHByhi_vvh4P0g>
    <xmx:SUnbaLBHUpwuRmCyw8GOooRXwfP_nLNwB-zS8Cg8di1paLFPLXL1_g>
    <xmx:SknbaNiyu-nsBmGa23iL5_ZVYf9n_iCNovTKVby-DEUdunHn1Ex7izg2>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 23:06:48 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 30 Sep 2025 11:06:41 +0800
Subject: [PATCH v3] net/can/gs_usb: increase max interface to U8_MAX
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIAEBJ22gC/3XMSw6CMBSF4a2Yjr2mLwh15D6Mg0u9QBMppoUGQ
 9i7hZExOvxPcr6FRQqOIjsfFhYouegGn0MdD8x26FsCd8/NJJcFN9JAG2GKNfQ4g2sAFde2UlI
 rKlj+PAM1bt696y135+I4hNfOJ7Gt/6QkQABpUReWG6EUXuxAD7Tox26KJ489sU1M8kNR/FuRW
 ZG2Mag1lVUpfinrur4B0E85aPgAAAA=
X-Change-ID: 20250929-gs-usb-max-if-a304c83243e5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Maximilian Schneider <max@schneidersoft.net>, 
 Henrik Brix Andersen <henrik@brixandersen.dk>, 
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>, 
 stable@vger.kernel.org, Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4003; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=YzKh5KM25egSgCIkXs8XfZcXIc8x3hlfCi9KXBW5mfw=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjNuerptZ9l4/XrCtZupcJo9OH3924xdzBAQPu6odi
 3uqe5aXv7SjlIVBjItBVkyRJa+E5SfnpbPdezu2d8HMYWUCGcLAxSkAE7nTxfC/at4R5/v/Pn1h
 vsn82vzuXPfImV6is/Zcn7CrtFZ9Me8GPUaGy9GbfHSXPN93IHHZbjWm3WZ/Pm4Q45/SV2N/r/w
 a0wl+TgCSS0nP
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
converter[1]. The original developers may have only 3 intefaces device to
test so they write 3 here and wait for future change.

During the HSCanT development, we actually used 4 interfaces, so the
limitation of 3 is not enough now. But just increase one is not
future-proofed. Since the channel type in gs_host_frame is u8, just
increase interface number limit to max size of u8 safely.

[1]: https://github.com/cherry-embedded/HSCanT-hardware

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v3:
- Cc stable should in patch instead of cover letter.
- Link to v2: https://lore.kernel.org/r/20250930-gs-usb-max-if-v2-1-2cf9a44e6861@coelacanthus.name

Changes in v2:
- Use flexible array member instead of fixed array.
- Link to v1: https://lore.kernel.org/r/20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name
---
 drivers/net/can/usb/gs_usb.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..69b068c8fa8fbab42337e2b0a3d0860ac678c792 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -289,11 +289,6 @@ struct gs_host_frame {
 #define GS_MAX_RX_URBS 30
 #define GS_NAPI_WEIGHT 32
 
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 3
-
 struct gs_tx_context {
 	struct gs_can *dev;
 	unsigned int echo_id;
@@ -324,7 +319,6 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 
@@ -336,9 +330,11 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 channel_cnt;
 
 	unsigned int pipe_in;
 	unsigned int pipe_out;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -599,7 +595,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
 
 	dev = parent->canch[hf->channel];
@@ -699,7 +695,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
 device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < parent->channel_cnt; rc++) {
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
@@ -1460,17 +1456,19 @@ static int gs_usb_probe(struct usb_interface *intf,
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(typeof(parent->channel_cnt))) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(typeof(parent->channel_cnt)));
 		return -EINVAL;
 	}
 
-	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
 	if (!parent)
 		return -ENOMEM;
 
+	parent->channel_cnt = icount;
+
 	init_usb_anchor(&parent->rx_submitted);
 
 	usb_set_intfdata(intf, parent);
@@ -1531,7 +1529,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250929-gs-usb-max-if-a304c83243e5

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


