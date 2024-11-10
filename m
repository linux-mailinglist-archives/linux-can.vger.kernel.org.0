Return-Path: <linux-can+bounces-1939-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786D69C33B9
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82E91C20AAD
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7912955C29;
	Sun, 10 Nov 2024 16:04:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA684C3D0
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254671; cv=none; b=RTTM1CKQEcNn8OzaQqJk/ExNQPufgI141+lTwUw5F51gxDOl0SkxlpLe1FEjea+tGhyDvJmsk0hxkArLO++jaRgeYK8XOqExV1ml8KzvCRWIaXHxGM0TAnndumgrFrlgWoOmtWQU8tGb+wmVR3HMhlxysGAHkcPgHeh4QZDvpSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254671; c=relaxed/simple;
	bh=p2ZJs9LEo4UC1JUgCX9uDAJ3fbxuZzju2aIA1KDx55g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVe2w6Irmk7yJ8aUxaL19RvTLK8MgFI5DHv6Fkg3sfYRxIurrfoskSG1jVNljRXh5PVDInoJxk8TjhCCmlgxod8QsOvy9p3qWmfmS5cxWbajpOkQEnootpkHpiI8mIIe4o5MqZEyE1Z3pdl9mO4QFCC+4/ZAQ0zpyjiKb7htqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72061bfec2dso3421376b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254669; x=1731859469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHzuB2QQz9MeIpBdKnCySArAOpMo77+xEhghKdzSO1Y=;
        b=Qah9xAM03MwfHG3bEsoBnWpz0OmtXYnwbiIYJtRpPQ5xgswwKTbQTOmuRyh9pehkeJ
         NhSfjH7vsMTfIJKVqF8UwQiUejyJECpBsO4owKFlG9gspbQzBlzgmak/zKVeXzs/x+m/
         hbUVW6PKm11DMGmwc1r3+Xyw31tjgTTFfFXNom03xuNqUkLIFPqga1zOAvpNnahAtFQQ
         v56LHVizmLjaD64MymZ1f5x0B/7btllD+58fEiM0mWFekcT819W9KIqQfP9FGKULh+Dn
         wvdMl+IamaQd+R7NxrxV/zF3J80A0Vfd8e5CcKWjUtA9Qh90Ol3NGqRyJwrbvn8WVDj6
         7uAw==
X-Gm-Message-State: AOJu0YwMbKa8OUShlp35AOKYyji+f2ULLZj16bjw149CZ0LDKPUt432l
	T6ifuxhbO84wBhjMl0M4enH/BL4i6G+/r1kT+876EqBexGswZ5pcBz72kQ==
X-Google-Smtp-Source: AGHT+IHe6xfyISau4lQdDC5uEKv0rKUqGYOtuNSPphYMbFXtSnvPzP0DpBkSlIPj8p8hOeF6ecLSNg==
X-Received: by 2002:a05:6a00:1820:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-724132c8850mr14256532b3a.12.1731254669105;
        Sun, 10 Nov 2024 08:04:29 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:28 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 3/8] iplink_can: reduce the visibility of tdc in can_parse_opt()
Date: Mon, 11 Nov 2024 01:01:33 +0900
Message-ID: <20241110160406.73584-13-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=p2ZJs9LEo4UC1JUgCX9uDAJ3fbxuZzju2aIA1KDx55g=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN8uzeL73ivssrD45W6Th7I5dCeZrp2mcKnER1Eh83 rH+3BXFjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABPhDmBkOPXo4qQ+ww+7dBlu /tuW9Cld6IJMSleJewX73iKxejMVX0aGew1qTy2OK3dIvHuu/b9mYcVe28Qa81PnNWdUzpuvwSf EDwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

tdc is only used in a single if block. Move its declaration to the top
of the compound statement where it is used.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 01d977fa..3414d6c3 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -128,7 +128,6 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 {
 	struct can_bittiming bt = {}, dbt = {};
 	struct can_ctrlmode cm = { 0 };
-	struct rtattr *tdc;
 	__u32 tdcv = -1, tdco = -1, tdcf = -1;
 
 	while (argc > 0) {
@@ -298,7 +297,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
 	if (tdcv != -1 || tdco != -1 || tdcf != -1) {
-		tdc = addattr_nest(n, 1024, IFLA_CAN_TDC | NLA_F_NESTED);
+		struct rtattr *tdc = addattr_nest(n, 1024,
+						  IFLA_CAN_TDC | NLA_F_NESTED);
+
 		if (tdcv != -1)
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, tdcv);
 		if (tdco != -1)
-- 
2.45.2


