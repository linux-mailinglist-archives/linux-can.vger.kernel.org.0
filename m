Return-Path: <linux-can+bounces-5974-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1441CEC75E
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 19:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6D2E300441B
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F682FFDEB;
	Wed, 31 Dec 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeugsZPD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E442C0F72
	for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205084; cv=none; b=KiqXw+BjuAoj4c7OjRrumlwrgrWfSif5cYqGncOuWmD3a8+S17W9KK7jHUW4YMC4APLlAhJomADPOv7rjO3pty9IAhT0X/xW//i/l/ni4NkITCIXabRDJFPHi4YeiLBXLyFUo431/CBU18cN0czNqF47RmnokHQjhC7y3DErBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205084; c=relaxed/simple;
	bh=BTzke5UMiMVL3wCJZvAqanY3V34uU419l/IqMBDWDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FE+EIHb4j09zwMsB29xTO38A4OBTnXqW+usfYDeSfED35QhASwoUwwpC0U5nx+qv99vVcJxyntvEhL8c+9uPr5n9YA/g3+xz6pzLJWcP5yNT9hSwOOl7bBCxRu2tMX/hkfaqR5ltYtNIV/F0dIQBduXRYyF/+e1vClzGr2L5B9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeugsZPD; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so6751031b3a.2
        for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767205081; x=1767809881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk5nNkPGMKxffcvL4HgXa7R0aYTHXmjldwY3CBQj3Pk=;
        b=BeugsZPDNFVU2QHfykbfA46DEv3hFWdlylAKcKmNXb0FBOX/KQ2h7B5Rm5s2AbCwyf
         7k3y+rcF/KMSuACndFNVeu3t8dp9nzhUtYZCzwbRHVFVaPLNxT/Xnkubm8VmHczqTqGJ
         Wkc/zWmk00gBitYVPI/+sEP+MzcHPRdILlZJ5+Ws/JIAR2Mbj57IGZhXhn8T3WFCSGYQ
         bjTuCQ7o/V5ZXp5aUIXoexQeD0sFbJrVyMd93zPMfn4FweFcfZ/Ek0y4rRbTIN4zp4aF
         pS6M88ipS8673fDLiEfOgsOewyKqC/KrYdrN20ihAKPk8hgAtFlAxeluKm4qYFK/Tpvq
         16vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767205081; x=1767809881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hk5nNkPGMKxffcvL4HgXa7R0aYTHXmjldwY3CBQj3Pk=;
        b=xOULGXuI61f695VDod9+6R2l4z8AorOisnVuY9zKYt6PrnPSGCg9n2WAlyJXVlJ5Od
         4SdR6sTGvo53m2x2JOJg1yiq6cTc3KBmE0SwGFlmXEQmYDedHuWAlHYdNgEAGIh+l6p9
         qEaEeXYkohEjyQTezXx6iHEcs80VqI2sG/zLbsETV1OkEIWtQbfDyv+XdxlY6CTpEHkO
         sw8/RSDYqTUetSQZBb5za2NgfwlXD1tZhzTlnGkmpz431N2j7H/I5sfZ4KH2bxdx1/0O
         dgzmWtO8FEgZEundeduU/TBbo9pVOwv5XwmL8D7hdsRcb3VjnOHK1YtRG6jg7P6JpQ9g
         AxcA==
X-Gm-Message-State: AOJu0YxZiGuvnpjJyNuOOERjKhZGUm60D6OOkl/mzNMIvWfseTIgz9dV
	Z2DJdMh6NVQit/3EHqjv1vcw8vB3k+54n/mR7fvDYNQjvGzrF15iYUxl
X-Gm-Gg: AY/fxX7YEYFl8LF5xC1cekk9fxTSvmt63Ge86cKPdv+JjrEnwDhrklLKIBAmG56k34x
	9rNQVuwba5Pa/tZyD7QoC0OwbOW/W6Ns8dwXyY/1kOV4eeJwDP2rl8i2yi0VTWqubdeXxATd+OL
	Fl0meLdAw6ervv+BX+TBz1Dr99bAoL/C8r9e6WBIdhTbrrTja2knGfuxz+npGgFSYoa9W6lsEtY
	SwjCMx+QWsjdn+eGmNIpAjDB4VnBXcgu7KTPTxWENUx3pGl8eHdhgoFAKm3WWNRYQD6jUG1P3Ol
	PyYpPLbT86Ypi3rgz4OfiPXIkUEGkcYgpJRQ50BLSKhn8aNumbVW5+VCk2tWfws5ni3Mugm8bYQ
	/jCrKCtAvwX/TdAuF1Z1JQIZb3GBUofaeBlgIGXv73Mn0Vqmj5vwM3d5vzrpMOZHlLhcD4K9GVE
	bPqzWzZGZwA+XsCyNG
