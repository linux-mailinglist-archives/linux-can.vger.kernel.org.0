Return-Path: <linux-can+bounces-5751-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EBBC90012
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 20:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596493A9B4F
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4C304BA6;
	Thu, 27 Nov 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkE4jsia"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367DE30499A
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271187; cv=none; b=C9vsrp8vIVblwaoSAp+aEUrGG8Fy9up0lqUJN8Lxe9LF9hTBs/FvThUfbLedn042CLqBWtU+SIRLywUzJz7/lhN3tmRjK4kHu+cBu84vCo8bkNIZu31L0apObpiXcLKR8dC0TpvE6Vpbrdrq3xH4g0IzLCY89miEI/SfKsiUWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271187; c=relaxed/simple;
	bh=ltgzoKtmPcHU7kxmG2ABinBijLEEBblnQbZTIW5X5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqxfAkWCCmNtNievMMQczC+8j4hvlRdu6aj3BqVtv/v4EYKRrpBKxXnExX/fm7nyV8+PUhBENUU1SA0xdeCXRP6k/oJekMDtjmOwe/P69XMHrKrpisdHtjMWCq8E8gBwqNrY2o+kSACOsG+sOIztMGkERQHsv1960j+5KAyZ0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkE4jsia; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so1253962b3a.0
        for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764271184; x=1764875984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLuLYT2TrBtDIGPjo8qeBlZO/H7986tS5S8+VaQQgHM=;
        b=UkE4jsiaTFgbR9npwiS4TGaVVORPnb9p01cSUIFm3OiCMHCQGvmPRtvUU1v21FfH8A
         0JcBadSLZCH4J9UodE82hrXHfWNMXWAabC5GJajtb42dsXLaBgCUeBkN/SyLTg+tjtPt
         CXW/sfiO30h0/w4pWaOUsLMD9NpUlQXAQTnQi193YISL0SefGwP6O7dimCSBZC+avhLC
         NWkzfseR2X9Zds90eB782/cJWM4DO+RVX6zZQvFhofGV6lWmEV4vKg38PPQFOBVXAsVo
         EhQtL7Wb8v8BdeWEWd0qykxb0X8Nzo2EApVKxdU35mzrAQB0HXi87TEYHV/DQqWMweRZ
         BV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271184; x=1764875984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLuLYT2TrBtDIGPjo8qeBlZO/H7986tS5S8+VaQQgHM=;
        b=l+b3oro7VQUeMyw1MZMLfrk6N1MuGaWFpXGH/NXTtx84wHLZMx5jOZmVYCpaSka5b7
         +0I1r908+o/yRGcJUeoIxY7Jig7nAY6CF/AOWLjVIKHYMpxdmsatJJKf5ybx7RfP6rvg
         BlXb0dbucQnvppEH9CzD0MwdISVMdXjcFBaoyEhEHOE4Yioc/LwkIPlGlHzjUnpSMpuF
         /kpqM9RWoGc8NSZR3oUXMWOQ6bATwuSgAwSDk92AhQYJ9TTXq9fBswqNsfmINUsnwl1/
         12Y2zMWxT9AAucSwTgbgkhhQydck5WsUw0haDY51PDVBPfyY3miCQ29AleK7aRjxVnr7
         nKnw==
X-Gm-Message-State: AOJu0Yzo9HYcwBHGkErj2h+ODvjvhpiesRZldnDgqU3D+R5OEjQUyTVq
	lZyqhsYjp1rPpBGwMq4r1f14Fsw6Ywtz400MccN7PVTKzlzJLE/N1Xz6MnMPVPgzUs8=
X-Gm-Gg: ASbGncu4Gis+uidfab8BVTeF2gcg3KkZM6CHuwRljQGufE/Q76o28A0HwbQ5Y2kT+Wv
	N8GL15PClT1bQFWNdCFrdjIiJQnDgXrWFSwCBcS07YSWTWHHM9UME3b0qruJi7pFWkyoQGWKlfn
	QgSvTnzuyRRiYCT0VPJLU0njLj6LFnPgc9NRkWNOjtyczC/Pz92uEjQDh3aXjwbT+fh1lqHfLka
	m4PhWyrysog8Ch6gdYZ32Eh8dezM/jDhfmQuCxK/tL7Ps0x3zwSGErl4gY5UwbMgBnIdu5ekFA+
	O+Ph3EB/tX8tIbx5AT+OgSm0WGHOw+y3dB+C8MTh/fj28g4ySDDz9OxXHq6rNO3aK6cyn/KQHtl
	/KgM0Lr9vD49w4V3HKV9nTsuU9sNcSDez0+CNDz1neeUs/1Hmx2ScDJuaxGuybIF6XIjgFN3acv
	jds0x4+GDXwoQ209Qi
