Return-Path: <linux-can+bounces-1645-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2B99BAB8
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 20:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D1F281B64
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8E1465AB;
	Sun, 13 Oct 2024 18:17:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98A18E20
	for <linux-can@vger.kernel.org>; Sun, 13 Oct 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843461; cv=none; b=BltcEn+7JvZoFtcWdwDfSa8Skb2khWoijHPEMd/BBLYSnvuK9ZcgZYCkWz1zq/Q2BDAJ6pvLa45jH5ind5UVg0Qqgmxl0aUB9mCSXk1xQgKY8bjz1yeegY7NhXXz4mqszlJ2Gn0LnmLo6PoFeKUIyZOpRML/qHlScMO+QDBtwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843461; c=relaxed/simple;
	bh=o7wl8/P1L+YWu7PAMmddhpXP6szhLbVs2vAMj91E0KY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iVCyUDf/9OmrM+ChBGtxlFmpH4ZdHWbiW5RMTDZiTr6GeAqH+O1HS9vaBYVreQwS9BFtyS0qNaH5SPgYMqh8Yj4bmM8W6MYE3Q/JgEro+60AhpCPQMPsYWOC5BPNlHnOmC7Sm+2A9s4xUoNmsOw5THj81d9ld47hmwse9arJlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t039c-0006pA-D7; Sun, 13 Oct 2024 20:17:20 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1t039Y-001bmS-Rd; Sun, 13 Oct 2024 20:17:16 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t039Y-00EdfZ-2Y;
	Sun, 13 Oct 2024 20:17:16 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] can: j1939: Extend stack documentation with buffer size behavior
Date: Sun, 13 Oct 2024 20:17:15 +0200
Message-Id: <20241013181715.3488980-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Extend the J1939 stack documentation to include information about how
buffer sizes influence stack behavior, detailing handling of simple
sessions, TP, and ETP transfers.

Additionally, describe various setsockopt(2) options, including their
usage  and potential error values that can be returned by the stack.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/j1939.rst | 675 +++++++++++++++++++++++++++++
 1 file changed, 675 insertions(+)

diff --git a/Documentation/networking/j1939.rst b/Documentation/networking/j1939.rst
index e4bd7aa1f5aa9..82f25ec8f6c00 100644
--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -66,6 +66,90 @@ the library exclusively, or by the in-kernel system exclusively.
 J1939 concepts
 ==============
 