X-Google-Smtp-Source: AGHT+IFRSSw4XW/PgulVcYnRG/6VI3grT5bh9VQQGSr/6qqM3up0kA1bqJVJKI2bIpPtrDdrEt/p2g==
X-Received: by 2002:a05:6a20:9392:b0:35b:4f5c:4adf with SMTP id adf61e73a8af0-376a96baae6mr30403198637.43.1767205080187;
        Wed, 31 Dec 2025 10:18:00 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:93ef:93d6:a0f7:dedb:d261:86b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm310787225ad.13.2025.12.31.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:17:59 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: rakuram.e96@gmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: can: update SocketCAN documentation for CAN XL
Date: Wed, 31 Dec 2025 23:43:16 +0530
Message-ID: <20251231-can_doc_update_v1-v1-2-97aac5c20a35@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
References: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767203695; l=36142; i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id; bh=EvJm5Z7ucjr9hus2ievx0N5MgT5+GQicaJWvpRCCuWI=; b=5CU4gGqjugB+rQOi3QRia35pw6cRbgVMkUlybdQ4sznbgnzbielCr/kXbP8DMtmlA0SGcwI1K oLywJsn08IEBw71RNBez4DTqGUxKzWQtONpRoPYmpYnt7r0mFcX3YwL
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519; pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=
Content-Transfer-Encoding: 8bit

Extend the SocketCAN documentation to cover CAN XL support, including
the updated frame layout, MTU definitions, mixed-mode operation, and
bitrate/XBTR configuration. The new text also explains how error
signalling behaviour differs between CAN FD, CAN XL mixed-mode, and
CAN-XL-only operation, as implemented in the current kernel stack.

In addition, provide example iproute2 "ip" tool commands demonstrating
how to configure CAN XL interfaces and corresponding bittiming
attributes.

These updates align the documentation with the behaviour of recent
CAN XL implementations and help users and developers set up correct
test environments.

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Tested the documentation build with Sphinx; no errors or warnings.

Used below command for testing:
     make htmldocs SPHINX_WARNINGS_LOG=warnings.log

 Documentation/networking/can.rst | 615 +++++++++++++++++++++++++++++++++------
 1 file changed, 518 insertions(+), 97 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d1016fb84b82ff3bfeef3813bf98f..67c94e44dddfcb7c503b2f0d644d1662b7d66576 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -5,7 +5,7 @@ SocketCAN - Controller Area Network
 Overview / What is SocketCAN
 ============================
 
-The socketcan package is an implementation of CAN protocols
+The SocketCAN package is an implementation of CAN protocols
 (Controller Area Network) for Linux.  CAN is a networking technology
 which has widespread use in automation, embedded devices, and
 automotive fields.  While there have been other CAN implementations
@@ -16,6 +16,11 @@ as similar as possible to the TCP/IP protocols to allow programmers,
 familiar with network programming, to easily learn how to use CAN
 sockets.
 
+SocketCAN covers Classical CAN (CAN 2.0B), CAN FD (Flexible Data Rate)
+and CAN XL (CAN with eXtended frame Length). All three generations
+share the same protocol family PF_CAN and socket API concepts, but use
+different frame structures and MTUs as described below.
+
 
 .. _socketcan-motivation:
 
@@ -109,11 +114,21 @@ As described in :ref:`socketcan-motivation` the main goal of SocketCAN is to
 provide a socket interface to user space applications which builds
 upon the Linux network layer. In contrast to the commonly known
 TCP/IP and ethernet networking, the CAN bus is a broadcast-only(!)
-medium that has no MAC-layer addressing like ethernet. The CAN-identifier
-(can_id) is used for arbitration on the CAN-bus. Therefore the CAN-IDs
-have to be chosen uniquely on the bus. When designing a CAN-ECU
-network the CAN-IDs are mapped to be sent by a specific ECU.
-For this reason a CAN-ID can be treated best as a kind of source address.
+medium that has no MAC-layer addressing like ethernet.
+
+For Classical CAN and CAN FD the CAN identifier (can_id) is used for
+arbitration on the CAN-bus. The CAN-IDs have to be chosen uniquely on
+the bus. When designing a CAN-ECU network the CAN-IDs are mapped to be
+sent by a specific ECU. For this reason a CAN-ID can be treated best
+as a kind of source address.
+
+For CAN XL the arbitration is performed on an 11 bit *priority* field
+in the ``prio`` element of the CAN XL frame. The field shares the same
+bit width as Classical CAN standard identifiers and is restricted by
+``CANXL_PRIO_MASK`` / ``CANXL_PRIO_BITS``. The remaining bits of ``prio``
+
+can optionally carry an 8-bit Virtual CAN Network Identifier (VCID) for
+logical separation of traffic.
 
 
 .. _socketcan-receive-lists:
