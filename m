Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17D482CC9
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfHFH3m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 03:29:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43447 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbfHFH3m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 03:29:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so60205237lfm.10
        for <linux-can@vger.kernel.org>; Tue, 06 Aug 2019 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4EbuuDARnw7itWTUxD3epNYEJpxcqOag+tJOiaNO7os=;
        b=YQSG+YB6xtyOv9f4JWBmHcUMyqYFq+ID77SIeoCAgkPZRltuvOkZW08tvshFvP0Vh8
         1dijtxth7gMGja7j99tDecGszlFSuRqYaWE6Lk31wIqhf6/6Uz69d25eXdeOmUPWVsZJ
         JZ024uytQ6Q9McwSgOujXe9paybmq8H3DHhRNRaiVXwwJJ0WrLkBj0+Httf+vp679jTn
         JYKD5vnTTrBO/3UwKpm/3zY8p5yvLtGwC/EL3a/ksrseFk97Z/2O9QWrSj39Xxzhf6+h
         W+QsPbkOpTAXokQWrPGvYCMnbfDu2AvmOS2q6QZGI5o+UHGuwRd0SM+n86PtUYaXcgz4
         ac2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4EbuuDARnw7itWTUxD3epNYEJpxcqOag+tJOiaNO7os=;
        b=PxQOi26TjdbYMZ3WqsA43sQysK7Ytb1WEAKlWJwR9n2B7jjfX7MHfvRS6Y5DoG4E2q
         4hnWshFs5ljJSYgwMPOOwCeHrbccyktCmcza/y0oHGb/zwzIoq2AXNvZbxkIRvwxlU6U
         oqRIPx/P2db3Iy3TPjTQsGwzge4LOR7x/ujaJ/ZV3Bchntpj1AL9+RFXsLbB7PgYf/kG
         bcNT/XvpsLsloOE1lE6zDET5uj1bvuhMV8vEmSG1pEfZEN981Sf9UXvE6ZxNvBiUMsrK
         GdIvhM7s/bM1NG0coiuoEcxXEKG8K+jD1/KHr3OxMo/xO5gbR5vO7LZunaDsVCoLa8mS
         TZ2g==
X-Gm-Message-State: APjAAAXRIDZmFyhqEqNVZCzJQYpZmHeH0krFN6jyUNpo7umuieK8L+eP
        wiXdDl1UZXn5hdkqHbqCDn4If0T+1/xo0g==
X-Google-Smtp-Source: APXvYqzvU5SJegZ+zPNoyJR94AJYG+6sm3t2e3UBE4u6u53kLcoYFmzqlykp2trTyaNcehfjRHJMbw==
X-Received: by 2002:ac2:563c:: with SMTP id b28mr1348603lff.93.1565076579953;
        Tue, 06 Aug 2019 00:29:39 -0700 (PDT)
Received: from [10.0.3.110] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id p12sm17691207lja.23.2019.08.06.00.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 00:29:39 -0700 (PDT)
Subject: [PATCH][next] can: kvaser_pciefd: remove unnecessary code when
 setting pwm duty cycle to zero
To:     linux-can@vger.kernel.org
Cc:     Henning Colliander <henning.colliander@evidente.se>
References: <20190725112509.1075-1-colin.king@canonical.com>
 <954ea3c6-3a2d-ee4e-c4c8-a49358d569b6@pengutronix.de>
 <34bd981c-0bc1-6eba-9663-f8e8ced2f72e@pengutronix.de>
 <db550f33-fac6-5e2b-c623-3587976e2d51@kvaser.com>
 <c45f56e6-9448-7023-8eca-703cb1c5050e@kvaser.com>
 <20686c0c-9b34-8bf1-16c1-8a2c85b6b41f@pengutronix.de>
From:   Christer Beskow <chbe@kvaser.com>
Message-ID: <90e8cb72-b4e6-4136-cf29-85f099b22e4d@kvaser.com>
Date:   Tue, 6 Aug 2019 09:29:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20686c0c-9b34-8bf1-16c1-8a2c85b6b41f@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Christer Beskow <chbe@kvaser.com>

To set the duty cycle to zero (i.e. pwm_stop), the trigger
value shall be equal to the top value.

This is achieved by reading the value of the top bit field from the pwm
register and then writing back this value to the trigger and top bit
fields.

Signed-off-by: Christer Beskow <chbe@kvaser.com>
---
  drivers/net/can/kvaser_pciefd.c | 10 +++-------
  1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c 
b/drivers/net/can/kvaser_pciefd.c
index 3af747cbbde4..ccba42c544a3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -643,7 +643,7 @@ static int kvaser_pciefd_bus_on(struct 
kvaser_pciefd_can *can)

  static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
  {
-       int top, trigger;
+       u8 top;
         u32 pwm_ctrl;
         unsigned long irq;

@@ -651,12 +651,8 @@ static void kvaser_pciefd_pwm_stop(struct 
kvaser_pciefd_can *can)
         pwm_ctrl = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
         top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;

-       trigger = (100 * top + 50) / 100;
-       if (trigger < 0)
-               trigger = 0;
-
-       pwm_ctrl = trigger & 0xff;
-       pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
+       /* Set duty cycle to zero */
+       pwm_ctrl |= top;
         iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
         spin_unlock_irqrestore(&can->lock, irq);
  }
--
2.17.1
