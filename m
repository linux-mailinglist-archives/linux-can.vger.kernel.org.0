Return-Path: <linux-can+bounces-7702-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGJIL+OeFGoLPAcAu9opvQ
	(envelope-from <linux-can+bounces-7702-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 21:11:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCA5CDF4E
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 21:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF6DA302262C
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733B937CD53;
	Mon, 25 May 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="s6KOFQJv"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905838423F;
	Mon, 25 May 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736238; cv=none; b=uNpNFM5CqZgL/bIx2NhluqfQRQLZW1zyU/TwbMCDXEYwVp6QjrvA6wyRG42avKdIqMw9NGW+67yfyGJNcXQ2KIbTfEYfjR0XVKByIrYQKWkZN537vW8jb+OSmGilIOy7GTiFoSRnBG6cyMNZZowGGE+7KiWVNh/L1GyIJCnJtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736238; c=relaxed/simple;
	bh=KMWoBcApqlzqSQP5zDn3fyfi9XAs41jfVui5hFzJyl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYpUke3TDF0WZVJ6t4COr5C3C8njUb+WqzaaKA54u+p4S3OuEnrGILnCAl2w+Xs8oEDSbcaV1RzG3zH42rFBtinnNP8lYKQLNk0IVRe6yq2nu/uMB5OdzcCV7vcb4/vAtLyrn7YyvFTGnD4Gy+YBra0PLYY3MmWyRqXXPPzXaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=s6KOFQJv; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779736230; x=1780341030;
	i=alexander.hoelzl@gmx.net;
	bh=WeDZ+/9HU8XuxaSxC8BvuEEjCYskaUWMr0oVW6N+yfs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s6KOFQJve6rV4759XOXhn/kA1DK6VYwlDQt2ADZwYO/AVjda2GJdXEGMFNq7x3wp
	 YZN3B70/gvRbsCZdtInUZDuTpWpZVobRUMV1AcVtEobL+XxR/zFCdNjs9zzAWDSMq
	 VRaj1nTwza5FMEb3VeAN8ZRWBJNi1tlkE2BMBSdBzKCmzDfzOw77WDUf05llF92gp
	 kP3iT8Wzt9IOAmALnTVl9ONobd/j7lYQd8/MNMN7O3GRBcaP0jkUNV4AEBLiwoLvC
	 WoUMI+wG3imXLsgjhS7xgZXV+VRAxpuGDermphwo6kojHfvnIRaaVACTULstROgSl
	 39JnNtODP070s+eaUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1wXv0z2XWB-00Bp9Z; Mon, 25
 May 2026 21:10:30 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v3 2/2] Add J1939 CTS hold tests
Date: Mon, 25 May 2026 21:08:49 +0200
Message-ID: <20260525190948.42461-2-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
References: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NOZvNcYK96qsmhHQ3+AJ5kYuDtobhqWR/V6f8aj22eT3DIEPqhs
 bseigwcB4I3ZZrT0+bO3fNGR5BO6LmUH7wJd2ZD67ktC7IV3k+hHCboIjZU3Ldv/pQDzVkS
 WCTEtEj8e1QHIv+wfdMo20c+ukwJ0O7qmk2NZwt+BzGijViwtISITy8D+TZXCUL1uSdrj4f
 L3tIoLucKjYQsaNc9SZaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s0gGLmrvUzI=;DcTLu8Z6AqeevUBC8FWbaPy5QUy
 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
 W8/37R6NOcO9rQrJ5U=
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7702-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[protonic.nl,vger.kernel.org,pengutronix.de,gmx.net];
	DKIM_TRACE(0.00)[gmx.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,j1939.name:url,test_cts_hold.sh:url]
X-Rspamd-Queue-Id: 15CCA5CDF4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add tests to verify the correct behavior of CTS hold messages.

The test verify that the J1939 is correctly able to restart the
transmission after the reception of a hold message and the
session is terminated if the receiver does not send a CTS to
resume from the hold.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   8 +-
 tools/testing/selftests/net/can/config        |   1 +
 .../testing/selftests/net/can/test_cts_hold.c | 359 ++++++++++++++++++
 .../selftests/net/can/test_cts_hold.sh        |  45 +++
 5 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/test_cts_hold.c
 create mode 100755 tools/testing/selftests/net/can/test_cts_hold.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/se=
lftests/net/can/.gitignore
index 764a53fc837f..96ef18ae986d 100644
=2D-- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
+test_cts_hold
\ No newline at end of file
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/self=
tests/net/can/Makefile
index 5b82e60a03e7..182346682bce 100644
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
+	test_cts_hold.sh \
=20
-TEST_GEN_FILES :=3D test_raw_filter
+TEST_GEN_FILES :=3D \
+	test_raw_filter \
+	test_cts_hold \
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
diff --git a/tools/testing/selftests/net/can/test_cts_hold.c b/tools/testi=
ng/selftests/net/can/test_cts_hold.c
new file mode 100644
index 000000000000..4fe4b97d6206
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_cts_hold.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
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
+/* Segemented payload sent by the J1939 socket*/
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
+/* Timeout payload sent on connection timeout */
+const uint8_t ABORT_TIMEOUT_PAYLOAD[] =3D {0xFF, 0x03, 0xFF, 0xFF, 0xFF, =
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
+/* Test RTS/CTS transport without hold as baseline */
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
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send hold with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 1 as expeceted");
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expeceted");
+
+	memcpy(tx_frame.data, EOMA_PAYLOAD, sizeof(EOMA_PAYLOAD));
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send EOMA with raw sock: %d", errno);
+}
+
+/* Test holding RTS/CTS transport on first frame and resuming immediatley=
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
+		TH_LOG("Failed to receive RTS as expeceted");
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
+		TH_LOG("Failed to receive DATA 1 as expeceted");
+
+	res =3D recv_payload(self->raw_sock, DATA_2_PAYLOAD, sizeof(DATA_2_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive DATA 2 as expeceted");
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
+		TH_LOG("Failed to receive RTS as expeceted");
+
+	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
+	ASSERT_GT(res, 0)
+		TH_LOG("failed to send cts(1) with raw sock: %d", errno);
+
+	res =3D recv_payload(self->raw_sock, DATA_1_PAYLOAD, sizeof(DATA_1_PAYLO=
AD));
+	ASSERT_EQ(res, 0)
+		TH_LOG("Failed to receive RTS as expeceted");
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
+		TH_LOG("Failed to receive DATA 2 as expeceted");
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
diff --git a/tools/testing/selftests/net/can/test_cts_hold.sh b/tools/test=
ing/selftests/net/can/test_cts_hold.sh
new file mode 100755
index 000000000000..e69e9109245c
=2D-- /dev/null
+++ b/tools/testing/selftests/net/can/test_cts_hold.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS=3D"
+	test_cts_hold
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
+test_cts_hold()
+{
+	./test_cts_hold
+	check_err $?
+	log_test "test_cts_hold"
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit $EXIT_STATUS
=2D-=20
2.54.0


