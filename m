Return-Path: <linux-can+bounces-5062-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC4BABA39
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF3D3B5DCA
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD1278E53;
	Tue, 30 Sep 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="NQgGgenm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATU7dZM+"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C835977;
	Tue, 30 Sep 2025 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212959; cv=none; b=c5MQwiT+EKgUsxkjfAurIIKG1Qb1njWqhAN4k87THGKY5dIJ/Nav7v7sMGTSW3FA+28IEqpgmq0yQ51vbLK8SFuUDsMwzxgPAe8+27sOsnHKDxHTMj9Af/zW57ZHGtE/rDqnh1rAj6EUU+NK90+lfoA5lkGWAYU/1ke58xYcR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212959; c=relaxed/simple;
	bh=JSQS8jWtwJZMUtJLN+eiTBqu4cu1mxUPYo0c+AVC/Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a6prPs7fWo9LwVjrHBhJ0CQjAtAHI2CVLzvS7NlEIqfGOUr83wR7TX1s+mOIcPXlZyEEGMA7b0gMQHrHZWGoxmHlUFKLZ6mmfjpa7jEUXaRlbJiwZ0V/Y1TZHnm8xz4gcDvCdbFkNP1yK2IH5nGpeIOeR+RB3s0Cw5Sitv0bCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=NQgGgenm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATU7dZM+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D9AC31D000E9;
	Tue, 30 Sep 2025 02:15:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Sep 2025 02:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1759212955; x=1759299355; bh=3YeOxUVsgLqUs6AjL8RDewiOARrX1Caf
	+gKI6bQrRKM=; b=NQgGgenmTgz9kg0gCPRs+cn4raxwuqxtSmGQWfRSBSSDIbFq
	SVXkKvdf68ntyz3M5rvsVJ6WVjoGczUgVVdxBfMSnOfPbAdGiynsLAQSJ9sT3bkQ
	4k3FWyH0pk8AIPtXbSxiJLxGbrBRVg1UyqdFFirnSmlUQV/mAeofD2KwpGGY2tNi
	m9DfkaVLC3SpcqS5o1TkwC5b4b09SKSGI6DZsfk8Un/ahTpV9evEJ2KA0EYk+R7b
	CaKmoP2XazhPtwB/dRUcb2CT/criMQ31UwQStHDWXj4F3zgSvLOWs5VPa/QqJxqj
	F3ZcwOS7szKbwyedd/oMovNhop8SVTarNn4BvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759212955; x=1759299355; bh=3YeOxUVsgLqUs6AjL8RDewiOARrX
	1Caf+gKI6bQrRKM=; b=ATU7dZM+CQTETm2CXJj3LwHWWOn7jFl4bKPsZLNYvrtL
	/UxDaawOYliovW6ZFByA870YXnPOEEyrj0MQZ7ApDpDIyM8gi+ElMTKNLcXrScUS
	+i971sJj/7+/fO3XDqs+bieNCRCQKzWSLkB8wQrFykboTpLhdyKwDeoNkrLPRjqO
	y6HIFKwCoF3PYZwF3Q33eD1HshVQdUZKejhUo2aAJS/N8t6c7ScNB49wd8DBSS9K
	H/pidk9nJG+cR2xOfKyE7IkbTbHek+BfsBG15zwVAVu+H06Z4EZPIiN/1jFhUk9v
	toOO0sIttNwdvb9tbRApHQwSdgiAs+LqK5GXdMGVlQ==
X-ME-Sender: <xms:m3XbaFCvs9ff2qNXtxPXPcMysHbyTinKrCYpCGVMuqLc6SLprh9vbg>
    <xme:m3XbaAPRbVIDuXYQNg0yszfuNjN1Lt5OaqHoXM07s9RZhWMJomzSagAusC_PYJSkC
    8aLNtd7WYkAsJ7_2xhj4KNJHwXMv-waS4RDJSHRRIkYqRyzpLOiOOQ7>
X-ME-Received: <xmr:m3XbaEeTPIV7Ia6BuCv8cNZX0gOklMjODM5PlZ1dZCsYsBdFNep-Nb-DEwo9aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvegvlhgvshhtvgcu
    nfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpedtgfehkeeuveekvdeuueeiteehgfeitdekudekgeeiteduudeufeelheejgeei
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegtohgv
    lhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhgrihhlhhholheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeifghesghhrrghnuggvghhgvghrrdgtohhmpdhrtghpthhtohephhgvnhhrihhksegs
    rhhigigrnhguvghrshgvnhdrughkpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrgiesshgthhhnvghiuggvrhhsohhfth
    drnhgvthdprhgtphhtthhopehmrghilhhhohhlrdhvihhntggvnhhtseifrghnrgguohho
    rdhfrhdprhgtphhtthhopehmkhhlsehpvghnghhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:m3XbaJ5yVhxscVptjyRbIR1za9eAgS98bPwKeKPTzdfNnCYqhNIjnA>
    <xmx:m3XbaOIO6DC9KRM21tYmnFMPq2EbwNCQuEWjmK5bWZ5YAH9cCULZaQ>
    <xmx:m3XbaLWpBTWiODrsTFivn91F-NVkrlp7UYOa4-SU4p5EjvU39pV9sg>
    <xmx:m3XbaCFoKDITWXtyZ1u0B2H8OW-bCwY2PUQGWEAvAEEEOdANySh-0Q>
    <xmx:m3XbaB4Vm8U9dWUHlPVTOH1MWfuEoRvWqWS1MM2nZmWbeJTSjVO1SJyS>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 02:15:54 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 30 Sep 2025 14:15:47 +0800
Subject: [PATCH v4] net/can/gs_usb: increase max interface to U8_MAX
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-gs-usb-max-if-v4-1-8e163eb583da@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIAJJ122gC/33MSw6DIBSF4a0YxqUBLj7oqPtoOkC8KEnFRtTYG
 PdedNQ0tcP/JOdbSMDeYSCXZCE9Ti64zseQp4SYRvsaqatiE8FEypRQtA50DCVt9UydpRqYNAU
 ICZiS+Hn2aN28e7d77MaFoetfOz/xbT2SJk45RcnL1DDFAfTVdPjQRvuhGcPZ6xbJJk7iQwH2r
 YioCGOVlhKzIuNHCvxVYFN4pfIqt9yA/KWs6/oG2TmN6z4BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4222; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=JSQS8jWtwJZMUtJLN+eiTBqu4cu1mxUPYo0c+AVC/Ew=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjNulU9eVXSpIVPNJ41Vm8+rfI3eoYYnCv4T8HXNzP
 6dcC2XS9ewoZWEQ42KQFVNkySth+cl56Wz33o7tXTBzWJlAhjBwcQrARNhmMDIc4jv0KNZd9EBK
 RCfXqQ+ZRwpe3plY9rqdf+bKkuSrD4+xMPwv2vyv5JngjC0r5IwlVewTz4qc/3Iz948Hl0/O3Ns
 aqw8wAACMF0pJ
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
converter[1]. The original developers may have only 3 interfaces device to
test so they write 3 here and wait for future change.

During the HSCanT development, we actually used 4 interfaces, so the
limitation of 3 is not enough now. But just increase one is not
future-proofed. Since the channel type in gs_host_frame is u8, just
increase interface number limit to max size of u8 safely.

[1]: https://github.com/cherry-embedded/HSCanT-hardware

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
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


