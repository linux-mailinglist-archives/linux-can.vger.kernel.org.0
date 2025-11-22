Return-Path: <linux-can+bounces-5608-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2407C7D145
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 14:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91F574E2774
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50A1369B4;
	Sat, 22 Nov 2025 13:03:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9813635E;
	Sat, 22 Nov 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763816638; cv=none; b=h8qfDJqO8/PzvackPNUJkGBcxbezZERnfWMGDohbw9FXmS7k8B0hvia8EBoL4+JKONCn/zbZkxZp6tc7nK8fiykgyfgAy+1t/V0bAvCmk99zTUw9FZwdDcmp7thACJutynWZe0O3naV1ahLHsI0OmgC+1wD9sgpjIPafTyyix+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763816638; c=relaxed/simple;
	bh=+Lfgpq3Ao74rH+mvc7/RI/ecOf6K18wyFuufJ41TGII=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MhDEgSGnkXXy6qOIbz595sJYJ+mWQRwD4++lixFY20m7jdjb4Vsn0nProH5xFxX5XZn/C6bwRlVm2aoXVpaKP+ojqvkGbkeQL/Kka/F92+54Xii52+z48Z7iNl/7iEOBcuT5cbFQE3gq/AIJPJpWsOxROGJWXdG/fx2K+hSI9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AMD3e18085787;
	Sat, 22 Nov 2025 22:03:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AMD3elD085784
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 22 Nov 2025 22:03:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c57cdb0f-83c5-4550-91b9-61d068bd8264@I-love.SAKURA.ne.jp>
Date: Sat, 22 Nov 2025 22:03:40 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can/j1939] unregister_netdevice: waiting for vcan0 to become
 free. Usage count = 2
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
 <aSArkb7-JNW-BjrG@pengutronix.de>
 <3679c610-5795-4ddf-81ad-a9a043bab3fc@I-love.SAKURA.ne.jp>
 <aSA4JMyFNdliTpli@pengutronix.de>
 <c95f5436-3e7e-43b8-820b-e380f059b9f8@I-love.SAKURA.ne.jp>
 <aSA_hyGuitJDHpB3@pengutronix.de>
 <85b701a9-511d-4cf2-8c9c-5fade945f187@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <85b701a9-511d-4cf2-8c9c-5fade945f187@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/11/22 16:00, Tetsuo Handa wrote:
> So, not only we need to make sure that all existing j1939_session are destroyed
> but also we need to make sure that no new j1939_session is created if underlying
> net_device is no longer in NETREG_REGISTERED state.

For your testing, here is a delay injection patch and a complete reproducer.

---------- delay injection patch start ----------
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fbf5c8001c9d..601a32397f72 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1492,6 +1492,9 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	struct j1939_session *session;
 	struct j1939_sk_buff_cb *skcb;
 
+	pr_info("%s() delay start\n", __func__);
+	mdelay(5000);
+	pr_info("%s() delay end\n", __func__);
 	session = kzalloc(sizeof(*session), gfp_any());
 	if (!session)
 		return NULL;
---------- delay injection patch end ----------

---------- j1939_example.c start ----------
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sched.h>
#include <linux/can.h>
#include <linux/can/j1939.h>
#include <net/if.h>
#include <errno.h>

#define IF_NAME "vcan0"
#define SRC_ADDR 0x20 // SA
#define DST_ADDR 0x30 // DA
#define PGN_TX   0x12300 // Sender PGN
#define PGN_RX   0x12300 // Receiver PGN

static void sender_task(int sock_s);
static void receiver_task(int sock_r);

int main(int argc, char *argv[])
{
	int sock_s, sock_r;
	struct sockaddr_can addr_s, addr_r;
	struct ifreq ifr;

	// Create a new namespace.
	if (unshare(CLONE_NEWNET)) {
		perror("unshare failed");
		return 1;
	}

	// Create vcan0 in that namespace.
	system("/usr/sbin/ip link add dev vcan0 type vcan");
	system("/usr/sbin/ip link set up vcan0");

	sock_s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	sock_r = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);

	if (sock_s < 0 || sock_r < 0) {
		perror("socket creation failed");
		return 1;
	}

	strcpy(ifr.ifr_name, IF_NAME);
	if (ioctl(sock_s, SIOCGIFINDEX, &ifr) < 0) {
		perror("ioctl SIOCGIFINDEX failed");
		return 1;
	}

	addr_s.can_family = AF_CAN;
	addr_s.can_ifindex = ifr.ifr_ifindex;
	addr_s.can_addr.j1939.name = J1939_NO_NAME;
	addr_s.can_addr.j1939.addr = SRC_ADDR;
	addr_s.can_addr.j1939.pgn = J1939_NO_PGN;
	// Delete vcan0 in that namespace while bind() on vcan0 is in progress.
	if (fork() == 0) {
		sleep(1);
		system("/usr/sbin/ip link del dev vcan0 type vcan");
		_exit(0);
	}
	// Delay is injected by the kernel side.
	if (bind(sock_s, (struct sockaddr *)&addr_s, sizeof(addr_s)) < 0) {
		perror("sender bind failed");
		return 1;
	}

	addr_r.can_family = AF_CAN;
	addr_r.can_ifindex = ifr.ifr_ifindex;
	addr_r.can_addr.j1939.name = J1939_NO_NAME;
	addr_r.can_addr.j1939.addr = DST_ADDR;
	addr_r.can_addr.j1939.pgn = PGN_RX;
	if (bind(sock_r, (struct sockaddr *)&addr_r, sizeof(addr_r)) < 0) {
		perror("receiver bind failed");
		return 1;
	}

	printf("J1939 sockets set up on %s\n", IF_NAME);
	printf("Sender (SA 0x%02X) and Receiver (PGN 0x%05X) ready.\n", SRC_ADDR, PGN_RX);
	sender_task(sock_s);
	receiver_task(sock_r);
	return 0;
}

static void sender_task(int sock_s) {
	struct sockaddr_can addr_dest;
	socklen_t len_dest = sizeof(addr_dest);
	char data[] = "Hello J1939 Localhost!";

	addr_dest.can_family = AF_CAN;
	addr_dest.can_ifindex = 0;
	addr_dest.can_addr.j1939.name = J1939_NO_NAME;
	addr_dest.can_addr.j1939.addr = DST_ADDR;
	addr_dest.can_addr.j1939.pgn = PGN_TX;
	printf("Sending message: \"%s\" (Length: %lu)\n", data, (unsigned long)strlen(data) + 1);
	if (sendto(sock_s, data, strlen(data) + 1, 0, (struct sockaddr *)&addr_dest, len_dest) < 0) {
		perror("sendto failed");
	} else {
		printf("Message sent successfully.\n");
	}
}

static void receiver_task(int sock_r) {
	struct sockaddr_can addr_src;
	socklen_t len_src = sizeof(addr_src);
	char buffer[256];
	ssize_t bytes_received;

	printf("Waiting for messages...\n");
	bytes_received = recvfrom(sock_r, buffer, sizeof(buffer) - 1, 0, (struct sockaddr *)&addr_src, &len_src);
	if (bytes_received < 0) {
		perror("recvfrom failed");
	} else {
		buffer[bytes_received] = '\0';
		printf("Received %zd bytes from SA 0x%02X, PGN 0x%05X: \"%s\"\n",
		       bytes_received, addr_src.can_addr.j1939.addr, addr_src.can_addr.j1939.pgn, buffer);
	}
}
---------- j1939_example.c end ----------


