Return-Path: <linux-can+bounces-3702-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E8AC5B11
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEEF4A57BA
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF02D20296E;
	Tue, 27 May 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XDZ0LZ/F";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/i7vRlK1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899020296A
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375813; cv=pass; b=jNFP1Zp6WXlU8aaaEXsCascHnK8YByNJBRStliRlGRe1bKPCGS2FLplDWAMa6CdysvpW+qKQcpEmRkWjOmrl2cyLrJrn2Y5OD/34jwpJxfGZAFJrSU8b7W3/Ec72OWRnQDV8EzIZbTYUX8r1gc00E2CGo8pOVZ4xhvXBt2YeuVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375813; c=relaxed/simple;
	bh=Kj5IMkwA9jB370iPEeEr1zAPbDJUXzg9+aJKTzLk/cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ks67VxsxXDRDMDTGC8QVAN6S92p+zg5RsKq0q9NQGlI38X4bSxGLQeeBuX9Xmdweg6Zqnn5QD4vHcwWOKXopVhQ3NYWcmB7nxGkhAvhJRTVdGPqWOiMbUqLCfFQ18baIsYy0sdlJskAxWlF7PUQNyaTyVbZ8mbz6Z/79ojgGvS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XDZ0LZ/F; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/i7vRlK1; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375801; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TPRLnGeWJ78x72o+UwegI1TZ7qQRj9+N172dWbQVi55xlix+oosNnbr+bUa4cWgJwU
    01vwhH+GAVlielU986RlHbLoJSM8Uf+CuDdI6y9F9fMfHWOtfL5vAkEGPQlJPUa2+Bpi
    GiZWKeTrsXTAN/aUot74hG0aZ5dYE6lAlPq9S1H7YfPfB5kOMprHGBxt6dTLt/wtpbAW
    b1GvN9TfmslJcNf6dW74nuDmzQLLiwmCxwY6ovDbiPa7U7BYw7C0Vm9VzA2US7sgB+Ss
    GatI8H8elqKJbDq7SvERCJ/uhb82/mfcskBNtH4Z6yX+phndTy+UpqGwKnVy3lRVHsd5
    OWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AKq/o1GM8Vq0yS5eZhlAWevbO7qEAV29xb4aXdkuIPk=;
    b=AfcFdWoi9x7zrjmAZ/Qp7J2KplwWAe2IgTN5kkGRmAo7ihW7sCOO96/h4atdgm18Wt
    a2oAEdmXnWxj2u07ZMP84iS6YIhGOYEnUcQHxjuNFMFKUc5gRQh0WnJmASTyFbtnjvpI
    6ZuAH1vZHBSCq6f92EnSzc7+W8GNZAQwVXoYp4/MvVB9BBJxbc0nRmEb+vpyijQuGRr8
    ASKofefKG5UMekdsCXvg/n022ACfmT/GvnafIiOlmBwfFwlqW4TqaeJOKA3WqKitH/JN
    XTmeic2PPqqUgL6HDUkAF3NPEa2allI5O82+7pY8pS4S286WgCEhgpNYx4UjZ+3hGNav
    b4nQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AKq/o1GM8Vq0yS5eZhlAWevbO7qEAV29xb4aXdkuIPk=;
    b=XDZ0LZ/FWUFzwfA/21v1CqvO7KRXiY12lGlSlroYPYXPRXovbcPjzBibrScnkYSxoy
    0VPJs4Jkjf/biAMC3F5VME5Rad2gCyUzi7NZIE4i1WQ4EPW6AEz+i3DZgfs6j+1nJ3GA
    W6wBVZJMSrRVYRCAGf291tIzHdhzZrcMyHooxPM5NaAc60isULLRYy0eHBL+ZFFKcqhb
    JnUgcB2vipKaXtJH3akt5kTxJZiGQBCROh6jKcIl3R9cSpGutgtIbLhqxF8qk3Au/bOA
    q9CYNYQ5fTmVrU4P46M5aX0TSDMcAS6fYPz0hvllFhXr6SG6hF/uh7ly6EIf1oHMK5jF
    fhsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AKq/o1GM8Vq0yS5eZhlAWevbO7qEAV29xb4aXdkuIPk=;
    b=/i7vRlK16c+8CBkiHNyOR2BMdPduqnEymz+Ut/iZmadAoP8Lhu4s6kpF0PhtN2CFWW
    QOJPn3mtwPHNPryujwBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJufiW4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:41 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 02/11] can: netlink: replace tabulation by space in assignment
Date: Tue, 27 May 2025 21:56:16 +0200
Message-ID: <20250527195625.65252-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

commit cfd98c838cbe ("can: netlink: move '=' operators back to
previous line (checkpatch fix)") inadvertently introduced a tabulation
between the IFLA_CAN_DATA_BITTIMING_CONST array index and the equal
sign.

Remove it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index a36842ace084..4ebd5181aea9 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -16,11 +16,11 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_BITTIMING] = { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_CLOCK] = { .len = sizeof(struct can_clock) },
 	[IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
 	[IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
-	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
 };
 
-- 
2.47.2


