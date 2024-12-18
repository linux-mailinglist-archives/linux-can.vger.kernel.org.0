Return-Path: <linux-can+bounces-2431-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB399F5DF6
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 05:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281D21885D41
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 04:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3D14F12D;
	Wed, 18 Dec 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYvIewXO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA535974
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497937; cv=none; b=bzUB6PwcVgEYrFvr1zei/BZZy5LOLoPtXZpoc96I2qaXxWq0mqWHIj7kFvaO4AQUxWIMv9+OteWNmCoCStFIEgjaFs2smGRapyPu3ypkV3J+q479G88s3yhNUlgYxpAxdmTnp6phvbWTH/UuXV8JIwE0ijB1eKplwz8+ghyilK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497937; c=relaxed/simple;
	bh=OP/jwW3gd5O2ZWPfTneKQq/heqR1V6KD/zpx+h+phgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH67LOQe/hk1DZHDPQaGE+taZFWqUwbvGi9a+RPYiykyOug8Ggvx6nJRYECx8Y+lNr6QPm//FI2tsW98LI5sq9PNCqLt4qy4gWQuK3Yr+/IDbAAIgFjwgNuoTIvs9QYDSIdyOgsdfshdp3pBspFXTTurvmAJQfNZaRLx+BFcKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYvIewXO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21619108a6bso46135165ad.3
        for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 20:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734497935; x=1735102735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP/jwW3gd5O2ZWPfTneKQq/heqR1V6KD/zpx+h+phgs=;
        b=BYvIewXO0XwVVEeLUd0rifDu2Wlux3k+SjSyp6K4FPBXD5zXtyW9Lh2LeeN30JIrFv
         igI81nlOlHE3nYgg3nFdBiYIMRYc3VD6wUZTJgGWKUSdS5BRdIdrhlz/oXkn3PQRnkHh
         7/1OuOJIlXA67TBKsgIYZh8T/+qzhkxNxXuszUqE0b8sUJxGfbgO5wZ0hpRJoe8aA64X
         Udu9Fc4wX8lGzpgmWJizVEjgq6BLF3PwMNsloWvSHUshVbQLYSXa7l6fP9ItMhl5rrj/
         wM5FgT7JgbriM+yrt1eYkuQr8j7Via5u+B10fFdZxDj7g5883tA1kBa7NTolzCwFnA+p
         Xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734497935; x=1735102735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP/jwW3gd5O2ZWPfTneKQq/heqR1V6KD/zpx+h+phgs=;
        b=cVGmfUW13uEGrANu2gtS705s7T2Z+DOdJc4CNKREf2fnObhK8dLsQt4beycyqs2FBz
         wAF/wDSHl8sl3mtB15wz+tqRHkMHuNNpguKuv7cx+I6BAQpTaxMJ6TfOccsLgBqnPcTQ
         G+Amzut0Cm8nfegNkW5L/6gwKipaNZrv4LUkhCg4vLj8yafo/rEQJV29FFZIetOwJ5Nj
         g2ZZdpThai1UXyKhFVTfpKO+/DUI6QALK6gyLiaAJt+1eTk3MkCQZI6hjLJZQ2ta1p2O
         TEP5rJWp0KOnN1LRaT8RIRUvSZX1HDfFLakGs3LxG+iH6HV945aMJ2pi6LRCGY1wMD1M
         c4tw==
X-Gm-Message-State: AOJu0YzIdSAFDn92Be9cJxcD4n0uV3GsigSp40F0d+44boiPot8mHjNe
	YYtJHqw/TU35h36PdjjvQQ9MhNtZI6AhUW9HRUXWQHLZutPAnuuLL4emlzyu
X-Gm-Gg: ASbGnctR7Ejkw4IVpTVCKJpW0E6GC2USv7LkeKSgLL8Q4/Ire65PPTN2Sx+eOOcHWxe
	qOyxTpjB8av2jkz8fUKsk8Bwzh6bs2dfaQLFMZxMtht/71H5bFee4hJNtcSuA24/jp8KdPSwCK7
	GeV3Bu5xiXFiSO5sEL9ICrVafUNDqIF5s/QrX2asJMlu/0I72bBC77Rmo9XJWDuN/W8rQ3FbrUn
	Pt0xXZT9OS/Cxd14Ni9yySlCXs8Ak23u2i9niVoWW+WwEj+b80=
X-Google-Smtp-Source: AGHT+IG552Hz7VZMabAs7CS1PCmjhyraQQ6h9sgm0pfSuZNZd3VvlCerNDrtfJ51tlRYy8MyPezrMQ==
X-Received: by 2002:a17:902:f64b:b0:216:2a36:5b2e with SMTP id d9443c01a7336-218d722410amr25350645ad.32.1734497935316;
        Tue, 17 Dec 2024 20:58:55 -0800 (PST)
Received: from debian.. ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1ea02dcsm67164735ad.165.2024.12.17.20.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 20:58:54 -0800 (PST)
From: Renjaya Raga Zenta <ragazenta@gmail.com>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org,
	martin@geanix.com,
	matthias.schiffer@ew.tq-group.com,
	msp@baylibre.com
Subject: Re: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
Date: Wed, 18 Dec 2024 11:58:53 +0700
Message-ID: <20241218045853.88388-1-ragazenta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210-rational-abiding-guppy-0160a3-mkl@pengutronix.de>
References: <20241210-rational-abiding-guppy-0160a3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10.12.2024 21:37:19, Marc Kleine-Budde wrote:
> Applied to linux-can.

Hi Marc,

I can't find this patch in linux-can main [1] or testing [2]. Did
you apply it to somewhere else?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/drivers/net/can/m_can?h=main
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/drivers/net/can/m_can?h=testing

Regards,
Renjaya

