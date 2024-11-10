Return-Path: <linux-can+bounces-1923-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1389C33A6
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E07C1C20921
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908A22619;
	Sun, 10 Nov 2024 15:59:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F84CDEC
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254374; cv=none; b=Tc9qSlZiuj1B+X2+hsItvBClDEv5W6SOF7YGI7/HREii4wXBrZkevpwi+H8pLiOv+bblG2W4mtr9IFX1fHr9RHSaoRJpW5gDPvEFvSbvCMhWj8Uv/Eg7mw/b+PJjm4O83fJa3kkbQ49uVxzMWLvdb6XY27SkHYypWlp5/lH3qGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254374; c=relaxed/simple;
	bh=igPwDEX+kBFS8vI6XFFpwe0dABOtFHrwLHC1/mtnRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUtibkXnKgWrftZv3ixfpYgd1XmclrRaw1GdrizSuWE6PMylVmPB0vmlsLrzuD8J7eqbWbKxr/1UfwlOC/HEzTm8PqAMxsb/iYrTV/CzrBq7MeA1HyrUaeWb5/knigWVwe0TQWsSp0sVy3s//0XgQHsJ4W7OOFU9qYySzvvHaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723db2798caso3877281b3a.0
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254372; x=1731859172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkHCbMuM5Oo8Rc+XZYcC1s9rSah9HoD4WbusbkFpTzk=;
        b=MP6WE+Lq+UJfe/6SMwd0Dd5xaxttPpO9RCyHbnoEF8d6w9a/dB7GvxqLL4mSel5RE2
         tl8KlXvqBUMoxS409KuB1ElPWwU075ybqV4ZgPHVHDbAvN8q9pV6mTBRRHIqcFb4OdD1
         YA6pXOkifoda7nquL38HhirfuPaSuFVcxPUwF+az6kgxpv24NAMuzC9I6Xw0rj6Oea8Q
         KYVWe7/taa8+8anJWxaR+tomSR3E7twoO/+qSP099d9B3RFja7yQ3JZ5GirVJmngqWDc
         PBiBA2QoYPGgMDnKW5Ju1wxgVoaFCi4n+BLeLxSBFx2Ci4Ler6s8HXlEVEQZ3NL93rnZ
         W9qA==
X-Gm-Message-State: AOJu0Yw0k+43wII6oQhuPt5xeDuQgktcPMUXjmWmaJB6WR+xo/9TDh73
	mFTKh/QakeK3UQeXNiaf4HqHXsbjasjITjrhGS2aVbaETZyDGLtJvTM5tw==
X-Google-Smtp-Source: AGHT+IG5pFiNSJztPsIWauWCVf+9tx/GLvQ75iJx+DDXk5+YRFjSaOg9WSLbWizotOAPDaxQe3DQtw==
X-Received: by 2002:a05:6a20:2587:b0:1da:4dea:3a41 with SMTP id adf61e73a8af0-1dc228b22d7mr13965805637.5.1731254372140;
        Sun, 10 Nov 2024 07:59:32 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:31 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 02/14] can: netlink: replace tabulation by space in assignement
Date: Mon, 11 Nov 2024 00:55:51 +0900
Message-ID: <20241110155902.72807-18-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=igPwDEX+kBFS8vI6XFFpwe0dABOtFHrwLHC1/mtnRb4=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwKYrY8IuSraL7P00eD71/rvyNurGdNEmEXckmfYl M+5IdHQUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCIJnQy/WSK4rtlOkfokJ/7J bs8MFi0Gicj01RWpUhFfWBwYb7GYMfwvKt9SrXP73Y4rm7J3b7yS80rzlhBnrtGhs1MuZp0JW9b GDQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

commit cfd98c838cbe ("can: netlink: move '=' operators back to
previous line (checkpatch fix)") inadvertedly introduced a tabulation
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


