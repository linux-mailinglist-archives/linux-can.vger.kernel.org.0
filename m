Return-Path: <linux-can+bounces-2288-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2AE9DF239
	for <lists+linux-can@lfdr.de>; Sat, 30 Nov 2024 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF312B21474
	for <lists+linux-can@lfdr.de>; Sat, 30 Nov 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752561FCE;
	Sat, 30 Nov 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XAmHFP0a";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hel+19SJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE01DFF7
	for <linux-can@vger.kernel.org>; Sat, 30 Nov 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732987319; cv=pass; b=YKmOHezo7o6dW2LiSwaVlLTjFGvpwrdyGhqry2SwPffynI16jcFkvJbMjAtkSCQNU0lYJNWmqU1uN1/6iYvzC24dyJiL80Rk0FlLN8jQHLwh7u4fp8XecBWAaxHnpYnsYxE+l/bb4zf4eBHSmI0YMWkEEXLfn/cmAandCUS5mno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732987319; c=relaxed/simple;
	bh=72c9LDImSDdMhTx3g/khfI8vlQk75a3/O4Pfxmliebs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LnpRrOt5VAFhyO/xjEy/GdaaXA6ine1b41+e1sVXOi0/RqbRkeMImF4t4rtv6mn5Hgit8jndIydZcfhXFBLY3vLjTpRta9BnkvzX46CqMWHG0pI/SzYNt3elfyESt2vhOg8Eh5mCbQrR+BiHKD1lRml1wXsvI6PNZPS+QISU9jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XAmHFP0a; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hel+19SJ; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1732986591; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HDAvuDnARE6HHmjjfTHVb++YP7VAOusIdsHw4AKTa7lG1IDo00dAkmaK7HkDX6gfH9
    y0WWF00vFHj+Zds87oiqW3GVnLiGFdP0xEbE/iOmNmeaf1jHXppA43Wz0ub9yGxuOXV8
    DAmHZnrM1He4LUOGX7kQF2B7xxKRk9CfT5GlvYuE3eN6gfOV/peJVocp06uyQukFJw6P
    tzWiIuFZSOJXPX/q/d44lnOxF/jLA+hx4Kldsn2oJyxZy3MK14yit+vNEvFwXtblPVX0
    ZTFMUG4sNK/SESZm6js8KdA61i4r9rrtxdN6VdbbxB4NODp1EFEdDkrnNoOgjzd8hwvx
    DORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1732986591;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=YVGL0aUWbxIm7l8IKAroy3wA8xKDGqeTexeP45jQAd8=;
    b=ZVGGKqSuqY2GeVtXEevyLt92WYeUDXQUBSQXbNsXb2l6/wpyO3UMAFg+n3SKJ8rVze
    MSUynWGE0Z8w7sApKeN10VbHR4jyv0WeA55AOiJTGOzkxg2ISLGY3ODf43RWBARPxZjB
    UghJkCekUSsEF81chW8TK83qaWdiXE1cXf535WuLcFVkflLlFyDQfP6LIiczM4EYry2p
    ItmgEtrPCHjBRd13MR++aDPneQmwNZDChNf4tgsjA/FyfDRG7CjFLhlveUEcc9+TZnUY
    wzwlBsDgzXkC473fxriG8bRo8K//9HYbEN9tfYimc8azUk2IQgc23/9cykgHQryZUgdF
    U4yQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1732986591;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=YVGL0aUWbxIm7l8IKAroy3wA8xKDGqeTexeP45jQAd8=;
    b=XAmHFP0akxBUtcLbHW18E711ld3rOH7jShReJnqpphf1cIpKOm/eI9Ua8z5L2vdA05
    yiZrjTU8J2xpJpNSR4pm6m1pOZqlgQCdKaJfxN6fkq94YRHweEXVBrczs/ZFw1jhkMn7
    flGR4eWWQbvDjU5EBzZpNFz/JbkwZ+/FUuBw6Aan71j9C+n2SgEQHzK/qAoykyfpfTzS
    KB8qZpAsZ2u3QfVWcv0QjwmTrsB8eVNDUokNMb0wwCbtVO42pNJPI1u+EP1PAH4Xo5ze
    JqRaNSHHl+ckYqSR2rV/IpOzNuzxOdAvm4MmZUpW+iBqLlhkZPHB2jT+xL6HCWVwRph6
    a0SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1732986591;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=YVGL0aUWbxIm7l8IKAroy3wA8xKDGqeTexeP45jQAd8=;
    b=hel+19SJ73xhTnzyU9+QtUlbpuCKyPWNOrDfmSXwutLhxx45unCRUGEGMjMulH1HBb
    TJv+zgy9srENEIlI2xBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0AUH9pfOQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 30 Nov 2024 18:09:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] mailmap: add an entry for Oliver Hartkopp
Date: Sat, 30 Nov 2024 18:08:34 +0100
Message-ID: <20241130170911.2828-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Map my retired company address and an accidentally used personal
mail address within mailmap.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5ff0e5d681e7..37ecf2632be3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -527,10 +527,12 @@ Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <o.rempel@pengutronix.de>
 Oleksij Rempel <o.rempel@pengutronix.de> <ore@pengutronix.de>
+Oliver Hartkopp <socketcan@hartkopp.net> <oliver.hartkopp@volkswagen.de>
+Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
 Oliver Upton <oliver.upton@linux.dev> <oupton@google.com>
 Ondřej Jirman <megi@xff.cz> <megous@megous.com>
 Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
 Pali Rohár <pali@kernel.org> <pali.rohar@gmail.com>
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
-- 
2.45.2


