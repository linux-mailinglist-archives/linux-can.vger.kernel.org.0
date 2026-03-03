Return-Path: <linux-can+bounces-6813-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEC1Oimypmn9SgAAu9opvQ
	(envelope-from <linux-can+bounces-6813-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 11:04:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE361EC498
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8361301E4AB
	for <lists+linux-can@lfdr.de>; Tue,  3 Mar 2026 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44038C427;
	Tue,  3 Mar 2026 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyX3lR4M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hde4VKFh"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727663845BB
	for <linux-can@vger.kernel.org>; Tue,  3 Mar 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532241; cv=none; b=AbzUgiHnMkBMyDS0RZaSM97Gg+loprRFHSdYYA9wmoWG7mtXzWMpLWoTLbPRXmL7n4AWxA05hA9VvhJ6DIcf614JfC0rmNxBisaQy80ygHFjWv+aVIlZoeTTwXxP0xATXmenT1ikqN7OqyDPaJcYB/xFnyPuu7Au+PDcN6jhFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532241; c=relaxed/simple;
	bh=Xrijs2S0LIf0uIV7ByfZUfFoXRqDAymrKcU9pM2VFOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RbxMigMBkxMu12epuLYKW2ZxxDSs+RknmYmISqVJdqzPs5sPMO9DRTJQzt+hcyp2PmyY75iCaKA875bYpqFdJ0z8O7Sofp/nR+itDRQlq0xr7e75ejSdmCwN2+S6H0PgvB7G/hSjdai9BdNj2IHe/kDZkvd3EOZ4gg10E6n4Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyX3lR4M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hde4VKFh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772532236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4k49TTKYu7o2TrHzDNtk5xNW7BPxPNJHT8UZM8xGEFA=;
	b=AyX3lR4Mj/mofI8UIHT1tdRAuOKb65O5AxQIaKg7TeLhsCW9DAiPtR+jQjGPIbygHNNpDe
	3MOsKb6YPb1mbwvr8MHnTCvvW1yN4W2GnvTlu8NMMZEksTlS7CD6qb7gsH6F5vl0afLj9z
	ck5X+RyBF1zFgIhGbeYkF4WRyESbKwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-pwjcN8dDPpWuAj4p6uP8BA-1; Tue, 03 Mar 2026 05:03:55 -0500
X-MC-Unique: pwjcN8dDPpWuAj4p6uP8BA-1
X-Mimecast-MFC-AGG-ID: pwjcN8dDPpWuAj4p6uP8BA_1772532234
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so53201055e9.2
        for <linux-can@vger.kernel.org>; Tue, 03 Mar 2026 02:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772532234; x=1773137034; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4k49TTKYu7o2TrHzDNtk5xNW7BPxPNJHT8UZM8xGEFA=;
        b=Hde4VKFhDxWEHwPA0YXMik+ZILjUi+wk57v6WWKhyaXS5XkT+276MuRhHZiE4zltSy
         q9DYXGpR8r2sipJLTMeSwCSG8tW3VeMhY57Gf6gECjK+qSS666P1pGgdik+Pixp5R8q0
         vTPmhvtzBiOyqpJirGGbiJ6b6ywIeC6H0/Mzsw5w136ka1ZIC4jZEKJZ+/O7opC18dIX
         kK06IJWQT6yDqiy/g/Z+Y6EfUmtgkM02wAdrHB5yE8T57Oevg8Y+a7Q/TNxPUSh+IdWV
         iIzh4zlUp5Vul869avUE6AhCaYzRDnPKie3fuzi10uqsFRPx1YxSSfUpg13T4jLIKX3M
         T6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532234; x=1773137034;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k49TTKYu7o2TrHzDNtk5xNW7BPxPNJHT8UZM8xGEFA=;
        b=pma6aRHJoMyOjfgPEVJXTf4Wza+y8yC0IspFxvGsAH+vsXeB3X67W480+Irm+4bmup
         NPPohHsd4rjdvWFwI/p8o2UGpDNHSg8S3LPiqy5LV3lw1Nre+9/e/5f+vQjbxF2JSU+4
         8OoBfAFewyxopt47vTTPAFun2v9hTIy7Izjpbqj6foEixAq1stbyAQ5JFHFtnkbWJvro
         kN6GZedwkEPzwVImfg5OQZ7i1DsgxholeGMEBZ5mtDP2NK+Z33JLm/PQSm6vYgRJW/d3
         iac9fcySJa4iIy2/wdp6ltCxx2fOgtAGj8Vc0ETUiIX7NlUh6SNZBVOdPnRTqRTE7/C+
         DHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc55pLmMUnApoCPs+yVxlc5yGp1x6f/rfLoLtc3lvA5W88UXBV+7KWilAcaTxO4mwoztXddFdjjk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeHP4Szhzjc8n95mie1jQ6OOxUpFywSu6yIpk5AgV80F0icOy
	1Xxzz1GDMAAtAOgfzsqYU0i/o2UW0CXtGPGlzcHwAwKpxpHGpXoYe/K0lDdE3ViAj4bd2VM9yy0
	7jv61ZTbQn2Gc10QUpGlsvQF1XbxYCZEXV/FoG14M9a4JcTMvOgtPVmftXGkZoQ==
X-Gm-Gg: ATEYQzy3iILjG0aQqn3m0Js4+wcPk/STENNLHzyfWvQAWQ0SIkKF/Vk+tahFm/MiWqz
	5fRWJDEwB0y9Vs2IbHEHTwwRDiWE4vOC8f3lEkvcxY98w8SCf+w3lMis3j/t4XAALYOxnvORGCh
	wvSRwRmraSWmEKyqpm7s5uetn/i2vdNjBs0W8/rO1nzULO7d6HBIuRxCrsgApqOQCFFUKK/aSlT
	cVgKeNKGZB3lepqCPsQSjNFqpOfZsgxgA8uUiEEkl/0XGYSWz1h/oBGPrtrD9f1PxB1XMH6DkUQ
	XTHkUJvFO+zNQVlnGdZJ+pvpwlI2atrquB+vPED5KyMIdBs9M8d5rWQp08LdJIcESjo0gROxRs+
	NunqwLuhOVnDBeUw=
X-Received: by 2002:a05:600c:35c2:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-483c9c1532emr281683655e9.26.1772532233477;
        Tue, 03 Mar 2026 02:03:53 -0800 (PST)
X-Received: by 2002:a05:600c:35c2:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-483c9c1532emr281682875e9.26.1772532232777;
        Tue, 03 Mar 2026 02:03:52 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126b35fbsm13372695e9.11.2026.03.03.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:03:51 -0800 (PST)
Date: Tue, 3 Mar 2026 11:03:49 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, mvaralar@redhat.com,
	francesco@valla.it, mst@redhat.com
Subject: [PATCH v11] can: virtio: Add virtio CAN driver
Message-ID: <aaayBa4vrtjdBTdb@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2DE361EC498
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6813-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mvaralar@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,pengutronix.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,opensynergy.com:email]
X-Rspamd-Action: no action

