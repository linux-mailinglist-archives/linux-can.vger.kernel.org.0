Return-Path: <linux-can+bounces-1600-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7599394B
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 23:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF9284D0B
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33618C359;
	Mon,  7 Oct 2024 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Iz9zRhD6"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6218E037
	for <linux-can@vger.kernel.org>; Mon,  7 Oct 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336945; cv=none; b=Lb3BGTYp+F8iUEvadqod48b+oEydprtF1vrgQO0aZW2gmBzUj8WD+DaPNTxnESaRIBVaemApMurIij+y9A+EBTh/6NUzIGChtTutJTfeWcolsblKztYZdpOvSpioimM4HYxeCt/wKzdOnZ3kpMbkDLGw1pKYDvykIt8Rgzi0mV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336945; c=relaxed/simple;
	bh=Za6d2/ag0cx5W3bmCrv67Ur4+k+VPgr8uvsyupNoJnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSbhbphDl40s6+5fSGvsN49Nm/LPvm51gzDMHKTK7NPSyox82DVTmLcZmKKh6oj7Vjxj20BGCKqdljzoGC3vFwApF6gPmCm+sYqGeBq8Q7CoUtRyQ07lLo7sbGw+c+Fu9wtd50Cd0h4UV8aml1iU+P6zXRI6DMh/V4R318Noyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Iz9zRhD6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso3240052f8f.1
        for <linux-can@vger.kernel.org>; Mon, 07 Oct 2024 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336942; x=1728941742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=Iz9zRhD6wRn/Ctlf5ev018am/0nLW5at2MOCHuyXmr9uE/SP8mt91WzpI+bJTy3//g
         qeaWtbKMspHNaRemf3MWYiJ3S4Ap6lieJC+WscCoyAtzSfXgr4MOnF18UIzs0v2ChBMY
         QdnhiluDaWedij+0IxHt0FA7VH4rabbN9hVAbTzSyjam3GmzLUtzj6J9yhB+tyuC6AGJ
         mW/pyl8g+Gi8ATYHoacuOD4Ji1f4axXRvN+O3CfItkX/vobcRdEiuz5+jgshw6vyfTX7
         dSrln/uuccSJSaiILA/Hh0Hb+jsWlPNbIn0ayI4d72IqcCeXZfYWnFJtYmAlSJ8MnRq0
         6zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336942; x=1728941742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=t58dJzAWdveNw/kLTXNWF78c+Z2hdRzvM2L7HBZ+zOIWi33JoyVZDqsx9AJ/xYt5FD
         WErgJZ51gwJ8cQhbuw9n2USFYNbc1rp5fXPijqrA+lOLxr4aCCvKq2K43GEvUaW+Tqx1
         LP4vIB9L4pOm0ureeVHCbCx9/n1kVBIfgQJE4u0iaJ4c8TJFBkPJnlX/5TrDvMlyYiOx
         SQS+aJpHrVGEusKWojrgRmgBQRjg2ua2h8N1X+LzAglosNso6r8QkA5ozKXO7uecfESZ
         /kjWtUUOMS8kltxMgygaZ0bT0BCt9scEH30g38qr0dvH/y040EQ0EL2c1pf0atUin4sa
         y//g==
X-Forwarded-Encrypted: i=1; AJvYcCVqEgjbq6zgiLab2Z38eeQdDQMcx3t8QEaSNPzcttjGnrMomC14ZOpiwRIaELNqpkH4DdMc1Q7q8kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yGVzUg+GubQh8f2KcEfHNi59Ji5EY9PAHcYx+9aNSlnKBdwZ
	MS1qUIxuvgUHjgtGjD5jxyIP364UffqHI5ps/R5s1kAHqIPK/El2gcunDURCTGc=
X-Google-Smtp-Source: AGHT+IHAyQYt8epuqdqQ1WiemxSSnJdRW7ySGcsdfEr9r4QwNV8qbe0cvU/RBNztpAk9AJdBnDqlqA==
X-Received: by 2002:a5d:6052:0:b0:37c:c9ae:23fb with SMTP id ffacd0b85a97d-37d0e7d43fbmr7244020f8f.40.1728336942347;
        Mon, 07 Oct 2024 14:35:42 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:40 -0700 (PDT)
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
Subject: [PATCH v2 3/8] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Mon,  7 Oct 2024 22:34:57 +0100
Message-Id: <20241007213502.28183-4-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
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