@@ -228,8 +243,9 @@ send(2), sendto(2), sendmsg(2) and the recv* counterpart operations
 on the socket as usual. There are also CAN specific socket options
 described below.
 
-The Classical CAN frame structure (aka CAN 2.0B), the CAN FD frame structure
-and the sockaddr structure are defined in include/linux/can.h:
+The Classical CAN frame structure (aka CAN 2.0B), the CAN FD frame structure,
+the CAN XL frame structure and the sockaddr structure are defined in
+include/uapi/linux/can.h:
 
 .. code-block:: C
 
@@ -242,11 +258,11 @@ and the sockaddr structure are defined in include/linux/can.h:
                      */
                     __u8 len;
                     __u8 can_dlc; /* deprecated */
-            };
-            __u8    __pad;   /* padding */
-            __u8    __res0;  /* reserved / padding */
+            } __attribute__((packed)); /* disable padding added in some ABIs */
+            __u8    __pad;    /* padding */
+            __u8    __res0;   /* reserved / padding */
             __u8    len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
-            __u8    data[8] __attribute__((aligned(8)));
+            __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
     };
 
 Remark: The len element contains the payload length in bytes and should be
@@ -406,7 +422,7 @@ the CAN_RAW socket supports a new socket option CAN_RAW_FD_FRAMES that
 switches the socket into a mode that allows the handling of CAN FD frames
 and Classical CAN frames simultaneously (see :ref:`socketcan-rawfd`).
 
-The struct canfd_frame is defined in include/linux/can.h:
+The struct canfd_frame is defined in include/uapi/linux/can.h:
 
 .. code-block:: C
 
@@ -416,9 +432,23 @@ The struct canfd_frame is defined in include/linux/can.h:
             __u8    flags;   /* additional flags for CAN FD */
             __u8    __res0;  /* reserved / padding */
             __u8    __res1;  /* reserved / padding */
-            __u8    data[64] __attribute__((aligned(8)));
+            __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
     };
 
+The following flag bits are defined for ``canfd_frame.flags``:
+
+.. code-block:: C
+
+    #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
+    #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
+    #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
+
+The use of ``struct canfd_frame`` implies the FD Frame (FDF) bit to be set
+on the wire. Since the introduction of CAN XL, the CANFD_FDF flag is set in
+all CAN FD frame structures provided by the CAN subsystem of the Linux
+kernel. Applications can use this flag to distinguish CAN FD content when
+``struct canfd_frame`` is used for mixed Classical CAN / CAN FD payload.
+
 The struct canfd_frame and the existing struct can_frame have the can_id,
 the payload length and the payload data at the same offset inside their
 structures. This allows to handle the different structures very similar.
@@ -432,16 +462,81 @@ the easy handling of the length information the canfd_frame.len element
 contains a plain length value from 0 .. 64. So both canfd_frame.len and
 can_frame.len are equal and contain a length information and no DLC.
 For details about the distinction of CAN and CAN FD capable devices and
-the mapping to the bus-relevant data length code (DLC), see :ref:`socketcan-can-fd-driver`.
+the mapping to the bus-relevant data length code (DLC), see
+:ref:`socketcan-can-fd-driver`.
 
 The length of the two CAN(FD) frame structures define the maximum transfer
 unit (MTU) of the CAN(FD) network interface and skbuff data length. Two
-definitions are specified for CAN specific MTUs in include/linux/can.h:
+definitions are specified for CAN specific MTUs in include/uapi/linux/can.h:
+
+.. code-block:: C
+
+  #define CAN_MTU   (sizeof(struct can_frame))    /* Classical CAN frame */
+  #define CANFD_MTU (sizeof(struct canfd_frame))  /* CAN FD frame */
+
+Remark about CAN XL (extended frame length) support:
+
+CAN XL extends the payload length beyond CAN FD. The UAPI defines the
+following constants for CAN XL payload and DLC according to ISO 11898-1:
+
+.. code-block:: C
+
+    #define CANXL_MIN_DLC 0
+    #define CANXL_MAX_DLC 2047
+    #define CANXL_MAX_DLC_MASK 0x07FF
+    #define CANXL_MIN_DLEN 1
+    #define CANXL_MAX_DLEN 2048
+
+This means the CAN XL DLC ranges from 0 .. 2047 and maps to a data length
+range from 1 .. 2048 bytes. The CAN XL frame structure is defined as:
 
 .. code-block:: C
 
