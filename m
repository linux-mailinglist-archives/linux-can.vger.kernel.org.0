Return-Path: <linux-can+bounces-1505-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729697970A
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79775B216F1
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182AC1C6890;
	Sun, 15 Sep 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIO7Y0lx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB71E4BE;
	Sun, 15 Sep 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409731; cv=none; b=sY4V2r8f67/gjzs/jaK2TtQ/ojQca2VeyE5UIq+V69A/pzWfnmMb1vtwC60iYOTzTK+wH4rT69faA/fNUGZLDAEp3EUkQHoitfHMTF7ONL/kut7X99uMkOkw+eM8EgwVs7rjjDloe7BrFN+vn7aiNwHrDQsCtsn8pSzkqMiNAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409731; c=relaxed/simple;
	bh=Y8g+1lUqRX0W1fC3xTwgMjUUi1WKPVHiJa71JZRTFqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bq6PLvtQGP99UAU+W8yVm9x54dxOT6jPMdJz6yZu4jmeMxLqTdt9y3+KpiYokA/rfeejh19WI6OEZVbSdlWhDh1HXHxGNv4cBCGVZlSvzyMkYBUcwaWtoUop5NnLsdYqWOnHnJIaa7PVTc8Ixg7CuRrBbdGoF3IwjxcdWrrw7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIO7Y0lx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53659867cbdso3081433e87.3;
        Sun, 15 Sep 2024 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726409727; x=1727014527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxWPUFOwZqCM5Kx8t3Y3dLzbYEJ4j8qYd64u0k3UgAI=;
        b=GIO7Y0lxyN6JitlI1CzJhw/BIhjqzWF0t4E9G8/kbcpmpvGE/TZ3+MvTHkm82oeEUV
         E9bF0Fi11JSKADd2UEMVr/xztAA7m3M34OXkeF5utZWXW5onXPFJnEy0B1+NioJZNeuP
         QhDYEoaKlu8mYHZAyTFDOuStR6Q1eiY2vgzD3D0MmjK+9F2pyvDQ4AIM3J0GPe4XuA5x
         sCzStbmbNZ+OtlLaiJZOMVZ07NY3NNIkk4YA2KgIzliHB7yYosCgjY+AL/GYmKLA0Uft
         PIFFX8ZAhpipkOxdUESxqs2pBrl3ky3BHVPnR2bG/xFVUWrdVqXdiXoDsbRLgBoGxNzV
         zqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409727; x=1727014527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxWPUFOwZqCM5Kx8t3Y3dLzbYEJ4j8qYd64u0k3UgAI=;
        b=FehMUxoA7YTKUe5jtgSlnHTVnUwci+8ynmHeowEQnnqMDuXJSKRzCI0MuBx4HMSHO4
         kFT46Y8IgQCBxHn4A1NxvZd7I3a3zMSFQn1x1UPSKH//KIJ8VqKqA82oeysMz/FQjXGA
         cn2AviCOCTv+0qEo42cpXzrejE3oOHbe5KRsUqo3nGpSQlmu0GP7zFNf8m3PniKTMZnE
         e4YeJJgKW3yYnk2DuIH7l5CTKFFE4JItDyLxwx3UVw8bnCdJPSNiRilxs8dz170+O6kh
         7glZR9d9G20mOzYuc/jiGlo8u67zZAE/PuCDvVDKgJsX3A5vwKRQ47exYf6B4tjJgJy7
         PgYw==
X-Forwarded-Encrypted: i=1; AJvYcCUK47CBl+kbH+aejn5tmV43nBKy35mZuGlwMjHUDtMEQWKCqMwG5Y0WyyhkhiCtsW9m8/MPeTpzzWZ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSp19xmGkyqYbfh+MWg2GVHYZCa2ELDToMPrSfnEAWEmTD7tI
	9DGwaos0wMTkYM0qqK5N1fBk6MzuP6IcdH0O+/qHn/wN7JyZQSOZ
X-Google-Smtp-Source: AGHT+IEJ+njp+cA+9w7K2cq2tMEHrF7kJ65e7YQB/kgbpx48q1bhw0G7hdbCaMTdy8mggLDHBQM9mA==
X-Received: by 2002:a05:6512:238b:b0:52e:932d:88ab with SMTP id 2adb3069b0e04-5367fee25a8mr6036044e87.23.1726409726478;
        Sun, 15 Sep 2024 07:15:26 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-5-228-117-203.ip.moscow.rt.ru. [5.228.117.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968d1sm565255e87.175.2024.09.15.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:15:26 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ilya Orazov <ilordash02@gmail.com>
Subject: [PATCH v4 0/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip
Date: Sun, 15 Sep 2024 17:13:39 +0300
Message-Id: <20240915141340.2802953-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

In this v4, I addressed Krzysztof's comments and incorporated the changelog
and tag received from Conor.

v3:
https://lore.kernel.org/r/20240808191735.1483572-1-ilordash02@gmail.com/

v2:
https://lore.kernel.org/r/20240807180210.1334724-1-ilordash02@gmail.com/

v1:
https://lore.kernel.org/r/20240718210322.37492-1-ilordash02@gmail.com/

First of all, I want to apologize for the silly mistakes in my patch
preparation. I wasn’t aware of the need to include the changelog and
received tags in new versions. This is my first patch in the kernel,
and I am very excited about it. I am eager to gain experience in working
on FOSS.

I greatly appreciate all your feedback, and I will do my best to address
and fix any issues.

Ilya Orazov (1):
  dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)


base-commit: 872cf28b8df9c5c3a1e71a88ee750df7c2513971
-- 
2.34.1


