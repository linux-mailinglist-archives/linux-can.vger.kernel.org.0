Return-Path: <linux-can+bounces-2187-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F49D65A7
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008A1161505
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B81BC06C;
	Fri, 22 Nov 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KezNprRJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C851BD519
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313822; cv=none; b=GC9dtKoAnMjtdtvBCu+//g6b3zyK1UsrnEkCgDlxjKF9VivETeCiBuTDENyEjNjyQigWHCM1tSIJbH3tIkhGSrDUeTDW7zbAhffV0nhwol9fNdJmXfhfhVpsHWJqIwktYGuTmomjXjilFDjpX66SpMfUdFoAERFCqrSBZ3yQHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313822; c=relaxed/simple;
	bh=efbjGTczyugw1pySOLOPhnxLKFyFbgfz1MN4+/QXZKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQohIkx58Y4CP/c5EbTr3W1oyW8F68Z3jamIaCSaxVEBeoOpHuwWzP+JVXsYaGMBstwAxbeNY7JUlF4lTO4iVwr85igxP2zIk5h5D8r4Arez6Lpz4mkns25hx/Mil0TR+ubItPQq9B2XbqnXVthKzlHmTIjqOeW7KjeVhLMZop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KezNprRJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfa9979cd1so4453239a12.1
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313819; x=1732918619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJP+d2oKTX52rq2v9NzXxSt1l/2jtdXfEIdax2O5les=;
        b=KezNprRJDgkB/ZvtFVWa7/OaNf18HGv82uDoN6JgL5KWjlVORS0DRe5374FnknBc6v
         6i54IS2IiMhq/wTYg6r8jx6NtvQdA4Sz9Sa2KvTf1j8ZqTl4SHlTagjKlUl5fMgXjmsi
         IhwoxIvA9vziGCHKTX4oLJbE/qqoK37/aaHuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313819; x=1732918619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJP+d2oKTX52rq2v9NzXxSt1l/2jtdXfEIdax2O5les=;
        b=EfTQaJhbylyFlqFx6NGoUIZ9evNLCuwjR0PyptNVGllUvFDGeeJUA1mxTNZZUOuEXr
         tCmJ0N6o90/pD0aD4Vyk+wCPdrladChKsj5ElYCeeHLTYluLcnqr5KvwwREomxhvdrZn
         hHlBbiOW1CjrJ4KgVuPGQfB9vcgM29W+u34uzxwstFKNJN4MbEDwcnvyCh11bSDAYqJb
         gtYTurSyeQQrTBdsCKn1kusmRbEz/b4nyGzj2DXn4GjWxu9vUeE7MIICR5WFJgM/RtB6
         Zdg28g4KnBb97auL71pbWFrO6nQ3HmvVC6mGPrzX/H5DqQ7GVeVIFXZKR5mTrzijJblp
         +Dbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxKqTfRJgpVcGDNS8Jfn1wpANyd7DlTGFyIzcx5FfoBVE26hc1+C3rC3pwQqiPaxxZLNL86N41K3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAmd+wWKzzhL53fx5tK3OmXXfpUgmyz6k/7+ETMTZRWj4MuBE
	vRgkqa9eeNuVie6tzSBqP+q5rCA7/rE8sqCpqTU8+Lm5PLx3nIvDL+pUfAqv3gc=
X-Gm-Gg: ASbGncureLwPuDnOwCKbnocHU+rUsr8Imfa9g3Xjbcut3OcnzPzCyWzI6K97pQrpxoJ
	nKcx8/oC3PQizKCdURo+VVT03vCED/jwWRFWQiU9ygLNJ8ylxTjQ8nXfJMrbHJcYV3rP+eRWiTK
	Ltv2wG75z4/0GCCgB+LJkiJqVeXKSp+kMH351Ml9cq1ibm0YcczXX3AxbgSIJk7/rd1vN15Xqbr
	2RC/bHX6CKhPKAkyRcgoDSrzD6srz+tfa/jk2ppGoQeXj1ZITGkxBXWjNBTIKky5trsO/cC8Zbk
	SyhsL351jrdYckdQDy0Ju3P4eKxM17ptkP3MGZ+1TXEf1zcEM8zQgW3OaVLqm4MI9RIkBvAwtBg
	eDKro6BykTGByVuGj
X-Google-Smtp-Source: AGHT+IGVxTQySZsE/tv/VZESBfxk3xJJqygiRA0W4TZmeP4NEP+xLMVnae8R8ot7CiIlz9KLOHPPtA==
X-Received: by 2002:a05:6402:2554:b0:5d0:ada:e44b with SMTP id 4fb4d7f45d1cf-5d01d57df0emr4922820a12.16.1732313818928;
        Fri, 22 Nov 2024 14:16:58 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 04/12] can: hi311x: fix txerr and rxerr reporting
Date: Fri, 22 Nov 2024 23:15:45 +0100
Message-ID: <20241122221650.633981-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit a22bd630cfff ("can: hi311x: do not report txerr and rxerr
during bus-off") removed the reporting of rxerr and txerr even in case
of correct operation (i. e. not bus-off). The CAN frame is unnecessarily
set since netif_rx() has already been called. The patch fixes the issue
by postponing the netif_rx() call in case of txerr and rxerr reporting.

Fixes: a22bd630cfff ("can: hi311x: do not report txerr and rxerr during bus-off")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/spi/hi311x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 148d974ebb21..b67464df25ff 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -671,9 +671,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			tx_state = txerr >= rxerr ? new_state : 0;
 			rx_state = txerr <= rxerr ? new_state : 0;
 			can_change_state(net, cf, tx_state, rx_state);
-			netif_rx(skb);
 
 			if (new_state == CAN_STATE_BUS_OFF) {
+				netif_rx(skb);
 				can_bus_off(net);
 				if (priv->can.restart_ms == 0) {
 					priv->force_quit = 1;
@@ -684,6 +684,7 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 				cf->can_id |= CAN_ERR_CNT;
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
+				netif_rx(skb);
 			}
 		}
 
-- 
2.43.0


