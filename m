Return-Path: <linux-can+bounces-5056-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A04BAB1D7
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 05:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B963A35AA
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831338DE1;
	Tue, 30 Sep 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="1Yv5gxpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFvPP4WG"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670C22EE5;
	Tue, 30 Sep 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201221; cv=none; b=J50tawZw7i1RO4/T81LsHExSTiPOPp1M0SOBJ6IrCpHU3Br6xCb1ndxR0LWEJdiacF8okl/nMIp2jIN+UpCZ8LRQMRBHKQXdDg3TCvKt4xNMQmFSDR89FgkO64tUfvg36Q2EL2v9GA4/vBns3sJ3boceLUt21F7vYd5ahGej8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201221; c=relaxed/simple;
	bh=/rtfOd9YoXigPMKxm2r3haVCF7hvKj5640IX41LmS5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vk6dQbDzi378Vn1JTBzvmCR+Od7mZPE/9dhUW2qO4DMBA3kaufp0fnxfThmznPDNW9qkKMoA/AAVocv0KFKekwMPtKpkyTFB0P6xwdrredzzZHAisiGScwdi/mzT8KFBq+g01ooPFfMxf8tSwJfL3e90zVuKzvR5gGLYBvJ62Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=1Yv5gxpz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFvPP4WG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 913A51D000D7;
	Mon, 29 Sep 2025 23:00:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Sep 2025 23:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1759201217; x=1759287617; bh=Df/YBdpo5lSMIH+RKZ2JadgtO6rJaALH
	3kr7ZM9U59o=; b=1Yv5gxpzoLbmWmAONO8+kqhqlKadpToaeFdIb6FOqjDj58pz
	XvTPjYGYqSSx3/FSY0P8m8j2fkoLh84ezux88EqMlzUPBgKPjeE+vDSoGh2ocY3N
	PSSgpOmVYs7pvEGaLrHsmiqdZOka4biAVjuiIBM5h1cPOD2/7o/1U1QPC/vWZ/qs
	YZNsio9ufOkNSdbeC5O5rzcFQAchiM/lVtRYyEJWajF+H/u1GxRUhb7zaihd3Xru
	vfyz3N8OyewJxMfnC/tUKhg1gWcrZI3Y3VgxpfUwtu5C2Ik/OIo4nWG0xPf41rB+
	7J1NAP4UVgAU8I2gS46EayKOWh9Fz9/nsJybYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759201217; x=1759287617; bh=Df/YBdpo5lSMIH+RKZ2JadgtO6rJ
	aALH3kr7ZM9U59o=; b=OFvPP4WGpMkK1BPtujNR9SnT4fMb9Kn2aAOlAdOdpqfR
	gEsSgnH1DSl8X9aQU3xC2J9xTF6oJEh9v4ty21aXI6Dljv74JM7TCIVZQ0uXzJ41
	7m2qGZv3NkmcAy7rrdjxQd79mqeE+9HoRVo0v2AlbxZbPYldBAXNDDn2NbVDERDQ
	L3VKIv13IMXrjW+Ap3evB9S67yL6WKD7X4KHvuMe4FrtWdY0/w2LaIEZx9opTZNj
	uHHLqP3sVSn9kyN2s/+aRI1urhbnIBSYFjYoPlSuPDmkISsP+60Ph7frqTSYgKl3
	qUMm2+Iy3pCnDpBd9/6Edx6pLWvogDXAJdOeVGnTWw==
X-ME-Sender: <xms:wEfbaEe_vTyCZAsbmFnkTswli70caDZbOD24WJc5UgavTYSYt7J4yQ>
    <xme:wEfbaApJsQfSp5HJKdQorOukZmKKqmoorh5GNG6LUyU2w9nORaFY7w36Ddos6EwmV
    wBTPvdaSZ56exJqK2I0o1tDSDLTzhqwXV3Jx7YDej4vBhQbwodvshk>
X-ME-Received: <xmr:wEfbaNCTveFebqtTRMxY1cGip0a7LOZ07VU3Y8M1HrK6Ocgsw6vLIK_tjP7tHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepvegvlhgvshhtvgcu
    nfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrghtth
    gvrhhnpedtgfehkeeuveekvdeuueeiteehgfeitdekudekgeeiteduudeufeelheejgeei
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegtohgv
    lhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigidruggvpdhrtghp
    thhtohepfihgsehgrhgrnhguvghgghgvrhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    gtrghnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhunhgthhgvnhhgrdhluheshh
    hpmhhitghrohdrtghomhdprhgtphhtthhopehmrghilhhhohhlrdhvihhntggvnhhtseif
    rghnrgguohhordhfrhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wEfbaBfxNJHxyEQGENpFgVqWB4JX8tnrdipn7gbhL65aSNhW5nq-AQ>
    <xmx:wEfbaFvwxvzaqz9De6EPj9OBIL2pSfHgdibGYEbsohBgWWFNq8IkJg>
    <xmx:wEfbaIgjdHMyfnqcLCd1tNIoRglTULo5wrT2LkrppTGFQAwnDiPSiQ>
    <xmx:wEfbaNucaT-oSMbTklW5RzGuGAZgqv6u97R3zz1B-Kv87LWIE79Dww>
    <xmx:wUfbaJtPEr0fuSQ0ww6J54pjbbR4PpXc1qCT-E7jvZ_qOw9vADXhq8Re>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 23:00:15 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 30 Sep 2025 11:00:06 +0800
Subject: [PATCH v2] net/can/gs_usb: increase max interface to U8_MAX
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-gs-usb-max-if-v2-1-2cf9a44e6861@coelacanthus.name>
X-B4-Tracking: v=1; b=H4sIALVH22gC/3XMyw6CQAyF4VcxXVszF0jEle9hWJSxQBMZzBQIh
 vDujuxd/ic53wbKSVjhdtog8SIqY8zhzicIPcWOUZ65wRlXmspV2CnO2uBAK0qL5E0Rrt4Vnkv
 In3fiVtbDe9S5e9FpTJ+DX+xv/SctFi1yYZsymMp6T/cw8osCxamf9RJpYKj3ff8CBRCwx7IAA
 AA=
X-Change-ID: 20250929-gs-usb-max-if-a304c83243e5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Maximilian Schneider <max@schneidersoft.net>, 
 Henrik Brix Andersen <henrik@brixandersen.dk>, 
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Runcheng Lu <runcheng.lu@hpmicro.com>, Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3803; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=/rtfOd9YoXigPMKxm2r3haVCF7hvKj5640IX41LmS5k=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjNvuu3qu/bVcFbHzgM230CniDp1XWVPyv9ms2D7r7
 5Ok4pnXf3d0lLIwiHExyIopsuSVsPzkvHS2e2/H9i6YOaxMIEMYuDgFYCJGZxkZXn1faRpilJez
 /m7U2kt/1CRveD2uePThr9BbARtltwvGPQx/Ba9J/Y84v7S07/oXZe9zDmJFdy5ZP+Vj43Z1iJq
 qnODJAgD+PU0H
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
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
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


