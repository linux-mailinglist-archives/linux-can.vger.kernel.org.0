Return-Path: <linux-can+bounces-2186-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C379D65A5
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1CAB22B58
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C85F1C82E3;
	Fri, 22 Nov 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U16nzsOt"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15419F432
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313821; cv=none; b=NRZ29SMGT9l6eFwCA79Vl/PJfb/YsU9byawGih+P/pTbN0hDOCRWVtLMCvaKPS8W4ZbbxhlzcdZ9MOfMM2P5wn+xJQyzghsSHz24//fjaIS0SigygkbWzR2vsMQXsLS3YsEAcEu3bI6bGFqnKYCNWKjQv2338/nxvRnZ+PXwlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313821; c=relaxed/simple;
	bh=bJ5akgXBwoiUhGjbtM87dqu6r2AImjKv44f50PKcNNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXcorwvRusjP9hROlVp36ggjSO7kfvBRFRsDYlBJnIoVNjmYdx2XemBmedFEWH2Qx7QbBNqTmI5KqSi+mw19/FYuRVLL+sZbkufTZLf3HNCQXQYCz9Q4+mE7fYV61w7DG1NNjBEiFdrRF1ZpFqcowaxteG0/h1d9+QUjTST0F4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=U16nzsOt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99f646ff1bso366088166b.2
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313818; x=1732918618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da17qF15VPZTU2YSYHqLzMcyFK3KqWPtGcD0XFwPoOY=;
        b=U16nzsOt4XpL++sydhwST5W6HFxEY3efaLlkPhLsTK809xbURx2OBDQzeauZc+RlG7
         1fd90CVOsCo5kGPFpbWa5pbX57s81hjzCMnegwm9J9EpZO6r5RE5HbrcyCwpSd/aUmww
         XLy0vi/E9L9JcMmSSz+UoISG22msb4CyOKdto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313818; x=1732918618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da17qF15VPZTU2YSYHqLzMcyFK3KqWPtGcD0XFwPoOY=;
        b=mcj61o2DmFVwwsZE6SI8aSb+6FOs9vJrjK9lGM4HMo40LLieOyxm3CO4b+B00U0FMD
         LdZat3aCXEEFhXPHAZVhB3j74jdAcApADkdB9akS0BKBvKdVWbn8qNsAVOvyCnlzMF45
         s82D2Pk/fxj0vFCCtHRLEaxFUoDJjyKv8w0/Z/FP2Xk4HhgPBGC3nD+qIGeyjqkm4IaK
         xoyN1R+TV7HfVpNAmM0eCbMYJD5Z2bjRUVewV4cSntzzvqulXkRmgjs/MS45j5coUmz3
         cvY0h00EJPfCyMoLY7c61KfXxzxjfQ518GJpld2H5vTeqLpXRmilXIPf2ZUc6CpTsN85
         dFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSLNdazKlQm84om3gm4NSAgChrrAApuhjCAEzlOfJdYxVvTmMRpwCzbxA55z4UsuiE8ReFAyj5yYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQWe42D60etxod601EGlWSNEBtGFQIvQ0hunoUDliXI6G9Q6W
	8TtFQ+j8aG0kiExAzV+gPhydmNr7Du0UMKQZi557IWXTHOTk+h9iszjTmZhFzNQ=
X-Gm-Gg: ASbGncuLuFWDW2T3H801kJycAUloc1HOsP67CPON4UlfsLPaJL4eMXuBPeY2VmMbda5
	ERKsXgNqvZLffi2QO7dZ0NdrQMwfk7Xzov2lNi1Sl1YCZnLLzxWszP/+yPZ9M6fl2ysJkviGx6h
	42IzVFtceGvi8wQNuDqlZuvxtgmbPHWEQSqmUnzYi8Fq0NCShgtZC7PUQQ1H/J34SeSg9b5dxTa
	uXLRatT13r4twjFOW+hENT8cyd9txs5C1cIt0cLvJU7flQQtR2XGK5ezAp+xs/KWjlviAYUQce1
	Viq3MzowEIztgiB0+uR529U2Re2KJ0GrJk9zksHnrDFY9tbB3sV/16UpqviVyL9zMBVzvcBAMbT
	G+HEdYZSh03G/vrbd
X-Google-Smtp-Source: AGHT+IFqavb84q465UWZ6gGwXgO+FxfrEo4gdscEtW86lZSTJTKpRR6rT4g7qMsIZYvAutdo4gpnMQ==
X-Received: by 2002:a17:906:4c9:b0:aa5:cec:2785 with SMTP id a640c23a62f3a-aa50cec28b3mr343858766b.25.1732313817919;
        Fri, 22 Nov 2024 14:16:57 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 03/12] can: sun4i_can: continue to use likely() to check skb
Date: Fri, 22 Nov 2024 23:15:44 +0100
Message-ID: <20241122221650.633981-4-dario.binacchi@amarulasolutions.com>
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

Throughout the sun4i_can_err() function, the likely() macro is used to
check the skb buffer, except in one instance. This patch makes the code
consistent by using the macro in that case as well.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 17f94cca93fb..840b972498c1 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -570,7 +570,7 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (skb && state != CAN_STATE_BUS_OFF) {
+	if (likely(skb) && state != CAN_STATE_BUS_OFF) {
 		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
-- 
2.43.0


