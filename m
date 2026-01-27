Return-Path: <linux-can+bounces-6318-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIVqIQICeWmOuQEAu9opvQ
	(envelope-from <linux-can+bounces-6318-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 19:20:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B898F20
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEBB303CD01
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997962222AA;
	Tue, 27 Jan 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu9WpsMm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oTcxZA67"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C522D7B9
	for <linux-can@vger.kernel.org>; Tue, 27 Jan 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537997; cv=none; b=lUMWyiakgn2PpuVTsG//JDg+sctW5dd+rLQg1nxiwniBgsEt9UmBsvvh28SpgBorqPROj9yw+hT1J8sw8T8L68cHYy8bzJcgBeXrmzohvONj5Sk97apPnSu+cQFBKasTPasZj8naJRe8VC21o80VHacCvaGfTW/c4PtxkPE2B2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537997; c=relaxed/simple;
	bh=GI11GnkfGJr27ZMrgvAVegSGAL0vFdDzzqahx5McHbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pal4pf3Ct96+gWuE/6LFSqKpin4amX0v8D8bN0DiRWdiV0GOR+EFHbU0js9zuAVteMvr0+dlpbt6BoJ2MTz8NvsUEFiUNUwWLvezGXk3EyM7M5FPOB2iZ9hziRPCXVbcrQnji0upeKAMurobfkdiMnGy8RUx+t9NRUoP8jZHjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mu9WpsMm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oTcxZA67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769537994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0trcQZiR/+oHbQ1pstjVD2h6ZnZcMqt439rbjSNh/54=;
	b=Mu9WpsMmferMzgE8Ly3fC0MgZMhkwlSGPmdW0rNSxndGqfpzDOomjS0qV9ADXfFxnqWusG
	bGmd9AnwBeRnk5Y4v9rxiuOobv3QRUap+mW2M2EKop2iVXBGV/B+7tznIIKwosvh5i2HPg
	AXtHX6qeS9WYis4InaBFwllugVf/jtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-FQg1Wrs9OjSRPKlgsFIB6Q-1; Tue, 27 Jan 2026 13:19:52 -0500
X-MC-Unique: FQg1Wrs9OjSRPKlgsFIB6Q-1
X-Mimecast-MFC-AGG-ID: FQg1Wrs9OjSRPKlgsFIB6Q_1769537991
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fb1c2c403so4160662f8f.3
        for <linux-can@vger.kernel.org>; Tue, 27 Jan 2026 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769537991; x=1770142791; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0trcQZiR/+oHbQ1pstjVD2h6ZnZcMqt439rbjSNh/54=;
        b=oTcxZA67baHzAtFRaLKGuwJV+kNyTTx96E6yRsLuzz26Q78ObJdPyStpMQ+UwsJWJq
         iFMVesEsRx8K2RAQKtmWri+gz4biCr3HLCT+VODcOf+9lpl96VgX2O8CnDV35/kJAq+H
         MhmgslfLmEK2VUeWjcMrO0lFWVxxD5AUHkUBRs4HBarIi74d6sECBJpwly9+o4nKc8EL
         wKDqlCwPD0N9kooAWkYbaGH718jOLC07F8yXyM9FiTDkOktLKg4nRPjtWk1YtYxFUXx5
         ZH5+azwuv+jCRTkRBfkIFRkJt/mD55SsGBj9TGblYljgHn5lbnBZZPQGTIYS9PFt1hvf
         T/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537991; x=1770142791;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0trcQZiR/+oHbQ1pstjVD2h6ZnZcMqt439rbjSNh/54=;
        b=di2f3mzQdTv2GR86KhCt5dihdALoMjm3an6GKLn3MyJ/giL7r8xFt+ewnyPo4W+8h/
         BG5itZdTruhqEUZ8JdPqTuPaGUPdtxvMOi+kNHziBXy2xq3HIptC0U+TXXjVj7IJi5K1
         aafZa7MLOSsY2y/NYAXn3tZjGoGCtLsKIXR4Q+SQ01ILv9av2SPug2SVRhTzhSdLvcvt
         53sx7tBYv6pzXVDjGYACqMDBv6HwcHjeJq5RpixEa6JuS0Mbm/SCZhFRDnuZuJL6NdwZ
         UqOOH1BFQ3Ob8ralak4QX1qtMtztj/fIlAq7eUU3q9CPLdaA50iRlFIL04ojVnklNp5M
         nXQw==
X-Forwarded-Encrypted: i=1; AJvYcCUANADK3QEqZ3WvKRCnRdBx/7Rd5dzTAyIp/KNp4/3DtOlvCbCX5hB+RzG3qK3r7Kj1jytbdpnFfKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLN0ZxiTz8wBIX15FYzU0VWkRzk4QeBZ+wG0N3tfbk5sez6vIK
	IYpdezslPGBcoijAEzTY+uz3GuYOe3WA2WG5zfZVwLqvSjXoR4g240mA+Po29xv6KyOel4aBfdk
	JZT+3FzrhD5ctMVS1V7cU81cR6wUtPoR9XSJL8b20C6l3318HWxfC4sABJfGlIw==
X-Gm-Gg: AZuq6aLTVtZ671Uip1C97Ssk2TjSytFVxP40wsdRveyR1u7F8fiWSkxRhP4SjuNNpPU
	ozuJfhYC4VclhsAHs5rnn8O3uanuxWkjKfq4XlohDkEmzj/dUND6tU6X9F4dEiU3EE3la9HGTuR
	mCmoNL+oYi/n52q77iTPdJflRAXq+5lz/05/h6WnRYE/b+thGD2JCMQSOTSjZ3iXqg//f33+yMK
	+FHUWqvb6fNqplYuTcUtyzk3JjiwYyyn/uHxDVmr6C/dTAepcSoL7FiLPafnai3Fzo0yWf7rA04
	0mPDtUy8T4su4/pPjeXrcoSWTmZeQXkdkHDDQcPW7Omzh/CAD1rM+fkNYyZjfdJspra7mGt8/XF
	W84c=
X-Received: by 2002:a05:6000:22c9:b0:435:bd00:3978 with SMTP id ffacd0b85a97d-435dd1d3268mr4045954f8f.60.1769537990908;
        Tue, 27 Jan 2026 10:19:50 -0800 (PST)
X-Received: by 2002:a05:6000:22c9:b0:435:bd00:3978 with SMTP id ffacd0b85a97d-435dd1d3268mr4045898f8f.60.1769537990194;
        Tue, 27 Jan 2026 10:19:50 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e135422csm557205f8f.40.2026.01.27.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:19:49 -0800 (PST)
Date: Tue, 27 Jan 2026 19:19:47 +0100
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
Subject: [PATCH v9] can: virtio: Add virtio CAN driver
Message-ID: <aXkBw2CDPofvihv2@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6318-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mvaralar@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,qualcomm.com:email,opensynergy.com:email,pengutronix.de:email]
X-Rspamd-Queue-Id: A89B898F20
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
 drivers/net/can/virtio_can.c    | 934 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_can.h |  78 +++
 5 files changed, 1034 insertions(+)
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
index d43d56694667..7b5806f11853 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -217,6 +217,18 @@ config CAN_XILINXCAN
 	  Xilinx CAN driver. This driver supports both soft AXI CAN IP and
 	  Zynq CANPS IP.
 
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
 source "drivers/net/can/c_can/Kconfig"
 source "drivers/net/can/cc770/Kconfig"
 source "drivers/net/can/ctucanfd/Kconfig"
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
index 000000000000..905f55beb1f4
--- /dev/null
+++ b/drivers/net/can/virtio_can.c
@@ -0,0 +1,934 @@
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
+				 priv->can.echo_skb_max - 1, GFP_KERNEL);
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
+	struct device *dev = &priv->vdev->dev;
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
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
+static void virtio_can_start(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	u8 result;
+
+	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_START);
+	if (result != VIRTIO_CAN_RESULT_OK)
+		netdev_err(ndev, "CAN controller start failed\n");
+
+	priv->busoff_pending = false;
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	/* Switch carrier on if device was not connected to the bus */
+	if (!netif_carrier_ok(ndev))
+		netif_carrier_on(ndev);
+}
+
+static int virtio_can_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	switch (mode) {
+	case CAN_MODE_START:
+		virtio_can_start(dev);
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
+	virtio_can_start(ndev);
+
+	netif_start_queue(ndev);
+
+	return 0;
+}
+
+static void virtio_can_stop(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	struct device *dev = &priv->vdev->dev;
+	u8 result;
+
+	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STOP);
+	if (result != VIRTIO_CAN_RESULT_OK)
+		dev_err(dev, "CAN controller stop failed\n");
+
+	priv->busoff_pending = false;
+	priv->can.state = CAN_STATE_STOPPED;
+
+	/* Switch carrier off if device was connected to the bus */
+	if (netif_carrier_ok(ndev))
+		netif_carrier_off(ndev);
+}
+
+static int virtio_can_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+	/* Keep RX napi active to allow dropping of pending RX CAN messages,
+	 * keep TX napi active to allow processing of cancelled CAN messages
+	 */
+	virtio_can_stop(dev);
+	close_candev(dev);
+
+	return 0;
+}
+
+static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
+					 struct net_device *dev)
+{
+	const unsigned int hdr_size = sizeof(struct virtio_can_tx_out);
+	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	netdev_tx_t xmit_ret = NETDEV_TX_OK;
+	struct virtio_can_tx *can_tx_msg;
+	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
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
+	int ret;
+	struct canfd_frame *cf;
+	struct sk_buff *skb;
+	unsigned int len;
+	u32 can_flags;
+	u16 msg_type;
+	u32 can_id;
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
+	struct virtio_can_rx *buf = priv->rpkt;
+	unsigned int idx;
+	unsigned int buf_size = priv->rpkt_len;
+	int ret;
+	int num_elements = vq->num_free;
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
+	if (vdev->config->reset)
+		vdev->config->reset(vdev);
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
+	/* Set Virtio CAN supported operations */
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
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
+		netif_stop_queue(ndev);
+		netif_device_detach(ndev);
+		virtio_can_stop(ndev);
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


