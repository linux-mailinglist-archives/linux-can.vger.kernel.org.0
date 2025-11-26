Return-Path: <linux-can+bounces-5664-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE20C87FC3
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 04:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECA90354370
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 03:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D9B308F09;
	Wed, 26 Nov 2025 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="XHP2KBa8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1991632DD
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128773; cv=none; b=YsFc4OGQbZuUbFlEitn8PqKyiqeg42dAYlgpZ8tKWTuEfZRM+tbwJr/xg3QjCalzKZ4SeNS0s2FhsI9YgWi7MGHd0TI55ppkXeZfEljDAIQQ7DJe8sEWu25uiEv5Cg7COvpjFZNwHCgwTqIMF8RKPKaIlvAmciNBEU4HoQBcvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128773; c=relaxed/simple;
	bh=YTJTsaHQmUL99NvK8+4VZBxoWMvT0DJLWraueRWowDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USMLS0N510KLOaTVFdJWKhRO9gtqv0wx+quWenyOcM9QDWYntlodv8xKsl3eJUyBT0lf2J9oiTJSH7orv4zr3tJgLPJlWx9uzZFqlZ2GXVd11aou6IdhXLwnAXSlpkxtp+kRYu4sqw5d1VymI9w6lJN2+mDP7Tbn1janm1Sfj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=XHP2KBa8; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso8890066a91.2
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 19:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764128771; x=1764733571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0OQa00OisAI9Yf2BGn0QlVHZWUx/PRSa3ljqdERpcQ=;
        b=XHP2KBa8J45PHqk4TG0AZi6qTrM1tPDokkLlQWViQ0+szwHvxDwNOuJE7pPI4qIr8m
         6iRdvbfNZyo8iYTz7LQgd7k5LrB8hR/rBtUoLcG4VmRl/XsXXNeI2wpyqw1RwTyx449I
         8E/rman10kBGMCPL6SCJZ1J91v2B1NAEaT12k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764128771; x=1764733571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0OQa00OisAI9Yf2BGn0QlVHZWUx/PRSa3ljqdERpcQ=;
        b=eaYEaj3jXjAIM0JbOytMMHhP3rS0+qUMdbh5Q5k1B1Qd5O5ROhud1n8arevPwW77hU
         9hb6swpenkyCQxvmIuEEu9NMbCBAr852hk5IiM3nfjPsgFhSuySU65mwz5y3ZrJH6okf
         5cguE5J1aTB7C/b8mGm9O8Q39AoNTWzLTucEu6DUVij6WbipF6OQLIVQ+XQfiYlHoPbE
         Mg0e5ggyoK3yQvC0T9Kmm1seUVVlwuhOoRaASDE8a3wlVlRV3+1fCoHFzgYz7xqk3TCb
         BCvPoMflTZ77QeGW/rVSWWDLWdzlxgbMSfLdsYNuoIV2IAAmq0LDAwCdyN9T2oymKeZy
         Vpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXu+nlJx49Gwy5AXMS45LeJjoy2MEhUSvUIsUmX8zeuJue5Swth2X3/Iuq0aLbtkTzSF3OFWBogPs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjmU1hAoRRmYo31v5G1vpfSS2drNk5/2O7OPwLX2KlsOiq4ZNa
	uy9J1df7xZHYfDE3H1BeIi8yxp9B/I8a7+OiwmXOw69085VPOgBWeQxR+1Kf3aqlJqI=
X-Gm-Gg: ASbGncvPwudkq22DzsnZFddTNv2xTEiuuElaiNk+RmK46nCGG5LdIyEB5GpA5UYHSFB
	SmK0NNA/MSTiSURyZ0Be76FKrspZ89D+hEe8fhMblYgIEcjHABVNkUJ01A1Mwv6rH4whT6V+G4v
	Syr0TEqti5NwnoNltAwN5ato60PyZKgc5pvIh5Iu98ArtT2R5eXJKfMmAq6iYNvOSOz9XWYmoUt
	IAbn+bScMzMsnYfMxSDSWobFd2eIpvGnhn9LCDWFWfdT8fqd0rMJr8g5BHrpZJi75v+kSq31J3r
	IGkebksEljRjI++EfVpVtJ9f2ioihmINGfH8IjseDOxKu/z/C5qIjm+dnFrqlnTMaDxiaijGKcV
	zdAVFIdDVZ15jxfKNwXvyrt1bnaCoaIiuKfz6R38oMNscH+yU4xp4PtBzO6FR5tjgDDrdYbWJJA
	+E26MK/I+hpPERkX+uGn8cmxAIAo5GbYqDuRHkv2rDQEg9z89sKV7xRH4m
X-Google-Smtp-Source: AGHT+IGdbZpTaNhkORvuwsJtkl/0aqTP4Z+/MfLQ2cdKMWZ8EnjRZs396Kq3PBwRLHF0A7Z5HsdZeA==
X-Received: by 2002:a17:90b:53c3:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-34733d68a15mr15410786a91.0.1764128771454;
        Tue, 25 Nov 2025 19:46:11 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:f53f:2666:7529:e5cd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ea1b3e8sm1509638a91.5.2025.11.25.19.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:46:10 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Subject: [PATCH net] net/sched: em_canid: add length check before reading CAN ID
Date: Wed, 26 Nov 2025 09:16:01 +0530
Message-Id: <20251126034601.236922-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Add a check to verify that the skb has at least sizeof(canid_t) bytes
before reading the CAN ID from skb->data. This prevents reading
uninitialized memory when processing malformed packets that don't
contain a valid CAN frame.

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/sched/em_canid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5337bc462755..a9b6cab70ff1 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
 	int i;
 	const struct can_filter *lp;
 
+	if (skb->len < sizeof(canid_t))
+		return 0;
+
 	can_id = em_canid_get_id(skb);
 
 	if (can_id & CAN_EFF_FLAG) {
-- 
2.34.1


