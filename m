Return-Path: <linux-can+bounces-199-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03138498A0
	for <lists+linux-can@lfdr.de>; Mon,  5 Feb 2024 12:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCFBB25E91
	for <lists+linux-can@lfdr.de>; Mon,  5 Feb 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E9D18641;
	Mon,  5 Feb 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM4x2+kb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8D8F6D
	for <linux-can@vger.kernel.org>; Mon,  5 Feb 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131882; cv=none; b=h68Qzg+NdUTopAaz0qwYm6PYfKWLaiUwC7bo5f+ND44geOoZdd8n1UkX6S+dB2oyqQeTxkDaUsSgCc6cViAFQVSSGyIJVHvt25HzOCW4PxLojzcQbq9RNf0n8I3aQY8iqz0WFxlNrz6DpBRBOEGQkypGlnNw+Oom0sgCmffTzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131882; c=relaxed/simple;
	bh=CeO37g3sbvYjXy+qHSQY7uWXmSadX7wGrwV3ULOlk/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY/Q6ivYr/EKO7MRo53teXiWRg2U2L5fnitpH0OgvHeimhlX8uN9/hWcXpXtNkN9avtt80+MNGn6rS+H7semwyI0Nejyth5+z9shdGHkOGrmSIgPOsTyKthR5RoFUfFyaPjjftwQvkESYb3Xuhp8qVtZeiCCFXHU6l1BWYOldDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM4x2+kb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d51ba18e1bso38846605ad.0
        for <linux-can@vger.kernel.org>; Mon, 05 Feb 2024 03:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707131879; x=1707736679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwVzzw6q7T6rJMoizsqJwSZOFB3EjGWPnULEwJzCBOw=;
        b=lM4x2+kbj9enqQqEPnqXhuzZyWV9273OgvMVs5Q3PuJkMfI03dhSnNycnSSeEri67E
         TmR7M0tgTLRCsYavX5wd8OuGQXgarLiiQirnKnEWCD7Ii1xIaeYkxG+rWkWHx5FjmnMC
         lix8bXVq2YATgxVmb9F+z/FsYuIF2CdnglLxdnCtChtB6z3ScNDODsU7xZ+L3XPrTgi/
         7qm9BJ6D20uOX5SgRH0KXg+Qzf6cLOQc1paCgeuYMdgyS8Ypf/4e9tPhk5YCcQj+R7al
         AyzDVbZ4TLt91PwegKn760VUW82x79kNkXOpI/kj8UcLXbeSsKFRZvSuq2BBRyP9r2wm
         /56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131879; x=1707736679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwVzzw6q7T6rJMoizsqJwSZOFB3EjGWPnULEwJzCBOw=;
        b=FfdjZ2Vyi2tH4zaGrDxNCHjf/PwCt6qe2waZpN+qiNj3GyAAWTic0yQ+Q4f9KoNjBl
         VIa/r+X9Gg106QvF+oRJ1v7fDIxDp6ZqkCWx8VgthhWxYvc9lol8kZtg0G6Azz+jVAq5
         EJQ1cnTLP9c9VSFL7coSavSmKZRmWle1r0Ywo8wezQv7THHbu7TipOzT2j0jJ+/ZlAWr
         2hqtvF2A6kRZEbOTvgAV9azEJFRvs8/BtGBOEIsLQTyjyvqhYqBwLZeSs6wjH0VNPolN
         bblbjDU9dB5waiyk0yAILBO0vAchdB7atetbC8m2DuO0tcrdwju/w3yjk/JJv9MnbEUu
         lpOw==
X-Gm-Message-State: AOJu0YwzxtfnxfiGM8I4B45xJ7l7ArLmZHcUDR9AW/wJwmOoy5MZ7AJV
	K3PHl1dyjV8jg8UqhVSHPGsg2+gnDqmgOVy2G9BMFhC4pEtpYS9/3cZEGJaFpJc=
X-Google-Smtp-Source: AGHT+IFFNbQ9mj5virwghiG7GyMw7KzkOLURG4v9ncOHFgxiabfmm3wY9ZoD5kw4/UP5zWFHuwUvvA==
X-Received: by 2002:a05:6a21:1798:b0:19c:a996:da2f with SMTP id nx24-20020a056a21179800b0019ca996da2fmr10501679pzb.44.1707131878995;
        Mon, 05 Feb 2024 03:17:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQiCpVU6LCunZlfbhhSy6WZI09gB+t62eJk7R6rxY9w+/nXPU2IwfCRvyJ2OfTItEGx6owHIKTTD8v8IyrqwfISu+CKiX1ODZ4M0biUTN+axQMy0f+
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a00088700b006d638fd230bsm6574756pfj.93.2024.02.05.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:17:58 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH 1/1] can: change can network drivers maintainer
Date: Mon,  5 Feb 2024 20:15:02 +0900
Message-ID: <20240205111743.920528-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205111743.920528-1-mailhol.vincent@wanadoo.fr>
References: <20240205111743.920528-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wolfgang has not been active on the linux-can mailing list other the
last two years, his last activity being on November 2021 [1].

In replacement, I would like to nominate myself (Vincent Mailhol) as
the second maintainer of the CAN drivers subtree.

Wolfgang is already listed in the CREDITS since [2], so despite this
removal, his legacy remains credited.

Thank you for all your contributions!

[1] https://lore.kernel.org/linux-can/?q=f%3AWolfgang+Grandegger

[2] commit 4261a2043f1b ("can: Update MAINTAINERS and CREDITS file")
Link: https://git.kernel.org/torvalds/c/4261a2043f1b

CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..2d28862c9f0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4629,8 +4629,8 @@ S:	Maintained
 F:	net/sched/sch_cake.c
 
 CAN NETWORK DRIVERS
-M:	Wolfgang Grandegger <wg@grandegger.com>
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
+M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 W:	https://github.com/linux-can
-- 
2.43.0


