Return-Path: <linux-can+bounces-820-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02763911E2A
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D271C21E6E
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C0173342;
	Fri, 21 Jun 2024 08:02:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FD17109B
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956939; cv=none; b=DGUqSDbuOYxLC6DupsSC76NgmOGMISsBQ5Kc3taTOAA3skJBHBjjPz17cNXa3D3ogXtoZ6IESR2SKqQU7ggmFn4F3HgBkpqG9/H9vfd6zm1UKun8NK/m44slq92k7G2eTKUCA4ZErAJm/3QfJwruRGqvj6RTRcxhSMLXw+gqnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956939; c=relaxed/simple;
	bh=PZ3iSRo6beXmNFSCnt/F3cjiRLkXPTgnH76wor8BrKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo5VDiQX0swoKHL/0Inwq8w4lRvLCGo5svTugVuLrmNbNezeWRdpbHHMCDprVW37MNnxTygaVhAyoSCLbhCW4f3uzvYBDhHRETFujQ/yVXFDLnImbIz30bBtFCypXKQbbXixHoClDGizmATOWy6kLQmysqSsaglgC5/rxiikOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDm-00044o-Rp
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDi-003tJo-Pi
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 49A112EE409
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 21CAF2EE399;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4baafb8b;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Francesco Valla <valla.francesco@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/24] Documentation: networking: document ISO 15765-2
Date: Fri, 21 Jun 2024 09:48:27 +0200
Message-ID: <20240621080201.305471-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Francesco Valla <valla.francesco@gmail.com>

Document basic concepts, APIs and behaviour of the ISO 15675-2 (ISO-TP)
CAN stack.

Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240501092413.414700-2-valla.francesco@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/index.rst      |   1 +
 Documentation/networking/iso15765-2.rst | 386 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 3 files changed, 388 insertions(+)
 create mode 100644 Documentation/networking/iso15765-2.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index a6443851a142..cd5574005dba 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -19,6 +19,7 @@ Contents:
    caif/index
    ethtool-netlink
    ieee802154
+   iso15765-2
    j1939
    kapi
    msg_zerocopy
diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
new file mode 100644
index 000000000000..0e9d96074178
--- /dev/null
+++ b/Documentation/networking/iso15765-2.rst
@@ -0,0 +1,386 @@
+.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+====================
+ISO 15765-2 (ISO-TP)
+====================
+
+Overview
+========
+
+ISO 15765-2, also known as ISO-TP, is a transport protocol specifically defined
+for diagnostic communication on CAN. It is widely used in the automotive
+industry, for example as the transport protocol for UDSonCAN (ISO 14229-3) or
+emission-related diagnostic services (ISO 15031-5).
+
+ISO-TP can be used both on CAN CC (aka Classical CAN) and CAN FD (CAN with
+Flexible Datarate) based networks. It is also designed to be compatible with a
+CAN network using SAE J1939 as data link layer (however, this is not a
+requirement).
+
+Specifications used
+-------------------
+
+* ISO 15765-2:2024 : Road vehicles - Diagnostic communication over Controller
+  Area Network (DoCAN). Part 2: Transport protocol and network layer services.
+
+Addressing
+----------
+
+In its simplest form, ISO-TP is based on two kinds of addressing modes for the
+nodes connected to the same network:
+
+* physical addressing is implemented by two node-specific addresses and is used
+  in 1-to-1 communication.
+
+* functional addressing is implemented by one node-specific address and is used
+  in 1-to-N communication.
+
+Three different addressing formats can be employed:
+
+* "normal" : each address is represented simply by a CAN ID.
+
+* "extended": each address is represented by a CAN ID plus the first byte of
+  the CAN payload; both the CAN ID and the byte inside the payload shall be
+  different between two addresses.
+
+* "mixed": each address is represented by a CAN ID plus the first byte of
+  the CAN payload; the CAN ID is different between two addresses, but the
+  additional byte is the same.
+
+Transport protocol and associated frame types
+---------------------------------------------
+
+When transmitting data using the ISO-TP protocol, the payload can either fit
+inside one single CAN message or not, also considering the overhead the protocol
+is generating and the optional extended addressing. In the first case, the data
+is transmitted at once using a so-called Single Frame (SF). In the second case,
+ISO-TP defines a multi-frame protocol, in which the sender provides (through a
+First Frame - FF) the PDU length which is to be transmitted and also asks for a
+Flow Control (FC) frame, which provides the maximum supported size of a macro
+data block (``blocksize``) and the minimum time between the single CAN messages
+composing such block (``stmin``). Once this information has been received, the
+sender starts to send frames containing fragments of the data payload (called
+Consecutive Frames - CF), stopping after every ``blocksize``-sized block to wait
+confirmation from the receiver which should then send another Flow Control
+frame to inform the sender about its availability to receive more data.
+
+How to Use ISO-TP
+=================
+
+As with others CAN protocols, the ISO-TP stack support is built into the
+Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN, and
+thus follows the same socket API.
+
+Creation and basic usage of an ISO-TP socket
+--------------------------------------------
+
+To use the ISO-TP stack, ``#include <linux/can/isotp.h>`` shall be used. A
+socket can then be created using the ``PF_CAN`` protocol family, the
+``SOCK_DGRAM`` type (as the underlying protocol is datagram-based by design)
+and the ``CAN_ISOTP`` protocol:
+
+.. code-block:: C
+
+    s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+
+After the socket has been successfully created, ``bind(2)`` shall be called to
+bind the socket to the desired CAN interface; to do so:
+
+* a TX CAN ID shall be specified as part of the sockaddr supplied to the call
+  itself.
+
+* a RX CAN ID shall also be specified, unless broadcast flags have been set
+  through socket option (explained below).
+
+Once bound to an interface, the socket can be read from and written to using
+the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2)``,
+``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
+Unlike the CAN_RAW socket API, only the ISO-TP data field (the actual payload)
+is sent and received by the userspace application using these calls. The address
+information and the protocol information are automatically filled by the ISO-TP
+stack using the configuration supplied during socket creation. In the same way,
+the stack will use the transport mechanism when required (i.e., when the size
+of the data payload exceeds the MTU of the underlying CAN bus).
+
+The sockaddr structure used for SocketCAN has extensions for use with ISO-TP,
+as specified below:
+
+.. code-block:: C
+
+    struct sockaddr_can {
+        sa_family_t can_family;
+        int         can_ifindex;
+        union {
+            struct { canid_t rx_id, tx_id; } tp;
+        ...
+        } can_addr;
+    }
+
+* ``can_family`` and ``can_ifindex`` serve the same purpose as for other
+  SocketCAN sockets.
+
+* ``can_addr.tp.rx_id`` specifies the receive (RX) CAN ID and will be used as
+  a RX filter.
+
+* ``can_addr.tp.tx_id`` specifies the transmit (TX) CAN ID
+
+ISO-TP socket options
+---------------------
+
+When creating an ISO-TP socket, reasonable defaults are set. Some options can
+be modified with ``setsockopt(2)`` and/or read back with ``getsockopt(2)``.
+
+General options
+~~~~~~~~~~~~~~~
+
+General socket options can be passed using the ``CAN_ISOTP_OPTS`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_options opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts))
+
+where the ``can_isotp_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_options {
+        u32 flags;
+        u32 frame_txtime;
+        u8  ext_address;
+        u8  txpad_content;
+        u8  rxpad_content;
+        u8  rx_ext_address;
+    };
+
+* ``flags``: modifiers to be applied to the default behaviour of the ISO-TP
+  stack. Following flags are available:
+
+  * ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames); normally
+    used as a testing feature.
+
+  * ``CAN_ISOTP_EXTEND_ADDR``: use the byte specified in ``ext_address`` as an
+    additional address component. This enables the "mixed" addressing format if
+    used alone, or the "extended" addressing format if used in conjunction with
+    ``CAN_ISOTP_RX_EXT_ADDR``.
+
+  * ``CAN_ISOTP_TX_PADDING``: enable padding for transmitted frames, using
+    ``txpad_content`` as value for the padding bytes.
+
+  * ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, using
+    ``rxpad_content`` as value for the padding bytes.
+
+  * ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the received
+    frames.
+
+  * ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received frames
+    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specified,
+    this flag is ignored.
+
+  * ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duplex mode
+    (that is, transport mechanism can only be incoming or outgoing at the same
+    time, not both).
+
+  * ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC; normally
+    used as a testing feature.
+
+  * ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin; normally
+    used as a testing feature.
+
+  * ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_address``
+    as extended addressing byte on the reception path. If used in conjunction
+    with ``CAN_ISOTP_EXTEND_ADDR``, this flag effectively enables the "extended"
+    addressing format.
+
+  * ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before returning
+    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operations).
+
+  * ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot be
+    specified alongside ``CAN_ISOTP_CF_BROADCAST``).
+
+  * ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow control
+    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``).
+    NOTE: this is not covered by the ISO 15765-2 standard.
+
+  * ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control
+    parameters.
+
+* ``frame_txtime``: frame transmission time (defined as N_As/N_Ar inside the
+  ISO standard); if ``0``, the default (or the last set value) is used.
+  To set the transmission time to ``0``, the ``CAN_ISOTP_FRAME_TXTIME_ZERO``
+  macro (equal to 0xFFFFFFFF) shall be used.
+
+* ``ext_address``: extended addressing byte, used if the
+  ``CAN_ISOTP_EXTEND_ADDR`` flag is specified.
+
+* ``txpad_content``: byte used as padding value for transmitted frames.
+
+* ``rxpad_content``: byte used as padding value for received frames.
+
+* ``rx_ext_address``: extended addressing byte for the reception path, used if
+  the ``CAN_ISOTP_RX_EXT_ADDR`` flag is specified.
+
+Flow Control options
+~~~~~~~~~~~~~~~~~~~~
+
+Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` optname
+to provide the communication parameters for receiving ISO-TP PDUs.
+
+.. code-block:: C
+
+    struct can_isotp_fc_options fc_opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RECV_FC, &fc_opts, sizeof(fc_opts));
+
+where the ``can_isotp_fc_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_options {
+        u8 bs;
+        u8 stmin;
+        u8 wftmax;
+    };
+
+* ``bs``: blocksize provided in flow control frames.
+
+* ``stmin``: minimum separation time provided in flow control frames; can
+  have the following values (others are reserved):
+
+  * 0x00 - 0x7F : 0 - 127 ms
+
+  * 0xF1 - 0xF9 : 100 us - 900 us
+
+* ``wftmax``: maximum number of wait frames provided in flow control frames.
+
+Link Layer options
+~~~~~~~~~~~~~~~~~~
+
+Link Layer (LL) options can be passed using the ``CAN_ISOTP_LL_OPTS`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_ll_options ll_opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll_opts, sizeof(ll_opts));
+
+where the ``can_isotp_ll_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_ll_options {
+        u8 mtu;
+        u8 tx_dl;
+        u8 tx_flags;
+    };
+
+* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_MTU``
+  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
+
+* ``tx_dl``: maximum payload length for transmitted frames, can have one value
+  among: 8, 12, 16, 20, 24, 32, 48, 64. Values above 8 only apply to CAN FD
+  traffic (i.e.: ``mtu = CANFD_MTU``).
+
+* ``tx_flags``: flags set into ``struct canfd_frame.flags`` at frame creation.
+  Only applies to CAN FD traffic (i.e.: ``mtu = CANFD_MTU``).
+
+Transmission stmin
+~~~~~~~~~~~~~~~~~~
+
+The transmission minimum separation time (stmin) can be forced using the
+``CAN_ISOTP_TX_STMIN`` optname and providing an stmin value in microseconds as
+a 32bit unsigned integer; this will overwrite the value sent by the receiver in
+flow control frames:
+
+.. code-block:: C
+
+    uint32_t stmin;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &stmin, sizeof(stmin));
+
+Reception stmin
+~~~~~~~~~~~~~~~
+
+The reception minimum separation time (stmin) can be forced using the
+``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseconds as
+a 32bit unsigned integer; received Consecutive Frames (CF) which timestamps
+differ less than this value will be ignored:
+
+.. code-block:: C
+
+    uint32_t stmin;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeof(stmin));
+
+Multi-frame transport support
+-----------------------------
+
+The ISO-TP stack contained inside the Linux kernel supports the multi-frame
+transport mechanism defined by the standard, with the following constraints:
+
+* the maximum size of a PDU is defined by a module parameter, with an hard
+  limit imposed at build time.
+
+* when a transmission is in progress, subsequent calls to ``write(2)`` will
+  block, while calls to ``send(2)`` will either block or fail depending on the
+  presence of the ``MSG_DONTWAIT`` flag.
+
+* no support is present for sending "wait frames": whether a PDU can be fully
+  received or not is decided when the First Frame is received.
+
+Errors
+------
+
+Following errors are reported to userspace:
+
+RX path errors
+~~~~~~~~~~~~~~
+
+============ ===============================================================
+-ETIMEDOUT   timeout of data reception
+-EILSEQ      sequence number mismatch during a multi-frame reception
+-EBADMSG     data reception with wrong padding
+============ ===============================================================
+
+TX path errors
+~~~~~~~~~~~~~~
+
+========== =================================================================
+-ECOMM     flow control reception timeout
+-EMSGSIZE  flow control reception overflow
+-EBADMSG   flow control reception with wrong layout/padding
+========== =================================================================
+
+Examples
+========
+
+Basic node example
+------------------
+
+Following example implements a node using "normal" physical addressing, with
+RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
+to their default.
+
+.. code-block:: C
+
+  int s;
+  struct sockaddr_can addr;
+  int ret;
+
+  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+  if (s < 0)
+      exit(1);
+
+  addr.can_family = AF_CAN;
+  addr.can_ifindex = if_nametoindex("can0");
+  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
+  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
+
+  ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+  if (ret < 0)
+      exit(1);
+
+  /* Data can now be received using read(s, ...) and sent using write(s, ...) */
+
+Additional examples
+-------------------
+
+More complete (and complex) examples can be found inside the ``isotp*`` userland
+tools, distributed as part of the ``can-utils`` utilities at:
+https://github.com/linux-can/can-utils
diff --git a/MAINTAINERS b/MAINTAINERS
index e66b7d4324ae..17e3fa3eb6fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4842,6 +4842,7 @@ W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/networking/can.rst
+F:	Documentation/networking/iso15765-2.rst
 F:	include/linux/can/can-ml.h
 F:	include/linux/can/core.h
 F:	include/linux/can/skb.h
-- 
2.43.0



