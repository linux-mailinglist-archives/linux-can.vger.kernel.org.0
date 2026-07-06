Return-Path: <linux-can+bounces-8014-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OE8XAUAwTGoFhgEAu9opvQ
	(envelope-from <linux-can+bounces-8014-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:46:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFF8716229
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:46:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=XNQ8iD86;
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8014-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8014-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40872300E15F
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C9364024;
	Mon,  6 Jul 2026 22:46:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66582F7EF5;
	Mon,  6 Jul 2026 22:46:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377972; cv=none; b=EJDvWKdtyZ9sYL6R6VeI4+yy8JsskG2JbDcSyP170gRyhCQWJFKeVogdO/gXjVnU1yc10WUqC0DTx1CI+STsQPe2f8Uryk6ygG39A7D5W7gTzvC1rvK5KvaepnAr4R02cXhIZmSrFnDT6kKB+O7DcQUlOVAGmwR7Nd2cOgnZngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377972; c=relaxed/simple;
	bh=GwUrRap093T7Y/+hK4rWE8q76lm3WJ7Cq68PiqOjM7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIyj3yrk1mJd6CvcteefTIfj8g5KoHwq/aTPrh4TeLaC5gYYN2S4zQkiQuOoSYbsN6LLj/8zVxdbdI+JMI49FtgL+3iFGwTUxlunG9gl3XpoVCHt7gJ+YroKtGwbBhQGXFAv4iI4ON7bbranf6l6IlGje/OL1DnnZO1907vGf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=XNQ8iD86; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783377967; x=1783982767;
	i=alexander.hoelzl@gmx.net;
	bh=OSfPcdtZgsuL6HvWfySKYsFBpSdU0i1sNg45gEwqrNA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XNQ8iD86DgYGPxpapZn3v5IvCF5BLQZbLIM37uGrmNba1d0sDLO3DrsCYDqLfLje
	 GgK8dBCeJ3vmBEPICWUP279Yyd4+galgHljzcLRi1tVNk7EDjuP4h5MDe8Sm4IP3Y
	 wd7vQwlIfbzleY60GVNJn9TSa7Jad8QgkSmIODOnurjDH98wrXuMLIcqkY/3TfGKd
	 shKvAteKe+3MGHYrpnYB5iixp1iTpyZzD5ol/mmaHJNZbFYbHdTaYQxj6DLbsJCmy
	 KBMSLvAAuiMWS33pc4u5ALdDrjVgZ3dn1y82el/1I/GSzrEfwD8buZZCKoUe1+gCy
	 gJP9pLN1L0hGrp39LQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GQy-1xBpBm3wsC-016oGS; Tue, 07
 Jul 2026 00:46:07 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v4 3/3] j1939: add J1939 rx CTS tests
Date: Tue,  7 Jul 2026 00:41:07 +0200
Message-ID: <20260706224548.100451-3-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
References: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szvxe77Da5jodAnxFWrLtkPlxLti3SNmilESb7w3pWtcFXwloPi
 es/jlHPF+obxW7qI7ZRvlp0pW8aledWHlCCNpYxkumcJ4886OMqHX6kMNrSR6eA7VoHRXXH
 Uf3iAAShUpwUcCIEjp/XOvMRGSVPMB6ppLSycthbnphGpwW3Or9NerUnVe04nwEV3mSwtFw
 n+PA6JLAYrex8Z43W1pPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iJAYgeb5IW4=;RAF8nplydfddnk8ZuruWeyt7oe6
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:robin@protonic.nl,m:linux-kernel@vger.kernel.org,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:alexander.hoelzl@gmx.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8014-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonic.nl,vger.kernel.org,pengutronix.de,gmx.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDFF8716229

Add tests to verify the correct behavior of received CTS messages.

The tests verify that the J1939 is able to handle received CTS messages
correctly. The following scenarios are tested:

1. Normal transmission of a segmented message
2. Transmission can be resumed after the reception of a hold message
   and the session is terminated if the receiver does not send a CTS to
   resume from the hold.
3. Transmission is aborted upon request of already acked message
4. Transmission is aborted if too many retransmit requests are sent

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   8 +-
 tools/testing/selftests/net/can/config        |   1 +
 tools/testing/selftests/net/can/test_rx_cts.c | 450 ++++++++++++++++++
 .../testing/selftests/net/can/test_rx_cts.sh  |  45 ++
 5 files changed, 503 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/test_rx_cts.c
 create mode 100755 tools/testing/selftests/net/can/test_rx_cts.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/se=
