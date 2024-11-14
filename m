Return-Path: <linux-can+bounces-2033-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E14D9C8590
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A80B2AEF0
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65A1DF24B;
	Thu, 14 Nov 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbvk/xIz"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E41DD525
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575041; cv=none; b=kCCiGO7olxu9zNqRWrfHWBh412798co2E9g2t1wlJ2zOjFBz75g1FPK9phbmAiyhENB/jgTfSsleNROU+mSGURYLWeo7NPaYHbLxpAN4ewRF00L6tGfxl14OZA5TMl29ccA7buAsdmUtEhABJ9Sq6lmuH2QEFt1KlmkeuHnPaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575041; c=relaxed/simple;
	bh=zWuRiFchZrNBLXRq0j24MhQKqSTdtNiY9xXXezztt0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tirs1c4P/UynNsEn/8ZkyryNsYdUzI/RTOkt/e6eCJ7jvW1L3zinu8ze0ORcKfP6k+SvUC2A4K12Hy2V5xkx5JuIqV7VT3OxpfeUY2GbhB62Ib9Yz2BhZuNN5deScdVqKCdpdxrKIS2YPFxbdEXjt4HZBthyhjRrtf+3GNvGm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbvk/xIz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so261339f8f.1
        for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731575036; x=1732179836; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yR9tbhF0q7yv18wxqWfZSuY7tMkF/Aly2je5xrlXRw=;
        b=lbvk/xIzFDHpYcENEsDUfX4v6vkLmdEQktMwFkPfPCkStNa5r8g9MwNcT6RmMg27k/
         7H+L3rUf8b9Krh/OIeYSvQREm6Pkgaq4aezNsqGVTPqFRro8GI4u12gg+HvknsIUbBJk
         lm02PXX8kZxd6cXzLMnmUBm7vV3edn90njBiiZ3o8TIShL33W3pFZOUi4kD9BI/z2KpH
         uKPS8S4IKQ20LIS0Sr94GFIsutVA9EsAtwNaC9pA8kyp/F0IJrzJ0mgq/BAOTIpLNnjp
         hHWwirY0Ozbp1IQBpdRqUSQhzwE8YVRkPEQD3GggCFIg+aFFJNvcaylN9xLg4AAUt4Dg
         HRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575036; x=1732179836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yR9tbhF0q7yv18wxqWfZSuY7tMkF/Aly2je5xrlXRw=;
        b=NblMFSmck4JpKp6cRjXJnAJl9kOvMS1wVa8+UjiFPZWRms1Yitfk8lcDvXQSWe0sah
         URzJTLgvxpAXFVJ2V9UySv5r16tFzKUYj1vLWVuOJscyVftajfQMJNnK9rinMXf5rv1d
         3Wzlw9mrcLBWXOwnDjtz5njtdxyApntmI194OME34u2j5gsxtAsEB/NZG4Al+LqsEikh
         NZ2zsHJGs+XgqcDH4JuI1ALl+jSRnsrSE9Fekt9rNGSJ5KFKecVqH5KNnwSkcXSiCG7G
         19mU1ioICmjAQ0hQwebX8BjEMlb5VPJQwF/oxqniLnF6guy1ATL18SGI505YiGcB/BR9
         BLrg==
X-Forwarded-Encrypted: i=1; AJvYcCViEJhRIlnJwWx7vBWZMziRRCpo3g2NzPplXaW0dCO0fDA1Rh6M0aDrwD1PPJVj/lUlFmBi+uRKQrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRGeLJHFII72Fr3P8iJwMYhoSq9m3qZGe0FCdByLMZHm+cGdV
	ZStNdd3nhFT4M32avLdGVr3zk+Ra5mAfIq4T88RCggLKy3LaMNpgzUJ5FFVQrFA=
X-Google-Smtp-Source: AGHT+IF7LePleA2RVAB0zLKwWrjCZlENR6/gtLxK87oI7QxvhdPKjaNrSnuc/bm9zTG3lEGgwAT6DQ==
X-Received: by 2002:a5d:6487:0:b0:37e:f4ae:987d with SMTP id ffacd0b85a97d-381f1872f43mr18512390f8f.29.1731575036374;
        Thu, 14 Nov 2024 01:03:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382207fd632sm82453f8f.44.2024.11.14.01.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:03:55 -0800 (PST)
Date: Thu, 14 Nov 2024 12:03:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code is printing hex values to the &local_txbuf buffer and it's
using the snprintf() function to try prevent buffer overflows.  The
problem is that it's not passing the correct limit to the snprintf()
function so the limit doesn't do anything.  On each iteration we print
two digits so the remaining size should also decrease by two, but
instead it passes the sizeof() the entire buffer each time.

If the frame->len were too long it would result in a buffer overflow.

I've also changed the function from snprintf() to scnprintf().  The
difference between the two functions is that snprintf() returns the number
of bytes which would have been printed if there were space while the
scnprintf() function returns the number of bytes which are actually
printed.

Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 drivers/net/can/can327.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 24af63961030..5c05ebc72318 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -623,16 +623,16 @@ static void can327_handle_prompt(struct can327 *elm)
 			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
 		} else {
 			/* Send a regular CAN data frame */
+			int off = 0;
 			int i;
 
 			for (i = 0; i < frame->len; i++) {
-				snprintf(&local_txbuf[2 * i],
-					 sizeof(local_txbuf), "%02X",
-					 frame->data[i]);
+				off += scnprintf(&local_txbuf[off],
+						 sizeof(local_txbuf) - off,
+						 "%02X", frame->data[i]);
 			}
 
-			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
-				 "\r");
+			scnprintf(&local_txbuf[off], sizeof(local_txbuf) - off, "\r");
 		}
 
 		elm->drop_next_line = 1;
-- 
2.45.2


