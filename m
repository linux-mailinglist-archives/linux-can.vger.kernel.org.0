Return-Path: <linux-can+bounces-1996-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A79C61EF
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 20:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0565FB365DF
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B420821D;
	Tue, 12 Nov 2024 16:51:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D872076D5;
	Tue, 12 Nov 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430298; cv=none; b=pnxrPGWmwaawJQTEAwR62xCruKItZ7HyrdwVk/Or5sTYe7XIjcGKWw6tnk4RKlAJcuQW+cppZRLaGO8H3Om8Ruz5XAT/LZddBcLbvlwgMVXxzvdXSukb6K31LxiEtCFopKMtGw8QADjTQcZ4HHp/of2Gj6Y6oPDJ1xLtJtTcHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430298; c=relaxed/simple;
	bh=HUuRF+VpnVCdV5kJ9WCQELFFEG9d8bVIIEs+eIl+0EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGed7kTo8K4z2jheA5MT32NH0+/rsDKGf16sBw4t4tqT4O30dGgT6Si3EppgBDYgQQMFa+PbDMfsoKhh8D5UfMcq1+yCMAR/0mikRjK17y0mzm8tnnFbFkGfTiOrCv0tySuRH//o0/8F1xxI4JvUVzroMHNtdz3MJOWf4TWROVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240fa50694so4533194b3a.1;
        Tue, 12 Nov 2024 08:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430296; x=1732035096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llFs2o/AZRfDbTGGAt9cEjHshD2VstPRhzSHKTGEl4Y=;
        b=X6041hvkCbzoud9NJ+YY92RiSr+Z2FEJJUc8xijOM7tq5Is2vSxCrc0fg5krZGrjrs
         WXor6f2Kw8YbXKiy9zXR/fRMZxIjKXBQPk+PTndYih1jjAq5ewqF12pw43zQbacAKJoM
         /65+VH3Rp0OTWGWZC/QfxBiA2ePx1XYDYjQOnRpRdOovxqQSyb0LZfPgBZQnnR4VJu96
         +Hoe7bbcfvKWN9T3MDx4AkXdOC+ktNclL0qquVmTgw31+fw+IYEtX3cDJmvHIMDtcPEB
         drY0W+f5YGiDsDWQYe5jGY+t6aU5E9Ks+gwHeYswAyKZ2XZeOFzpUAtKpL7WDK9hOVbp
         HbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfkcMJb/ttUzGMy+F9UhUgn22/5d0dna11jfbIkhaF0wQ/RqlhIu0oGaV2U+LgcgIyW86junr6eLePq8k=@vger.kernel.org, AJvYcCWTDkDyEzdBLfdTUMskpGn7OyBILVZIrU+JnluYqrtvKsKCvuWFQy4W9I1b9JMgLqJsetOqtHBv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/E8O6NosWPh/NNEpAl2YfKKwltlQ5tKaogE8dX+DJPRbF5mTP
	brZzqRqtyn9Nk0dAv2YMxOWkxQTID6V+0X1OfVRFKCQ6L7l6CLcxkA6zpw==
X-Google-Smtp-Source: AGHT+IGfEvt+vr5Gelf7D4xOsG1UREz/mUJN+n6wyuY+ufWwPryyN6GsE6YKmfawgOTA2GUdFXWWKw==
X-Received: by 2002:a05:6a00:a1d:b0:71e:693c:107c with SMTP id d2e1a72fcca58-724132c15a3mr21756587b3a.11.1731430296049;
        Tue, 12 Nov 2024 08:51:36 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860aa5sm11271260b3a.32.2024.11.12.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:51:35 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 2/5] can: netlink: replace tabulation by space in assignment
Date: Wed, 13 Nov 2024 01:50:17 +0900
Message-ID: <20241112165118.586613-9-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
References: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=HUuRF+VpnVCdV5kJ9WCQELFFEG9d8bVIIEs+eIl+0EM=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnG7W1hM5fP5rqw0lzPsNmzMvvm9+aWuvhyxkebfRwzf 4pu3dLaUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCL39jP8s9o499TinmvPt8kU JoV5VV/7wPM57/iXdYp8Sh5Lzq3Oc2P4xcTOEi0609Yhz+VX2KO50tvSp/q1pMh7frm2vjWJTae RCQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

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
index 7455a7c5a383..df8b7ba68b6e 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -18,7 +18,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_CLOCK] = { .len = sizeof(struct can_clock) },
 	[IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
 	[IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
-	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
-- 
2.45.2


