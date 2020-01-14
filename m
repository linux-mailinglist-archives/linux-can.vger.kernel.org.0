Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD4139E38
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 01:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANAaE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 19:30:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41266 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgANAaE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 19:30:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so10865154otc.8
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 16:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qSm233hBzLTG9G2DIy5d4ytValKHnVbjxr5pAXtlvA=;
        b=sRKVX3flSttSOxTNqsUs6lJ1E2k84mwBOiAwSr/z9RTKwtiFQdlaoI5L8BOayGDACy
         HbSr+bD29vreuARVBcHx4haR9Gb5qYsNaxBMvbkxbCirJ9DRHPRW08UnES5qtmuq5fjF
         uGXXC0nUbL+wPEJY8wh0wibDQ36Y3nabEcKwTIp08nZwzh8JT087pOlE8uQpVrD5xrMS
         tKrDIIeQw7gnzxJF2GZmEUtmvvT7g7NuW6GGWOtM4VtqQDZ38wUDKWONgEZSzdFY8LJT
         hQaG7ZTnWF3AuBBaE5gVvqZOv+sCdNgEa1aD2xBDVy3JC7XyYqFb+mMAiEA4WGT9PRsx
         Dogw==
X-Gm-Message-State: APjAAAU6SYTgT3SXvXhHLeW8tay3s2Oy7iupxEbFnisX2YTRJpwpkABY
        hoI98HvUtedNALdRtkPVGDhif3E=
X-Google-Smtp-Source: APXvYqyjPUQZ5NStzvXCltFtOcnZ7ARHiyVedrc9dvB8cXHpCQ0P8G6mxEAsQ5Tahtig8M2uEKv2Fw==
X-Received: by 2002:a05:6830:20d3:: with SMTP id z19mr13841227otq.330.1578961803507;
        Mon, 13 Jan 2020 16:30:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j20sm4753369otp.24.2020.01.13.16.30.02
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:30:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d1
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:21:19 -0600
Date:   Mon, 13 Jan 2020 18:21:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 12/17] dt-bindings: atmel,at91rm9200-rtc: add
 microchip,sam9x60-rtc
Message-ID: <20200114002119.GA18003@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 10 Jan 2020 18:18:04 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-rtc to DT bindings documentation.
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Alexandre,
> 
> I kept this patch as in v1 (same for patch
> "dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
> I'm waiting your response to this version and take an action aftewards.
> 
> Thank you,
> Claudiu Beznea
> 
>  Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