Add virtio CAN driver based on Virtio 1.4 specification (see
https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). The driver
implements a complete CAN bus interface over Virtio transport,
supporting both CAN Classic and CAN-FD Ids. In term of frames, it
supports classic and CAN FD. RTR frames are only supported with classic
CAN.

Usage:
- "ip link set up can0" - start controller
- "ip link set down can0" - stop controller
- "candump can0" - receive frames
- "cansend can0 123#DEADBEEF" - send frames

Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
Co-developed-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
Signed-off-by: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>
Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
Reviewed-by: Francesco Valla <francesco@valla.it>
Tested-by: Francesco Valla <francesco@valla.it>
Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
---
V11:
* Set CAN_VIRTIO_CAN config before CAN_XILINXCAN
* Use GFP_ATOMIC in virtio_can_alloc_tx_idx()
* Use open_candev() and set bittiming.bitrate to CAN_BITRATE_UNKNOWN and
  data_bittiming.bitrate to CAN_BITRATE_UNKNOWN
* Fix leak of skb by adding kfree_skb(skb)
* Fix out-of-bounds in virtio_can_populate_rx_vq()
* Initialize `ret`
* Use virtio_reset_device()
* Add napi_disable() in virtio_can_remove()
* Propagate error in virtio_can_start() and virtio_can_stop()

V10:
* Follow Reverse Christmas Tree convention

V9:
* Remove unnecessary comments
* Update maintainer list

V8:
* Address nits

V7:
* Address nits
* Remove unnecessary comments
* Remove io_callbacks[]
* Use guard() syntax
* Remove kicking for each inbuf
* replace sdu_len with rpkt_len
* Use devm_kzalloc()
* Use scoped_guard() to protect virtqueue_add_sgs() and virtqueue_kicks() for
  tx queue
* Tested with vhost-device-can
  (see https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-can) and
  Qemu (942b0d3) with [1]. A reviewer observed that the device stops to work
  after flooding from host. This issue is still present.

[1]
https://lore.kernel.org/qemu-devel/20251031155617.1223248-1-mvaralar@redhat.com/

V6:
* Address nits
* Check for error during register_virtio_can()
* Remove virtio_device_ready()
* Allocate virtio_can_rx rpkt[] at probe
* Define virtio_can_control struct
* Return VIRTIO_CAN_RESULT_NOT_OK after unlocking
* Define sdu[] as a flex array for both tx and rx. For rx, use
  VIRTIO_CAN_F_CAN_FD to figure out the max len for sdu
* Fix statistics in virtio_can_read_tx_queue() and
  how we indicate error to the user when getting
  VIRTIO_CAN_RESULT_NOT_OK
