Return-Path: <linux-can+bounces-5500-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A3C6F2A5
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C73BA4EA2F2
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FAF363C5A;
	Wed, 19 Nov 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bZASKZdk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03D3559F8
	for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560235; cv=none; b=dvZwhK6kAvReiiRqFyMVtBDVwlC2LyBGEUi1u5hKBJb9Vv9DV0tA7STdNnCvdyGc4SvVulymsNgqSQCX/Kint6jNEUXKnDyY2CQyZshdTgv1gAlscq+Ishf7X3PJXGq7ygLoOk9D1M1N7uG7XtQIE60uYHAe9JVJ/BEzJPGj+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560235; c=relaxed/simple;
	bh=g0A1oOjCo8aNYadwxhIdHt+1wsv4bdKMJGzDp8pJbCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eaWIs0cg/tND4vBjmRXBTSK4ggHJFrS3+w+tOVz9GNW15airtYUSRjvI9dXtlApoitS30YOBuAGnB7bIiZKKyOi/Sbos697nJ8CQlVVoa3vIEkNUam/xTKHCOYFHiiVGSQJ0om9qND3NBcNFEiyCIV8HeFZeBiVU81bHTO/d15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bZASKZdk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so11464301a12.0
        for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 05:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763560230; x=1764165030; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSuvBH/q1X+ha4gPADohZjlga07A5eLYHbT8ry/OBVE=;
        b=bZASKZdklzu29jO39t4zDx3ZBTBBV3Ga8m0E5kEje0zOHqMAFvWDNx1vS3nLeEZE+U
         DbFXy2DNDdHW0sLylWK8JVYRpclFYtW6d7C4j7hXDc15UvDmy5pVIx7Fye2Q5U7E367b
         sCbP97ZDcgddLDheBZhFEu6EWyP/CLlVUJu41HDuolYKaCvX6XlTm5LRDGHiLbVQO4FN
         GfQu6DDcsDj2rYMMhq3scgXPFPmDTWc6qjerK5ErU00TuwQ0BKZRmGUzTOb/d8fNo44g
         p3Yx3vJt1sTsrMvuaeOUk090Jq8AHdlYbLwe0wqcS9eU4P0qw+CZCIjn9meYNOKRY8k1
         P7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560230; x=1764165030;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSuvBH/q1X+ha4gPADohZjlga07A5eLYHbT8ry/OBVE=;
        b=nZruHeKeWC+fQb5c82LXIYMnLfE7+/R1qCB+/8r7unb/k0RM9TBQrTLwAtbnL9c+vu
         nWScWWDcEUjkyvu3LELQI+bk7T23A3N4dDr1PzpOzVy5uH0sdSZ2jzW7KqDBY1VluU6s
         +sMR0HbpAltaHEzvgWjQ4ICXQTFi2ZH7hifQr02aiEtOychTnAeJptm392dlKsfT8b/F
         traGq8EsI4ppCYUyAbTItJf5wjtLJ8J1CjquZY+ZRcMf2VN6SYZxyJGE3nae1LuxfZPh
         KaIGytm007EMyysAEBO0e7OmyWWJIrRu59wMW3llR0o9H1Yb5EwjXAI+AjeebIIHbIep
         aypQ==
X-Gm-Message-State: AOJu0YyJAhAVdCeoecQYCvAIqupymQKvteddNd0Cl/t9Y1++vU/2egiU
	dcOP1yrp37cPEDQYGuw7uRla0A8EjWswt6ZiqFzxp61q+g98muZzostLEq3yvSxRyWc=
X-Gm-Gg: ASbGncs32uqdL6ghiR7Atk8412dFZOE03nWyjSnhc2eQacfus3SihjAgG5EJMSOKxxL
	h6zQtboY14ybP4c4psKvMsBcgzXLRLypbUcPxiq2H7djUx+5uQZpZnrqIKopRb1H1qLxYeB4+v/
	PBliXEdUvOXrZwTgR6XXSmWbfTqIwUUNwLJmrQ1Zku8qxtIOc74r3LoDc5TDUVhM1bOoXn1Buz1
	ENQe+g3oBfV1gvqgIdGEtL2mG5K/qio18pxqiO6YS//CQ6hMwjzlpg7eOzeAhfRFjMI8advMohJ
	cJ/kQvkOo8JUP5OUBzS/c+4nAuhm1ULG+xFcQlRgN0dfqp1pUjrbMx2iMUHhwpMdEa3WpQWfyN0
	lkswJV6jFKkyZAfHfOVql6OP4y37vIjsn8kMbJkeV1WVPDzeLPde5BhrbDsPljT+/F5AvWfqZEJ
	shzYWvwR5KTjMoGSP48Q==
X-Google-Smtp-Source: AGHT+IEXWFU1HVT9ZlNg1U2KW49IA43KXHhGuwY6VcZ+h3T50g+PEU3kKnXR//yGGwTJ/aZhBju8fg==
X-Received: by 2002:a17:907:720f:b0:b73:5f5e:574d with SMTP id a640c23a62f3a-b7637a47ee8mr273090466b.59.1763560228242;
        Wed, 19 Nov 2025 05:50:28 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b734fed9e9fsm1614859466b.69.2025.11.19.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:50:27 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/2] MAINTAINERS: Add myself as m_can maintainer
Date: Wed, 19 Nov 2025 14:50:01 +0100
Message-Id: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAArLHWkC/42NQQ6CMBBFr0Jm7Rg6tFpdeQ/DAuogkwglLakaw
 t0tnMDl+/n//QUiB+EI12KBwEmi+DEDHQpwfTM+GeWRGagko0oinP0kDgfXjLj1+c0B0wmVRWN
 J63PH1lEFeT8F7uSzu+915l7i7MN3v0pqS/+xJoUKrTXsDOtKX6pb23xf0gY+Oj9Ava7rD4k2M
 bXFAAAA
X-Change-ID: 20251022-topic-mcan-reviewer-v6-18-582447fe8c23
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=msp@baylibre.com;
 h=from:subject:message-id; bh=g0A1oOjCo8aNYadwxhIdHt+1wsv4bdKMJGzDp8pJbCY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzZ04I2YvozLbn3/Eq+fC1k0kE2re3L1mtky65o3cAZf
 s+n3OpkRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzE9STD/5xWm+3FZ+f5vJy6
 6d6Xm0eX6v1IZ9KYw5GbclT5oZHOjbWMDHM2xn9wucY64/opg00mN5qSRV26pVbtdlOJSrqbHJM
 2lRsA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

these two patches are updating the m_can maintainer entry, replacing the
current maintainer and simplifying the files mentioned.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Changes in v2:
- Add myself as maintainer instead of reviewer
- Add patch to use the m_can directory for the MAINTAINERS entry
- Link to v1: https://lore.kernel.org/r/20251022-topic-mcan-reviewer-v6-18-v1-1-885ec5e43493@baylibre.com

---
Markus Schneider-Pargmann (2):
      MAINTAINERS: Add myself as m_can maintainer
      MAINTAINERS: Simplify m_can section

 MAINTAINERS | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251022-topic-mcan-reviewer-v6-18-582447fe8c23

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


