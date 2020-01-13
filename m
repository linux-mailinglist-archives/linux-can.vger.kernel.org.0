Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C61139D73
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAMXkH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 18:40:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46989 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgAMXkH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 18:40:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so10045777oij.13
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 15:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyL/JS9B7rUgj8Iql4HM1FyxI7CsxZnIzSDjO8scpzY=;
        b=f2qTg+TRqAEN/6Z7uUrxu0BAvVI7kKx2u9PP7md7q6Yrw5Gq4+vjSKUYvnIOfxqVBh
         rtWrZq+ZKuHiupFcncks6/92YbUhPvNNtOgAxFdSQRjPA2JLvZWmEoqUY681VZYEqMd6
         1Gw1FPr0d26NxyWdfG5Gest+f5KPPuFoqFlLEcjVsz93LPT2RLM+Mmv8vp4i9BkYphYw
         gHDtyLjkdkai8HGvRiSX3wReTHTDBm3/UewWyT6eouvKPy6ZFV0LWJuEI067XL/MMe/9
         62X/79Or4ZhX8iFlTjdCvIu29oneMzHEO96vAWpjkcHWN9XGh/kLzo9UWl3cGmvjY9FH
         CYeg==
X-Gm-Message-State: APjAAAWIYSyQ9DwU5Wsh7V5Jwa1Swbitu+dmZ4FtLGdf1HXgs9kr2yxr
        rdH+OF1l/i4pvSyJgFOU7TORM4TN1g==
X-Google-Smtp-Source: APXvYqy0m6TaFobziBDJS04gbz/pIsPhKNaGmVJkaiIvSF+FqR6RBphxLwkvjLcC/XOHqprvRt1FmQ==
X-Received: by 2002:aca:d78b:: with SMTP id o133mr14937139oig.163.1578958806319;
        Mon, 13 Jan 2020 15:40:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l17sm4787808ota.27.2020.01.13.15.40.03
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:40:05 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:23 -0600
Date:   Mon, 13 Jan 2020 17:23:23 -0600
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
Subject: Re: [PATCH v2 03/17] dt-bindings: atmel-can: add
 microchip,sam9x60-can
Message-ID: <20200113232323.GA31125@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 10 Jan 2020 18:17:55 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-can to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