+Data Sent to the J1939 Stack
+----------------------------
+
+The data buffers sent to the J1939 stack from user space are not CAN frames
+themselves. Instead, they are payloads that the J1939 stack converts into
+proper CAN frames based on the size of the buffer and the type of transfer. The
+size of the buffer influences how the stack processes the data and determines
+the internal code path used for the transfer.
+
+**Handling of Different Buffer Sizes:**
+
+- **Buffers with a size of 8 bytes or less:**
+
+  - These are handled as simple sessions internally within the stack.
+
+  - The stack converts the buffer directly into a single CAN frame without
+    fragmentation.
+
+  - This type of transfer does not require an actual client (receiver) on the
+    receiving side.
+
+- **Buffers up to 1785 bytes:**
+
+  - These are automatically handled as J1939 Transport Protocol (TP) transfers.
+
+  - Internally, the stack splits the buffer into multiple 8-byte CAN frames.
+
+  - TP transfers can be unicast or broadcast.
+
+  - **Broadcast TP:** Does not require a receiver on the other side and can be
+    used in broadcast scenarios.
+
+  - **Unicast TP:** Requires an active receiver (client) on the other side to
+    acknowledge the transfer.
+
+- **Buffers from 1786 bytes up to 111 MiB:**
+
+  - These are handled as ISO 11783 Extended Transport Protocol (ETP) transfers.
+
+  - ETP transfers are used for larger payloads and are split into multiple CAN
+    frames internally.
+
+  - **ETP transfers (unicast):** Require a receiver on the other side to
+    process the incoming data and acknowledge each step of the transfer.
+
+  - ETP transfers cannot be broadcast like TP transfers, and always require a
+    receiver for operation.
+
+**Non-Blocking Operation with `MSG_DONTWAIT`:**
+
+The J1939 stack supports non-blocking operation when used in combination with
+the `MSG_DONTWAIT` flag. In this mode, the stack attempts to take as much data
+as the available memory for the socket allows. It returns the amount of data
+that was successfully taken, and it is the responsibility of user space to
+monitor this value and handle partial transfers.
+
+- If the stack cannot take the entire buffer, it returns the number of bytes
+  successfully taken, and user space should handle the remainder.
+
+- **Error handling:** When using `MSG_DONTWAIT`, the user must rely on the
+  error queue to detect transfer errors. See the **SO_J1939_ERRQUEUE** section
+  for details on how to subscribe to error notifications. Without the error
+  queue, there is no other way for user space to be notified of transfer errors
+  during non-blocking operations.
+
+**Behavior and Requirements:**
+
+- **Simple transfers (<= 8 bytes):** Do not require a receiver on the other
+  side, making them easy to send without needing address claiming or
+  coordination with a destination.
+
+- **Unicast TP/ETP:** Requires a receiver on the other side to complete the
+  transfer. The receiver must acknowledge the transfer for the session to
+  proceed successfully.
+
+- **Broadcast TP:** Allows sending data without a receiver, but only works for
+  TP transfers. ETP cannot be broadcast and always needs a receiving client.
+
+These different behaviors depend heavily on the size of the buffer provided to
+the stack, and the appropriate transport mechanism (TP or ETP) is selected
+based on the payload size. The stack automatically manages the fragmentation
+and reassembly of large payloads and ensures that the correct CAN frames are
+generated and transmitted for each session.
+
 PGN
 ---
 
@@ -338,6 +422,459 @@ with ``cmsg_level == SOL_J1939 && cmsg_type == SCM_J1939_DEST_ADDR``,
 		}
 	}
 
