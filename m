Return-Path: <linux-can+bounces-1669-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C299D3A9
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8321F243EA
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875C1CC173;
	Mon, 14 Oct 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gHmxVmqE"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D61CACE8
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920321; cv=none; b=I6XIit5kwyft8FWmpOX5OpDAK+LvVce5uIMNFHiHMIXdbbGWESfV//oqNzAzG9RbQpTt42C258G8M+19rGZwKyNcDOWVOoeWeP/OGWSSCOEdbz11WpOQopWuEos/yQIb5ZppNjNoe2iUU4t54lY9oK8QGsHk1xfTakYkqgqccvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920321; c=relaxed/simple;
	bh=tpRnxtvyDHesMuGsYGGagBR2XeIwxtaApq6sfrvnYrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGN0R08nHI4IxfGRHODXI9Rl3pm+ZDcZBPXOpABGpWoQA1cxOMVY0n8bUe6YA9WDQP0H/waEjr4kayx4Gx1lg0WFrwsh7CCA4u4TivCRSZPQFadFc/xsDU8ID7roI9h32fNThGvqiOL5B9ZQudOPMLrQmHGEPOpc0GlUuHZl5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gHmxVmqE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2737383f8f.3
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920318; x=1729525118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRdyGf4lfZr6TznDuyWqYCBTl3G4Nizl8+blfyYvkoE=;
        b=gHmxVmqEAq2H3WSZdMhuCmkb7TtWIvdeoxB74oty9UCExauTw/LyGcw1zxvAxXy+dl
         atl6R+YmvG/iOTONZWptqoYAvtsk18MOlOEoxma5Wm9/yUeJwdWl2m7eHekbakfFlNsp
         3WRnxaf09V5yQcY4IoY6C+Cn9sYW+fDiuUm5RphdLf0PVLs2lzP1O8RgC/9rKGMfn7MT
         V6zcXMCuSi4hB+mipouR6I9AqQY03la+55wgk4ESopEG5IFPB6HGn4BzXSeHR5OS1/ef
         25NRI8f0N7QtIu4fS/wpbbzKeoqkr8TXRr5iXDmJam0flodQyZ9ydnUGbxvSGqVh0tS8
         iGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920318; x=1729525118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRdyGf4lfZr6TznDuyWqYCBTl3G4Nizl8+blfyYvkoE=;
        b=pDVhDz4lNlt40pfXwcexvC19YriUx/YsFh0N/xffd1QrTfZW7Zay/ICgSEU+9WQpJ0
         JYAIDTDCLfcYqAhFe5vvQcps37ApqfHw8nNXOVJvjRdomxofT+RCq31YdhLn8TKVFUB6
         02hkoA7IXVJkAxzDX2NhGv6Dif74BzjWnj4d7J2IJQL+RFsm5KRjZt765f2yhIqWb89D
         +c+zrrw/sPY6DsYuReYPYGt52HDgWbCT9ThBqfhviJs1ukW1Bb+2fWKiATP3p/gOwpAB
         mlUG/wrSpVjZHQFxMRcyxPE3PHxHihccCyEG/DE8/b/45JC6TSyeLLOZ2QGUqJ3J369G
         +PeA==
X-Forwarded-Encrypted: i=1; AJvYcCU9zDI6gE9TLYW7z55blJvWuNrqwSqmUwoVqQRQ/olfc5jRwjeasMx65N3+eX/qFE43kX8O/R+jCJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vHYSPtzh7TUeKLJ1g9xb+Iuq2e0HgUl12d7D+8JvDgq9MxBh
	Pnb4DpH3stibH6jIMu0yoFT+bA28qZEkKsyEQZD3MXRSd+rJ4sMoM747sZzHv/8=
X-Google-Smtp-Source: AGHT+IEvSESGNKtr3mfQllscjnvWPixVZXXYDJK2VErqCT7tUm2cqjBB5hZh+pW+OcOgTVIOFBIPag==
X-Received: by 2002:adf:e908:0:b0:37d:3def:2a82 with SMTP id ffacd0b85a97d-37d5529acb1mr9092817f8f.36.1728920318048;
        Mon, 14 Oct 2024 08:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 8/9] net: warn, if pf->create does not clear sock->sk on error
Date: Mon, 14 Oct 2024 16:38:07 +0100
Message-Id: <20241014153808.51894-9-ignat@cloudflare.com>
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

All pf->create implementations have been fixed now to clear sock->sk on
error, when they deallocate the allocated sk object.

Put a warning in place to make sure we don't break this promise in the
future.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 24b404299015..9a8e4452b9b2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1576,9 +1576,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	err = pf->create(net, sock, protocol, kern);
 	if (err < 0) {
 		/* ->create should release the allocated sock->sk object on error
-		 * but it may leave the dangling pointer
+		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		sock->sk = NULL;
+		DEBUG_NET_WARN_ON_ONCE(sock->sk);
 		goto out_module_put;
 	}
 
-- 
2.39.5


