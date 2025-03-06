Return-Path: <linux-can+bounces-2988-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30CA548E4
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EE31894E45
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DBA20A5D5;
	Thu,  6 Mar 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iptpuS4D"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B2204699
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259762; cv=none; b=TiZKKDdeFXEQrfiMSfqbS7ddz5FZl5bTLMpb5/WwwwcEPeYJd0/CQsyARhytPvIPQt1kC9JMEpO6DkrI2mUXk8FyG9P97Wp4teFlZXU/zLTnvBA3cR9KzvTYgnJliT5JerUeI2H+4BtoiG6DoMLW7n+y48fj0WUQB/iGd38Jk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259762; c=relaxed/simple;
	bh=oOMPzH4LdaksoCbIxuNdPeXLXt+dMP0qmI97tgFNQuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljhUzkg74fz6QMdh5ZzS3fOUrIZU0rvfb1dZk2evvuu47K0gtE6IJyZpnNqArWh5oLnqBcEQFYgh7JXV7uzcrBjlO9lSwhBkpwFdBXxMAv653UTbG2Fr1vHc7PnkWdGnkCJ7SKbD3qOXUy/Gg1h4utb6H52xjJ4Vlo7trdUm0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iptpuS4D; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e535d16180so701977a12.1
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259757; x=1741864557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AD4+541pvr0AchIZJuu3S8UqRaWJvIBsW2zPu2lnUwQ=;
        b=iptpuS4DKDG2TSqLVH3IxvemS64ByotsODplLL8XyVHoYvkwzAAZtojPIvELItiimP
         ZcBKQBgRAjr842IeoxS/sW1FAupS7y120kDn9S2SM6ARRYR2sPHAwkthvuuRHyEAvfsb
         0ikDsEnmCvtQYl9swarygDdGaYiwXRW8ybC7KKlMAIgM9b4+3NXgHNSGClrtRz0uDzhN
         mg8YG8aJuA/qfLF/Hwlqot/Xahu+fgEAKcAIdv/BtnRUlAybbkmGUuOvoBVGJ5ypXRZT
         ljuk1UapcZ/QrcbiQBZnYFdDyUI4afooOBwL7BnaDaazg7Vi/ESx9EN6uyBW++ibGnGk
         b1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259757; x=1741864557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AD4+541pvr0AchIZJuu3S8UqRaWJvIBsW2zPu2lnUwQ=;
        b=l/F6oynwJrtzk8PeQzmi+XiSGZt6FqLzDv1vs87cHbUsyg81WAITOgtkOP9KlVgzV9
         wcDLBbH6MyVlatKPKPXOTK522CW1cQXLWW4t7y/FRkYeASDQWJwnz2FxETUGe91Gg67E
         BZokOn5S5l7kS52zbnirXWFMXfieMxYR87qhhlG+fBmaysN58eb4DDbFuwZdLTlygDU9
         8v3THPurRLjl2c/KM7y69QqGDawi66916BtWkC7sVQNzuicZdUSyV0oIWNaynBXN/1Y1
         BxXb+B0KlP8bZNzRpKuGP0zoP4g9crumUl8si4hhVCNffgxww8Bbqi4Rek0QXIICGj1t
         bGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXptGil8IkQrOsypih5iuzFqoX/I8lDw081aSgtvcdEscekLsNgNGhshqKnmn+BGysdnFDvv/jXUME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyWdgwQSCwfQhEVZWqTyU4PiOktpwUGMGwb9Tkz5AX6/VrA88
	Lbk1xf8wVnT0LmOkyW2g78BIi4UPF/Y8udJ8sOhSOqf5mHtWpYlNwr6wzGpUp9w=
X-Gm-Gg: ASbGncuz05PU5eULih9RW3A0FAF4eUyDhy09mudyBkxNlQ5NvxfDA91XflvwGKhg632
	AfhWmG/vOW7nHxh6PtlxUVhEe28I64vYMgUyNW+d786u0PRY/PvUIcyMwS4SueJm4EfDJmYKi3h
	o8BOlnhufycUemTJY/Ui/i7hwiiNaO2rsO282SZZHC6w0+slqsQfVpshfxpjX+NocFiUhTakEYw
	l/y28REH7vT+cWiZOYSLBb9bW601LWcJeRH21grwpE0mkGFas1g0bpYVnlI+1QqtvmzKGNZI7nf
	OBIhJaZvqo/sFQ1c/biQ+9ma9ceg0jRVFjgOr6zVuA==
X-Google-Smtp-Source: AGHT+IGakkDRo68IlrFBMJ0rTm6jyQBbovkArr+qu4dyz6/GSFx4+sETc8W/v1I3QTmizbzR3UPY5g==
X-Received: by 2002:a05:6402:2712:b0:5de:dfde:c8b1 with SMTP id 4fb4d7f45d1cf-5e59f394cc4mr16158716a12.4.1741259757166;
        Thu, 06 Mar 2025 03:15:57 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c766a194sm775352a12.59.2025.03.06.03.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:15:56 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:39 +0100
Subject: [PATCH v5 01/13] firmware: ti_sci: Support transfers without
 response
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-1-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=msp@baylibre.com;
 h=from:subject:message-id; bh=oOMPzH4LdaksoCbIxuNdPeXLXt+dMP0qmI97tgFNQuY=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNq9bO/exe8L37NsnKybG2lxeyBZxyt1PWpP5WPyCw
 sBnG1lXdpSyMIhxMMiKKbLc/bDwXZ3c9QUR6x45wsxhZQIZwsDFKQATsYhkZJj917mXS//svgkX
 eSRMP2mwhD8SMjryb9pKueW1zZxa728z/OH+qnz2WYBp1+SuFXzcET63pbX/H5ga+r7FvmRlhv1
 ZIXYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Check the header flags if an response is expected or not. If it is not
expected skip the receive part of ti_sci_do_xfer(). This prepares the
driver for one-way messages as prepare_sleep for Partial-IO.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 806a975fff22ae00ecb88587b2c47ba172120bc2..09d11e75e14e6a6a82f6d99ab1852c142aeb7e5f 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
+	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
+						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
@@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (system_state <= SYSTEM_RUNNING) {
+	if (response_expected && system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
-	} else {
+	} else if (response_expected) {
 		/*
 		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.

-- 
2.47.2