X-Google-Smtp-Source: AGHT+IHiC23seufR4Y9IKMsPcVCraCt1Lgv/xemwPblgMHP5TgbSVB8KjjzbIuCayPMj6G+DodU3cQ==
X-Received: by 2002:a05:6a00:13a4:b0:7ab:fc99:d856 with SMTP id d2e1a72fcca58-7c58db2cccdmr27221140b3a.18.1764271183879;
        Thu, 27 Nov 2025 11:19:43 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:211f:b50d:1190:e256:8b21:a462])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f176096sm2620703b3a.57.2025.11.27.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 11:19:43 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	socketcan@hartkopp.net,
	mailhol@kernel.org,
	khalid@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rakuram.e96@gmail.com,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [RFC PATCH 2/2] docs: can: update SocketCAN documentation for CAN XL
Date: Fri, 28 Nov 2025 00:48:08 +0530
Message-ID: <20251127191808.144723-3-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127191808.144723-1-rakuram.e96@gmail.com>
References: <20251127191808.144723-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

 Documentation/networking/can.rst | 470 ++++++++++++++++++++++++++++---
 1 file changed, 433 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d..08c932bb516f 100644
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
 
 .. code-block:: C
 
-  #define CAN_MTU   (sizeof(struct can_frame))   == 16  => Classical CAN frame
-  #define CANFD_MTU (sizeof(struct canfd_frame)) == 72  => CAN FD frame
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
+
+.. code-block:: C
+
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
@@ -1244,6 +1345,7 @@ Setting CAN device properties::
         [ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
         [ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
           dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
+        [ tdcv TDCV tdco TDCO tdcf TDCF ]
 
         [ loopback { on | off } ]
         [ listen-only { on | off } ]
@@ -1254,36 +1356,129 @@ Setting CAN device properties::
         [ fd-non-iso { on | off } ]
         [ presume-ack { on | off } ]
         [ cc-len8-dlc { on | off } ]
+        [ tdc-mode { auto | manual | off } ]
 
         [ restart-ms TIME-MS ]
         [ restart ]
 
-        Where: BITRATE       := { 1..1000000 }
-               SAMPLE-POINT  := { 0.000..0.999 }
-               TQ            := { NUMBER }
-               PROP-SEG      := { 1..8 }
-               PHASE-SEG1    := { 1..8 }
-               PHASE-SEG2    := { 1..8 }
-               SJW           := { 1..4 }
-               RESTART-MS    := { 0 | NUMBER }
+        [ termination { 0..65535 } ]
+
+        Where: BITRATE          := { NUMBER in bps }
+               SAMPLE-POINT     := { 0.000..0.999 }
+               TQ               := { NUMBER in ns }
+               PROP-SEG         := { NUMBER in tq }
+               PHASE-SEG1       := { NUMBER in tq }
+               PHASE-SEG2       := { NUMBER in tq }
+               SJW              := { NUMBER in tq }
+               TDCV             := { NUMBER in tc }
+               TDCO             := { NUMBER in tc }
+               TDCF             := { NUMBER in tc }
+               RESTART-MS       := { 0 | NUMBER in ms }
+
+Since IPROUTE2 version 6.16.0 the "ip" tool supports CAN XL devices
+and the following additional parameters.
+
+Setting CAN XL device properties::
+
+    $ ip link set can0 type can help
+    ...
+        [ xl-bitrate BITRATE [ xsample-point SAMPLE-POINT] ] |
+        [ xtq TQ xprop-seg PROP-SEG xphase-seg1 PHASE-SEG1
+          xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]
+        [ xtdcv TDCV xtdco TDCO xtdcf TDCF pwms PWMS pwml PWML pwmo PWMO]
+
+        [ xl-cc-len16-dlc { on | off } ]
+    ...
+        [ restricted { on | off } ]
+	    [ xl { on | off } ]
+	    [ xtdc-mode { auto | manual | off } ]
+	    [ tms { on | off } ]
+	    [ err-signal { on | off } ]
+    ...
+        Where: BITRATE          := { NUMBER in bps }
+               ...
+               PWMS		        := { NUMBER in tqmin }
+		       PWML		        := { NUMBER in tqmin }
+		       PWMO		        := { NUMBER in tqmin }
 
 Display CAN device details and statistics::
 
     $ ip -details -statistics link show can0
-    2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP qlen 10
-      link/can
+    2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+      link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
       can <TRIPLE-SAMPLING> state ERROR-ACTIVE restart-ms 100
       bitrate 125000 sample_point 0.875
-      tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
-      sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
-      clock 8000000
+      tq 31 prop-seg 111 phase-seg1 112 phase-seg2 32 sjw 16 brp 5
+      dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+	  dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+	  tdco 0..127 tdcf 0..127
+	  termination 0 [ 0, 120 ]
+	  clock 160000000 
       re-started bus-errors arbit-lost error-warn error-pass bus-off
       41         17457      0          41         42         41
+      numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536 
       RX: bytes  packets  errors  dropped overrun mcast
       140859     17608    17457   0       0       0
       TX: bytes  packets  errors  dropped carrier collsns
       861        112      0       41      0       0
 
+Display CAN XL device details and statistics::
+
+    $ ip -details -statistics link show can0
+    7: can0: <NOARP,UP,LOWER_UP> mtu 2060 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+    link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060 
+    can <FD,TDC-AUTO,XL,XL-TDC-AUTO> state STOPPED restart-ms 0 
+	  bitrate 1000000 sample-point 0.750
+	  tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
+	  dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+	  dbitrate 2000000 dsample-point 0.750
+	  dtq 6 dprop-seg 29 dphase-seg1 30 dphase-seg2 20 dsjw 10 dbrp 1
+	  tdco 60 tdcf 0
+	  dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+	  tdco 0..127 tdcf 0..127
+	  xbitrate 4000000 xsample-point 0.750
+	  xtq 6 xprop-seg 14 xphase-seg1 15 xphase-seg2 10 xsjw 5 xbrp 1
+	  xtdco 30 xtdcf 0
+	  dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+	  xtdco 0..127 xtdcf 0..127
+	  pwms 1..8 pwml 2..24 pwmo 0..16
+	  termination 0 [ 0, 120 ]
+	  clock 160000000 
+      re-started bus-errors arbit-lost error-warn error-pass bus-off
+	  0          0          0          0          0          0         
+      addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536 
+      RX:  bytes packets errors dropped  missed   mcast           
+               0       0      0       0       0       0 
+      TX:  bytes packets errors dropped carrier collsns           
+               0       0      0      49       0       0 
+
+Display CAN XL with TMS device details and statistics::
+
+    $ ip -details -statistics link show can0
+    7: can0: <NOARP,UP,LOWER_UP> mtu 2060 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
+    link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060 
+    can <XL,XL-TMS> state STOPPED restart-ms 0 
+	  bitrate 1000000 sample-point 0.750
+	  tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
+	  dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
+	  dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
+	  tdco 0..127 tdcf 0..127
+	  xbitrate 4000000 xsample-point 0.500
+	  xtq 6 xprop-seg 9 xphase-seg1 10 xphase-seg2 20 xsjw 10 xbrp 1
+	  pwms 5 pwml 15 pwmo 0
+	  dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
+	  xtdco 0..127 xtdcf 0..127
+	  pwms 1..8 pwml 2..24 pwmo 0..16
+	  termination 0 [ 0, 120 ]
+	  clock 160000000
+      re-started bus-errors arbit-lost error-warn error-pass bus-off
+	  0          0          0          0          0          0         
+      addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536 
+      RX:  bytes packets errors dropped  missed   mcast           
+               0       0      0       0       0       0 
+      TX:  bytes packets errors dropped carrier collsns           
+               0       0      0      49       0       0 
+
 More info to the above output:
 
 "<TRIPLE-SAMPLING>"
@@ -1528,6 +1723,207 @@ by the device::
           clock 80000000
 
 
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
+                                      xbitrate 4000000 xl on
+
+CAN XL-only mode with TMS enabled and CAN FD disabled::
+
+    # ip link set can0 type can bitrate 1000000 xbitrate 12308000 xl on \
+                                      tms on fd off
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
+    can0:    supported: 0x0000ba22
+    can0:    enabled: 0x00003220
+    can0:    list:
+    can0:           LISTEN-ONLY: off
+    can0:           FD: on
+    can0:           TDC-AUTO: on
+    can0:           RESTRICTED: off
+    can0:           XL: on
+    can0:           XL-TDC-AUTO: on
+    can0:           TMS: off
+    can0:
+    can0: Classical CAN nominal bittiming:
+    can0:    bitrate: 1000000
+    ...
+    can0: CAN FD databittiming:
+    can0:   bitrate: 2000000
+    ...
+    can0:   CAN FD TDC:
+    ...
+    can0:
+    can0: CAN XL databittiming:
+    can0:    bitrate: 4000000
+    can0:    sample_point: 750
+    can0:    tq: 6
+    can0:    prop_seg: 14
+    can0:    phase_seg1: 15
+    can0:    phase_seg2: 10
+    can0:    sjw: 5
+    can0:    brp: 1
+    can0:    CAN XL TDC:
+    can0:           tdcv: 0
+    can0:           tdco: 30
+    can0:           tdcf: 0
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
+Some early development versions of CAN XL support in ``iproute2`` may
+still show an ``[ err-signal { on | off } ]`` helper option in
+``ip link set can0 type can help``.  In current kernels the
+error-signalling behaviour is derived automatically from the selected
+mixed-mode or CANXL-only configuration and is no longer controlled by an
+explicit netlink attribute.
+
+The effective state can be observed in the kernel log, for example::
+
+    can0: error-signalling is enabled
+
+Applications should rely on the controller mode and driver output rather
+than on an explicit ``err-signal`` configuration switch
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
+    can0: CAN XL TDC:
+    can0:        tdcv: 0
+    can0:        tdco: 30
+    can0:        tdcf: 0
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
+
+
 Supported CAN Hardware
 ----------------------
 
-- 
2.51.0


