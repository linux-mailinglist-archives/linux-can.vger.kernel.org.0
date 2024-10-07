Return-Path: <linux-can+bounces-1602-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99A993954
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 23:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BE82830F4
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 21:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13B18BC3A;
	Mon,  7 Oct 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="V0dg1jn+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61D192D92
	for <linux-can@vger.kernel.org>; Mon,  7 Oct 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336950; cv=none; b=m0KjMI2TjXO8px17FABrcqj4Ova955hHQaeh2Xs/Z8R+IqXwbTdXsDTyY6UCEZ5is2RLL5y5853NrmUvqqKAnstJcbsDwmodes7/eH2o1m7eadPQ2LcZ+sivTVQdjG753r63vSOZfPb9VYgseu4qENLiQLHl9muCjV6gDKf4fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336950; c=relaxed/simple;
	bh=q1wcm6mMQ7h4EZDUMr6oUmN6x8BUBq/PxsPoaXApW48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+VY5Ex/3xzJT2pVR42ivM6Yl0QOEP1mlVtpUBiJZL3axIGQjLdoQ7225E5c0pjlv8ArZs2sKnCbm4w63JfnZf+sPXztzMYxWVUdRPCGlYJNAZ3qNLH16MbAs3zISaoU7bkIeCqcaNYLMKJW1fy07rwBxkpz40/vsc95nYQWklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=V0dg1jn+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso66347845e9.1
        for <linux-can@vger.kernel.org>; Mon, 07 Oct 2024 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336947; x=1728941747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=V0dg1jn+hKCA6cx8/K7ivEzNGRNPOTwmbBp4libmwBR4w7QfFZykVVJwiFI0B3Dtwe
         9pA4ppJZyurmox+9o8VN8W7IzdR1aoh9HUSAPzLNcG+snCsWpcj00jhS6ryv698rcoOC
         gZnbN+0t1Gk00/rP4ePsOtZPj2joB/04jCR3LYs8lQ3QPIop/aTB9tPjfZg07Egp+QVz
         l3U2ccKHLawsRuLPajBOanV5BSAm27X6cxI7T1uTuP0zp2l+01eZEiJOCkiBnjlmk4uO
         ePOX9e3xqgda9uJXVc4DErdEKDqBNAen9xV8cMjKsx0k4wWdXaW6nMIvIezShB0ilT4V
         ngXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336947; x=1728941747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=Ps5+XA/OpOlSJjccNeyuDVKI09r7q+F+kfHugID3EsGcAUHfvfQ1YRqxJdtPTRs+s+
         Vu7AWTzj9wO31AQkVQ/ol8YDXmnMHpL3riFuGTg6epRE+vD1QWC+9E5jCphDi1K0JMvz
         bWXkEgS1hmf9VerptDJXBI3Ut6mepWLwlG0a6RQfgE4/focirRn0GdqHzhdtOtdxy0+w
         g/OIC5SPTsFg2PWMP2GkHbZTiU5y+ZWTPFVwGiG80N3+3GilmnfJevgDa/FwEc9l+ANr
         H4OU0tipVHzcjsZMCNsq/kjI9kgcxVd5+hyA7lUZLobNw+nvTt8zw3HP71Jo1SJmVYfj
         WQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXvSBBWccrXRYYc8lX5z3b/6EWQ10zek/tT4deLCIm7eE4PJVXXNtp1qvBdKYL32mfEaH0RsmhxUJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1iqdfddQ8Z8I9tr+lhFXX9y+ojIl+m1GTXsIUpxdu7qf3LZ8
	Z0Cd5jgYhZmctAk6wfwL3adyaHv9v+jd0bZuM0hFmPvWhN37I5VaDAMvbCaMwJk=
X-Google-Smtp-Source: AGHT+IGIEgvlVQ63MN8px9sXGIB6rH0PaHc0x2aiS2t9bCm+0YE6s5XpgSiahpjGOCaDNGfNsSEswQ==
X-Received: by 2002:a05:600c:5494:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-42f85aef6e2mr143742535e9.29.1728336946921;
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
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
Subject: [PATCH v2 5/8] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Mon,  7 Oct 2024 22:34:59 +0100
Message-Id: <20241007213502.28183-6-ignat@cloudflare.com>
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

On error can_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object. This will leave a
dangling sk pointer in the sock object and may cause use-after-free later.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 707576eeeb58..01f3fbb3b67d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.39.5