* Fix syntax of virtio_find_vqs()
* Drop tx_list
* Fix values of VIRTIO_CAN_F_LATE_TX_ACK and VIRTIO_CAN_F_RTR_FRAMES
* Tested with vhost-device-can
  (see
  https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-can)
  and qemu (see
  https://github.com/virtualopensystems/qemu/tree/vhu-can-rfc) 

V5:
* Re-base on top of linux-next (next-20240103)
* Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3

RFC V4:
* Apply reverse Christmas tree style
* Add member *classic_dlc to RX and TX CAN frames
* Fix race causing a NETDEV_TX_BUSY return
---
 MAINTAINERS                     |   9 +
 drivers/net/can/Kconfig         |  12 +
 drivers/net/can/Makefile        |   1 +
 drivers/net/can/virtio_can.c    | 964 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_can.h |  78 +++
 5 files changed, 1064 insertions(+)
 create mode 100644 drivers/net/can/virtio_can.c
 create mode 100644 include/uapi/linux/virtio_can.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 80cd3498c293..f295a904c93e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27068,6 +27068,15 @@ F:	drivers/scsi/virtio_scsi.c
 F:	include/uapi/linux/virtio_blk.h
 F:	include/uapi/linux/virtio_scsi.h
 
+VIRTIO CAN DRIVER
+M:	"Harald Mommer" <harald.mommer@oss.qualcomm.com>
+M:	"Matias Ezequiel Vara Larsen" <mvaralar@redhat.com>
+L:	virtualization@lists.linux.dev
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/virtio_can.c
+F:	include/uapi/linux/virtio_can.h
+
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit@kernel.org>
 L:	virtualization@lists.linux.dev
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index d43d56694667..f33ae46d9766 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -209,6 +209,18 @@ config CAN_TI_HECC
 	  Driver for TI HECC (High End CAN Controller) module found on many
 	  TI devices. The device specifications are available from www.ti.com
 
+config CAN_VIRTIO_CAN
+	depends on VIRTIO
+	tristate "Virtio CAN device support"
+	default n
+	help
+	  Say Y here if you want to support for Virtio CAN.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called virtio-can.
+
+	  If unsure, say N.
+
 config CAN_XILINXCAN
 	tristate "Xilinx CAN"
 	depends on ARCH_ZYNQ || ARM64 || MICROBLAZE || COMPILE_TEST
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 56138d8ddfd2..2ddea733ed5d 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
 obj-$(CONFIG_CAN_SJA1000)	+= sja1000/
 obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
+obj-$(CONFIG_CAN_VIRTIO_CAN)	+= virtio_can.o
 obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
 
 subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
new file mode 100644
index 000000000000..56031f840caa
--- /dev/null
+++ b/drivers/net/can/virtio_can.c
@@ -0,0 +1,964 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CAN bus driver for the Virtio CAN controller
+ *
+ * Copyright (C) 2021-2023 OpenSynergy GmbH
+ * Copyright Red Hat, Inc. 2025
+ */
+
+#include <linux/atomic.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/stddef.h>
+#include <linux/can/dev.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_can.h>
+
+/* CAN device queues */
+#define VIRTIO_CAN_QUEUE_TX 0
+#define VIRTIO_CAN_QUEUE_RX 1
+#define VIRTIO_CAN_QUEUE_CONTROL 2
+#define VIRTIO_CAN_QUEUE_COUNT 3
+
+#define CAN_KNOWN_FLAGS \
+	(VIRTIO_CAN_FLAGS_EXTENDED |\
+	 VIRTIO_CAN_FLAGS_FD |\
+	 VIRTIO_CAN_FLAGS_RTR)
+
+/* Max. number of in flight TX messages */
+#define VIRTIO_CAN_ECHO_SKB_MAX 128
+
+struct virtio_can_tx {
+	unsigned int putidx;
+	struct virtio_can_tx_in tx_in;
+	/* Keep virtio_can_tx_out at the end of the structure due to flex array */
+	struct virtio_can_tx_out tx_out;
+};
+
+struct virtio_can_control {
+	struct virtio_can_control_out cpkt_out;
+	struct virtio_can_control_in cpkt_in;
+};
+
+/* virtio_can private data structure */
+struct virtio_can_priv {
+	struct can_priv can;	/* must be the first member */
+	/* NAPI for RX messages */
+	struct napi_struct napi;
+	/* NAPI for TX messages */
+	struct napi_struct napi_tx;
+	/* The network device we're associated with */
+	struct net_device *dev;
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+	/* The virtqueues */
+	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
+	/* Lock for TX operations */
+	spinlock_t tx_lock;
+	/* Control queue lock */
+	struct mutex ctrl_lock;
+	/* Wait for control queue processing without polling */
+	struct completion ctrl_done;
+	/* Array of receive queue messages */
+	struct virtio_can_rx *rpkt;
+	struct virtio_can_control can_ctr_msg;
+	/* Data to get and maintain the putidx for local TX echo */
+	struct ida tx_putidx_ida;
+	/* In flight TX messages */
+	atomic_t tx_inflight;
+	/* Packet length */
+	int rpkt_len;
+	/* BusOff pending. Reset after successful indication to upper layer */
+	bool busoff_pending;
+};
+
+static void virtqueue_napi_schedule(struct napi_struct *napi,
+				    struct virtqueue *vq)
+{
+	if (napi_schedule_prep(napi)) {
+		virtqueue_disable_cb(vq);
+		__napi_schedule(napi);
+	}
+}
+
+static void virtqueue_napi_complete(struct napi_struct *napi,
+				    struct virtqueue *vq, int processed)
+{
+	int opaque;
+
+	opaque = virtqueue_enable_cb_prepare(vq);
+	if (napi_complete_done(napi, processed)) {
+		if (unlikely(virtqueue_poll(vq, opaque)))
+			virtqueue_napi_schedule(napi, vq);
+	} else {
+		virtqueue_disable_cb(vq);
+	}
+}
+
+static void virtio_can_free_candev(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+
+	ida_destroy(&priv->tx_putidx_ida);
+	free_candev(ndev);
+}
+
+static int virtio_can_alloc_tx_idx(struct virtio_can_priv *priv)
+{
+	int tx_idx;
+
+	tx_idx = ida_alloc_max(&priv->tx_putidx_ida,
+			       priv->can.echo_skb_max - 1, GFP_ATOMIC);
+	if (tx_idx >= 0)
+		atomic_inc(&priv->tx_inflight);
+
+	return tx_idx;
+}
+
+static void virtio_can_free_tx_idx(struct virtio_can_priv *priv,
+				   unsigned int idx)
+{
+	ida_free(&priv->tx_putidx_ida, idx);
+	atomic_dec(&priv->tx_inflight);
+}
+
+/* Create a scatter-gather list representing our input buffer and put
+ * it in the queue.
+ *
+ * Callers should take appropriate locks.
+ */
+static int virtio_can_add_inbuf(struct virtqueue *vq, void *buf,
+				unsigned int size)
+{
+	struct scatterlist sg[1];
+	int ret;
+
+	sg_init_one(sg, buf, size);
+
+	ret = virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC);
+
+	return ret;
+}
+
+/* Send a control message with message type either
+ *
+ * - VIRTIO_CAN_SET_CTRL_MODE_START or
+ * - VIRTIO_CAN_SET_CTRL_MODE_STOP.
+ *
+ */
+static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
+{
+	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
+	struct device *dev = &priv->vdev->dev;
+	unsigned int len;
+	int err;
+
+	guard(mutex)(&priv->ctrl_lock);
+
+	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
+	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
+		    sizeof(priv->can_ctr_msg.cpkt_out));
+	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
+
+	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
+	if (err != 0) {
+		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
+		return VIRTIO_CAN_RESULT_NOT_OK;
+	}
+
+	if (!virtqueue_kick(vq)) {
+		dev_err(dev, "%s(): Kick failed\n", __func__);
+		return VIRTIO_CAN_RESULT_NOT_OK;
+	}
+
+	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
+		wait_for_completion(&priv->ctrl_done);
+
+	return priv->can_ctr_msg.cpkt_in.result;
+}
+
+static int virtio_can_start(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	u8 result;
+
+	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_START);
+	if (result != VIRTIO_CAN_RESULT_OK) {
+		netdev_err(ndev, "CAN controller start failed\n");
+		return -EIO;
+	}
+
+	priv->busoff_pending = false;
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+}
+
+static int virtio_can_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	int err;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		err = virtio_can_start(dev);
+		if (err)
+			return err;
+		netif_wake_queue(dev);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int virtio_can_open(struct net_device *ndev)
+{
+	int err;
+
+	err = open_candev(ndev);
+	if (err)
+		return err;
+
+	err = virtio_can_start(ndev);
+	if (err) {
+		close_candev(ndev);
+		return err;
+	}
+
+	netif_start_queue(ndev);
+
+	return 0;
+}
+
+static int virtio_can_stop(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	struct device *dev = &priv->vdev->dev;
+	u8 result;
+
+	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STOP);
+	if (result != VIRTIO_CAN_RESULT_OK) {
+		dev_err(dev, "CAN controller stop failed\n");
+		return -EIO;
+	}
+
+	priv->busoff_pending = false;
+	priv->can.state = CAN_STATE_STOPPED;
+
+	/* Switch carrier off if device was connected to the bus */
+	if (netif_carrier_ok(ndev))
+		netif_carrier_off(ndev);
+
+	return 0;
+}
+
+static int virtio_can_close(struct net_device *dev)
+{
+	int err;
+
+	netif_stop_queue(dev);
+	/* Keep RX napi active to allow dropping of pending RX CAN messages,
+	 * keep TX napi active to allow processing of cancelled CAN messages
+	 */
+	err = virtio_can_stop(dev);
+	close_candev(dev);
+
+	return err;
+}
+
+static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
+					 struct net_device *dev)
+{
+	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
+	const unsigned int hdr_size = sizeof(struct virtio_can_tx_out);
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
+	netdev_tx_t xmit_ret = NETDEV_TX_OK;
+	struct virtio_can_tx *can_tx_msg;
+	u32 can_flags;
+	int putidx;
+	int err;
+
+	if (can_dev_dropped_skb(dev, skb))
+		goto kick; /* No way to return NET_XMIT_DROP here */
+
+	/* No local check for CAN_RTR_FLAG or FD frame against negotiated
+	 * features. The device will reject those anyway if not supported.
+	 */
+
+	can_tx_msg = kzalloc(sizeof(*can_tx_msg) + cf->len, GFP_ATOMIC);
+	if (!can_tx_msg) {
+		kfree_skb(skb);
+		dev->stats.tx_dropped++;
+		goto kick; /* No way to return NET_XMIT_DROP here */
+	}
+
+	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
+	can_flags = 0;
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		can_flags |= VIRTIO_CAN_FLAGS_EXTENDED;
+		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
+	} else {
+		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
+	}
+	if (cf->can_id & CAN_RTR_FLAG)
+		can_flags |= VIRTIO_CAN_FLAGS_RTR;
+	else
+		memcpy(can_tx_msg->tx_out.sdu, cf->data, cf->len);
+	if (can_is_canfd_skb(skb))
+		can_flags |= VIRTIO_CAN_FLAGS_FD;
+
+	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
+	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
+
+	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);
+	sg_init_one(&sg_in, &can_tx_msg->tx_in, sizeof(can_tx_msg->tx_in));
+
+	putidx = virtio_can_alloc_tx_idx(priv);
+
+	if (unlikely(putidx < 0)) {
+		/* -ENOMEM or -ENOSPC here. -ENOSPC should not be possible as
+		 * tx_inflight >= can.echo_skb_max is checked in flow control
+		 */
+		WARN_ON_ONCE(putidx == -ENOSPC);
+		kfree(can_tx_msg);
+		kfree_skb(skb);
+		dev->stats.tx_dropped++;
+		goto kick; /* No way to return NET_XMIT_DROP here */
+	}
+
+	can_tx_msg->putidx = (unsigned int)putidx;
+
+	/* Push loopback echo. Will be looped back on TX interrupt/TX NAPI */
+	can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);
+
+	/* Protect queue and list operations */
+	scoped_guard(spinlock_irqsave, &priv->tx_lock)
+		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
+
+	if (unlikely(err)) {
+		can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
+		virtio_can_free_tx_idx(priv, can_tx_msg->putidx);
+		netif_stop_queue(dev);
+		kfree(can_tx_msg);
+		/* Expected never to be seen */
+		netdev_warn(dev, "TX: Stop queue, err = %d\n", err);
+		xmit_ret = NETDEV_TX_BUSY;
+		goto kick;
+	}
+
+	/* Normal flow control: stop queue when no transmission slots left */
+	if (atomic_read(&priv->tx_inflight) >= priv->can.echo_skb_max ||
+	    vq->num_free == 0 || (vq->num_free < ARRAY_SIZE(sgs) &&
+	    !virtio_has_feature(vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))) {
+		netif_stop_queue(dev);
+		netdev_dbg(dev, "TX: Normal stop queue\n");
+	}
+
+kick:
+	if (netif_queue_stopped(dev) || !netdev_xmit_more()) {
+		scoped_guard(spinlock_irqsave, &priv->tx_lock) {
+			if (!virtqueue_kick(vq))
+				netdev_err(dev, "%s(): Kick failed\n", __func__);
+		}
+	}
+
+	return xmit_ret;
+}
+
+static const struct net_device_ops virtio_can_netdev_ops = {
+	.ndo_open = virtio_can_open,
+	.ndo_stop = virtio_can_close,
+	.ndo_start_xmit = virtio_can_start_xmit,
+};
+
+static int register_virtio_can_dev(struct net_device *dev)
+{
+	dev->flags |= IFF_ECHO;	/* we support local echo */
+	dev->netdev_ops = &virtio_can_netdev_ops;
+
+	return register_candev(dev);
+}
+
+static int virtio_can_read_tx_queue(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+	struct net_device *dev = can_priv->dev;
+	struct virtio_can_tx *can_tx_msg;
+	struct net_device_stats *stats;
+	unsigned int len;
+	u8 result;
+
+	stats = &dev->stats;
+
+	scoped_guard(spinlock_irqsave, &can_priv->tx_lock)
+		can_tx_msg = virtqueue_get_buf(vq, &len);
+
+	if (!can_tx_msg)
+		return 0;
+
+	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
+		netdev_err(dev, "TX ACK: Device sent no result code\n");
+		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
+	} else {
+		result = can_tx_msg->tx_in.result;
+	}
+
+	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
+		if (result != VIRTIO_CAN_RESULT_OK) {
+			struct can_frame *skb_cf;
+			struct sk_buff *skb = alloc_can_err_skb(dev, &skb_cf);
+
+			if (skb) {
+				skb_cf->can_id |= CAN_ERR_CRTL;
+				skb_cf->data[1] |= CAN_ERR_CRTL_UNSPEC;
+				netif_rx(skb);
+			}
+			netdev_warn(dev, "TX ACK: Result = %u\n", result);
+			can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
+			stats->tx_dropped++;
+		} else {
+			stats->tx_bytes += can_get_echo_skb(dev, can_tx_msg->putidx,
+				NULL);
+			stats->tx_packets++;
+		}
+	} else {
+		netdev_dbg(dev, "TX ACK: Controller inactive, drop echo\n");
+		can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
+		stats->tx_dropped++;
+	}
+
+	virtio_can_free_tx_idx(can_priv, can_tx_msg->putidx);
+
+	/* Flow control */
+	if (netif_queue_stopped(dev)) {
+		netdev_dbg(dev, "TX ACK: Wake up stopped queue\n");
+		netif_wake_queue(dev);
+	}
+
+	kfree(can_tx_msg);
+
+	return 1; /* Queue was not empty so there may be more data */
+}
+
+static int virtio_can_tx_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *dev = napi->dev;
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
+	int work_done = 0;
+
+	while (work_done < quota && virtio_can_read_tx_queue(vq) != 0)
+		work_done++;
+
+	if (work_done < quota)
+		virtqueue_napi_complete(napi, vq, work_done);
+
+	return work_done;
+}
+
+static void virtio_can_tx_intr(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+
+	virtqueue_disable_cb(vq);
+	napi_schedule(&can_priv->napi_tx);
+}
+
+/* This function is the NAPI RX poll function and NAPI guarantees that this
+ * function is not invoked simultaneously on multiple processors.
+ * Read a RX message from the used queue and sends it to the upper layer.
+ */
+static int virtio_can_read_rx_queue(struct virtqueue *vq)
+{
+	const unsigned int header_size = sizeof(struct virtio_can_rx);
+	struct virtio_can_priv *priv = vq->vdev->priv;
+	struct net_device *dev = priv->dev;
+	struct net_device_stats *stats;
+	struct virtio_can_rx *can_rx;
+	unsigned int transport_len;
+	struct canfd_frame *cf;
+	struct sk_buff *skb;
+	unsigned int len;
+	u32 can_flags;
+	u16 msg_type;
+	u32 can_id;
+	int ret;
+
+	stats = &dev->stats;
+
+	can_rx = virtqueue_get_buf(vq, &transport_len);
+	if (!can_rx)
+		return 0; /* No more data */
+
+	if (transport_len < header_size) {
+		netdev_warn(dev, "RX: Message too small\n");
+		goto putback;
+	}
+
+	if (priv->can.state >= CAN_STATE_ERROR_PASSIVE) {
+		netdev_dbg(dev, "%s(): Controller not active\n", __func__);
+		goto putback;
+	}
+
+	msg_type = le16_to_cpu(can_rx->msg_type);
+	if (msg_type != VIRTIO_CAN_RX) {
+		netdev_warn(dev, "RX: Got unknown msg_type %04x\n", msg_type);
+		goto putback;
+	}
+
+	len = le16_to_cpu(can_rx->length);
+	can_flags = le32_to_cpu(can_rx->flags);
+	can_id = le32_to_cpu(can_rx->can_id);
+
+	if (can_flags & ~CAN_KNOWN_FLAGS) {
+		stats->rx_dropped++;
+		netdev_warn(dev, "RX: CAN Id 0x%08x: Invalid flags 0x%x\n",
+			    can_id, can_flags);
+		goto putback;
+	}
+
+	if (can_flags & VIRTIO_CAN_FLAGS_EXTENDED) {
+		can_id &= CAN_EFF_MASK;
+		can_id |= CAN_EFF_FLAG;
+	} else {
+		can_id &= CAN_SFF_MASK;
+	}
+
+	if (can_flags & VIRTIO_CAN_FLAGS_RTR) {
+		if (!virtio_has_feature(vq->vdev, VIRTIO_CAN_F_RTR_FRAMES)) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: RTR not negotiated\n",
+				    can_id);
+			goto putback;
+		}
+		if (can_flags & VIRTIO_CAN_FLAGS_FD) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: RTR with FD not possible\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > 0xF) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: RTR with DLC > 0xF\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > 0x8)
+			len = 0x8;
+
+		can_id |= CAN_RTR_FLAG;
+	}
+
+	if (transport_len < header_size + len) {
+		netdev_warn(dev, "RX: Message too small for payload\n");
+		goto putback;
+	}
+
+	if (can_flags & VIRTIO_CAN_FLAGS_FD) {
+		if (!virtio_has_feature(vq->vdev, VIRTIO_CAN_F_CAN_FD)) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: FD not negotiated\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > CANFD_MAX_DLEN)
+			len = CANFD_MAX_DLEN;
+
+		skb = alloc_canfd_skb(priv->dev, &cf);
+	} else {
+		if (!virtio_has_feature(vq->vdev, VIRTIO_CAN_F_CAN_CLASSIC)) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: classic not negotiated\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > CAN_MAX_DLEN)
+			len = CAN_MAX_DLEN;
+
+		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
+	}
+	if (!skb) {
+		stats->rx_dropped++;
+		netdev_warn(dev, "RX: No skb available\n");
+		goto putback;
+	}
+
+	cf->can_id = can_id;
+	cf->len = len;
+	if (!(can_flags & VIRTIO_CAN_FLAGS_RTR)) {
+		/* RTR frames have a DLC but no payload */
+		memcpy(cf->data, can_rx->sdu, len);
+	}
+
+	if (netif_receive_skb(skb) == NET_RX_SUCCESS) {
+		stats->rx_packets++;
+		if (!(can_flags & VIRTIO_CAN_FLAGS_RTR))
+			stats->rx_bytes += cf->len;
+	}
+
+putback:
+	/* Put processed RX buffer back into avail queue */
+	ret = virtio_can_add_inbuf(vq, can_rx,
+				   priv->rpkt_len);
+	if (!ret)
+		virtqueue_kick(vq);
+	return 1; /* Queue was not empty so there may be more data */
+}
+
+static int virtio_can_handle_busoff(struct net_device *dev)
+{
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	if (!priv->busoff_pending)
+		return 0;
+
+	if (priv->can.state < CAN_STATE_BUS_OFF) {
+		netdev_dbg(dev, "entered error bus off state\n");
+
+		/* bus-off state */
+		priv->can.state = CAN_STATE_BUS_OFF;
+		priv->can.can_stats.bus_off++;
+		can_bus_off(dev);
+	}
+
+	/* propagate the error condition to the CAN stack */
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb))
+		return 0;
+
+	/* bus-off state */
+	cf->can_id |= CAN_ERR_BUSOFF;
+
+	/* Ensure that the BusOff indication does not get lost */
+	if (netif_receive_skb(skb) == NET_RX_SUCCESS)
+		priv->busoff_pending = false;
+
+	return 1;
+}
+
+static int virtio_can_rx_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *dev = napi->dev;
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
+	int work_done = 0;
+
+	work_done += virtio_can_handle_busoff(dev);
+
+	while (work_done < quota && virtio_can_read_rx_queue(vq) != 0)
+		work_done++;
+
+	if (work_done < quota)
+		virtqueue_napi_complete(napi, vq, work_done);
+
+	return work_done;
+}
+
+static void virtio_can_rx_intr(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+
+	virtqueue_disable_cb(vq);
+	napi_schedule(&can_priv->napi);
+}
+
+static void virtio_can_control_intr(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+
+	complete(&can_priv->ctrl_done);
+}
+
+static void virtio_can_config_changed(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *can_priv = vdev->priv;
+	u16 status;
+
+	status = virtio_cread16(vdev, offsetof(struct virtio_can_config,
+					       status));
+
+	if (!(status & VIRTIO_CAN_S_CTRL_BUSOFF))
+		return;
+
+	if (!can_priv->busoff_pending &&
+	    can_priv->can.state < CAN_STATE_BUS_OFF) {
+		can_priv->busoff_pending = true;
+		napi_schedule(&can_priv->napi);
+	}
+}
+
+static void virtio_can_populate_rx_vq(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
+	unsigned int buf_size = priv->rpkt_len;
+	int num_elements = vq->num_free;
+	u8 *buf = (u8 *)priv->rpkt;
+	unsigned int idx;
+	int ret = 0;
+
+	for (idx = 0; idx < num_elements; idx++) {
+		ret = virtio_can_add_inbuf(vq, buf, buf_size);
+		if (ret < 0) {
+			dev_dbg(&vdev->dev, "rpkt fill: ret=%d, idx=%u, size=%u\n",
+				ret, idx, buf_size);
+			break;
+		}
+		buf += buf_size;
+	}
+
+	if (!ret)
+		virtqueue_kick(vq);
+
+	dev_dbg(&vdev->dev, "%u rpkt added\n", idx);
+}
+
+static int virtio_can_find_vqs(struct virtio_can_priv *priv)
+{
+	struct virtqueue_info vqs_info[] = {
+		{ "can-tx", virtio_can_tx_intr },
+		{ "can-rx", virtio_can_rx_intr },
+		{ "can-state-ctrl", virtio_can_control_intr },
+	};
+
+	/* Find the queues. */
+	return virtio_find_vqs(priv->vdev, VIRTIO_CAN_QUEUE_COUNT, priv->vqs,
+			       vqs_info, NULL);
+}
+
+/* Function must not be called before virtio_can_find_vqs() has been run */
+static void virtio_can_del_vq(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	int q;
+
+	/* Reset the device */
+	virtio_reset_device(vdev);
+
+	/* From here we have dead silence from the device side so no locks
+	 * are needed to protect against device side events.
+	 */
+
+	for (q = 0; q < VIRTIO_CAN_QUEUE_COUNT; q++)
+		while (virtqueue_detach_unused_buf(priv->vqs[q]))
+			;
+
+	if (vdev->config->del_vqs)
+		vdev->config->del_vqs(vdev);
+}
+
+static void virtio_can_remove(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct net_device *dev = priv->dev;
+
+	napi_disable(&priv->napi);
+	napi_disable(&priv->napi_tx);
+
+	unregister_candev(dev);
+
+	virtio_can_del_vq(vdev);
+
+	virtio_can_free_candev(dev);
+}
+
+static int virtio_can_validate(struct virtio_device *vdev)
+{
+	/* CAN needs always access to the config space.
+	 * Check that the driver can access the config space
+	 */
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev,
+			"device does not comply with spec version 1.x\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int virtio_can_probe(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv;
+	struct net_device *dev;
+	int err;
+
+	dev = alloc_candev(sizeof(struct virtio_can_priv),
+			   VIRTIO_CAN_ECHO_SKB_MAX);
+	if (!dev)
+		return -ENOMEM;
+
+	priv = netdev_priv(dev);
+
+	ida_init(&priv->tx_putidx_ida);
+
+	netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
+	netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
+
+	SET_NETDEV_DEV(dev, &vdev->dev);
+
+	priv->dev = dev;
+	priv->vdev = vdev;
+	vdev->priv = priv;
+
+	priv->can.do_set_mode = virtio_can_set_mode;
+	priv->can.bittiming.bitrate = CAN_BITRATE_UNKNOWN;
+	/* Set Virtio CAN supported operations */
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
+		priv->can.fd.data_bittiming.bitrate = CAN_BITRATE_UNKNOWN;
+		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
+		if (err != 0)
+			goto on_failure;
+	}
+
+	/* Initialize virtqueues */
+	err = virtio_can_find_vqs(priv);
+	if (err != 0)
+		goto on_failure;
+
+	spin_lock_init(&priv->tx_lock);
+	mutex_init(&priv->ctrl_lock);
+
+	init_completion(&priv->ctrl_done);
+
+	priv->rpkt_len = sizeof(struct virtio_can_rx);
+
+	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
+		priv->rpkt_len += CANFD_MAX_DLEN;
+	else
+		priv->rpkt_len += CAN_MAX_DLEN;
+
+	priv->rpkt = devm_kzalloc(&vdev->dev, priv->rpkt_len *
+						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
+						GFP_KERNEL);
+	if (!priv->rpkt) {
+		virtio_can_del_vq(vdev);
+		err = -ENOMEM;
+		goto on_failure;
+	}
+	virtio_can_populate_rx_vq(vdev);
+
+	err = register_virtio_can_dev(dev);
+	if (err) {
+		virtio_can_del_vq(vdev);
+		goto on_failure;
+	}
+
+	napi_enable(&priv->napi);
+	napi_enable(&priv->napi_tx);
+
+	return 0;
+
+on_failure:
+	virtio_can_free_candev(dev);
+	return err;
+}
+
+static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct net_device *ndev = priv->dev;
+
+	napi_disable(&priv->napi);
+	napi_disable(&priv->napi_tx);
+
+	if (netif_running(ndev)) {
+		int err;
+
+		netif_stop_queue(ndev);
+		netif_device_detach(ndev);
+		err = virtio_can_stop(ndev);
+		if (err)
+			return err;
+	}
+
+	priv->can.state = CAN_STATE_SLEEPING;
+
+	virtio_can_del_vq(vdev);
+
+	return 0;
+}
+
+static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct net_device *ndev = priv->dev;
+	int err;
+
+	err = virtio_can_find_vqs(priv);
+	if (err != 0)
+		return err;
+	virtio_can_populate_rx_vq(vdev);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	if (netif_running(ndev)) {
+		virtio_can_start(ndev);
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
+	napi_enable(&priv->napi);
+	napi_enable(&priv->napi_tx);
+
+	return 0;
+}
+
+static struct virtio_device_id virtio_can_id_table[] = {
+	{ VIRTIO_ID_CAN, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static unsigned int features[] = {
+	VIRTIO_CAN_F_CAN_CLASSIC,
+	VIRTIO_CAN_F_CAN_FD,
+	VIRTIO_CAN_F_LATE_TX_ACK,
+	VIRTIO_CAN_F_RTR_FRAMES,
+};
+
+static struct virtio_driver virtio_can_driver = {
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = virtio_can_id_table,
+	.validate = virtio_can_validate,
+	.probe = virtio_can_probe,
+	.remove = virtio_can_remove,
+	.config_changed = virtio_can_config_changed,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_can_freeze,
+	.restore = virtio_can_restore,
+#endif
+};
+
+module_virtio_driver(virtio_can_driver);
+MODULE_DEVICE_TABLE(virtio, virtio_can_id_table);
+
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN bus driver for Virtio CAN controller");
diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio_can.h
new file mode 100644
index 000000000000..ade068188d22
--- /dev/null
+++ b/include/uapi/linux/virtio_can.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2021-2023 OpenSynergy GmbH
+ * Copyright Red Hat, Inc. 2025
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
+#define _LINUX_VIRTIO_VIRTIO_CAN_H
+
+#include <linux/types.h>
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+/* Feature bit numbers */
+#define VIRTIO_CAN_F_CAN_CLASSIC        0
+#define VIRTIO_CAN_F_CAN_FD             1
+#define VIRTIO_CAN_F_RTR_FRAMES         2
+#define VIRTIO_CAN_F_LATE_TX_ACK        3
+
+/* CAN Result Types */
+#define VIRTIO_CAN_RESULT_OK            0
+#define VIRTIO_CAN_RESULT_NOT_OK        1
+
+/* CAN flags to determine type of CAN Id */
+#define VIRTIO_CAN_FLAGS_EXTENDED       0x8000
+#define VIRTIO_CAN_FLAGS_FD             0x4000
+#define VIRTIO_CAN_FLAGS_RTR            0x2000
+
+#define VIRTIO_CAN_MAX_DLEN    64 // this is like CANFD_MAX_DLEN
+
+struct virtio_can_config {
+#define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */
+	/* CAN controller status */
+	__le16 status;
+};
+
+/* TX queue message types */
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX                   0x0001
+	__le16 msg_type;
+	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	__u8 padding;
+	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+	__le32 flags;
+	__le32 can_id;
+	__u8 sdu[] __counted_by(length);
+};
+
+struct virtio_can_tx_in {
+	__u8 result;
+};
+
+/* RX queue message types */
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX                   0x0101
+	__le16 msg_type;
+	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	__u8 padding;
+	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+	__le32 flags;
+	__le32 can_id;
+	__u8 sdu[] __counted_by(length);
+};
+
+/* Control queue message types */
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
+	__le16 msg_type;
+};
+
+struct virtio_can_control_in {
+	__u8 result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_CAN_H */
-- 
2.42.0


