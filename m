Return-Path: <linux-can+bounces-7334-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMh/DFePz2mmxAYAu9opvQ
	(envelope-from <linux-can+bounces-7334-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 11:58:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A18393137
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9120D31232C1
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2026 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F73339FCCA;
	Fri,  3 Apr 2026 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYu7qNVn"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246639D6EA
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209819; cv=none; b=Ofx/7UKM0Ky3Z+hZQiC/8N79YqQE0/3X/hZGJh9ezIzUMXEJhTKo9xBraxvO9wEZqcqit7ti1MKoxXs5K3tXCBkVdboas28PeC3uTFO4JnMuoMeWJVfGXKkjZSkSAFTLVg7uLsfaVABWOIsfSUezEF0vKFx9d3SPxR69Gtno9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209819; c=relaxed/simple;
	bh=MmUaG8Tpdj86GsYS5kfMIG6th0XHXmlH2xRgSRofHmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkN10djCneBSIHR5TolJYZiKlLg7JF6YOT25wBN7gwKJyUuHq88qt+ggZx1/8V9L/wPs5+yyYBlKo/mtG6omQF8wcCvXXLl1T68xikKQVZs5NEf2Ewzh+z54Mk1SKSE+41QFn6fO5IOYlnPO7KsWolJiCsUM7womrZbb07Jt/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYu7qNVn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so11751375e9.2
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2026 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209812; x=1775814612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOzNDs1gxrF0+eT+GD1BoehPlyrAM/scv18YsO5VzWg=;
        b=kYu7qNVnvSq30if478Btd2i/Q6VsQmAADymWHVSSVasgrCQS12aMwtN5UR0hyHKZXE
         sEG071LKDRasEJ+L+2Rd7k4Dc/0IldeDud0ei32skbx5N/RahMWY2qsMNw9dl9nVl0qV
         8BHg9cV5o3x2gwnGZAcV8aMaiPS/uW3DaQ7PxpesShcyjcJ3fpjqD4dFhxJFuVQ/5kT+
         zJf7THM3VDukI/GMWhfEL9IGD6XhkNkGdVofnCZnQ4t0HtNmUNUYsW2ztvsrLnycO3Yk
         9lg3awgO+K9GIMyvJRrv0eJRrk4dvxNQQdT2OGqmtDO2Rj+NhUBg2vu5aRYM7uEy1czE
         XEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209812; x=1775814612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOzNDs1gxrF0+eT+GD1BoehPlyrAM/scv18YsO5VzWg=;
        b=FrJgpPBhckaUozYc02HKduPSbsb+5ihqkTB547BzCxWFM6VEXDOjQPlPLTPCt9A6Ed
         ILSEvpO8oy6qcWfIUoQ0hHtk6B2j6j1XMuzqPqadnbgZu06HoEBr8fYSQVBjG8Qucp+0
         uVOicQD7neIZO6mC9Fxcd1ODPG3+GOnjXzayPnrdssYpTE/OSS628s7YWGJ8lz8bxkRV
         64wEogrUrTjaJ85gk66fnvZpF0rs7b///rD5dZpehHn1/z1LTstF1S2Zgv48oTrZfBMp
         pN00HReyUcpcs8aD3pnFaE7Jn+Zulw2sECq5I9U+yJ8yoAIAaOVqqcAAPb/zo1b17Ndv
         6m2w==
X-Forwarded-Encrypted: i=1; AJvYcCV5pfkLoZUq0xvsu9npJ/eIcs5JIqyfBE72MWEL0JfY9ql+78SW7PeLceV2wDEwwKGWLKl9qbleims=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yIWAvO33+qrhjzI4NDwAgZXs9xbb5zpQ0D1V6Pfca3mMEe2M
	PY/mclZh/5fLQdawj9Iv3O9Lct8onx9tQ5SzIUlOz9JsnK2EBTjc59TQ
X-Gm-Gg: ATEYQzwFbGxpC8BDeXprjRCh4OlDF6IFV3+OPNq4m8IAKGrwcp6HrkxBoVohLxyGsGr
	UiwK0MTgg+/NylDXDCqfJqsvveSJECsJTriL1Rn/S3yuZjfDFDZm8BtqkQUeelpcGGj+IyJHCJp
	fpbxYlvPDuzpq5O51B0mT4tI1wlsuKFkF4KbZApwVg4omHq097tHBgSnNGGx2RxvWKch45cfxlH
	60tQa7SswEBsvytIyafXRA8BAYbx8LESye/xRPcFjdQwhWq993687MUeclZtcWonffyWkzxeIAJ
	UwhmuTML1vg7PGJlVMAOcBQFCWTg3iXopDiqsdcCx7BBpwswc28FTQYA158OAhXAr9WP6NKzm9v
	KgCNAqmh9vEak79TyHBI9uXNdJeZUcQM2UO6ffxk9AcYDcWEvGPu59jCxTQj8qjrOLNgX+5TPbw
	zhOlxJY9owEm0YdXu4SzSn4488nBW1eCwnnoiwRhBnDrFpQ7m4
X-Received: by 2002:a05:600c:64cd:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-488998f8b3dmr30471025e9.31.1775209811489;
        Fri, 03 Apr 2026 02:50:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:58b8:b4b6:c8e1:8690])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fc89c0sm25965355e9.1.2026.04.03.02.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:50:10 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 3/3] can: rcar_canfd: Handle Bus-Off recovery interrupt
Date: Fri,  3 Apr 2026 10:50:00 +0100
Message-ID: <20260403095003.104542-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7334-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: D0A18393137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Add handling for the Bus-Off recovery interrupt in the error handler.
When the channel bus-off recovery interrupt is received, transition the
CAN state back to CAN_STATE_ERROR_ACTIVE to reflect that the controller
has successfully recovered from a bus-off event.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1d6d667b8816..427472d0fd98 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1186,6 +1186,10 @@ static void rcar_canfd_error(struct net_device *ndev, u32 cerfl,
 		can_bus_off(ndev);
 		cf->can_id |= CAN_ERR_BUSOFF;
 	}
+	if (cerfl & RCANFD_CERFL_BORF) {
+		netdev_dbg(ndev, "Bus-Off recovery interrupt\n");
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	}
 	if (cerfl & RCANFD_CERFL_OVLF) {
 		netdev_dbg(ndev,
 			   "Overload Frame Transmission error interrupt\n");
-- 
2.43.0