+setsockopt(2)
+^^^^^^^^^^^^^
+
+The ``setsockopt(2)`` function is used to configure various socket-level
+options for J1939 communication. The following options are supported:
+
+``SO_J1939_FILTER``
+~~~~~~~~~~~~~~~~~~~
+
+The ``SO_J1939_FILTER`` option is essential when the default behavior of
+``bind(2)`` and ``connect(2)`` is insufficient for specific use cases. By
+default, ``bind(2)`` and ``connect(2)`` allow a socket to be associated with a
+single unicast or broadcast address. However, there are scenarios where finer
+control over the incoming messages is required, such as filtering by Parameter
+Group Number (PGN) rather than by addresses.
+
+For example, in a system where multiple types of J1939 messages are being
+transmitted, a process might only be interested in a subset of those messages,
+such as specific PGNs, and not want to receive all messages destined for its
+address or broadcast to the bus.
+
+By applying the ``SO_J1939_FILTER`` option, you can filter messages based on:
+
+- **Source Address (SA)**: Filter messages coming from specific source
+  addresses.
+
+- **Source Name**: Filter messages coming from ECUs with specific NAME
+  identifiers.
+
+- **Parameter Group Number (PGN)**: Focus on receiving messages with specific
+  PGNs, filtering out irrelevant ones.
+
+This filtering mechanism is particularly useful when:
+
+- You want to receive a subset of messages based on their PGNs, even if the
+  address is the same.
+
+- You need to handle both broadcast and unicast messages but only care about
+  certain message types or parameters.
+
+- The ``bind(2)`` and ``connect(2)`` functions only allow binding to a single
+  address, which might not be sufficient if the process needs to handle multiple
+  PGNs but does not want to open multiple sockets.
+
+To remove existing filters, you can pass ``optval == NULL`` or ``optlen == 0``
+to ``setsockopt(2)``. This will clear all currently set filters. If you want to
+**update** the set of filters, you must pass the updated filter set to
+``setsockopt(2)``, as the new filter set will **replace** the old one entirely.
+This behavior ensures that any previous filter configuration is discarded and
+only the new set is applied.
+
+Example of removing all filters:
+
+.. code-block:: c
+
+    setsockopt(sock, SOL_CAN_J1939, SO_J1939_FILTER, NULL, 0);
+
+**Maximum number of filters:** The maximum amount of filters that can be
+applied using ``SO_J1939_FILTER`` is defined by ``J1939_FILTER_MAX``, which is
+set to 512. This means you can configure up to 512 individual filters to match
+your specific filtering needs.
+
+Practical use case: **Monitoring Address Claiming**
+
+One practical use case is monitoring the J1939 address claiming process by
+filtering for specific PGNs related to address claiming. This allows a process
+to monitor and handle address claims without processing unrelated messages.
+
+Example:
+
+.. code-block:: c
+
+    struct j1939_filter filt[] = {
+        {
+            .pgn = J1939_PGN_ADDRESS_CLAIMED,
+            .pgn_mask = J1939_PGN_PDU1_MAX,
+        }, {
+            .pgn = J1939_PGN_REQUEST,
+            .pgn_mask = J1939_PGN_PDU1_MAX,
+        }, {
+            .pgn = J1939_PGN_ADDRESS_COMMANDED,
+            .pgn_mask = J1939_PGN_MAX,
+        },
+    };
+    setsockopt(sock, SOL_CAN_J1939, SO_J1939_FILTER, &filt, sizeof(filt));
+
+In this example, the socket will only receive messages with the PGNs related to
+address claiming: ``J1939_PGN_ADDRESS_CLAIMED``, ``J1939_PGN_REQUEST``, and
+``J1939_PGN_ADDRESS_COMMANDED``. This is particularly useful in scenarios where
+you want to monitor and process address claims without being overwhelmed by
+other traffic on the J1939 network.
+
+``SO_J1939_PROMISC``
+~~~~~~~~~~~~~~~~~~~~
+
+The ``SO_J1939_PROMISC`` option enables socket-level promiscuous mode. When
+this option is enabled, the socket will receive all J1939 traffic, regardless
+of any filters set by ``bind()`` or ``connect()``. This is analogous to
+enabling promiscuous mode for an Ethernet interface, where all traffic on the
+network segment is captured.
+
+However, **`SO_J1939_FILTER` has a higher priority** compared to
+``SO_J1939_PROMISC``. This means that even in promiscuous mode, you can reduce
+the number of packets received by applying specific filters with
+`SO_J1939_FILTER`. The filters will limit which packets are passed to the
+socket, allowing for more refined traffic selection while promiscuous mode is
+active.
+
+The acceptable value size for this option is ``sizeof(int)``, and the value is
+only differentiated between `0` and non-zero. A value of `0` disables
+promiscuous mode, while any non-zero value enables it.
+
+This combination can be useful for debugging or monitoring specific types of
+traffic while still capturing a broad set of messages.
+
+Example:
+
+.. code-block:: c
+
+    int value = 1;
+    setsockopt(sock, SOL_CAN_J1939, SO_J1939_PROMISC, &value, sizeof(value));
+
+In this example, setting ``value`` to any non-zero value (e.g., `1`) enables
+promiscuous mode, allowing the socket to receive all J1939 traffic on the
+network.
+
+``SO_BROADCAST``
+~~~~~~~~~~~~~~~~
+
+The ``SO_BROADCAST`` option enables the sending and receiving of broadcast
+messages. By default, broadcast messages are disabled for J1939 sockets. When
+this option is enabled, the socket will be allowed to send and receive
+broadcast packets on the J1939 network.
+
+Due to the nature of the CAN bus as a shared medium, all messages transmitted
+on the bus are visible to all participants. In the context of J1939,
+broadcasting refers to using a specific destination address field, where the
+destination address is set to a value that indicates the message is intended
+for all participants (usually a global address such as 0xFF). Enabling the
+broadcast option allows the socket to send and receive such broadcast messages.
+
+The acceptable value size for this option is ``sizeof(int)``, and the value is
+only differentiated between `0` and non-zero. A value of `0` disables the
+ability to send and receive broadcast messages, while any non-zero value
+enables it.
+
+Example:
+
+.. code-block:: c
+
+    int value = 1;
+    setsockopt(sock, SOL_SOCKET, SO_BROADCAST, &value, sizeof(value));
+
+In this example, setting ``value`` to any non-zero value (e.g., `1`) enables
+the socket to send and receive broadcast messages.
+
+``SO_J1939_SEND_PRIO``
+~~~~~~~~~~~~~~~~~~~~~~
+
+The ``SO_J1939_SEND_PRIO`` option sets the priority of outgoing J1939 messages
+for the socket. In J1939, messages can have different priorities, and lower
+numerical values indicate higher priority. This option allows the user to
+control the priority of messages sent from the socket by adjusting the priority
+bits in the CAN identifier.
+
+The acceptable value **size** for this option is ``sizeof(int)``, and the value
+is expected to be in the range of 0 to 7, where `0` is the highest priority,
+and `7` is the lowest. By default, the priority is set to `6` if this option is
+not explicitly configured.
+
+Note that the priority values `0` and `1` can only be set if the process has
+the `CAP_NET_ADMIN` capability. These are reserved for high-priority traffic
+and require administrative privileges.
+
+Example:
+
+.. code-block:: c
+
+    int prio = 3;  // Priority value between 0 (highest) and 7 (lowest)
+    setsockopt(sock, SOL_CAN_J1939, SO_J1939_SEND_PRIO, &prio, sizeof(prio));
+
+In this example, the priority is set to `3`, meaning the outgoing messages will
+be sent with a moderate priority level.
+
+``SO_J1939_ERRQUEUE``
+~~~~~~~~~~~~~~~~~~~~~
+
+The ``SO_J1939_ERRQUEUE`` option enables the socket to receive error messages
+from the error queue, providing diagnostic information about transmission
+failures, protocol violations, or other issues that occur during J1939
+communication. Once this option is set, user space is required to handle
+``MSG_ERRQUEUE`` messages.
+
+Setting ``SO_J1939_ERRQUEUE`` to ``0`` will purge any currently present error
+messages in the error queue. When enabled, error messages can be retrieved
+using the ``recvmsg(2)`` system call.
+
+When subscribing to the error queue, the following error events can be
+accessed:
+
+- **``J1939_EE_INFO_TX_ABORT``**: Transmission abort errors.
+- **``J1939_EE_INFO_RX_RTS``**: Reception of RTS (Request to Send) control
+  frames.
+- **``J1939_EE_INFO_RX_DPO``**: Reception of data packets with Data Page Offset
+  (DPO).
+- **``J1939_EE_INFO_RX_ABORT``**: Reception abort errors.
+
+The error queue can be used to correlate errors with specific message transfer
+sessions using the session ID (``tskey``). The session ID is assigned via the
+``SOF_TIMESTAMPING_OPT_ID`` flag, which is set by enabling the
+``SO_TIMESTAMPING`` option.
+
+If ``SO_J1939_ERRQUEUE`` is activated, the user is required to pull messages
+from the error queue, meaning that using plain ``recv(2)`` is not sufficient
+anymore. The user must use ``recvmsg(2)`` with appropriate flags to handle
+error messages. Failure to do so can result in the socket becoming blocked with
+unprocessed error messages in the queue.
+
+It is **recommended** that ``SO_J1939_ERRQUEUE`` be used in combination with
+``SO_TIMESTAMPING`` in most cases. This enables proper error handling along
+with session tracking and timestamping, providing a more detailed analysis of
+message transfers and errors.
+
+The acceptable value **size** for this option is ``sizeof(int)``, and the value
+is only differentiated between ``0`` and non-zero. A value of ``0`` disables
+error queue reception and purges any existing error messages, while any
+non-zero value enables it.
+
+Example:
+
+.. code-block:: c
+
+    int enable = 1;  // Enable error queue reception
+    setsockopt(sock, SOL_CAN_J1939, SO_J1939_ERRQUEUE, &enable, sizeof(enable));
+
+    // Enable timestamping with session tracking via tskey
+    int timestamping = SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_TX_ACK |
+                       SOF_TIMESTAMPING_TX_SCHED |
+                       SOF_TIMESTAMPING_RX_SOFTWARE | SOF_TIMESTAMPING_OPT_CMSG;
+    setsockopt(sock, SOL_SOCKET, SO_TIMESTAMPING, &timestamping,
+               sizeof(timestamping));
+
+When enabled, error messages can be retrieved using ``recvmsg(2)``. By
+combining ``SO_J1939_ERRQUEUE`` with ``SO_TIMESTAMPING`` (with
+``SOF_TIMESTAMPING_OPT_ID`` and ``SOF_TIMESTAMPING_OPT_CMSG`` enabled), the
+user can track message transfers, retrieve precise timestamps, and correlate
+errors with specific sessions.
+
+For more information on enabling timestamps and session tracking, refer to the
+`SO_TIMESTAMPING` section.
+
+``SO_TIMESTAMPING``
+~~~~~~~~~~~~~~~~~~~
+
+The ``SO_TIMESTAMPING`` option allows the socket to receive timestamps for
+various events related to message transmissions and receptions in J1939. This
+option is often used in combination with ``SO_J1939_ERRQUEUE`` to provide
+detailed diagnostic information, session tracking, and precise timing data for
+message transfers.
+
+In J1939, all payloads provided by user space, regardless of size, are
+processed by the kernel as **sessions**. This includes both single-frame
+messages (up to 8 bytes) and multi-frame protocols such as the Transport
+Protocol (TP) and Extended Transport Protocol (ETP). Even for small,
+single-frame messages, the kernel creates a session to manage the transmission
+and reception. The concept of sessions allows the kernel to manage various
+aspects of the protocol, such as reassembling multi-frame messages and tracking
+the status of transmissions.
+
+When receiving extended error messages from the error queue, the error
+information is delivered through a `struct sock_extended_err`, accessible via
+the control message (``cmsg``) retrieved using the ``recvmsg(2)`` system call.
+
+There are two typical origins for the extended error messages in J1939:
+
+1. ``serr->ee_origin == SO_EE_ORIGIN_TIMESTAMPING``:
+
+   In this case, the `serr->ee_info` field will contain one of the following
+   timestamp types:
+
+   - ``SCM_TSTAMP_SCHED``: This timestamp is valid for Extended Transport
+     Protocol (ETP) transfers and simple transfers (8 bytes or less). It
+     indicates when a message or set of frames has been scheduled for
+     transmission.
+
+     - For simple transfers (8 bytes or less), it marks the point when the
+       message is queued and ready to be sent onto the CAN bus.
+
+     - For ETP transfers, it is sent after receiving a CTS (Clear to Send)
+       frame on the sender side, indicating that a new set of frames has been
+       scheduled for transmission.
+
+     - The Transport Protocol (TP) case is currently not implemented for this
+       timestamp.
+
+     - On the receiver side, the counterpart to this event for ETP is
+       represented by the ``J1939_EE_INFO_RX_DPO`` message, which indicates the
+       reception of a Data Page Offset (DPO) control frame.
+
+   - ``SCM_TSTAMP_ACK``: This timestamp indicates the acknowledgment of the
+     message or session.
+
+     - For simple transfers (8 bytes or less), it marks when the message has
+       been sent and an echo confirmation has been received from the CAN
+       controller, indicating that the frame was transmitted onto the bus.
+
+     - For multi-frame transfers (TP or ETP), it signifies that the entire
+       session has been acknowledged, typically after receiving the End of
+       Message Acknowledgment (EOMA) packet.
+
+2. ``serr->ee_origin == SO_EE_ORIGIN_LOCAL``:
+
+   In this case, the `serr->ee_info` field will contain one of the following
+   J1939 stack-specific message types:
+
+   - ``J1939_EE_INFO_TX_ABORT``: This message indicates that the transmission
+     of a message or session was aborted. The cause of the abort can come from
+     various sources:
+
+     - **CAN stack failure**: The J1939 stack was unable to pass the frame to
+       the CAN framework for transmission.
+
+     - **Echo failure**: The J1939 stack did not receive an echo confirmation
+       from the CAN controller, meaning the frame may not have been successfully
+       transmitted to the CAN bus.
+
+     - **Protocol-level issues**: For multi-frame transfers (TP/ETP), this
+       could include protocol-related errors, such as an abort signaled by the
+       receiver or a timeout at the protocol level, which causes the session to
+       terminate prematurely.
+
+     - The corresponding error code is stored in ``serr->ee_data``
+       (``session->err`` on kernel side), providing additional details about
+       the specific reason for the abort.
+
+   - ``J1939_EE_INFO_RX_RTS``: This message indicates that the J1939 stack has
+     received a Request to Send (RTS) control frame, signaling the start of a
+     multi-frame transfer using the Transport Protocol (TP) or Extended
+     Transport Protocol (ETP).
+
+     - It informs the receiver that the sender is ready to transmit a
+       multi-frame message and includes details about the total message size
+       and the number of frames to be sent.
+
+     - Statistics such as ``J1939_NLA_TOTAL_SIZE``, ``J1939_NLA_PGN``,
+       ``J1939_NLA_SRC_NAME``, and ``J1939_NLA_DEST_NAME`` are provided along
+       with the ``J1939_EE_INFO_RX_RTS`` message, giving detailed information
+       about the incoming transfer.
+
+   - ``J1939_EE_INFO_RX_DPO``: This message indicates that the J1939 stack has
+     received a Data Page Offset (DPO) control frame, which is part of the
+     Extended Transport Protocol (ETP).
+
+     - The DPO frame signals the continuation of an ETP multi-frame message by
+       indicating the offset position in the data being transferred. It helps
+       the receiver manage large data sets by identifying which portion of the
+       message is being received.
+
+     - It is typically paired with a corresponding ``SCM_TSTAMP_SCHED`` event
+       on the sender side, which indicates when the next set of frames is
+       scheduled for transmission.
+
+     - This event includes statistics such as ``J1939_NLA_BYTES_ACKED``, which
+       tracks the number of bytes acknowledged up to that point in the session.
+
+   - ``J1939_EE_INFO_RX_ABORT``: This message indicates that the reception of a
+     multi-frame message (Transport Protocol or Extended Transport Protocol) has
+     been aborted.
+
+     - The abort can be triggered by protocol-level errors such as timeouts, an
+       unexpected frame, or a specific abort request from the sender.
+
+     - This message signals that the receiver cannot continue processing the
+       transfer, and the session is terminated.
+
+     - The corresponding error code is stored in ``serr->ee_data``
+       (``session->err`` on kernel side ), providing further details about the
+       reason for the abort, such as protocol violations or timeouts.
+
+     - After receiving this message, the receiver discards the partially received
+       frames, and the multi-frame session is considered incomplete.
+
+In both cases, if ``SOF_TIMESTAMPING_OPT_ID`` is enabled, ``serr->ee_data``
+will be set to the session’s unique identifier (``session->tskey``). This
+allows user space to track message transfers by their session identifier across
+multiple frames or stages.
+
+In all other cases, ``serr->ee_errno`` will be set to ``ENOMSG``, except for
+the ``J1939_EE_INFO_TX_ABORT`` and ``J1939_EE_INFO_RX_ABORT`` cases, where the
+kernel sets ``serr->ee_data`` to the error stored in ``session->err``.  All
+protocol-specific errors are converted to standard kernel error values and
+stored in ``session->err``. These error values are unified across system calls
+and ``serr->ee_errno``.  Some of the known error values are described in the
+`Error Codes in the J1939 Stack` section.
+
+When the `J1939_EE_INFO_RX_RTS` message is provided, it will include the
+following statistics for multi-frame messages (TP and ETP):
+
+  - ``J1939_NLA_TOTAL_SIZE``: Total size of the message in the session.
+  - ``J1939_NLA_PGN``: Parameter Group Number (PGN) identifying the message type.
+  - ``J1939_NLA_SRC_NAME``: 64-bit name of the source ECU.
+  - ``J1939_NLA_DEST_NAME``: 64-bit name of the destination ECU.
+  - ``J1939_NLA_SRC_ADDR``: 8-bit source address of the sending ECU.
+  - ``J1939_NLA_DEST_ADDR``: 8-bit destination address of the receiving ECU.
+
+- For other messages (including single-frame messages), only the following
+  statistic is included:
+
+  - ``J1939_NLA_BYTES_ACKED``: Number of bytes successfully acknowledged in the
+    session.
+
+The key flags for ``SO_TIMESTAMPING`` include:
+
+- ``SOF_TIMESTAMPING_OPT_ID``: Enables the use of a unique session identifier
+  (``tskey``) for each transfer. This identifier helps track message transfers
+  and errors as distinct sessions in user space. When this option is enabled,
+  ``serr->ee_data`` will be set to ``session->tskey``.
+
+- ``SOF_TIMESTAMPING_OPT_CMSG``: Sends timestamp information through control
+  messages (``struct scm_timestamping``), allowing the application to retrieve
+  timestamps alongside the data.
+
+- ``SOF_TIMESTAMPING_TX_SCHED``: Provides the timestamp for when a message is
+  scheduled for transmission (``SCM_TSTAMP_SCHED``).
+
+- ``SOF_TIMESTAMPING_TX_ACK``: Provides the timestamp for when a message
+  transmission is fully acknowledged (``SCM_TSTAMP_ACK``).
+
+- ``SOF_TIMESTAMPING_RX_SOFTWARE``: Provides timestamps for reception-related
+  events (e.g., ``J1939_EE_INFO_RX_RTS``, ``J1939_EE_INFO_RX_DPO``,
+  ``J1939_EE_INFO_RX_ABORT``).
+
+These flags enable detailed monitoring of message lifecycles, including
+transmission scheduling, acknowledgments, reception timestamps, and gathering
+detailed statistics about the communication session, especially for multi-frame
+payloads like TP and ETP.
+
+Example:
+
+.. code-block:: c
+
+    // Enable timestamping with various options, including session tracking and
+    // statistics
+    int sock_opt = SOF_TIMESTAMPING_OPT_CMSG |
+                   SOF_TIMESTAMPING_TX_ACK |
+                   SOF_TIMESTAMPING_TX_SCHED |
+                   SOF_TIMESTAMPING_OPT_ID |
+                   SOF_TIMESTAMPING_RX_SOFTWARE;
+
+    setsockopt(sock, SOL_SOCKET, SO_TIMESTAMPING, &sock_opt, sizeof(sock_opt));
+
+
+
 Dynamic Addressing
 ------------------
 
