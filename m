Return-Path: <linux-can+bounces-7704-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOSCKQN2FWrHVAcAu9opvQ
	(envelope-from <linux-can+bounces-7704-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 12:29:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D2E5D42FC
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6AAC3033080
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C33CF699;
	Tue, 26 May 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmm7b1fW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E736CDFD
	for <linux-can@vger.kernel.org>; Tue, 26 May 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791037; cv=none; b=ixKx2u7YEZiyHrf6jQUJdb/r6IEnKIYc35848cG7yQlMjFNbHr+gzFQLS0tp9cb8uKWoSBzK76N36xC/M8Zuypv2G7VCI+OCkO4K1/2sIQHWKVSNnHPGh3HsIDtgYsZ5cJkHAAxoTxmTvWePs/KI6W6M+vxSoYYBu4tFNQMMz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791037; c=relaxed/simple;
	bh=6Um9fWmpRANzcDanWTXM5Px6iW65NGpoUApUQHiqwLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4Pb2G6BdWf5u7Xxat15dZvuKyNJMA4dpbvwzCa6/tlOuSvquaXiUGbmL792qrUZOL/Foz9pPpmx3e6a5W+tprIz0xBZakbpKCFiDfyDi0ST/eI6I9cbJdZK2xRrRKtx6H5HLwcpXjieIIBn822lyr7++bZepkQ5IhA6UBhaPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmm7b1fW; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so4549443b3a.1
        for <linux-can@vger.kernel.org>; Tue, 26 May 2026 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791035; x=1780395835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNbQUcph4snEoZvl/uFBL2YMK/LB86zIl3Ams7qGRrw=;
        b=nmm7b1fWfqMl9Fk4PRyEPWFIgDTTKS1qk5oo755D9sNyHwf/eUhbMLdzpPQVeYsllo
         SaRuEw6BQ3cbv0Eh9UkYfyWchOW3usC48UTAVtcvCrr7pNTnbCd0J51iO72qjiOnDQG/
         BYzhehD8M3q7nDYy3+CFB5quSIc7uLYRVl3Ps+IUZRZGaq8bEjAtpnVLPlcFDKcEzP5S
         zAqhbjf4YzTpgPJJnj+rihjJV75cQnOVH2VvX33h9BsYvxAnaslSggWBkAmNSloCuk1J
         WcmGFu8rhcThIWbphwApk7f2+key8n4GlyRfWB3e6+L+2rgx6wHbG2wLJtONxyHbcYN1
         1tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791035; x=1780395835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNbQUcph4snEoZvl/uFBL2YMK/LB86zIl3Ams7qGRrw=;
        b=cPWoIIYJKMsrpSEgprdpeJ+VWIemAOks1NoTvATiz2ZtxePi5Ak0M7B9aeABou0VKx
         b0bjV5+gp4h+W8r3SpxAyJKqhNoWB1RVmEshz1HK2JmXuDS6U+nZtjaRlzpBvxiYHnAo
         Pj4oReWCznqFueDfaj0SPoHyjGJ8p41TU4HZEV20UYa5RDYSCP1zaoxfrEd/rmVXyKEq
         ysEPDX9NSy4lSQnOPjdT85GlkGsoH3pvLcThbYY0Dwqdty7ln0s7sBYeVQzRpNscrclR
         wg2fau0kAacKtEfGAzPXooew0GIHrkhjEm86QhS4jbBFvrCVmEMl56d0VvZsfIHXNUK1
         Gcmw==
X-Gm-Message-State: AOJu0YzEKbxa1fVpUfkkjYJ3DCXGDa6VCtCTxtqqQnvf+ECp/Apw7e2R
	rcIYBGm9rMdt0MWDHEtQSBnBf5XB0SOkdqW1l/30ShSrz3sZVSGJLQv2
X-Gm-Gg: Acq92OGpdguRLFoLbDnVC/144jeWEfE9COFb3yBBcgel1yiwpoIu6mxEYZP6MNG9URY
	Xcu3IKnrMJVgX4iuGNIQRu3vUkSw/JHUE8gvs+4mwki/2EH+lxz2QXpoaCDBYfBKHZLf+L0C17A
	mQAaC9f89yVjqPbb5NSighXP2e7euN9piAAR0FnmYyLS8Iky/OkRcCZ9XFHVIQudHJQOOD/JgxX
	Cjy4La/zDW/Ml6G/kQXsqEWms2eg1A7Mvb/RcwW/F4eqL7p4KuLfvmwKGOPBMQ1Y3DApVnhjlXJ
	Gek2lJhqz39IMYM1acpQ8w73ar4tb3quQMVMNX2RwtYXFibsato/G4MVbb6eEBTdYtl1nWebtNQ
	hawfXuemr3dJvh2kLO2R9ce/aJr6Ois+yCkQ6J0WKWDDGndZnJe7Ltiga5cJ2A2QA/Vo1hp/FEC
	G3jtgnoeYoeiyQkpM8id4p/+ZNZIOWO/7TbZePUBrO/arv+azBSE26RlgaYO1G
X-Received: by 2002:a05:6a00:a116:b0:82f:51e8:b38e with SMTP id d2e1a72fcca58-8414b545033mr16491710b3a.24.1779791035355;
        Tue, 26 May 2026 03:23:55 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb3083sm11966089b3a.43.2026.05.26.03.23.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:23:54 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH can] can: bcm: add synchronize_rcu() in bcm_delete_rx_op() to fix UAF
Date: Tue, 26 May 2026 18:23:49 +0800
Message-ID: <20260526102349.94074-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7704-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 48D2E5D42FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bcm_delete_rx_op() calls can_rx_unregister() which does hlist_del_rcu(),
preventing new bcm_rx_handler invocations. However, already-dispatched
handlers continue running under rcu_read_lock() on other CPUs. The
subsequent bcm_remove_op() cancels the hrtimers and schedules deferred
free via call_rcu(), but a concurrent bcm_rx_handler can re-arm
op->thrtimer via hrtimer_start() after the cancel returns. The re-armed
timer fires on freed memory after the grace period.

The RX_NO_AUTOTIMER flag added by commit f1b4e32aca08 ("can: bcm: use
call_rcu() instead of costly synchronize_rcu()") only guards op->timer
(via bcm_rx_starttimer), not op->thrtimer (via bcm_rx_update_and_send).

Add synchronize_rcu() between list_del_rcu() and bcm_remove_op(),
matching the pattern in bcm_release(). This ensures all in-flight
handlers complete before timers are cancelled.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/can/bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..ae083f59a9ef 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -870,6 +870,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  bcm_rx_handler, op);
 
 			list_del_rcu(&op->list);
+			synchronize_rcu();
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
-- 
2.50.1 (Apple Git-155)