lftests/net/can/.gitignore
index 764a53fc837f..e42de065854b 100644
=2D-- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
+test_rx_cts
\ No newline at end of file
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/self=
tests/net/can/Makefile
index 5b82e60a03e7..df0f4389c974 100644
=2D-- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,8 +4,12 @@ top_srcdir =3D ../../../../..
=20
 CFLAGS +=3D -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $=
(KHDR_INCLUDES)
=20
-TEST_PROGS :=3D test_raw_filter.sh
+TEST_PROGS :=3D \
+	test_raw_filter.sh \
+	test_rx_cts.sh \
=20
-TEST_GEN_FILES :=3D test_raw_filter
+TEST_GEN_FILES :=3D \
+	test_raw_filter \
+	test_rx_cts \
=20
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selfte=
sts/net/can/config
index 188f79796670..cb538ed93ae4 100644
=2D-- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,4 @@
 CONFIG_CAN=3Dm
 CONFIG_CAN_DEV=3Dm
 CONFIG_CAN_VCAN=3Dm
+CONFIG_CAN_J1939=3Dm
\ No newline at end of file
diff --git a/tools/testing/selftests/net/can/test_rx_cts.c b/tools/testing=
/selftests/net/can/test_rx_cts.c
new file mode 100644
index 000000000000..1b437792d677
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_rx_cts.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
+#include <poll.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <linux/if.h>
+
+#include <linux/can.h>
+#include <linux/can/raw.h>
+#include <linux/can/j1939.h>
+
+
+#include "kselftest_harness.h"
+
+
+#define SENDER_ADDR		0x10
+#define RECEIVER_ADDR	0x20
+
+#define TEST_PGN 0xAB00
+#define SENDER_TP_CM_ID		(0x18EC2010 | CAN_EFF_FLAG)
+#define RECEIVER_TP_CM_ID	(0x18EC1020 | CAN_EFF_FLAG)
+
+#define DEFAULT_RECV_TIMEOUT_MS 2000
+
+/* Segmented payload sent by the J1939 socket*/
+const uint8_t J1939_PAYLOAD[] =3D {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x=
06, 0x07, 0x08, 0x09};
+
+/* Expected RTS payload */
+const uint8_t RTS_PAYLOAD[] =3D {0x10, 0x0A, 0x00, 0x02, 0x02, 0x00, 0xAB=
, 0x00};
+/* Hold payload to be sent by raw socket */
+const uint8_t HOLD_PAYLOAD[] =3D {0x11, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xA=
B, 0x00};
+/* CTS to send to only allow for the transmission of one data frame */
+const uint8_t CTS_1_FRAME_PAYLOAD[] =3D {0x11, 0x01, 0x01, 0xFF, 0xFF, 0x=
00, 0xAB, 0x00};
+/* Resume payload to resume from connection which has been held directly =
after RTS*/
+const uint8_t RESUME_IMMEDIATE_PAYLOAD[] =3D {0x11, 0x02, 0x01, 0xFF, 0xF=
F, 0x00, 0xAB, 0x00};
+/* Resume payload to resume session which has been held after first data =
frame */
+const uint8_t RESUME_PAYLOAD[] =3D {0x11, 0x01, 0x02, 0xFF, 0xFF, 0x00, 0=
xAB, 0x00};
+/* Data payloads */
+const uint8_t DATA_1_PAYLOAD[] =3D {0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0=
x05, 0x06};
+const uint8_t DATA_2_PAYLOAD[] =3D {0x02, 0x07, 0x08, 0x09, 0xFF, 0xFF, 0=
xFF, 0xFF};
+
+/* EOMA payload to cleanup session */
+const uint8_t EOMA_PAYLOAD[] =3D {0x13, 0x0A, 0x00, 0x02, 0xFF, 0x00, 0xA=
B, 0x00};
+
+/* Connection abort payload sent on connection timeout */
+const uint8_t ABORT_TIMEOUT_PAYLOAD[] =3D {0xFF, 0x03, 0xFF, 0xFF, 0xFF, =
0x00, 0xAB, 0x00};
+/* Connection abort payload sent on reaching retransmit request limit */
+const uint8_t ABORT_RETRANSMIT_PAYLOAD[] =3D {0xFF, 0x05, 0xFF, 0xFF, 0xF=
F, 0x00, 0xAB, 0x00};
+/* Connection abort payload sent due to duplicate sequence number */
+const uint8_t ABORT_DUP_SEQ_PAYLOAD[] =3D {0xFF, 0x08, 0xFF, 0xFF, 0xFF, =
0x00, 0xAB, 0x00};
+char CANIF[IFNAMSIZ];
+
+static int recv_payload_timeout(int sock, const uint8_t *payload, size_t =
len, int timeout_ms)
+{
+	struct can_frame rx_frame =3D {};
+	struct pollfd pfd =3D {
+		.fd =3D sock,
+		.events =3D POLLIN,
+	};
+	int ret;
+
+	/* Wait for data to be ready to read, up to timeout_ms */
+	ret =3D poll(&pfd, 1, timeout_ms);
+	if (ret < 0) {
+		perror("poll failed");
+		return 1;
+	}
+
+	if (ret =3D=3D 0) {
+		fprintf(stderr, "timeout waiting for can raw frame\n");
+		return 1;
+	}
+
+	/* Socket is readable, recv will not block */
+	if (recv(sock, &rx_frame, sizeof(rx_frame), 0) < 0) {
+		perror("failed to recv can raw frame");
+		return 1;
+	}
+
+	if (rx_frame.len !=3D len) {
+		fprintf(stderr, "received data length does not match expected value\n")=
;
+		return 1;
+	}
+
+	if (memcmp(rx_frame.data, payload, len)) {
+		fprintf(stderr, "received data does not match expected value\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static int recv_payload(int sock, const uint8_t *payload, size_t len)
+{
+	return recv_payload_timeout(sock, payload, len, DEFAULT_RECV_TIMEOUT_MS)=
;
+}
+
+
+FIXTURE(can_env)
+{
+	int j1939_sock;
+	int raw_sock;
+};
+
+FIXTURE_SETUP(can_env)
+{
+	struct sockaddr_can addr =3D {};
+	struct ifreq ifr =3D {};
+	int ret;
+
+	self->raw_sock =3D -1;
+	self->j1939_sock =3D -1;
+
+	self->raw_sock =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	ASSERT_GE(self->raw_sock, 0)
+		TH_LOG("failed to create CAN_RAW socket: %d", errno);
+
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name));
+	ret =3D ioctl(self->raw_sock, SIOCGIFINDEX, &ifr);
+	ASSERT_GE(ret, 0)
+		TH_LOG("failed SIOCGIFINDEX: %d", errno);
+
+
+	addr.can_family =3D AF_CAN;
+	addr.can_ifindex =3D ifr.ifr_ifindex;
+
+	ret =3D bind(self->raw_sock, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind CAN_RAW socket: %d", errno);
+
+	self->j1939_sock =3D socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	ASSERT_GE(self->j1939_sock, 0)
+		TH_LOG("failed to create CAN_J1939 socket: %d", errno);
+
+	addr.can_addr.j1939.addr =3D SENDER_ADDR;
+	addr.can_addr.j1939.name =3D J1939_NO_NAME;
+	addr.can_addr.j1939.pgn =3D J1939_NO_PGN;
+
+	ret =3D bind(self->j1939_sock, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed bind CAN_J1939 socket: %d", errno);
+
+	addr.can_addr.j1939.addr =3D RECEIVER_ADDR;
+	addr.can_addr.j1939.pgn =3D TEST_PGN;
+	ret =3D connect(self->j1939_sock, (struct sockaddr *)&addr, sizeof(addr)=
);
+	ASSERT_EQ(ret, 0)
+		TH_LOG("failed connect CAN_J1939 socket: %d", errno);
+}
+
+FIXTURE_TEARDOWN(can_env)
+{
+	if (self->j1939_sock !=3D -1)
+		close(self->j1939_sock);
+
+	if (self->raw_sock !=3D -1)
+		close(self->raw_sock);
+}
+
+/* Test normal RTS/CTS transport as baseline */
+TEST_F(can_env, test_no_hold)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, RESUME_IMMEDIATE_PAYLOAD, sizeof(RESUME_IMMEDIATE_=
PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expected");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to CTS with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expected");
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expected");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test holding RTS/CTS transport on first frame and resuming immediately=
 */
+TEST_F(can_env, test_hold_resume_immediate)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expected");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	/* Wait for 300ms before sending the resume */
+	usleep(300000);
+
+	memcpy(tx_frame.data, RESUME_IMMEDIATE_PAYLOAD, sizeof(RESUME_IMMEDIATE_=
PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send resume with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expected");
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expected");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test send hold in transport session and resuming */
+TEST_F(can_env, test_hold_resume)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+
+	memcpy(tx_frame.data, CTS_1_FRAME_PAYLOAD, sizeof(CTS_1_FRAME_PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expected");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send cts(1) with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expected");
+
+	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	/* Wait for 300ms before sending the resume */
+	usleep(300000);
+
+	memcpy(tx_frame.data, RESUME_PAYLOAD, sizeof(RESUME_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send resume with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expected");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test timeout after not resuming hold */
+TEST_F(can_env, test_hold_timeout)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+	struct timespec start, end;
+	long elapsed_ms;
+	int res;
+
+	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
+	res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expected");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	/* Record start time */
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	/*
+	 * Receive with a timeout larger than the expected 1050ms J1939 timeout.
+	 * 2000ms provides plenty of headroom for CI without hanging indefinitel=
y.
+	 */
+	res =3D recv_payload_timeout(self->raw_sock, ABORT_TIMEOUT_PAYLOAD,
+				   sizeof(ABORT_TIMEOUT_PAYLOAD), 2000);
+
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive abort as expected");
+
+	/* Record end time and calculate elapsed milliseconds */
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	elapsed_ms =3D (end.tv_sec - start.tv_sec) * 1000 +
+		     (end.tv_nsec - start.tv_nsec) / 1000000;
+
+	/*
+	 * The actual timeout is 1050ms. We define an acceptable window
+	 * to account for CI scheduling variations.
+	 */
+	ASSERT_GE(elapsed_ms, 1000)
+		TH_LOG("Abort received too early: %ld ms", elapsed_ms);
+	ASSERT_LE(elapsed_ms, 1500)
+		TH_LOG("Abort received too late: %ld ms", elapsed_ms);
+}
+
+/* Test that the connection is aborted after the retransmission of
+ * an already acked frame is requested
+ */
+TEST_F(can_env, test_abort_after_invalid_retransmit_request)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+	memcpy(tx_frame.data, CTS_1_FRAME_PAYLOAD, sizeof(CTS_1_FRAME_PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expected");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send cts(1) with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expected");
+
+	memcpy(tx_frame.data, RESUME_PAYLOAD, sizeof(RESUME_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send resume with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expected");
+
+	/* Now send a CTS for an already acked frame */
+	memcpy(tx_frame.data, CTS_1_FRAME_PAYLOAD, sizeof(CTS_1_FRAME_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send second cts(1) with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, ABORT_DUP_SEQ_PAYLOAD, sizeof(DATA_=
2_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive abort due to duplicate sequence number as exp=
ected");
+}
+
+TEST_F(can_env, test_abort_after_too_many_retransmits)
+{
+	struct can_frame tx_frame =3D {
+		.can_id =3D RECEIVER_TP_CM_ID,
+		.len =3D 8,
+	};
+	memcpy(tx_frame.data, CTS_1_FRAME_PAYLOAD, sizeof(CTS_1_FRAME_PAYLOAD));
+
+	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD),=
 0);
+
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send j1939 payload: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expected");
+
+	/* Send the valid retransmit requests */
+	for (int i =3D 0; i < 3; i++) {
+		res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+		ASSERT_GT(res, 0)
+			TH_LOG("failed to send cts(1) with raw sock: %d", errno);
+
+		res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYL=
OAD));
+		ASSERT_EQ(res, 0)
+			TH_LOG("Failed to receive DATA 1 as expected");
+	}
+
+	/* This is one retransmit request too many */
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send cts(1) with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, ABORT_RETRANSMIT_PAYLOAD, sizeof(AB=
ORT_RETRANSMIT_PAYLOAD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive abort too many retransmit requests as expecte=
d");
+}
+
+int main(int argc, char **argv)
+{
+	char *ifname =3D getenv("CANIF");
+
+	if (!ifname) {
+		printf("CANIF environment variable must contain the test interface\n");
+		return KSFT_FAIL;
+	}
+
+	strncpy(CANIF, ifname, sizeof(CANIF) - 1);
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_rx_cts.sh b/tools/testin=
g/selftests/net/can/test_rx_cts.sh
new file mode 100755
index 000000000000..b2064ea7851e
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_rx_cts.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS=3D"
+	test_rx_cts
+"
+
+net_dir=3D$(dirname $0)/..
+source $net_dir/lib.sh
+
+export CANIF=3D${CANIF:-"vcan0"}
+BITRATE=3D${BITRATE:-500000}
+
+setup()
+{
+	if [[ $CANIF =3D=3D vcan* ]]; then
+		ip link add name $CANIF type vcan || exit $ksft_skip
+	else
+		ip link set dev $CANIF type can bitrate $BITRATE || exit $ksft_skip
+	fi
+	ip link set dev $CANIF up
+	pwd
+}
+
+cleanup()
+{
+	ip link set dev $CANIF down
+	if [[ $CANIF =3D=3D vcan* ]]; then
+		ip link delete $CANIF
+	fi
+}
+
+test_rx_cts()
+{
+	./test_rx_cts
+	check_err $?
+	log_test "test_rx_cts
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit $EXIT_STATUS
=2D-=20
2.55.0


