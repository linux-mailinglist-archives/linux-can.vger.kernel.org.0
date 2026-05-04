Return-Path: <linux-can+bounces-7469-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA1BH48p+Gk3rAIAu9opvQ
	(envelope-from <linux-can+bounces-7469-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 07:07:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5D4B8729
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 07:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1B36300F9D3
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 05:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1E265606;
	Mon,  4 May 2026 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOhHPQfH"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFC7260D
	for <linux-can@vger.kernel.org>; Mon,  4 May 2026 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871236; cv=none; b=Isna+YBOoQajqdIHr+H7OgPORnU9TtpRc4D6ladtxO1AwM/ddyb7qXQau95Mf6XU5nH+kjn4NwoyvMzontd6ThrtTha+ZRTQSaNswULZMhhG75x8HrGIEucDhcW4ope2dUcG4a8hAKicKrbvdrA4sFv7iFoPzyDTxibuICLUZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871236; c=relaxed/simple;
	bh=9G0wXhHQpQant01a2OElCu8EYM2sME7MpXQNF7ffsqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iz94wwTx9Zubs4CPQOqw1uOMZs3elhNtnF7ESlCnjG1kRGCxiGOhNCMDWzDZdxy40FpQIVWNAQHGDx3vnvoQVzw+yoI0czu7mB2tyHCb+jal1bOkQ8P6bXIM5AAMMd/Ig9UemSgmM4k5kmji/9QW5zP9bQGFowbcEFasIzri8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOhHPQfH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso173057a12.3
        for <linux-can@vger.kernel.org>; Sun, 03 May 2026 22:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777871234; x=1778476034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liL6ORHjgNqfFwxXFopdobr8mpJfjv+P8vo1gUGM2m4=;
        b=LOhHPQfH0rsI1NRzaqnm2w9jKhbgfNBC0gaKOGcMvqBCKIcsM055RqXIi+AKOibZg0
         Uq7WonB9II32HvscXXFDbmgWGgVQRn/3SrZ5MZ0fzqtQqMFdLl6iPVbkYStxEj2ope3B
         WwjXVDKcip83wnBygxY/fzF4WassUyq6ugV6E0xrXC7MIJC2Qs06QwFchtf6vm1plpuQ
         3w+0MCZoX/ayqwsDw0R74uuU4D2iko5u1HPU7iYSjlg23w3OIZNvUJz6DBMpzPHH5mnt
         vErXmeEGmiBWtnfrXUMDukuvePj9bdNvRjmBTqkUewN0t5Xc/+6X5gwysObuqzPNN6Ra
         RCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777871234; x=1778476034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liL6ORHjgNqfFwxXFopdobr8mpJfjv+P8vo1gUGM2m4=;
        b=beBLYTwtksFXTQ2rbiwB8A7u/hs3tkc+2xMr5SLzCRqEZyCmk1GrUNUrEFQd3kEp9K
         thHdpMSVAfGTBkE4sO6TSrsVsdc0q5P2na0qRWxocoU8PXXYuzhHwPlm7p5Z1Gsu3DFb
         KcfZRTp4xknlwKi+wC0vZWAiKfDT42zJCSsjbQQ9s89hpeumvju8/wSTmEfyi/yr/SWC
         5wzWndOLBO9U1YTK7r1+NFyDq/4jjcujsK3No2Ip0TrQ8R29IHG4eGRTu1llfjcCahYv
         608biIsmNUHfGT4rFoGCMhLEwj0JZ0i1+haXUvxoztdN3nIOlLTrx3LjIHCFipEgUf2W
         hcJg==
X-Gm-Message-State: AOJu0YzOc9EwvafE6m8uOl/qWub/V0D7t9OSMeaQnF/6ZA4lsvZXkHCV
	98upoThOAF+7glrUtSCsgDYZZBS2SMIh9kRlNM1o1txXbFbn7PA7GRMT
X-Gm-Gg: AeBDietDuSeYaBCXj/I7h56HkIqyi6EXmg3+eSpGG/eTco2223MzJwhPHaCHKa+7PtV
	glwKXQV70IWTd4IWmz0kI66h7Jni0C2tk5hG3OAB3jaA+hEHZL9xe9SSiq/SaVz+xm+dKaFaQ6n
	Y6SKTrVrVhZEaZaB7E0KOdE3LQ4g3R+uhlOHVMqjAnNmpfX/Hjz/OjhnQ/e78Yx6F53aGDBgsnE
	do/iVfZxuimdM3kwy2g5Ul/Nb1hZ3SPMI7KFJDBsEHxsRXSRWZTy5o6/bfw06ReXeqrcKJo5+Rk
	eHXoSvCqn7MuMkU6oxJTPIwF6DnA06/IV+IcCA+dDeORYfSnong7z+hY6mzeO99dGAAs5Ia3XdM
	rjlfKnZ3ECOorJ6UZmLXEYTxSY5lxrVDwcb2dLYrIT1vMBT8WEGNNcFwCE5HBkfViRk8naFc/ds
	khDz5Excl8AeFNSeuz79n5+V3fUHwYuA5ydwA0KszsXzm/cuTixYyyRR6EJkPPbmhNPVczpPWWN
	E6WTHw=
X-Received: by 2002:a05:6a20:6a1e:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3a7f1a9e180mr8446226637.19.1777871234210;
        Sun, 03 May 2026 22:07:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83659d38ed3sm2879655b3a.52.2026.05.03.22.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 22:07:13 -0700 (PDT)
From: phucduc.bui@gmail.com
To: msp@baylibre.com,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] can: m_can: Use of_property_present() for wakeup-source
Date: Mon,  4 May 2026 12:07:02 +0700
Message-ID: <20260504050702.34013-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DA5D4B8729
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7469-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phucducbui@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: bui duc phuc <phucduc.bui@gmail.com>

The 'wakeup-source' property is declared as a phandle-array in both YAML
bindings and Device Tree source files. However, the driver currently
uses of_property_read_bool() to check for its existence.

According to the function's documentation, usage on non-boolean property
types is deprecated. Switch to of_property_present() to comply with the
recommended API for checking the presence of a property.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7d..16f80607e150 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2464,7 +2464,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
-	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+	if (dev->of_node && of_property_present(dev->of_node, "wakeup-source"))
 		device_set_wakeup_capable(dev, true);
 
 	/* Get TX FIFO size
-- 
2.43.0


