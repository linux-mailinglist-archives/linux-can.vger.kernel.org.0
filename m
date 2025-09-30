Return-Path: <linux-can+bounces-5067-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B8BACB24
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 13:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51CF7A8B45
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810F25C81F;
	Tue, 30 Sep 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="RZoAkK0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRQLRm54"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7525C82E;
	Tue, 30 Sep 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232085; cv=none; b=P6joSTx/nsUq/kv+2gE3QoR9a9eIexeLQrysTyQixIZ/whAdXvI+DRKdupKAPXD/omAiEwGafBj6ofM70Rj80Bqy7mLp3nhIPVt2xzqoj+vCKokI3GuwXL60Qxo5992KIt4sL0YvlzF0j9u3dpwk1dAmO0C6XUO593WNeDQiE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232085; c=relaxed/simple;
	bh=iKF972freU2WK3d86MrwzDv4ZOGu/rXvo4kqRTZxEdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjtOEdR4b9TCfvGRYDi9FjFHFNKdto0VW/gK0GQcY6rC/qKqEAxoNLgnV8lC+HQdG4B/hakDjFZHe2CVciUf7XLtkVTv7XIE3CRlo9giuSEAfj2//BSTYwJB3AQGgLxoiFtOKGQKrLS5J0qMbB7PH4V7zcm0wP2CDu45wMikLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=RZoAkK0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRQLRm54; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6804F7A0093;
	Tue, 30 Sep 2025 07:34:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 30 Sep 2025 07:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1759232081; x=1759318481; bh=eybtdOVK+vTAmRCYicSe7Uey/Y/LUrU7
	ciW87ZmzgN8=; b=RZoAkK0yb3TBAgefAlsfJwWZJkHc8peiG+v4/q2mTI210ivl
	8Ho/4GL/gDRm1vGOxBD9c5LUBa2sXdolqUq+qkCdn5tnRzV3XJAOcVitUfBXoYaW
	18RT1PzB9h/iLrjNMRh1WFJY03s+/QbkMh9vaYouZ1rcsRdvpOntY8gMgTv2Zf9/
	8l+kd29e08wm1/IiriJCCScoeI4kTmpZ3etiOfNMqM/kHNuCA/I97LkgaNdMPnvF
	vASGLWAcXHCHZkO9XPsTSBpEOUWr5hXNuYKA6aU6ooHUanJ1lMrCMzcjbpuho1OK
	bsNy8Kdc8CYV3aa6N6M0P3AxlSrffuoOqPB8kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759232081; x=1759318481; bh=eybtdOVK+vTAmRCYicSe7Uey/Y/L
	UrU7ciW87ZmzgN8=; b=NRQLRm54ur1cIs42Sot7ahfiVae1oJ74zA0BaVRQxsaN
	DHWrb3l+S1uKAPuSeHQQg432RrlfwRukUuXMipXpVTut7IVmwANajxdjUojOA1Mj
	k3aGVL6zPnpL5kfvx9ZQQSXSzWLYIzQgpiBlfqlU/vRpDAZ26zyj8jJsNU50opj/
	TXK0mL684un+tddOA01bx32jKyXIHp1Ghukb9C9F4MaFb3T9ryTzP8EtlzCn8ftl
	sxQUaTYLp8VBwztlaW6L8GpOuKNNnmXNJBfeRTsFW/7AhJxGmxOvA1io3E7PIOre
	geEQH8MOT16Ojg1dyrxiwWNKVcNTmP5kdPsjoGwACw==
X-ME-Sender: <xms:T8DbaH33bcHdF5klCMqXpS7ZdGMc0hz4-XfAE-3C_1HCMQson7r3LQ>
    <xme:T8DbaCz6EsMNFXBXbtnhdpR_-jrkjyjP5sQYhVBZ8dlr0wFE9RQl5jHRvPUPYZQut
    shPO1cJYdwH0esoYr0F0X4Ngf_qHyR4Czl2LTtoQUu49U8hL7V2pd0>
