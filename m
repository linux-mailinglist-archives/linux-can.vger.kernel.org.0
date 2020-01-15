Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6764E13BA9A
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2020 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAOIAn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 15 Jan 2020 03:00:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37954 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgAOIAn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Jan 2020 03:00:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so16648873wmc.3
        for <linux-can@vger.kernel.org>; Wed, 15 Jan 2020 00:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GYF/DnlQgs0gWW5ovHy/i9c/eiB+rqjkrsxQJeg0VgE=;
        b=OSL13EnCr58+/Jy2CAY7JUMNaer6GjpBYGtcO8Lm6VXlpX7/sjRVrcEpHJrWt3MXao
         sOMFij5RVNC/vB2rBhf2PpSRyBxSMMrVXFj/ZuClHUlB4zeP1xvKnpBMJjZC896upMDx
         pdMzyIjLqI6TXr0D0N+3qK7bLO6rmMZMg3o2Ovle3wcyv6xSRPfnKDapqr2oaN79UNuR
         lo15fKsiOQxDn8My+q+RIDFTY9EPZKyvD/DS6s2dTp5oREvoBEelzwmPJMimNa345pSS
         C4ytCDLYb5xpLNle2SWtZzbMuemq3sDt77k7Y2QN63t/r5djh4IpdruTiVp5w58ZOp82
         GX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GYF/DnlQgs0gWW5ovHy/i9c/eiB+rqjkrsxQJeg0VgE=;
        b=RRFffv1tpMoouweWhiRRF/pBbfk8QeOgn8aFrl4EK0ZeR3sgZ4Zfu8jOa/OadnuZNn
         r3HFsMsa7KT/rxwTaNmpHhH9hXaIcQOr0NGDxrgGGKl8teCcCDLQrRemItyvHlTjaeEO
         lpSBqhpMHO+9F4/vbGRKlGgfxtgLh6DnqAKy3LttS12qsGjM6lVkvErMgpg+8jcLaD23
         wOTY0juMRE0m0NhkmDh966gHwIyD7IYvyqX9zUsaAWVWnLfkOHVg0EDA78Ar23Vws4Ez
         i8pVhNuG7LYdAud8e76EM5+kZ/hoy5laZVxQvpymn+TJ2tNdqQuB2fdHCMOUF1Tj4W9q
         izeA==
X-Gm-Message-State: APjAAAX5bHZQU6S5eKof3ZzIY/I1j/nCNubeiu9oPhSE+V6Y/CUge79H
        CZ3X8lzBMM6zkC6aORacCkxqMg==
X-Google-Smtp-Source: APXvYqxVBHePDZFSLFy/b/HLtH4cLhZKLLeFdGF56PzZlj4pOAw+avsLwlunjnJ0XyKdMeObyl6u5A==
X-Received: by 2002:a1c:3dd5:: with SMTP id k204mr31244611wma.92.1579075241550;
        Wed, 15 Jan 2020 00:00:41 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id w13sm23148601wru.38.2020.01.15.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:00:40 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:00:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, wg@grandegger.com,
        mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 10/17] dt-bindings: atmel-smc: add
 microchip,sam9x60-smc
Message-ID: <20200115080053.GC325@dell>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
 <20200114095538.GJ3137@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114095538.GJ3137@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 14 Jan 2020, Alexandre Belloni wrote:

> On 10/01/2020 18:18:02+0200, Claudiu Beznea wrote:
> > Add microchip,sam9x60-smc to DT bindings documentation.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
> >  1 file changed, 1 insertion(+)
> Applied, thanks.

Remind me why you are applying this patch please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
