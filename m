Return-Path: <linux-can+bounces-1661-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45CF99D385
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBD21C22C26
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADF1ABEB8;
	Mon, 14 Oct 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JJP39igI"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16B1BC58
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920305; cv=none; b=CU5nf0BLWZB1AzMx3Dh2n7a7UZgpn04dsGs5H27W2Cov6NxV7V98LLAXG2rDf4sj6rZMc8Gmsb3y9ZEF/G2lWDWUPQKz7llbqLcW7uvMXs8Twtho9PnNPWNiudmUPdeOwSg8GGQdE/xHnqu4ircD5z+ONkEy4uNbVCAQQx3Z/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920305; c=relaxed/simple;
	bh=wnFLfn5BeeZ3wPCN20V30mk4CTpYaz6K85DjdS+HiHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qXu5yBnznBgdJks7Tonh0yeJO8exltss6qFu2BwGo/xafMzYRcNAMTcTxvz+8GiNuJMMgpZMxCPil1cYE4E79ELagjtMsIGfz9gTUVIyAamb9cY1PK1TU8aRXTEvzuSn66ouW8T9iLjadliMc+eevkelnEWkjj8W+Vnaa8h4fLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JJP39igI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d325beee2so2682769f8f.2
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920301; x=1729525101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHzMyBjSo/EDcGPVYKinoicVUAUc6s3aklub75jR0Lw=;
        b=JJP39igIjYtLhphYpdRanLZToLY8t29Od5fQ3cNLQlpEtOkd70DfFC9y2+RTae+bf/
         aGVv38VnD8A/SqcDsvUB/2BaO4erZMEjqzUJTY2KpYzbHuFneqWqkJuemj8nwmZcywRg
         UOCD+2/xcVoVam8A3vbALfUroDSUzcsxEmmai47j0QhHr71NgDnMoD2ExQH60Lp5zOcg
         Jl0E66/VWFg7fO78E5BF3Gk8VErtbtmOjWj29ARCWialCcNVlkzSobpBUPeQ4T1wCgy2
         UXPw5QLbPyTIQ6JRQZcW5gG9Sj8QYq4k9NSULBc8Z8XBshDd3nEv4B+g3If1kjidm9o9
         uakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920301; x=1729525101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHzMyBjSo/EDcGPVYKinoicVUAUc6s3aklub75jR0Lw=;
        b=fqkrPmiqpf2YrjntzuGmrqSp+gYR6JDH9ao4F3Tgru/kmm7CTim5N8LZuH/4VdLyfI
         08hr5JRyskyeOnV19Mj8uHtnWJk2yslk7HBCaqyn4YEaemj9hCp18l8HDIcd9ly9QeDv
         kYs4usf+Na3witnW6URPs62NaRWRDIqkNGnQsgP5QOwaAevubiJCzqVkqUJVq/xPaEXu
         B5q7ZVCDM1hPy9vLOorYPKM0PUM19Tj/EVflViMWbOkoPWGFQYX5SeZZVlui1ZrRGeyd
         F2SV58fGdEtOan7eabRhJmj1b7KrLTflX1OlGRgS4rCucGQqgeDU3XLcTJ4Ns1/+cv7m
         6yYA==
X-Forwarded-Encrypted: i=1; AJvYcCUbVwQXzmGHoxYZFqsu5QxnZ7o7hRfoztvd8efF/zvGixjmbCeDbYaUzFGB0FhX4MIpGSmiqzim0Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhljUaoNKWr+UCyS4kHknLIx7ZCOlZ5VBuSX8haWodlWXJ4IXY
	HEZwu5kN5rdk2C0UGlXHTk0/vQrSz6+QtfnB7q0z5iR757xo2hRjVHnviKcZo6s=
X-Google-Smtp-Source: AGHT+IFTv9Ec0x1pgYaAzfXLeF4AIIb/MZM5qOa/pOg2VUZq5MjMIBM3l7s9Bf7wq9KEq9mdpqLhRg==
X-Received: by 2002:adf:f686:0:b0:37d:5232:a963 with SMTP id ffacd0b85a97d-37d5fef48abmr5709371f8f.14.1728920300822;
        Mon, 14 Oct 2024 08:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/9] do not leave dangling sk pointers in pf->create functions
Date: Mon, 14 Oct 2024 16:37:59 +0100
Message-Id: <20241014153808.51894-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some protocol family create() implementations have an error path after
allocating the sk object and calling sock_init_data(). sock_init_data()
attaches the allocated sk object to the sock object, provided by the
caller.

If the create() implementation errors out after calling sock_init_data(),
it releases the allocated sk object, but the caller ends up having a
dangling sk pointer in its sock object on return. Subsequent manipulations
on this sock object may try to access the sk pointer, because it is not
NULL thus creating a use-after-free scenario.

We have implemented a stable hotfix in commit 631083143315
("net: explicitly clear the sk pointer, when pf->create fails"), but this
series aims to fix it properly by going through each of the pf->create()
implementations and making sure they all don't return a sock object with
a dangling pointer on error.

Changes in V3:
  * retargeted the series to net-next
  * dropped the hotfix patch, which was merged into net already
  * replaced the hotfix code with DEBUG_NET_WARN_ON_ONCE() to catch future
    violations

Changes in V2:
  * reverted the change introduced in 6cd4a78d962b ("net: do not leave a
    dangling sk pointer, when socket creation fails")
  * added optional commits to all pf->create implementaions to clear the
    sk pointer on error after sock_init_data()

Ignat Korchagin (9):
  af_packet: avoid erroring out after sock_init_data() in
    packet_create()
  Bluetooth: L2CAP: do not leave dangling sk pointer on error in
    l2cap_sock_create()
  Bluetooth: RFCOMM: avoid leaving dangling sk pointer in
    rfcomm_sock_alloc()
  net: af_can: do not leave a dangling sk pointer in can_create()
  net: ieee802154: do not leave a dangling sk pointer in
    ieee802154_create()
  net: inet: do not leave a dangling sk pointer in inet_create()
  net: inet6: do not leave a dangling sk pointer in inet6_create()
  net: warn, if pf->create does not clear sock->sk on error
  Revert "net: do not leave a dangling sk pointer, when socket creation
    fails"

 net/bluetooth/l2cap_sock.c  |  1 +
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 net/can/af_can.c            |  1 +
 net/core/sock.c             |  3 ---
 net/ieee802154/socket.c     | 12 +++++++-----
 net/ipv4/af_inet.c          | 22 ++++++++++------------
 net/ipv6/af_inet6.c         | 22 ++++++++++------------
 net/packet/af_packet.c      | 12 ++++++------
 net/socket.c                |  4 ++--
 9 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.39.5


