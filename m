Return-Path: <linux-can+bounces-1666-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644699D39E
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D871C2875DB
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE01BE23E;
	Mon, 14 Oct 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MdISMh2T"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768131C304F
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920316; cv=none; b=YknaiX0TpQbmtrXuInPEHFhrfmBjgnkIdzSPBwoHnSxcw00YqPIPKBd+e1AvorMIHlNzDvwClqIUCUeFS7PH2frelzNOmQ/6d+H9bonpN/ltYnZxvmvbHRKS0dYGhgApIs5QbcpLRFKqN8wCILc9/GSdrwjlefwzOi6b2jYEK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920316; c=relaxed/simple;
	bh=XZyeSxYL0Rt6XzD7DrYNwyUkhIbWdcwwkzg4XCE56kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHxFhBtCFlzzaO1nP9p6RHzcvA4u29DY32chxgo0FyPyLxA5gtpCzJ0F/qZAzcdlTZLpxjwGvtmk9kXECkGt3vmr8G5SVnxEfDODqK6bY3u1l4YnnPD3mfxRBbM76JP4bIdgFtrT1dD3ii3tVZCR2Gaf+TRPCZVEhijI+7Zaolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MdISMh2T; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d3ecad390so3494949f8f.1
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920312; x=1729525112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbHwWEpfmVr6vDfNAIj04FaBgRdnLx3F1Vt3RjTwrtE=;
        b=MdISMh2TxSBfUoqF8lTK+6J6uQKXbIMCfJrZTk/6CZNGiMzcPt68ImPAUhDH1m1dsz
         YJt23V5EHT/3HQhGRkewF6ynT3sir8fRvYKPU7kHtDC7q3OixowsoNhWb9pr6RCUlAfy
         ugZw/0YAW4yk2J9nc5U91yhNcRty7slQaA1wNFo9x374UmFLU7WFxsQmOYUoMH/654Br
         qdLOyIjIyUFEoQbmjsivrBkTGwSRSEeA2j5+FxjuGVJ/ufP4iIHrZZOyW846EWEnklg5
         s8VTZaN7tu9iW2Rz2rC+fz/1in2k3sDZhLeAlrvIDgtEBfmH+vhn0o/K+iyniUo3b95p
         v3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920312; x=1729525112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbHwWEpfmVr6vDfNAIj04FaBgRdnLx3F1Vt3RjTwrtE=;
        b=tRJ8I+/TxMZr9SPC3TclMgTLrP85xuN0DZo1ESPAfyPS4p6phDSChzAf3acGEDQfhL
         zuVw6iQ5QKBeOaMTsuu9G9ARRHi3SaSNDzJKYjyijtH0P2wcPZ7+hcX0XvVYIsy3OMNH
         4RVbEm62WqCDf7mASfKJbng2RvrJaiSzFiKlAu8T0+mEAvB53/R/tCVR04uAb3A5KYCa
         pHmaYnwfmZwSX4Y00bd2o7Z7ABWxD0I+263H+/8RefrVk/QFM0bQJgcSraHOCkUKHKik
         wAeLwraANUyLQMaDjq8fth2VmLMnpGNX1o4CEb2KOTFtDVpHd2GAYdnu4Gu4xoozBdjV
         DK1w==
X-Forwarded-Encrypted: i=1; AJvYcCVKhmLSEuVTkdVWAlvXfwKpekfF/pyNKF0lIEZAeXdIoLMWMMhJBTqoHp8fVG97zck5ZwqZah2kEXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWKcBwDuwX001HATJP/CohfBPWtv8/RIW4TeY0y79BPfmaDuR
	wXL9AF7TkQ4MXOs3ZbSgsXD10KH75J9SwLtg50+/tYRC08cHw8jPhnnh+HGtMTs=
X-Google-Smtp-Source: AGHT+IFpRrcvyLwLdEFLQDdJiBx0O5p4UCoiCY7EDrHsmjdj7yCbqKDU3xbbCNWtcTob1sB2WmybtA==
X-Received: by 2002:a5d:504e:0:b0:37c:ce3c:e15d with SMTP id ffacd0b85a97d-37d551d9cb7mr8770131f8f.14.1728920311872;
        Mon, 14 Oct 2024 08:38:31 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Mon, 14 Oct 2024 16:38:04 +0100
Message-Id: <20241014153808.51894-6-ignat@cloudflare.com>
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

sock_init_data() attaches the allocated sk object to the provided sock
object. If ieee802154_create() fails later, the allocated sk object is
freed, but the dangling pointer remains in the provided sock object, which
may allow use-after-free.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 990a83455dcf..18d267921bb5 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1043,19 +1043,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
 	if (sk->sk_prot->hash) {
 		rc = sk->sk_prot->hash(sk);
-		if (rc) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (rc)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		rc = sk->sk_prot->init(sk);
 		if (rc)
-			sk_common_release(sk);
+			goto out_sk_release;
 	}
 out:
 	return rc;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static const struct net_proto_family ieee802154_family_ops = {
-- 
2.39.5


