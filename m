Return-Path: <linux-can+bounces-1663-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D997799D38C
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8681C2334B
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3711B4F17;
	Mon, 14 Oct 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ADSl8+Xy"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BA1AC887
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920309; cv=none; b=cyZnp4fAt9J21tG0B/h7ohMFIIzyUm5YIG2CcmyxbJ46bBiWAGv0m2uCRCNE0uiGFKtVyhRb3gD+UISbTyFCNmBrIMvJzyjZX8AKlqZWgEdURpLdT3x+iQLh33s7KmNMR48S4h5bRrA2ddSYHXMKfcnNxEUDSJjaxexYdY6dsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920309; c=relaxed/simple;
	bh=Za6d2/ag0cx5W3bmCrv67Ur4+k+VPgr8uvsyupNoJnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=si1b5y2Vp+n41lAiq/fvNXqVR8lnP2zeOqvoenbQHjiAF6WWhndWWt7gzJb2aXfgZod0+nlr9+nDSLBUiBH2r8w9PHE/Zvmi4fcpJtV8tx9VdUpxgLXJZ603brANLLwC+jzM6DfohzpDIHl6Lhk5kFVsosY8ch16zVFLheW91GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ADSl8+Xy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2737221f8f.3
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920305; x=1729525105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=ADSl8+XydpCyUMT7zL3I7Xvi1Ix5wGUH5Qfk/p+HOYeLzB30nwmpsZnljcSmMl7gL1
         f5gBFjsvjemCwOTBAn3BFfZok4/J5eKhgkR0d6LFhagydEQ9CXJVOiZeSuHbZh8IZ6Pl
         4h+6QorPYZhw6NlENAoq5NXcVoV8SDgtaQFj+jV982TyCAhFCVV6luDMEjtEs7rHKnMg
         /CmjdtmnHerbQskx0gIUQFY4YluRL9dyg1C8jsGY57vCFoUF/RbPAP4xLWAJvi0UxtMy
         XhHNJZf0yIKgG9BlSHM8EIcMrPHPEc/6RFaVJdP9/HnrpApP7NF7p0Nwpp5905fxo0n0
         jBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920305; x=1729525105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=EF7FrDImLfyb1eNyFsgEv1jyAZWLOmlrsdZj08N7UzQv+WAGhNH1ITTQ70mgOvQYhX
         qk6k8kqUWyPOZ2scdimZwYAfQskK5p8YsRTA5KJ26Bjvpk+DQ3U1msw5dGDYlRLuiCfe
         E2qdmwtz5XkOMm9GEko/z85Hv7ofiiuuAs9T+Z0kiYcTwMwXZ7/suDHNUGqw27Ey/N3V
         8tnj1ynANF/tBTizWOEA1qUCGglXIlut6v9syq1DgXWLE1sZlj/YrY4gF8OFtMlBlpAT
         TJacTLx4YrU5YpTzUnHX90s7zLfrC0aNkW0hU9wHxwOyisnHdykPr+Or0DkF+92hzd7A
         8rXg==
X-Forwarded-Encrypted: i=1; AJvYcCXeq+mGNCQ6lGb/hUbRhllIZ0g7HICkerUbyJ8ONlh43w7G85KNKUecRnTJ2avWiZXHtNlm1iqnW6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVP8HnUYAor64i3xHSGTeAb8+g+96IK8jKUPHcuDxiU8wg1hwY
	TZS/Op1QWsFdIY/SthkMunwBnu4xQEHdfZ+/xjIPK4b6/8cWxaX4luYmLGNZ758=
X-Google-Smtp-Source: AGHT+IGI3bnawMCR2rBPHOoSypef3VQX2phi9r/huSmV/cqlV/2kFbNe9+Hj1byHQxm9DpEINFWl2w==
X-Received: by 2002:a5d:5c88:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37d61afacedmr5574208f8f.49.1728920305128;
        Mon, 14 Oct 2024 08:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:24 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net-next v3 2/9] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Mon, 14 Oct 2024 16:38:01 +0100
Message-Id: <20241014153808.51894-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sock_alloc() allocates the sk object and attaches it to the provided
sock object. On error l2cap_sock_alloc() frees the sk object, but the
dangling pointer is still attached to the sock object, which may create
use-after-free in other code.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba437c6f6ee5..18e89e764f3b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1886,6 +1886,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.39.5