@@ -458,3 +995,141 @@ Send:
 	};
 
 	sendto(sock, dat, sizeof(dat), 0, (const struct sockaddr *)&saddr, sizeof(saddr));
+
+
+Error Codes in the J1939 Stack
+------------------------------
+
+This section lists all potential kernel error codes that can be exposed to user
+space when interacting with the J1939 stack. It includes both standard error
+codes and those derived from protocol-specific abort codes.
+
+- ``EAGAIN``: Operation would block; retry may succeed. One common reason is
+  that an active TP or ETP session exists, and an attempt was made to start a
+  new overlapping TP or ETP session between the same peers.
+
+- ``ENETDOWN``: Network is down. This occurs when the CAN interface is switched
+  to the "down" state.
+
+- ``ENOBUFS``: No buffer space available. This error occurs when the CAN
+  interface's transmit (TX) queue is full, and no more messages can be queued.
+
+- ``EOVERFLOW``: Value too large for defined data type. In J1939, this can
+  happen if the requested data lies outside of the queued buffer. For example,
+  if a CTS (Clear to Send) requests an offset not available in the kernel buffer
+  because user space did not provide enough data.
+
+- ``EBUSY``: Device or resource is busy. For example, this occurs if an
+  identical session is already active and the stack is unable to recover from
+  the condition.
+
+- ``EACCES``: Permission denied. This error can occur, for example, when
+  attempting to send broadcast messages, but the socket is not configured with
+  ``SO_BROADCAST``.
+
+- ``EADDRNOTAVAIL``: Address not available. This error occurs in cases such as:
+
+  - When attempting to use ``getsockname(2)`` to retrieve the peer's address,
+    but the socket is not connected.
+
+  - When trying to send data to or from a NAME, but address claiming for the
+    NAME was not performed or detected by the stack.
+
+- ``EBADFD``: File descriptor in bad state. This error can occur if:
+
+  - Attempting to send data to an unbound socket.
+
+  - The socket is bound but has no source name, and the source address is
+    ``J1939_NO_ADDR``.
+
+  - The ``can_ifindex`` is incorrect.
+
+- ``EFAULT``: Bad address. Occurs mostly when the stack can't copy from or to a
+  sockptr, when there is insufficient data from user space, or when the buffer
+  provided by user space is not large enough for the requested data.
+
+- ``EINTR``: A signal occurred before any data was transmitted; see ``signal(7)``.
+
+- ``EINVAL``: Invalid argument passed. For example:
+
+  - ``msg->msg_namelen`` is less than ``J1939_MIN_NAMELEN``.
+
+  - ``addr->can_family`` is not equal to ``AF_CAN``.
+
+  - An incorrect PGN was provided.
+
+- ``ENODEV``: No such device. This happens when the CAN network device cannot
+  be found for the provided ``can_ifindex`` or if ``can_ifindex`` is 0.
+
+- ``ENOMEM``: Out of memory. Typically related to issues with memory allocation
+  in the stack.
+
+- ``ENOPROTOOPT``: Protocol not available. This can occur when using
+  ``getsockopt(2)`` or ``setsockopt(2)`` if the requested socket option is not
+  available.
+
+- ``EDESTADDRREQ``: Destination address required. This error occurs:
+
+  - In the case of ``connect(2)``, if the ``struct sockaddr *uaddr`` is ``NULL``.
+
+  - In the case of ``send*(2)``, if there is an attempt to send an ETP message
+    to a broadcast address.
+
+- ``EDOM``: Argument out of domain. This error may happen if attempting to send
+  a TP or ETP message to a PGN that is reserved for control PGNs for TP or ETP
+  operations.
+
+- ``EIO``: I/O error. This can occur if the amount of data provided to the
+  socket for a TP or ETP session does not match the announced amount of data for
+  the session.
+
+- ``ENOENT``: No such file or directory. This can happen when the stack
+  attempts to transfer CTS or EOMA but cannot find a matching receiving socket
+  anymore.
+
+- ``ENOIOCTLCMD``: No ioctls are available for the socket layer.
+
+- ``EPERM``: Operation not permitted. For example, this can occur if a
+  requested action requires ``CAP_NET_ADMIN`` privileges.
+
+- ``ENETUNREACH``: Network unreachable. Most likely, this occurs when frames
+  cannot be transmitted to the CAN bus.
+
+- ``ETIME``: Timer expired. This can happen if a timeout occurs while
+  attempting to send a simple message, for example, when an echo message from
+  the controller is not received.
+
+- ``EPROTO``: Protocol error.
+
+  - Used for various protocol-level errors in J1939, including:
+
+    - Duplicate sequence number.
+
+    - Unexpected EDPO or ECTS packet.
+
+    - Invalid PGN or offset in EDPO/ECTS.
+
+    - Number of EDPO packets exceeded CTS allowance.
+
+    - Any other protocol-level error.
+
+- ``EMSGSIZE``: Message too long.
+
+- ``ENOMSG``: No message available.
+
+- ``EALREADY``: The ECU is already engaged in one or more connection-managed
+  sessions and cannot support another.
+
+- ``EHOSTUNREACH``: A timeout occurred, and the session was aborted.
+
+- ``EBADMSG``: CTS (Clear to Send) messages were received during an active data
+  transfer, causing an abort.
+
+- ``ENOTRECOVERABLE``: The maximum retransmission request limit was reached,
+  and the session cannot recover.
+
+- ``ENOTCONN``: An unexpected data transfer packet was received.
+
+- ``EILSEQ``: A bad sequence number was received, and the software could not
+  recover.
+
-- 
2.39.5


