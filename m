Return-Path: <linux-can+bounces-1167-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFFF94AF53
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EC41C2129C
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785313B58E;
	Wed,  7 Aug 2024 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJCL1J8D"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F565473E;
	Wed,  7 Aug 2024 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053736; cv=none; b=qmSLeuVg9/YmFphPkPHncPzR8qQruzgoeyb7I6+oanp6CxURpQfj9rsAKeYdYypkjrloe3T/eNdeJVllFuOhXVsDYBJTdsb9E+DuWEh8gHgRZMYttZCAUmlEqXhftyPxZ3HNvBtYtUXhmzPGCxu/+VUFGeNelJKrmkFBofwiU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053736; c=relaxed/simple;
	bh=Esnjti3QfSVKt62AOhiCTq+vWYBQZ3XztcpaynOs8SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju0eud8IL6hrFgTmaAYA25XH8zNtrjgMgA//EiXo5IS+2Bo2VRqvmyLdIlXO6A0NQJfRjKZgcJptqkG/JwTFFHE5nkBnTwGwTvgMyxx12Vj6rvShBi/OWnqHU6eRt2kIx0EtvED5f3jUX10B0DGjdEQrzwenjFAJonoV0GNFfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJCL1J8D; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f042c15e3so113002e87.0;
        Wed, 07 Aug 2024 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053732; x=1723658532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2A9g7BZ+7ZlUH3giGRSRTBy0XcWPD03E9Hqr6OCk7w=;
        b=dJCL1J8DljKA9bmgV0LsB4rBOpA+mrX2LrgqFVEfVU0WxjlqdfMFIK4XUd6nlCxJ3P
         tTnJR08b0hLZGMptE5Vu86tpqpx0mDS8PeDdwnN8Yt7Oi+eg9KjC4nmK47LNfL7sd759
         kZC9tldKZcSBae/kPp0ttIwc4sEbZ+4pxsGbkF7PKVjLJtrQZvig1kTe4b/wuPxOVN7W
         JhwHrExvOUviyvEqfTKNqq7FLPPv9U7Y3rl/BJBc5iGo+K9vG8WGuQirYFGeVF3RQIH7
         AUnHeIoWmjZxWFG+a90ITDYXJpY8OEttTjTjVjEXZwFuWcrAP8ZQ/mDQr0U7O6kdG7nH
         1htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053732; x=1723658532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2A9g7BZ+7ZlUH3giGRSRTBy0XcWPD03E9Hqr6OCk7w=;
        b=OZKXiep2XhUdBETdv16itNZ3PAaVBLpgTDffzFUssDoH7vjSkghNW8l/ibrpGYkU7f
         1lzgkpO6j6l/VsvwniN6cPEClj9vcCga2BdToUuGBMzEG6AcU/Lhld2kxFaAdCmJ7sJl
         qqPTufeLQI/co8WIROIAb5QBvaWsy3rguoMiodJIUV3FSFQYlUC085FeV4mxR0lapva7
         V51AEuc2i7Qb8RucWfm7pnE906zCrJeE/8ZzVI8+MPCmhuGi/rOV5jAoBX7mQUDswgM0
         MKhiuSLe6AGi7OAB70uXsEFQwc9hjKMh3R5qUcDzDjaxmno0A7Mod5nYKDigPX1SKcfa
         4zKg==
X-Forwarded-Encrypted: i=1; AJvYcCX2nNqQZgWlUCEcn3zV+O1MVj+GycLbl51vbr7oLil0IKQA66uGFGdRFwiI9kCQ+tHMzq0TgV4hj8oo@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwbJn1EmnorksJtcKb9kBwc52NbUWrmZ+SLdLv3eXRyKne7qM
	3HiNCo1/dbLafyUCzBcIRTYMROAKhrAo8YW+SR+r1uwZGoMEkjSo
X-Google-Smtp-Source: AGHT+IE2BAMAPFwwogEC7hzieoxMnxVgSx0NiFFKKZ6GnjLEufMNH6xnC18sqOZH3VFa6Qgw9qtuQA==
X-Received: by 2002:a05:6512:2385:b0:52f:336:e846 with SMTP id 2adb3069b0e04-530dd9051acmr879884e87.14.1723053731989;
        Wed, 07 Aug 2024 11:02:11 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2e18sm332454e87.34.2024.08.07.11.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:02:11 -0700 (PDT)
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
Date: Wed,  7 Aug 2024 21:02:09 +0300
Message-Id: <20240807180210.1334724-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805-fruit-chip-cf08a0e166a3@spud>
References: <20240805-fruit-chip-cf08a0e166a3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ok, I changed patch to allow ti,tcan1042 as fallback compatible.

Ilya Orazov (1):
  dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.34.1


