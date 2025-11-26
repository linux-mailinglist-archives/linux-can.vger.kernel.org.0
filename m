Return-Path: <linux-can+bounces-5667-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4BC885A6
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 08:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89F74E3648
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4D288520;
	Wed, 26 Nov 2025 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="JQ7SWZ8v"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795421FF46
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140832; cv=none; b=Q3rVoskuVG0W3rHOCS1T7ax2CdauH+FBKdrJE+iubXLsfp6nVd/5SNDkL+wI+Cc04LDp8xF7ttKvY1TFZ9+AVnbYId0T6oqQY/jNI/MOjctJHes13PRYDWzRECIlJuy6NJMnqV9UcmF0ilT69hOtiZrCI/Wgu/Wp2Z+dvbTIsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140832; c=relaxed/simple;
	bh=VB4nQunFf+O3DmYPGWwxjYu5Lg4IWPHg/FOy86FFr0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BwsqZIvT4TWJW+ExNRtC38PZJk4PQdzpkkgeYbnKBCYextBxRWtKtiJB6EPMNGYmVrZjhy+HGCBu1bC1wAjGgRjgEEQOhg1DSonvx+SRnGX6LMkpLPtJnuZFTnhoYPG9LdyPdc87to6atdCtb8EKFr+gdFeI6kPsLKF3ynrVRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=JQ7SWZ8v; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2984dfae0acso100039015ad.0
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 23:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764140830; x=1764745630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXm+TGMia1g3kmuDV/aF57ZmqWwNOjaNm4FLB34Qkxc=;
        b=JQ7SWZ8va3yOG83pZgWPCtQoST0TmPwJka/mUlaX09ebW/KU5viLIYQoDWdDNMtPXC
         zO6/7qjqDanY3+m6VJ2jPLaZI5WgqgKurhpKX4EUXxyqwbTurZNVO1zSW8jqNki7Qfut
         4N+ynQI5lEvv3GhonqK+kXdK9H9KLIXcEC4ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764140830; x=1764745630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXm+TGMia1g3kmuDV/aF57ZmqWwNOjaNm4FLB34Qkxc=;
        b=XPQA3J1pXPFRjUivtgZBm8MlQhmLEYiSAuYZbbY77mSlbtm1X3b5iCunfrSAeTHGNn
         imIRArn2cwDdnMg9VohXtUnyC9QUskqXwH6pBFqiGI1QWbXPWobbrGIghfiF3J+te0CG
         +4JgAHfNk51Bp0LrNXAceLA5CMrZ9y/EuHlASIhFqlTJZ9QVfkicxYiEPVDOR+Bw7F7+
         wO51IzGDVYOxro2nr1CviIrRzIuGlMcf2rSiCuR2ewjOXfeEtVfZ3rXY2PKJPH4DbrV+
         YpC9dHeyMm5y5lXqAudoh2dXrttsTFZaliiTvvUd22uEEeaIETc6O0DunDLhicnCv7lq
         p5wA==
X-Forwarded-Encrypted: i=1; AJvYcCV8lm2zXBvh9H/FyOPb0KqDYBO+8f+LXdCuHE4dozwRLLve2jL6LGHpvFjGQX6AS6zXQffN3wzvybo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPauZVPVAYSQltW60EyZFLY7wIR+0h3xv+vQNDz+r67ca+5rjh
	BDUQvkS+wiXVVkT3gBvOZ0/exknyz7ZDCM13Kx3o9+qh3REevnxMPqhEtJavfGJQKa8=
X-Gm-Gg: ASbGnctwcpQDk687j8xi2AfVzM9/fSwl2oosUUs+FfwJLdECyon35qYVBcskqjFpdh/
	afGnxnj90pJDhu94GlckO3W+Vyd+udSr6blaLTfGCZQ3+VceWcW16SRlOK859dfpdBnxpn58f3H
	zmRusaYWqT2AI0tGIlUXmI+ukAA/f1oKSTt21iWOxpBpmglrLNsxkghNJWMpruZ+x9OIRqbNfqA
	OxVyqYeIRTFgiFgDTxu+Auth7zzFeYRIftLQI9jeigr2EfI7bXFhLC6fTQbdZpKrUDleKQ9kgCD
	99+z8YOn1BpTlSyeFrMxdkadlK69/3evmUJTInf0+QrtG5OUpq7AQwg6iq8QgnImtoofD2It2A4
	/OmVgMjndn5/m0jHbCLtfJxQPX2Prfhzkr4FFPCK+x02gv4ulbFalK3EJF2Ysz2HE3EZSrm9lYP
	g1f//q4KnLetX3QmDfEL8AhDZgEb10gTgzHdMl/6x5PXMB+t9fbnMtHDzqAn18tzn8KPA=
X-Google-Smtp-Source: AGHT+IGkJkFFiIZ7CfI+PiIjFnbPp5NR5QiZ9xPjeb3SVz81eUnXoOljRms9fCxUpzbe+iXyOsOtgw==
X-Received: by 2002:a17:902:f70c:b0:298:6a9b:238b with SMTP id d9443c01a7336-29bab1d74ddmr58569865ad.51.1764140829664;
        Tue, 25 Nov 2025 23:07:09 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:7ab4:fdd5:842b:6bfe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105e4csm183853715ad.2.2025.11.25.23.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:07:09 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rostislav Lisovy <lisovy@gmail.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Subject: [PATCH v2] net/sched: em_canid: fix uninit-value in em_canid_match
Date: Wed, 26 Nov 2025 12:36:41 +0530
Message-Id: <20251126070641.39532-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Use pskb_may_pull() to ensure the CAN ID is accessible in the linear
data buffer before reading it. A simple skb->len check is insufficient
because it only verifies the total data length but does not guarantee
the data is present in skb->data (it could be in fragments).

pskb_may_pull() both validates the length and pulls fragmented data
into the linear buffer if necessary, making it safe to directly
access skb->data.

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
v2: Use pskb_may_pull() instead of skb->len check to properly
    handle fragmented skbs (Eric Dumazet)
---
 net/sched/em_canid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5337bc462755..2214b548fab8 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
 	int i;
 	const struct can_filter *lp;
 
+	if (!pskb_may_pull(skb, sizeof(canid_t)))
+		return 0;
+
 	can_id = em_canid_get_id(skb);
 
 	if (can_id & CAN_EFF_FLAG) {
-- 
2.34.1


