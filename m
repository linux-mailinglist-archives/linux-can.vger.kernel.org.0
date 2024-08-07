Return-Path: <linux-can+bounces-1169-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFF94AF64
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 20:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0740DB20F2A
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD513D8A2;
	Wed,  7 Aug 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBbM7czx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A21F937;
	Wed,  7 Aug 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054202; cv=none; b=mwG00lZDTKoMnfK3HyRqBdYTsOJggnNfhw892SriMZrdpmibofHjRYNKz4gOEnl3+oPmLN8Z3r2uOSLL4bO8Y9dFbiCPkOOm9UT752CC9uyGUMYL/Um9LL5kt55dMDJiZEm88WNu7D7s4hI5bbEyrqdOElSZ7Z1z6Zr2fao4b3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054202; c=relaxed/simple;
	bh=mJnxtt8f/lxiqCTBr92mX7r/ZI3VYEv5zS96yOF/J2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDu+pxYpdX3AhIAsc9aQS+/qFBtSIQ2h0ITzMBeYts0SXKSdRHarhwiX509UFLixJeN39SC0PdC2nV7G3cb+TZ6tOZMF72j97nNC5ASKx4F3qxPqh5vXtrZl+f3TPqW/N9ZaYBIs8XF0UaZ9W27sdKuwLWaO3gZx1Al+IbI4ZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBbM7czx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so122543e87.1;
        Wed, 07 Aug 2024 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054199; x=1723658999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvQwopylpTcNNrDojafDg5hAThyB/Nm6dXGr8JGpA+A=;
        b=MBbM7czxGnNehnQA1ODxmwJJa7HJ8mbSQbwSpO9QOHDpeyi8OJdaYNDEKGMdcFPltY
         LiLV2zzE8bGVG4axzjJzQ1asWcUIMFlDQKsFgu0ubpHOPC13PELH4Ay7mCIduoWCgcf1
         kC7YGGayNFPWVULhZ9S21QErm6P1HtVWfwdAErJfU9SDRQl0q6mCEiJpvKNOfZihx0tC
         axrY37XxpeUDdRYw09UlkDUlqy8aaPpfJU6rXoyyh9C8J8JV9goHUpMsq58a50n99O3M
         SXP3i4Sy+XIsqeVhgrAgXvF+TkgaKbGec/3sjsts9/qcMbncEGZa2Mdg09QLyBjjtgsM
         xVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054199; x=1723658999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvQwopylpTcNNrDojafDg5hAThyB/Nm6dXGr8JGpA+A=;
        b=hf+E2VN4jT6WBhFaIbXF/XN3ma7DAaxb4FgxyqKkF7cWaI3YXABrz7NWjUmpuvbmJ7
         Xv5zvuM5uZtVOOqleZFn9S6Qh5lWRxN8my6IZdqjcHItUfpHkgwtBXG+Co7VqE4dKpr7
         JYHlMOnHIE/5AVoZYg47hJmkhOSQQ/V8N5tzfmFX7W24HYcMVfFXpJ03dTiX5BImeHZ7
         2lKLg5muBDJyNDC3GLo6gESsfOCCUeEzeI/Ybsm7T3Nc2e7B5VLFiLYk79QlFcuhkLVt
         lHGg3rb2RsOTivM5/sM+d8eLWn3ydAvLZLd5L5FinhLuoYFs2fM4VVZpugHQf8WHUBaC
         WhEA==
X-Forwarded-Encrypted: i=1; AJvYcCWtTazIvauZA6WuifK+Y8bxakDnfcC7ddO6rMgmfk3newlbsMeqorhXGrAOxbpBeuTmR6B9i0ANIg04Sy54cXBWLS2Ip0sWd839Kg==
X-Gm-Message-State: AOJu0YzdoQdnIzYFMdP5gQsGBm9l7w6eAHZjGhSBDnB5zqMkY2YNsRYq
	udfBp6rfmcfF8VjbT0YD4rehPGmhwpj8L0qroOeZiAgUw8HVJJpn
X-Google-Smtp-Source: AGHT+IE1p0KvtyXH4tArk9IeeKyVKqob1VTMUZulp1j/uYXdIC9x8IkR+3jeqgl+4TIMi5I0M9B3Dw==
X-Received: by 2002:a05:6512:1243:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-530bb3b189cmr10442926e87.58.1723054198397;
        Wed, 07 Aug 2024 11:09:58 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2ea2sm328995e87.36.2024.08.07.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:09:58 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ilya Orazov <ilordash02@gmail.com>
Subject: [PATCH v2 0/1] phy: Add support for Microchip ATA6561 CAN Transceiver
Date: Wed,  7 Aug 2024 21:09:55 +0300
Message-Id: <20240807180956.1341332-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807180210.1334724-2-ilordash02@gmail.com>
References: <20240807180210.1334724-2-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm sorry, I missed mistake in commit message, fixed it.

Ilya Orazov (1):
  dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.34.1


