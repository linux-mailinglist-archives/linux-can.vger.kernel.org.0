Return-Path: <linux-can+bounces-1165-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F5B94A7E6
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5DC2851D7
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4EF1E6724;
	Wed,  7 Aug 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NYcehtKO"
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9CC1E6723;
	Wed,  7 Aug 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034457; cv=none; b=iqUPc4dkGJ9oUUMhyXprbBICi3uZy8LlHgPM5q1AkKo4B4oP4MfUzuw986gNdOQntvRlVQtOkJ1gdp/plyB6HisYgBOA0XoMI2XkuOi/F6a6kabg3CQR7PUuRBQnMO54dhNvtJkIM1re1klgzOsT7FveQlyQhG6+fju2yY/aMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034457; c=relaxed/simple;
	bh=YehjdJhVQfE1SmMkcg6Vh92i4QqpLbWygY3qyRqS24M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GC42cO7majJ8Bf712GFIb3dpU0OkXsUWfEvrS0vCQ0+Nm1MhuEPPHhqSMs3WWgmsG+Mmn+AS+y4akPJRZyw9yU/4ocf9LskT7FCcalMUyK5go2C9pSMpxrEkuKdOUIk29TgUUEaXwIlAhOGtkTuxEp2csGAKeflYI+x8IZoLfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NYcehtKO; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723034151; bh=O8EFHvhwR3zwhlu6IVyc3fhL292dVDPjyYhLVFCwx/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYcehtKOF5ngNu+W+izX80ZjT6s4vNFNY316+dqjPH/hWOTyrGPHcuPl3QtW0CFFZ
	 UARTf8oW298PRDgjePGIR2IYe92O2JBFM8yYxnfvf5T1X1k9EUFmLrSSdhgzus8fig
	 PKq7Tcv2oBSOHcdwDPOy2D0ZNk5rTguFfMdUrzu8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 8EF23485; Wed, 07 Aug 2024 20:35:47 +0800
X-QQ-mid: xmsmtpt1723034147tl0ll2659
Message-ID: <tencent_BB8B66363CC7375A97D436964A80745F7709@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70Tm+qlsdo2pf6f8nFpD+KrPBYeIwgja1uUH6yN6aCauzhpeBrNS
	 /bvbDYlXxThybRPDEIo+E8MEER5lBoWsY5uF1tmy9Gm0+4BZql9jxcPM67GqsJbtziDFg8goENk5
	 INYeTNB2tNc07Fx8I23cQ39bJ3xGkjJ6pCaFjkzNhpS/leH1q0DW65VDdGH6UEjhGq+uwFIqpaD3
	 Crik8uYze2DfCfArnPZWHeTmG9QoDZytieWydhd7ulLPzxPrnZkhppD+Nk7mODMAPqrFVkg9IDpq
	 rWwmxjntkuPXk0m9eSMu+T6S02gQ/QQ3+eJMkXfLwjCtdN19K9Rmyui0p8a3YL4jb8fJ3uPD6IHI
	 sYZuKW8mlkKWeZ/RmRSbtccHfp3iWlXZT5fRbL9xUSxXb7QmxBLDfaktWIF7HhJhd+eJaSgYs6kM
	 aRRKzPGWBMow5MRCPxsWZnHw4GEp4tl4/Y1c9nRA1hhS8kQuxZO9LG9u2Nd1PsRGyqAaJAfiPaoX
	 YJBMEsOG9JQ657PKqs/ADl92szjk8gIgz0ATMy9CHbYri2+PrBbDUOlMuXZOpk0df8mbqNXkzRET
	 II3HYVhbHraY2e/+wKQfy6KLYKfb85zhwnnY4/h4S8aqRrl37nlmY8B50u2qJNnN4RCBtUYx5WPS
	 8mWC/5NyG4dwHKYfeigYhRRVXfaHDmVGzmp4ZShQFYnZngZDkSNVwhQrpPvE2isKbuWIfcIBRLGa
	 oBlXvTv+P1M258CwHAvnBzRqiME+ajR3TX7ePO1Wryw/q2PisSks6Yjs5imZIAzONM+whnBkHgmj
	 EoqyHtFFcQuhQ8L57+dhUUJ0ctknxSsrbuS3jpZWPiHCxpJ45arVnTi8Chz5Zyv3o35B7JO+5rGx
	 hqJ8HMmzcyFwfftKfwSFTQShKjxIc0zOoIIjt7qKQQy2iwCpWl7MA5ITR5AEZRFPTkj3K3OU4v3x
	 a5mgk5ABM=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	leitao@debian.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	robin@protonic.nl,
	socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net-next] can: j1939: fix uaf in j1939_session_destroy
Date: Wed,  7 Aug 2024 20:35:47 +0800
X-OQ-MSGID: <20240807123546.460919-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root cause of this problem is when both of the following conditions
are met simultaneously:
[1] Introduced commit c9c0ee5f20c5, There are following rules:
In debug builds (CONFIG_DEBUG_NET set), the reference count is always
decremented, even when it's 1.

[2] When executing sendmsg, the newly created session did not increase the
skb reference count, only added skb to the session's skb_queue.

The solution is:
When creating a new session, do not add the skb to the skb_queue.
Instead, when using skb, uniformly use j1939_session_skb_queue to add
the skb to the queue and increase the skb reference count through it.

Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")
Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/can/j1939/socket.c    | 7 ++++---
 net/can/j1939/transport.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..ec78bee1bfa6 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1170,10 +1170,11 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 					break;
 				}
 			}
-		} else {
-			skcb->offset = session->total_queued_size;
-			j1939_session_skb_queue(session, skb);
 		}
+		/* Session is ready, add it to skb queue and increase ref count.
+		 */
+		skcb->offset = session->total_queued_size;
+		j1939_session_skb_queue(session, skb);
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..dd503bc3adb5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,6 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
@@ -1548,6 +1547,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		kfree_skb(skb);
 		return NULL;
 	}
+	j1939_session_skb_queue(session, skb);
 
 	/* alloc data area */
 	skb_put(skb, size);
-- 
2.43.0


