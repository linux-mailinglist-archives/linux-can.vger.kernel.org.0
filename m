Return-Path: <linux-can+bounces-7523-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMrrNKXW+WmDEgMAu9opvQ
	(envelope-from <linux-can+bounces-7523-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:38:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB34CCC9D
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC6A330CB76B
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7E3E3DB6;
	Tue,  5 May 2026 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ThN/7tRt"
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FA32BF44;
	Tue,  5 May 2026 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979592; cv=none; b=tOACmE8xIyZ6cPWww0KQB8m+xxq4jlHWDX/S2tNRgwaQEbTgK/CmPRcHv4JPJnvf/7v+OVev6F3tpvwJ1kWl0dJu322hpIDUINLXkzr/1feZ+XSBLWvo4nPdRSTQxlfyW9jPEMCqbphCOiX7SCCnLrmfIbSLcZx+QTcKQzaMvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979592; c=relaxed/simple;
	bh=mGVAnLGtOPFV27xFwEwfReeld+RFhURreIS7Dh6s01M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jL1e7Wf+x0JbjoZTNMWBikAnQ00RRmQW8W/uOSeQoDLkrua/x6ONUBy29XbGhVhmphjey12KxnHNYV5I7zT2G22KeUBF7JN8sEZBFWiOviH9eGU/hGlH0tr/fpHenHejYLU9Aufqhtt0JBYcelzhgPJvZM/D5ko9LEpCgB+8wBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ThN/7tRt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZtK5G7nzJTsIuWFqmlMXMSaUIsWUgRKDSRorndPCA2M=; b=ThN/7tRtM3Dc61pJKFGRiP4L8R
	UyFNSZKHwZcYr4Z9xnHBJgY+UrIU8ZhqBzWXDODSHT+k/GPdQBjPHg4ZgO9syUxVUtYKSO9yF4ND0
	kUXE+FK28Ne7X3/xSVmLuRRHpKtQcnyzt3osZD+Ojs2V4W7URS+ZM9JoPzPZGvbpBahoFMycTcGyh
	HGGAtfXMyMFofto8hNweKJ287q2z/mW92zWfEHF2nV4kb2+OAI/hTn/WFwEB1DA6BoFDYvR8PSu1N
	L9tMx5wbujm29wjQsI+NZsmYwPKsT8VUozkHXXTd6S4MECNVeCRoB8GhpCrayPvbR+NfjyhVuNimP
	Sr7vBM8Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKDht-002lXj-14;
	Tue, 05 May 2026 11:12:53 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/5] net: convert four more protocols to
 getsockopt_iter
Date: Tue, 05 May 2026 04:12:37 -0700
Message-Id: <20260505-getsock_two-v1-0-4cb0738950e0@debian.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXQ+WkC/yXM0QqCMBQG4Fc5/NcOpstBe5UImfNkK9hiO5Ugv
 nto1x98KyqXyBWOVhT+xBpzgqO2IYS7TzOrOMEROt1Z3etezSw1h+cg36z86Kf2bE/GGIuG8Cp
 8i8uxXZBYVOJFcP1LfY8PDrJn2LYftd7AfnkAAAA=
X-Change-ID: 20260505-getsock_two-abad19643336
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=leitao@debian.org;
 h=from:subject:message-id; bh=mGVAnLGtOPFV27xFwEwfReeld+RFhURreIS7Dh6s01M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp+dCvA8oeaVvEBD/Zk8jGOTXQcSnc9oIylXxLh
 yCuApmiAF+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafnQrwAKCRA1o5Of/Hh3
 bc03D/9n7CBr8dOO0qZP1q4lDp3vkAY7d99GQ7MYvercgNQqjLPyrFCHtTmyPBTmETmJzY6iTcZ
 vy04WrG31AO5F7ObpliQfb16ms4NPS0FZ48o1E5tssB9CtPj4R+4cXQKYowwvnQoUHyOri79iuq
 xbPOcZBOBK4RgC7+VrzViahq7nGOSLlUwopX+MTOnDHqEWM7fjoPy7Qhi5KhNN0hl0JvaYG3UTN
 atlS2PS0AGJwSJ828VNBXRQOIVL54vpDjDv3ya41TpiZDHeqhwhiK/GALCQrXv9rAP/rE5KpkZV
 7mMI881JullQ9P8bghU92qkFNoWQBC14TMSaqUEfe6vqiYzg1wcG0wnHRGwXag8ulzZOi+rPhhf
 /j2lLWH9bM10NIKTnPcD82sZdseB6yOyThWTqSBwNlbuwZTn9caFowsD1hNtGKL2A1JYgx2brFL
 85mkNlPBVFLB80VTzSQXD0+Fh8/DNa5A5zNX04MDOkaA2bEX/+iyt7NBE5QJg/y8efg4Q4rlcXF
 fTD5GdxTAV2GBrfKx01s0CTmiBf8t1sES1+OuuwxhqMuzw5r63GlQqRr3sN0Av2GZxnNmuMJxF0
 FOyKwK26D6TkTvCG3BmnCkY5+xlyKyKMhpsNIvQ5m42EhwB7zPkkuz7n1VN0yT8/uFaoSHK1p0b
 4EXObHpTwuhKzvA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 37AB34CCC9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7523-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Continue the work to convert protocols to the new getsockopt_iter API.

Convert four additional getsockopt implementations to the new
sockopt_t/getsockopt_iter callback:

  - CAN ISO-TP
  - MCTP
  - CAN J1939
  - LLC

These are mechanical, ABI-preserving conversions following the same
pattern as the previously converted protocols (af_packet, can/raw,
af_netlink, af_vsock): the (char __user *optval, int __user *optlen)
pair is replaced with a single sockopt_t *opt that carries the buffer
length on input and the returned size on output, and exposes an iov_iter
for the copy-out path. put_user()/copy_to_user() pairs are replaced with
a single copy_to_iter() per option, and the wrapper in
do_sock_getsockopt() handles writing optlen back to userspace.

I picked these four because each is small and self-contained, with only
one getsockopt callback and a handful of options, so the conversions are
easy to audit individually.

NOTE: optlen is always updated (returned to userspace) even when optval
fails to copy. I.e, userspace will get the "new" optlen even when the
getsockop() fails. That seems wrong, but, this just preserve the
previous behaviour, not changing it.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (5):
      can: isotp: convert to getsockopt_iter
      can: j1939: convert to getsockopt_iter
      mctp: convert to getsockopt_iter
      llc: convert to getsockopt_iter
      selftests: net: getsockopt_iter: address review nits

 net/can/isotp.c                               |  12 ++-
 net/can/j1939/socket.c                        |  21 +++--
 net/llc/af_llc.c                              |  15 ++--
 net/mctp/af_mctp.c                            |  10 +--
 tools/testing/selftests/net/getsockopt_iter.c | 109 +++++++++++++++++++++++---
 5 files changed, 128 insertions(+), 39 deletions(-)
---
base-commit: c1e5127b577c6b88fa48e532616932ae978528d5
change-id: 20260505-getsock_two-abad19643336

Best regards,
--  
Breno Leitao <leitao@debian.org>


