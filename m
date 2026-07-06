Return-Path: <linux-can+bounces-8001-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rd+AKdIAS2o9KwEAu9opvQ
	(envelope-from <linux-can+bounces-8001-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 03:11:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74570BE29
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 03:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=fE8IZaM+;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8001-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8001-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89F43300101D
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059621C16A;
	Mon,  6 Jul 2026 01:11:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824981FBC8C
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 01:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783300303; cv=none; b=qBtByU9QJc7p2syuKXuaUgO8yaTG6UCL9Q/dDlEgZSrJ7bRMh/Nbuv4C6lfaCe5jhuoN8wDRTV5RlozcrZivbYVvV2dz8iga/+RO4DmcyHGPnSTDsGxCkcmO/BA7OVzrGlCuFUuFV1G49koCMwFVq80w/88li4uoCxCpfSoCIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783300303; c=relaxed/simple;
	bh=qTRNoIJbKHT0QHsZMURwgzxLuogblRpKJJhn1hS9blg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byOwv6CAUZevoRp7BExyCxRR3uc6bTsfl3MjdC7CurcMeaNrYeR2Ffu4ood6TX5RpzUHsEMqXNsMRUyjf5zUE4+qbxgrCjYuUoTb6+gazxxPS7+MDavmHQvsd4GTAKtMGUWQ39KBQaEPN0IAUICgeYxiME3UDNIPL56WdEXVXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=fE8IZaM+; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so6676325ad.0
        for <linux-can@vger.kernel.org>; Sun, 05 Jul 2026 18:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783300301; x=1783905101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5o+L6lvGahT9+d8C5f1+uKU+h4JTcYUYEJtTHHZwM/M=;
        b=fE8IZaM+8M5Bx2fDMwO/V/ccdVwmR8doI0mkogUobl2fRX++MAcH2j35A99Ez7AwVC
         vX5pn+fEEzESG/7nHcsZahE3AYIvwa6UjcjkKC5bHLGgTC7f1INWLlUBZ0hOh+O2vm18
         tHWUAsNaaF/Sb1DOJueGwhvl29IMlrT2u7n9EtQmkBOQLEj5Asfj9xFCh7oMDfDwKcAM
         3N+k6ld0oKph8wmJxJfToms8o5M9KgLY39kyBrQ7+GKEzkc1iUeSrL3qGOJN8aScPtNp
         mzQhfCx49Q001QbxEr0GpIrpmkgQeu4mysK1eA95B2Qe4zXlF0t8pdwm4X8NTC28EJ3q
         h3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783300301; x=1783905101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5o+L6lvGahT9+d8C5f1+uKU+h4JTcYUYEJtTHHZwM/M=;
        b=R/W1m1kVJHhHQKXVFUqnq61LsXCVEGYKhYL7LxR67QBEhCFBzMDuzJOO3QnjcBIjKx
         bXHEEEMO21FbNR7MMrtGvYX1TmvfzivcxVV2fA39sEOs1j8ENoaV/30qKgyQi3TLrIdl
         /f29v/5G3R5EOGqR+PH7bK0aKs0D0ihOHkdvGfjl15tfKxkUCXp3ESA23GqRTutRUeGx
         Bekq9yrHXKWo/7UGHvzaX6XqKGkHQAbj4IXGAGTGZp6xzBkLIHNUhKKILZ8/uapakzbl
         KfmrvCCFHQafHgCOHrtvfduAU9/rHpFQDw9DNei9CnBAwGyrQrthZzkbQuuqpY/feHI5
         JDpQ==
X-Gm-Message-State: AOJu0YwbOJxnw3iOOOJ4x3C/ICxmq0/jS79Hgq8gHfhSouECwEvuLh5Z
	scfMvL+X3ri8I2UHEhmw1NriI7lFRjH2tj8NNx3ZV2ULLmh5RTlxxiMGXtMlxxxz+t5xf63JWxw
	tmnY=
X-Gm-Gg: AfdE7cmP/lxuIwCTcGLIo2GAxcRZ2dDZv+LblztKdPDDM3CP470P/H6PgWNk1r3BjEr
	WokRpM3o6THKuIv7eKy1PpsoaWwT7wmGda2P6tBvgr6lgjK/EOn0/TQ9WmTuvVA2GDWs3o0F/mG
	wdtThfFT32f1PekvE29WXnpddwPvZiwmjb9L12KFTLdgFl7dn+tj+DWv72aGemvD/ZgYxg28FtW
	6MPobiJPK9esc5A691LrLU45MppgeWfufPz+KfixR7GIucJCfdTiiKEWG0iq4B7ps9Y4GZao+xT
	TpBvFh7D/CiEmjCHPxZSibK6XXwaAS2a8ECIVUS/3NQUC0Bo5Z3ggfgIM+UGvyJjB+Ex5yUavWn
	smDRwGzpvKoXdshpu8sigYiJfXdlXngoOFGm4IxisQDEr7ono+qkyA2uSKlmy9fTzTv7/t0rf/w
	==
X-Received: by 2002:a17:903:b0c:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2cbb1e32ddamr76354655ad.5.1783300300884;
        Sun, 05 Jul 2026 18:11:40 -0700 (PDT)
Received: from p1.. ([2607:fb91:1524:8834:f5c7:cf11:8d30:76f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71478dfsm40167375ad.37.2026.07.05.18.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 18:11:40 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel@pengutronix.de
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] can: j1939: zero the reassembly buffer to avoid uninitialized slab leak
Date: Sun,  5 Jul 2026 18:11:31 -0700
Message-ID: <20260706011131.2445034-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8001-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pkt.total:url,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B74570BE29

j1939_session_fresh_new() allocates the reassembly buffer with alloc_skb()
and exposes its whole data area via skb_put(skb, size) without zeroing it.

For non-ETP sessions j1939_xtp_rx_rts_session_new() sets pkt.total from an
attacker-controlled byte of the RTS/BAM frame (session->pkt.total =
dat[3]); a mismatch only warns and does not abort. A small pkt.total marks
the message complete after only a few bytes are copied, and
j1939_sk_recvmsg() delivers the full skb->len, leaking the untouched tail
of the buffer as uninitialized slab memory.

Zero the data area with skb_put_zero().

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..2e062f7d277d 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1568,7 +1568,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	}
 
 	/* alloc data area */
-	skb_put(skb, size);
+	skb_put_zero(skb, size);
 	/* skb is recounted in j1939_session_new() */
 	return session;
 }
-- 
2.43.0