-  #define CAN_MTU   (sizeof(struct can_frame))   == 16  => Classical CAN frame
-  #define CANFD_MTU (sizeof(struct canfd_frame)) == 72  => CAN FD frame
+    struct canxl_frame {
+            canid_t prio;  /* 11 bit priority for arbitration / 8 bit VCID */
+            __u8    flags; /* additional flags for CAN XL */
+            __u8    sdt;   /* SDU (service data unit) type */
+            __u16   len;   /* frame payload length in byte */
+            __u32   af;    /* acceptance field */
+            __u8    data[CANXL_MAX_DLEN];
+    };
+
+The following flag bits are defined for ``canxl_frame.flags``:
+
+.. code-block:: C
+
+    #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
+    #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+    #define CANXL_RRS 0x02 /* Remote Request Substitution */
+
+The CANXL_XLF bit always needs to be set to indicate a valid CAN XL frame.
+Undefined bits in ``canxl_frame.flags`` are reserved and shall be set to
+zero. Setting CANXL_XLF intentionally breaks the length checks for Classical
+CAN and CAN FD frames, which allows the stack to distinguish CAN XL frames
+from CAN(FD) traffic.
+
+The 8-bit VCID (Virtual CAN Network Identifier) is optionally placed in the
+prio element and is described by:
+
+.. code-block:: C
+
+    #define CANXL_VCID_OFFSET   16
+    #define CANXL_VCID_VAL_MASK 0xFFUL
+    #define CANXL_VCID_MASK     (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
+
+The CAN XL MTU macros are:
+
+.. code-block:: C
+
+    #define CANXL_MTU      (sizeof(struct canxl_frame))
+    #define CANXL_HDR_SIZE (offsetof(struct canxl_frame, data))
+    #define CANXL_MIN_MTU  (CANXL_HDR_SIZE + 64)
+    #define CANXL_MAX_MTU  CANXL_MTU
+
+Drivers for CAN XL-capable devices select an MTU in the inclusive range
+[CANXL_MIN_MTU, CANXL_MAX_MTU] depending on the maximum payload supported
+by the hardware. Applications should use CANXL_MTU and the related macros
+instead of hardcoding numerical values.
 
 
 Returned Message Flags
@@ -490,7 +585,7 @@ RAW socket option CAN_RAW_FILTER
 The reception of CAN frames using CAN_RAW sockets can be controlled
 by defining 0 .. n filters with the CAN_RAW_FILTER socket option.
 
-The CAN filter structure is defined in include/linux/can.h:
+The CAN filter structure is defined in include/uapi/linux/can.h:
 
 .. code-block:: C
 
@@ -693,6 +788,10 @@ When sending to CAN devices make sure that the device is capable to handle
 CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
 The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
 
+For CAN XL-capable devices, applications should additionally consider the
+MTU range [CANXL_MIN_MTU, CANXL_MAX_MTU] and use ``struct canxl_frame``
+when the corresponding protocol and socket semantics are available.
+
 
 RAW socket option CAN_RAW_JOIN_FILTERS
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -746,8 +845,9 @@ The broadcast manager sends responses to user space in the same form:
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined
-at the beginning of :ref:`socketcan-rawfd` and in the include/linux/can.h include. All
-messages to the broadcast manager from user space have this structure.
+at the beginning of :ref:`socketcan-rawfd` and in the include/uapi/linux/can.h
+include. All messages to the broadcast manager from user space have this
+structure.
 
 Note a CAN_BCM socket must be connected instead of bound after socket
 creation (example without error checking):
@@ -1072,7 +1172,7 @@ Writing Own CAN Protocol Modules
 --------------------------------
 
 To implement a new protocol in the protocol family PF_CAN a new
-protocol has to be defined in include/linux/can.h .
+protocol has to be defined in include/uapi/linux/can.h .
 The prototypes and definitions to use the SocketCAN core can be
 accessed by including include/linux/can/core.h .
 In addition to functions that register the CAN protocol and the
@@ -1111,8 +1211,9 @@ alloc_netdev_mqs(), to automatically take care of CAN-specific setup:
 
     dev = alloc_candev_mqs(...);
 
-The struct can_frame or struct canfd_frame is the payload of each socket
-buffer (skbuff) in the protocol family PF_CAN.
+The struct can_frame, struct canfd_frame or struct canxl_frame is the payload
+of each socket buffer (skbuff) in the protocol family PF_CAN, depending on
+the device capabilities and the protocol in use.
 
 
 .. _socketcan-local-loopback2:
@@ -1172,8 +1273,8 @@ Deactivate the terminating resistor::
 To enable termination resistor support to a can-controller, either
 implement in the controller's struct can-priv::
 
-    termination_const
     termination_const_cnt
+    termination_const
     do_set_termination
 
 or add gpio control with the device tree entries from
@@ -1194,7 +1295,7 @@ so in common use cases more than one virtual CAN interface is needed.
 The virtual CAN interfaces allow the transmission and reception of CAN
 frames without real CAN controller hardware. Virtual CAN network
 devices are usually named 'vcanX', like vcan0 vcan1 vcan2 ...
-When compiled as a module the virtual CAN driver module is called vcan.ko
+When compiled as a module, the virtual CAN driver module is called vcan.ko
 
 Since Linux Kernel version 2.6.24 the vcan driver supports the Kernel
 netlink interface to create vcan network devices. The creation and