X-ME-Received: <xmr:T8DbaLzvVV7empd_nUWq67PeynjhzpJ4uKA16ZB3MuV18ao3qR6CpIGR3J6nHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvegvlhgvshhtvgcu
    nfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpedtgfehkeeuveekvdeuueeiteehgfeitdekudekgeeiteduudeufeelheejgeei
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegtohgv
    lhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepfihgsehgrhgrnhguvghgghgvrhdrtghomhdprhgtphht
    thhopehruhhntghhvghnghdrlhhusehhphhmihgtrhhordgtohhmpdhrtghpthhtohepkh
    gvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehufihusegtohgvlhgrtggrnhht
    hhhushdrnhgrmhgvpdhrtghpthhtohephhgvnhhrihhksegsrhhigigrnhguvghrshgvnh
    drughkpdhrtghpthhtohepmhgrihhlhhholhdrvhhinhgtvghnthesfigrnhgrughoohdr
    fhhrpdhrtghpthhtohepmhgrgiesshgthhhnvghiuggvrhhsohhfthdrnhgvthdprhgtph
    htthhopehmkhhlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhig
    qdgtrghnsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T8DbaG_uDwcio5vCk2cZK9DI9Hkl4dLhL7wQhZJcGDGdVrqrVFKuFw>
    <xmx:T8DbaN-MyylTaIU9gsnibQvXHOuWiQyy7rT3x4TdfLEzolwtpU4zwg>
    <xmx:T8DbaG6cTxznaiZpUBlt3FH1dIvfxwlNB4sEaRKeAkbOF_ur6DzDiQ>
    <xmx:T8DbaOb2Qk1eGziXYJPk2VqcLLWlrrSfS3HU3OtdOxhtjGi05LYtlg>
    <xmx:UcDbaN83L39SOhMRnIlliJV9twTVrB2b-odmb57-e79IAl4XH_moIO6i>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 07:34:38 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 30 Sep 2025 19:34:28 +0800
Subject: [PATCH v5] net/can/gs_usb: increase max interface to U8_MAX
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIAEPA22gC/33PQQ6CMBCF4auYrq3pdFqgrryHcVHKIE0ETItEQ
 7i7hZUx4vJ/yXzJTCxS8BTZcTexQKOPvu9S6P2OucZ2V+K+Ss2kkFoYafg18kcseWuf3NfcolC
 uQKmQNEs390C1f67e+ZK68XHow2vlR1jWLWkEDpwUlNoJA4j25Hq6WWe7oXnEQ2dbYos4yg8Fx
 bcikyJdbaxSlBUZbCn4V8FFgcrkVV6DQ7WlqL+KSkpBkCGVusDq50fzPL8BXSJSNIQBAAA=
X-Change-ID: 20250929-gs-usb-max-if-a304c83243e5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Maximilian Schneider <max@schneidersoft.net>, 
 Henrik Brix Andersen <henrik@brixandersen.dk>, 
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>, 
 stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
 Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4499; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=iKF972freU2WK3d86MrwzDv4ZOGu/rXvo4kqRTZxEdk=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjNsHPMun3C6vF3bQzP0/fVvfjo4vr+/k696LM1ncc
 vi1hdnc/p8dpSwMYlwMsmKKLHklLD85L53t3tuxvQtmDisTyBAGLk4BmIj4NkaGmwl373c4TQjY
 cCX43KXfrJ2fZsW7LFmZeV65VbNZ6WVDCSPDl5bj21795Vr7eIrV7OJFDz/c/Mpy30ZwrvRK3ow
 u1u0FTADvYE9C
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
converter[1]. The original developers may have only 3 interfaces device to
test so they write 3 here and wait for future change.

During the HSCanT development, we actually used 4 interfaces, so the
limitation of 3 is not enough now. But just increase one is not
future-proofed. Since the channel index type in gs_host_frame is u8, just
make canch[] become a flexible array with a u8 index, so it naturally
constraint by U8_MAX and avoid statically allocate 256 pointer for
every gs_usb device.

[1]: https://github.com/cherry-embedded/HSCanT-hardware

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v5:
- Reword commit message to match the code better.
- Link to v4: https://lore.kernel.org/r/20250930-gs-usb-max-if-v4-1-8e163eb583da@coelacanthus.name

Changes in v4:
- Remove redudant typeof().
- Fix type: inteface -> interface.
- Link to v3: https://lore.kernel.org/r/20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name

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
index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..9fb4cbbd6d6dc88f433020eb0417ea53cd0c4d5f 100644
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
+	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(parent->channel_cnt));
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