@@ -1237,52 +1338,164 @@ Setting CAN device properties::
 
     $ ip link set can0 type can help
     Usage: ip link set DEVICE type can
-        [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
-        [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
-          phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
-
-        [ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
-        [ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
-          dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
-
-        [ loopback { on | off } ]
-        [ listen-only { on | off } ]
-        [ triple-sampling { on | off } ]
-        [ one-shot { on | off } ]
-        [ berr-reporting { on | off } ]
-        [ fd { on | off } ]
-        [ fd-non-iso { on | off } ]
-        [ presume-ack { on | off } ]
-        [ cc-len8-dlc { on | off } ]
-
-        [ restart-ms TIME-MS ]
-        [ restart ]
-
-        Where: BITRATE       := { 1..1000000 }
-               SAMPLE-POINT  := { 0.000..0.999 }
-               TQ            := { NUMBER }
-               PROP-SEG      := { 1..8 }
-               PHASE-SEG1    := { 1..8 }
-               PHASE-SEG2    := { 1..8 }
-               SJW           := { 1..4 }
-               RESTART-MS    := { 0 | NUMBER }
+            [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
+            [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
+            phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
+
+            [ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
+            [ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
+            dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
+            [ tdcv TDCV tdco TDCO tdcf TDCF ]
+
+            [ loopback { on | off } ]
+            [ listen-only { on | off } ]
+            [ triple-sampling { on | off } ]
+            [ one-shot { on | off } ]
+            [ berr-reporting { on | off } ]
+            [ fd { on | off } ]
+            [ fd-non-iso { on | off } ]
+            [ presume-ack { on | off } ]
+            [ cc-len8-dlc { on | off } ]
+            [ tdc-mode { auto | manual | off } ]
+
+            [ restart-ms TIME-MS ]
+            [ restart ]
+
+            [ termination { 0..65535 } ]
+
+            Where: BITRATE	    := { NUMBER in bps }
+                    SAMPLE-POINT    := { 0.000..0.999 }
+                    TQ              := { NUMBER in ns }
+                    PROP-SEG        := { NUMBER in tq }
+                    PHASE-SEG1      := { NUMBER in tq }
+                    PHASE-SEG2      := { NUMBER in tq }
+                    SJW             := { NUMBER in tq }
+                    TDCV            := { NUMBER in tc }
+                    TDCO            := { NUMBER in tc }
+                    TDCF            := { NUMBER in tc }
+                    RESTART-MS      := { 0 | NUMBER in ms }
+
+Since IPROUTE2 version 6.18.0 the "ip" tool supports CAN XL devices
+and the following additional parameters.
+
+Setting CAN XL device properties::
+
+    $ ip link set can0 type can help
+    Usage: ip link set DEVICE type can
+            ...
+            [ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |
+            [ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1
+            xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]
+            [ xtdcv TDCV xtdco TDCO xtdcf TDCF pwms PWMS pwml PWML pwmo PWMO]
+            ...
+            [ restricted { on | off } ]
+            [ xl { on | off } ]
+            [ xtdc-mode { auto | manual | off } ]
+            [ tms { on | off } ]
+            ...
+            Where:
+                    ...
+                    PWMS        := { NUMBER in mtq }
+                    PWML        := { NUMBER in mtq }
+                    PWMO        := { NUMBER in mtq }
+                    RESTART-MS  := { 0 | NUMBER in ms }
+
+            Units:
+                    bps	:= bit per second
+                    ms	:= millisecond
+                    mtq	:= minimum time quanta
+                    ns	:= nanosecond
+                    tq	:= time quanta
 
 Display CAN device details and statistics::
 
+    $ ip link set can0 up type can bitrate 500000
+
+    $ ip -details -statistics link show can0
+    2: can0: <NOARP,UP,LOWER_UP> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+        link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
+        can state STOPPED restart-ms 0
+            bitrate 500000 sample-point 0.875
+            tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
+            dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+            dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+            tdco 0..127 tdcf 0..127
+            dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+            xtdco 0..127 xtdcf 0..127
+            pwms 1..8 pwml 2..24 pwmo 0..16
+            termination 0 [ 0, 120 ]
+            clock 160000000
+            re-started bus-errors arbit-lost error-warn error-pass bus-off
+            0          0          0          0          0          0
+            numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 \
+                tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
+        RX:  bytes packets errors dropped  missed   mcast
+                 0       0      0       0       0       0
+        TX:  bytes packets errors dropped carrier collsns
+                 0       0      0       0       0       0
+
+Display CAN XL device details and statistics::
+
+    $ ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on xbitrate 4000000 xl on
+
     $ ip -details -statistics link show can0
-    2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP qlen 10
-      link/can
-      can <TRIPLE-SAMPLING> state ERROR-ACTIVE restart-ms 100
-      bitrate 125000 sample_point 0.875
-      tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
-      sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
-      clock 8000000
-      re-started bus-errors arbit-lost error-warn error-pass bus-off
-      41         17457      0          41         42         41
-      RX: bytes  packets  errors  dropped overrun mcast
-      140859     17608    17457   0       0       0
-      TX: bytes  packets  errors  dropped carrier collsns
-      861        112      0       41      0       0
+    3: can0: <NOARP,UP,LOWER_UP> mtu 2060 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+        link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060
+        can <FD,TDC-AUTO,XL,XL-TDC-AUTO> state STOPPED restart-ms 0
+            bitrate 1000000 sample-point 0.750
+            tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
+            dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+            dbitrate 2000000 dsample-point 0.750
+            dtq 6 dprop-seg 29 dphase-seg1 30 dphase-seg2 20 dsjw 10 dbrp 1
+            tdco 60 tdcf 0
+            dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+            tdco 0..127 tdcf 0..127
+            xbitrate 4000000 xsample-point 0.750
+            xtq 6 xprop-seg 14 xphase-seg1 15 xphase-seg2 10 xsjw 5 xbrp 1
+            xtdco 30 xtdcf 0
+            dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+            xtdco 0..127 xtdcf 0..127
+            pwms 1..8 pwml 2..24 pwmo 0..16
+            termination 0 [ 0, 120 ]
+            clock 160000000
+            re-started bus-errors arbit-lost error-warn error-pass bus-off
+            0          0          0          0          0          0
+            addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 \
+                tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
+        RX:  bytes packets errors dropped  missed   mcast
+                 0       0      0       0       0       0
+        TX:  bytes packets errors dropped carrier collsns
+                 0       0      0      49       0       0
+
+Display CAN XL with TMS device details and statistics::
+
+    $ ip link set can0 type can bitrate 1000000 xbitrate 12308000 xl on tms on fd off
+
+    $ ip -details -statistics link show can0
+    3: can0: <NOARP,UP,LOWER_UP> mtu 2060 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+        link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060
+        can <XL,TMS> state STOPPED restart-ms 0
+            bitrate 1000000 sample-point 0.750
+            tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
+            dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+            dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+            tdco 0..127 tdcf 0..127
+            xbitrate 12307692 xsample-point 0.538
+            xtq 6 xprop-seg 3 xphase-seg1 3 xphase-seg2 6 xsjw 3 xbrp 1
+            pwms 4 pwml 9 pwmo 4
+            dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+            xtdco 0..127 xtdcf 0..127
+            pwms 1..8 pwml 2..24 pwmo 0..16
+            termination 0 [ 0, 120 ]
+            clock 160000000
+            re-started bus-errors arbit-lost error-warn error-pass bus-off
+	        0          0          0          0          0          0
+            addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 \
+                tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
+        RX:  bytes packets errors dropped  missed   mcast
+                 0       0      0       0       0       0
+        TX:  bytes packets errors dropped carrier collsns
+                 0       0      0       0       0       0
 
 More info to the above output:
 
@@ -1445,19 +1658,23 @@ Example configuring 500 kbit/s arbitration bitrate and 4 Mbit/s data bitrate::
     $ ip link set can0 up type can bitrate 500000 sample-point 0.75 \
                                    dbitrate 4000000 dsample-point 0.8 fd on
     $ ip -details link show can0
-    5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN \
-             mode DEFAULT group default qlen 10
-    link/can  promiscuity 0
-    can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
-          bitrate 500000 sample-point 0.750
-          tq 50 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1
-          pcan_usb_pro_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 \
-          brp-inc 1
-          dbitrate 4000000 dsample-point 0.800
-          dtq 12 dprop-seg 7 dphase-seg1 8 dphase-seg2 4 dsjw 1
-          pcan_usb_pro_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024 \
-          dbrp-inc 1
-          clock 80000000
+    3: can0: <NOARP,UP,LOWER_UP> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+        link/can  promiscuity 0 allmulti 0 minmtu 72 maxmtu 72
+        can <FD,TDC-AUTO> state STOPPED restart-ms 0
+            bitrate 500000 sample-point 0.750
+            tq 6 prop-seg 119 phase-seg1 120 phase-seg2 80 sjw 40 brp 1
+            dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+            dbitrate 4000000 dsample-point 0.800
+            dtq 6 dprop-seg 15 dphase-seg1 16 dphase-seg2 8 dsjw 4 dbrp 1
+            tdco 32 tdcf 0
+            dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+            tdco 0..127 tdcf 0..127
+            dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+            xtdco 0..127 xtdcf 0..127
+            pwms 1..8 pwml 2..24 pwmo 0..16
+            termination 0 [ 0, 120 ]
+            clock 160000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 \
+                tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
 
 Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
 
@@ -1508,24 +1725,228 @@ bitrate, a TDCO of 15 minimum time quantum and a TDCV automatically measured
 by the device::
 
     $ ip link set can0 up type can bitrate 500000 \
-                                   fd on dbitrate 4000000 \
-				   tdc-mode auto tdco 15
+                                    fd on dbitrate 4000000 \
+				    tdc-mode auto tdco 15
     $ ip -details link show can0
-    5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP \
-             mode DEFAULT group default qlen 10
+    3: can0: <NOARP,UP,LOWER_UP> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
         link/can  promiscuity 0 allmulti 0 minmtu 72 maxmtu 72
-        can <FD,TDC-AUTO> state ERROR-ACTIVE restart-ms 0
-          bitrate 500000 sample-point 0.875
-          tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 1
-          ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 \
-          brp_inc 1
-          dbitrate 4000000 dsample-point 0.750
-          dtq 12 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 2 dbrp 1
-          tdco 15 tdcf 0
-          ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 \
-          dbrp_inc 1
-          tdco 0..127 tdcf 0..127
-          clock 80000000
+        can <FD,TDC-AUTO> state STOPPED restart-ms 0
+            bitrate 500000 sample-point 0.875
+            tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
+            dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+            dbitrate 4000000 dsample-point 0.750
+            dtq 6 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 5 dbrp 1
+            tdco 15 tdcf 0
+            dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+            tdco 0..127 tdcf 0..127
+            dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+            xtdco 0..127 xtdcf 0..127
+            pwms 1..8 pwml 2..24 pwmo 0..16
+            termination 0 [ 0, 120 ]
+            clock 160000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 \
+                tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
+
+
+.. _socketcan-can-xl-driver:
+
+CAN XL (Extended Frame Length) Driver Support
+---------------------------------------------
+
+CAN XL extends the CAN protocol family with support for payloads up to
+2048 bytes and additional header fields for service data unit (SDU)
+typing, security/segmentation and virtual channel identification (VCID).
+These extensions enable more flexible and higher-bandwidth communication
+compared to Classical CAN and CAN FD.
+
+The CAN XL netdevice driver capabilities can be distinguished by the network
+devices maximum transfer unit (MTU)::
+
+  Minimum MTU: CANXL_MIN_MTU (supports at least 64 bytes of payload)
+  Maximum MTU: CANXL_MAX_MTU (supports up to 2048 bytes of payload)
+
+The MTU can be queried using SIOCGIFMTU, just like with Classical CAN and CAN FD.
+In a typical configuration you may see, for
+
+Example::
+
+    can0: MTU: 2060
+
+This corresponds to a CAN XL frame with 2048 bytes of payload (plus protocol overhead).
+
+Configuring CAN XL bitrates and modes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Similar to the existing "bitrate" and "dbitrate" parameters used for
+Classical CAN and CAN FD, CAN XL introduces a separate "xbitrate" used
+for the CAN XL data phase. In addition, CAN XL capable controllers can
+be configured in different operating modes:
+
+- Classical CAN / CAN FD / CAN XL mixed mode
+- CAN XL-only mode
+- Optional Transceiver Mode Switching (TMS) when supported
+
+Examples (assuming ``can0`` is a CAN XL capable interface, e.g. provided
+by the dummy_can driver):
+
+Mixed Classical CAN / FD / XL mode with CAN XL enabled and TMS disabled::
+
+    # ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on \
+                                                    xbitrate 4000000 xl on
+
+CAN XL-only mode with TMS enabled and CAN FD disabled::
+
+    # ip link set can0 type can bitrate 1000000 xbitrate 12308000 xl on \
+                                                            tms on fd off
+
+Enable the debugging to see the output in dmesg::
+
+    # echo 'file drivers/net/can/dummy_can.c +p' > /sys/kernel/debug/dynamic_debug/control
+
+After setting the interface up with::
+
+    # ip link set can0 up
+
+the controller configuration can be inspected in the kernel log, for
+example::
+
+    can0: Clock frequency: 160000000
+    can0: Maximum bitrate: 20000000
+    can0: MTU: 2060
+    can0:
+    can0: Control modes:
+    can0: 	supported: 0x0000ba2
+    can0: 	enabled: 0x00003220
+    can0: 	list:
+    can0: 		LISTEN-ONLY: off
+    can0: 		FD: on
+    can0: 		TDC-AUTO: on
+    can0: 		RESTRICTED: off
+    can0: 		XL: on
+    can0: 		XL-TDC-AUTO: on
+    can0: 		TMS: off
+    can0:
+    can0: Classical CAN nominal bittiming:
+    can0: 	bitrate: 1000000
+    ...
+    can0: CAN FD databittiming:
+    can0:   bitrate: 2000000
+    ...
+    can0:   CAN FD TDC:
+    ...
+    can0:
+    can0: CAN XL databittiming:
+    can0: 	bitrate: 4000000
+    can0: 	sample_point: 750
+    can0: 	tq: 6
+    can0: 	prop_seg: 14
+    can0: 	phase_seg1: 15
+    can0: 	phase_seg2: 10
+    can0: 	sjw: 5
+    can0: 	brp: 1
+    can0: 	CAN XL TDC:
+    can0: 		tdcv: 0
+    can0: 		tdco: 30
+    can0: 		tdcf: 0
+    can0:
+    can0: error-signalling is enabled
+    can0: dummy-can is up
+
+This shows:
+
+- the configured MTU (here 2060, i.e. CANXL_MTU),
+- which control modes are enabled (FD, XL, XL-TDC-AUTO, TMS, etc.),
+- separate bit-timing blocks for Classical CAN, CAN FD and CAN XL, and
+- separate TDC information for CAN FD and CAN XL.
+
+Error Signalling Behaviour in CAN CC, CAN FD and CAN XL
+-------------------------------------------------------
+
+Classical CAN (CC) and CAN FD controllers implement mandatory
+error-signalling (ES) to report protocol and frame format violations
+by transmitting an error frame on the bus.
+
+With the introduction of CAN XL two operational models exist:
+
+* **Mixed-mode**: A CAN segment contains XL-tolerant CAN FD nodes and
+  CAN XL nodes. In this mode the FD controllers may transmit CC/FD
+  frames, while XL controllers may transmit CC/FD/XL frames.  Error
+  signalling remains enabled and is used consistently across all frame
+  types.
+
+* **CANXL-only mode**: The CAN XL controller disables error-signalling.
+  This mode allows transmission of CAN XL frames only and additionally
+  supports the optional Transceiver Mode Switching (TMS).  CC and FD
+  frames must not be sent in this mode.
+
+The operational mode is derived from the controller flags
+``CAN_CTRLMODE_FD`` and ``CAN_CTRLMODE_XL``:
+
++---------+---------+---------------------------+-------+----------------------------+
+|  FD     |   XL    | Mode                      |  ES   | Notes                      |
++=========+=========+===========================+=======+============================+
+|   0     |   0     | CC-only                   |   1   | Classical CAN              |
++---------+---------+---------------------------+-------+----------------------------+
+|   1     |   0     | FD/CC mixed-mode          |   1   | Standard CAN FD operation  |
++---------+---------+---------------------------+-------+----------------------------+
+|   1     |   1     | XL/FD/CC mixed-mode       |   1   | All frame types allowed    |
++---------+---------+---------------------------+-------+----------------------------+
+|   0     |   1     | CANXL-only                |   0   | XL-only; TMS optional      |
++---------+---------+---------------------------+-------+----------------------------+
+
+Note about error-signalling
+---------------------------
+
+The error-signalling behaviour is derived automatically from the selected
+mixed-mode or CANXL-only configuration and is no longer controlled by an
+explicit netlink attribute.
+
+The effective state can be observed in the kernel log, for example::
+
+    can0: error-signalling is enabled
+
+Applications should rely on the controller mode and driver output rather
+than on an explicit ``err-signal`` configuration switch.
+
+CAN XL TDC (Transmitter Delay Compensation)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Similar to CAN FD, the high data phase bitrates in CAN XL may require
+Transmitter Delay Compensation. CAN XL capable controllers can provide
+an XL-specific TDC configuration and may support an automatic mode.
+
+If supported by the device, the XL TDC settings (TDCV/TDCO/TDCF) are
+reported in the "CAN XL TDC" section in the kernel log, for example::
+
+    can0: 	CAN XL TDC:
+    can0: 		tdcv: 0
+    can0: 		tdco: 30
+    can0: 		tdcf: 0
+
+The precise netlink attributes and the corresponding "ip" options for
+XL TDC are controller specific and follow the same design as CAN FD TDC
+where possible. Users should consult the device driver documentation
+and the output of::
+
+    $ ip -details link show can0
+
+for details on XL TDC support.
+
+Application considerations for CAN XL
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For user space applications the following rules are important when
+handling CAN XL:
+
+- Use ``struct canxl_frame`` as basic data structure when CAN XL traffic
+  is expected.
+- Set CANXL_XLF in ``canxl_frame.flags`` for all valid CAN XL frames.
+- Ensure that undefined bits in ``canxl_frame.flags`` are kept at zero.
+- Respect the configured device MTU; do not send frames larger than
+  the MTU announced by the kernel.
+- For mixed-mode controllers, be prepared to handle Classical CAN,
+  CAN FD and CAN XL frames on the same interface and choose the frame
+  structure according to the socket/protocol semantics (e.g. dedicated
+  CAN XL APIs when available).
 
 
 Supported CAN Hardware

-- 
2.51.0


